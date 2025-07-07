import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollAnimatedWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Offset startOffset;
  final Key visibilityKey;

  const ScrollAnimatedWrapper({
    super.key,
    required this.child,
    required this.visibilityKey,
    this.duration = const Duration(milliseconds: 800),
    this.startOffset = const Offset(0, 0.1),
  });

  @override
  State<ScrollAnimatedWrapper> createState() => _ScrollAnimatedWrapperState();
}

class _ScrollAnimatedWrapperState extends State<ScrollAnimatedWrapper> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.visibilityKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 0.4 && !_visible) {
          setState(() {
            _visible = true;
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : widget.startOffset,
          duration: widget.duration,
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
