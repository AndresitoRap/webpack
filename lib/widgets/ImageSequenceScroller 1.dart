import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

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
  final int precacheRange;
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
    this.precacheRange = 10,
    this.pixelsPerFrame = 5.0,
    this.frameEasing,
    this.maxFramesLimit = 1000,
  }) : assert(totalFrames > 0),
       assert(totalFrames <= maxFramesLimit),
       assert(visibilityThreshold >= 0.0 && visibilityThreshold <= 1.0),
       assert(precacheRange >= 0),
       assert(pixelsPerFrame > 0);

  @override
  State<ImageSequenceScroller> createState() => _ImageSequenceScrollerState();
}

class _ImageSequenceScrollerState extends State<ImageSequenceScroller> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _visibilityKey = GlobalKey();
  late final ValueNotifier<int> _frameNotifier;
  bool _isVisible = false;
  int _currentFrame = 1;
  int _errorCount = 0;
  double? _autoScrollStartOffset;
  double? _autoScrollEndOffset;
  bool _startOffsetSet = false;
  DateTime? _lastFrameUpdate;
  bool _firstFrameReady = false;
  final Duration _frameInterval = const Duration(milliseconds: 16); // 60fps

  ScrollController get _effectiveController => widget.externalScrollController ?? _scrollController;

  @override
  void initState() {
    super.initState();
    _frameNotifier = ValueNotifier(_currentFrame);

    // Precache primeros N frames
    for (int i = 1; i <= min(widget.precacheRange, widget.totalFrames); i++) {
      _precacheSingleFrame(i);
    }

    // Precarga y espera primer frame
    final firstFrame = AssetImage(_buildFramePath(_currentFrame));
    firstFrame
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener(
            (_, __) {
              if (mounted) {
                setState(() => _firstFrameReady = true);
              }
            },
            onError: (_, __) {
              widget.onError?.call("Error cargando el primer frame");
            },
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      Future.delayed(const Duration(milliseconds: 100), _checkVisibility);
    });

    _effectiveController.addListener(_onVisibilityCheck);

    // Ajustar caché
    PaintingBinding.instance.imageCache.maximumSize = 200;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20;
  }

  @override
  void dispose() {
    if (_isVisible) {
      _effectiveController.removeListener(_onScroll);
    }
    _effectiveController.removeListener(_onVisibilityCheck);
    if (widget.externalScrollController == null) {
      _scrollController.dispose();
    }
    _frameNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isVisible) return;

    final now = DateTime.now();
    if (_lastFrameUpdate != null && now.difference(_lastFrameUpdate!) < _frameInterval) return;
    _lastFrameUpdate = now;

    final offset = _effectiveController.offset;
    final start = widget.scrollStartOffset ?? _autoScrollStartOffset ?? 0.0;
    final end = widget.scrollEndOffset ?? _autoScrollEndOffset ?? (start + widget.totalFrames * widget.pixelsPerFrame);
    final localOffset = (offset - start).clamp(0.0, end - start);
    final range = end - start;

    double t = localOffset / range;
    if (widget.frameEasing != null) t = widget.frameEasing!.transform(t);
    final frame = (t * (widget.totalFrames - 1)) + 1;
    final calculated = widget.frameCalculationMode == 'ceil' ? frame.ceil() : frame.floor();
    final clamped = calculated.clamp(1, widget.totalFrames);
    final adjusted = (clamped == widget.totalFrames - 1 && offset >= end - 5) ? widget.totalFrames : clamped;

    if (adjusted != _currentFrame) {
      _currentFrame = adjusted;
      _frameNotifier.value = _currentFrame;
      _precacheSingleFrame(_currentFrame);

      if (_currentFrame == widget.totalFrames) {
        widget.onLastFrameReached?.call();
      }
    }
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

    if (!_startOffsetSet) {
      final scrollOffset = _effectiveController.offset;
      final widgetOffset = renderBox.localToGlobal(Offset.zero).dy + scrollOffset;
      _autoScrollStartOffset = widgetOffset;
      _autoScrollEndOffset = widgetOffset + (widget.totalFrames * widget.pixelsPerFrame);
      _startOffsetSet = true;
    }

    if (_isVisible != shouldBeVisible) {
      _isVisible = shouldBeVisible;
      if (_isVisible) {
        _effectiveController.addListener(_onScroll);
      } else {
        _effectiveController.removeListener(_onScroll);
      }
    }
  }

  void _precacheSingleFrame(int frame) {
    final context = _visibilityKey.currentContext;
    if (context == null) return;
    final path = _buildFramePath(frame);
    precacheImage(AssetImage(path), context, onError: (_, __) => _errorCount++);
  }

  String _buildFramePath(int frame) {
    return '${widget.framePrefix}${frame.toString().padLeft(4, '0')}.${widget.frameExtension}';
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
          valueListenable: _frameNotifier,
          builder: (_, frame, __) {
            final framePath = _buildFramePath(frame);
            return Image.asset(
              framePath,
              gaplessPlayback: true,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey, child: const Center(child: Text('Error al cargar')));
              },
            );
          },
        ),
      ),
    );
  }
}
