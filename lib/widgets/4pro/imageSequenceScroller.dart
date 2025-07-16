import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<ui.Image?> safeLoadImage(String path) async {
  try {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 1920);
    final frame = await codec.getNextFrame();
    return frame.image;
  } catch (e) {
    debugPrint('Error loading image: $path → $e');
    return null;
  }
}

class ImageSequenceScroller extends StatefulWidget {
  final String framePrefix;
  final String frameExtension;
  final int totalFrames;
  final double? width;
  final double? height;
  final VoidCallback? onLastFrameReached;
  final Function(String)? onError;
  final ScrollController? externalScrollController;
  final double? scrollStartOffset;
  final double? scrollEndOffset;
  final String frameCalculationMode;
  final double visibilityThreshold;
  final double pixelsPerFrame;
  final Curve? frameEasing;
  final int maxFramesLimit;

  const ImageSequenceScroller({
    super.key,
    required this.framePrefix,
    required this.frameExtension,
    required this.totalFrames,
    this.width,
    this.height,
    this.onLastFrameReached,
    this.onError,
    this.externalScrollController,
    this.scrollStartOffset,
    this.scrollEndOffset,
    this.frameCalculationMode = 'ceil',
    this.visibilityThreshold = 0.5,
    this.pixelsPerFrame = 5.0,
    this.frameEasing,
    this.maxFramesLimit = 1000,
  }) : assert(totalFrames > 0),
       assert(totalFrames <= maxFramesLimit),
       assert(visibilityThreshold >= 0.0 && visibilityThreshold <= 1.0),
       assert(pixelsPerFrame > 0);

  @override
  State<ImageSequenceScroller> createState() => _ImageSequenceScrollerState();
}

class _ImageSequenceScrollerState extends State<ImageSequenceScroller> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _visibilityKey = GlobalKey();
  final Map<int, ui.Image> imageCache = {};
  final ValueNotifier<int> currentFrame = ValueNotifier(1);

  ScrollController get _effectiveController => widget.externalScrollController ?? _scrollController;

  double? _autoScrollStartOffset;
  double? _autoScrollEndOffset;
  bool _startOffsetSet = false;
  bool _firstFrameReady = false;
  bool _isVisible = false;

  ui.Image? _lastRenderedImage;
  int _lastRenderedFrame = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = _effectiveController;
      if (controller.hasClients) controller.jumpTo(0.0);

      // 🔹 Cargar primer frame inmediatamente
      final firstPath = _buildFramePath(1);
      final firstImage = await safeLoadImage(firstPath);
      if (firstImage != null) {
        imageCache[1] = firstImage;
        if (mounted) setState(() => _firstFrameReady = true);
      }

      // 🔹 Precargar el resto en segundo plano sin bloquear el UI
      Future.microtask(() async {
        for (int i = 2; i <= widget.totalFrames; i++) {
          final path = _buildFramePath(i);
          final img = await safeLoadImage(path);
          if (img != null) imageCache[i] = img;
        }
      });

      _checkVisibility();
    });

    _effectiveController.addListener(_onVisibilityCheck);

    // Opcional: aumentar el caché de imágenes
    PaintingBinding.instance.imageCache.maximumSize = 300;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 300 << 20;
  }

  void _onVisibilityCheck() => _checkVisibility();

  void _checkVisibility() {
    final renderBox = _visibilityKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final widgetTop = position.dy;
    final widgetBottom = widgetTop + renderBox.size.height;
    final visibleHeight = min(widgetBottom, screenHeight) - max(widgetTop, 0);
    final ratio = visibleHeight / renderBox.size.height;
    final shouldBeVisible = ratio >= widget.visibilityThreshold;
    final scrollOffset = _effectiveController.offset;

    if (!_startOffsetSet) {
      final widgetOffset = widgetTop + scrollOffset;
      _autoScrollStartOffset = widgetOffset;
      _autoScrollEndOffset = widgetOffset + (widget.totalFrames * widget.pixelsPerFrame);
      _startOffsetSet = true;
    }

    if (_isVisible != shouldBeVisible) {
      _isVisible = shouldBeVisible;
      if (_isVisible) {
        _effectiveController.addListener(_onScroll);
        _onScroll();
      } else {
        _effectiveController.removeListener(_onScroll);
      }
    }
  }

  void _onScroll() {
    final offset = _effectiveController.offset;
    if (_autoScrollStartOffset == null || _autoScrollEndOffset == null) return;
    if (offset < _autoScrollStartOffset! || offset > _autoScrollEndOffset!) return;

    final localOffset = offset - _autoScrollStartOffset!;
    final rawFrame = (localOffset / widget.pixelsPerFrame);
    final calculatedFrame = widget.frameCalculationMode == 'ceil' ? rawFrame.ceil() : rawFrame.floor();

    final frame = calculatedFrame.clamp(1, widget.totalFrames);
    if ((frame - currentFrame.value).abs() >= 1) {
      currentFrame.value = frame;
    }
  }

  String _buildFramePath(int frame) {
    return '${widget.framePrefix}${frame.toString().padLeft(4, '0')}.${widget.frameExtension}';
  }

  @override
  void dispose() {
    if (widget.externalScrollController == null) _scrollController.dispose();
    currentFrame.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_firstFrameReady) {
      return SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? 300,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return KeyedSubtree(
      key: _visibilityKey,
      child: SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: ValueListenableBuilder<int>(
          valueListenable: currentFrame,
          builder: (context, value, child) {
            final image = imageCache[value];
            if (image != null) {
              _lastRenderedImage = image;
              _lastRenderedFrame = value;
            }

            if (_lastRenderedImage == null) {
              return const SizedBox.shrink();
            }

            return RepaintBoundary(
              child: RawImage(
                key: ValueKey<int>(_lastRenderedFrame),
                image: _lastRenderedImage!,
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
            );
          },
        ),
      ),
    );
  }
}
