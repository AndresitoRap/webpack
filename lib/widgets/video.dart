import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web';

class VideoFlutter extends StatefulWidget {
  final String src;
  final bool blur;
  final bool loop;
  final bool autoplay;
  final bool showControls;
  final BoxFit fit;
  final double? height;
  final VoidCallback? onEnded;
  final bool isPause;
  final bool retry;
  final Duration delay;

  const VideoFlutter({
    super.key,
    required this.src,
    this.blur = false,
    this.loop = true,
    this.autoplay = true,
    this.showControls = false,
    this.fit = BoxFit.cover,
    this.height,
    this.onEnded,
    this.isPause = true,
    this.retry = false,
    this.delay = Duration.zero,
  });

  @override
  State<VideoFlutter> createState() => VideoFlutterState();
}

class VideoFlutterState extends State<VideoFlutter> {
  late final String _viewId;
  late final web.HTMLVideoElement _video;
  bool isPlaying = true;
  double _retryRotationTurns = 0;
  bool _lastBlur = false;

  @override
  void initState() {
    super.initState();

    _viewId = 'html-video-${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    _video =
        web.HTMLVideoElement()
          ..src = widget.src
          ..autoplay = widget.delay == Duration.zero && widget.autoplay
          ..loop = widget.loop
          ..muted = true
          ..controls =
              false // controlado manualmente
          ..style.width = '100%'
          ..style.height = widget.height != null ? '${widget.height}px' : '100%'
          ..style.objectFit = widget.fit.name
          ..style.border = 'none'
          ..style.backgroundColor = 'transparent'
          ..style.transition = 'filter 0.5s ease-in-out'
          ..style.filter = widget.blur ? 'blur(30px)' : 'none';

    if (!widget.showControls) {
      _video.style.pointerEvents = 'none';
    }

    _video.onClick.listen((_) => _togglePlayPause());

    _video.onEnded.listen((_) => widget.onEnded?.call());

    _video.onPlay.listen((_) {
      if (!mounted) return;
      setState(() => isPlaying = true);
    });

    _video.onPause.listen((_) {
      if (!mounted) return;
      setState(() => isPlaying = false);
    });

    // Registro de la vista
    platformViewRegistry.registerViewFactory(_viewId, (int _) => _video);

    if (widget.delay > Duration.zero) {
      Future.delayed(widget.delay, () {
        if (mounted && widget.autoplay) _video.play();
      });
    }

    _lastBlur = widget.blur;
  }

  /// Permite pausar el video desde el widget padre.
  void pause() => _video.pause();

  /// Permite reproducir el video desde el widget padre.
  void play() => _video.play();

  /// Permite volver el video al inicio desde el widget padre.
  void seekToStart() => _video.currentTime = 0;

  @override
  void didUpdateWidget(VideoFlutter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Solo aplica blur si cambió realmente
    if (_lastBlur != widget.blur) {
      _lastBlur = widget.blur;
      _video.style.filter = widget.blur ? 'blur(30px)' : 'none';
    }
  }

  void _togglePlayPause() {
    if (!widget.isPause) return;
    if (_video.paused) {
      _video.play();
    } else {
      _video.pause();
    }
  }

  void _retryVideo() {
    _video.pause();
    _video.currentTime = 0;
    _video.play();
    setState(() => _retryRotationTurns += 0.5);
  }

  void retry() => _retryVideo();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HtmlElementView(viewType: _viewId),

        if (widget.showControls)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onDoubleTap: _togglePlayPause,
              child: FloatingActionButton(
                mini: true,
                shape: const CircleBorder(),
                backgroundColor: const Color(0xffb1b0b4),
                onPressed: () {},
                child: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              ),
            ),
          ),

        if (widget.retry)
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              mini: true,
              shape: const CircleBorder(),
              backgroundColor: const Color(0xffb1b0b4),
              onPressed: _retryVideo,
              child: AnimatedRotation(
                turns: _retryRotationTurns,
                duration: const Duration(milliseconds: 150),
                child: const Icon(Icons.restart_alt_outlined, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
