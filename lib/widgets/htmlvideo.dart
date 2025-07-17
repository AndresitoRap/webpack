import 'dart:html' as html;

import 'dart:ui_web' as ui_web show platformViewRegistry;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webpack/class/menu_data.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:webpack/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HtmlBackgroundVideo extends StatefulWidget {
  final String src;
  final bool blur;
  final bool loop;
  final bool showControls;
  final BoxFit? fit;
  final double? height;
  final VoidCallback? onEnded;
  final bool isPause;
  final bool retry;

  const HtmlBackgroundVideo({
    super.key,
    required this.src,
    this.blur = false,
    required this.loop,
    this.onEnded,
    this.showControls = false,
    this.fit,
    this.height,
    this.isPause = true,
    this.retry = false,
  });

  @override
  State<HtmlBackgroundVideo> createState() => _HtmlBackgroundVideoState();
}

class _HtmlBackgroundVideoState extends State<HtmlBackgroundVideo> {
  late final String _viewId;
  late html.VideoElement _videoElement;
  bool isPlaying = true;
  double _retryRotationTurns = 0;

  @override
  void initState() {
    super.initState();

    _viewId = 'html-video-${widget.src.hashCode}-${DateTime.now().millisecondsSinceEpoch}';

    _videoElement =
        html.VideoElement()
          ..id = _viewId
          ..src = widget.src
          ..autoplay = true
          ..loop = widget.loop
          ..muted = true
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = (widget.fit ?? BoxFit.cover).name
          ..style.transition = 'filter 0.5s ease-in-out'
          ..style.backgroundColor = 'transparent'
          ..style.filter = widget.blur ? 'blur(30px)' : 'none';

    if (widget.height != null) {
      _videoElement.style.height = '${widget.height}px';
    }

    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) => _videoElement);

    _videoElement.onClick.listen((_) {
      if (!widget.isPause) return;
      if (_videoElement.paused) {
        _videoElement.play();
      } else {
        _videoElement.pause();
      }
    });

    _videoElement.onEnded.listen((event) {
      widget.onEnded?.call();
    });

    _videoElement.onPlay.listen((event) {
      if (!mounted) return;
      setState(() {
        isPlaying = true;
      });
    });

    _videoElement.onPause.listen((event) {
      if (!mounted) return;
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  void didUpdateWidget(covariant HtmlBackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.blur != widget.blur) {
      _videoElement.style.filter = widget.blur ? 'blur(30px)' : 'none';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // El video con GestureDetector
        GestureDetector(
          onTap: () {
            if (!widget.isPause) return;
            setState(() {
              if (_videoElement.paused) {
                _videoElement.play();
              } else {
                _videoElement.pause();
              }
            });
          },
          child: HtmlElementView(viewType: _viewId),
        ),

        // Botón de control de reproducción
        if (widget.showControls)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                if (!widget.isPause) return;
                setState(() {
                  if (_videoElement.paused) {
                    _videoElement.play();
                  } else {
                    _videoElement.pause();
                  }
                });
              },
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xffb1b0b4),
                mini: true,
                child: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        if (widget.retry)
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xffb1b0b4),
              mini: true,
              onPressed: () {
                _videoElement.pause();
                _videoElement.currentTime = 0;
                _videoElement.play();
                setState(() {
                  _retryRotationTurns += 0.50; // 90 grados = 1/4 vuelta
                });
              },
              child: AnimatedRotation(
                turns: _retryRotationTurns,
                duration: const Duration(milliseconds: 100),
                child: const Icon(Icons.restart_alt_outlined, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
