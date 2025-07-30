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
  });

  @override
  State<VideoFlutter> createState() => _VideoFlutterState();
}

class _VideoFlutterState extends State<VideoFlutter> {
  late final String _viewId;
  late final web.HTMLVideoElement _video;
  bool isPlaying = true;
  double _retryRotationTurns = 0;

  @override
  void initState() {
    super.initState();

    _viewId = 'html-video-${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    _video =
        web.HTMLVideoElement()
          ..src = widget.src
          ..autoplay = widget.autoplay
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
  }

  @override
  void didUpdateWidget(VideoFlutter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.blur != widget.blur) {
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
