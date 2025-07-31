import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'dart:ui_web';
import 'dart:html' as html;

class PQRS extends StatefulWidget {
  const PQRS({super.key});

  @override
  State<PQRS> createState() => _PQRSState();
}

class _PQRSState extends State<PQRS> {
  @override
  Widget build(BuildContext context) {
    const url = 'https://forms.office.com/r/qnhVaPYkUJ';

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 45),

              child: Column(
                children: [
                  SizedBox(
                    height: 1000,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: videoBlurNotifier,
                      builder: (context, isBlur, _) {
                        return HtmlBlurIframe(url: url, blur: isBlur);
                      },
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}

class HtmlBlurIframe extends StatefulWidget {
  final String url;
  final bool blur;
  final double height;

  const HtmlBlurIframe({super.key, required this.url, this.blur = false, this.height = 1000});

  @override
  State<HtmlBlurIframe> createState() => _HtmlBlurIframeState();
}

class _HtmlBlurIframeState extends State<HtmlBlurIframe> {
  late String _viewId;

  @override
  void initState() {
    super.initState();
    _generateIframe();
  }

  void _generateIframe() {
    _viewId = 'iframe-${widget.url.hashCode}-${widget.blur}-${DateTime.now().millisecondsSinceEpoch}';

    // ignore: undefined_prefixed_name
    platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe =
          html.IFrameElement()
            ..src = widget.url
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '${widget.height}px'
            ..style.transition = 'filter 0.5s ease-in-out'
            ..style.backgroundColor = 'white'
            ..style.filter = widget.blur ? 'blur(30px)' : 'none';

      return iframe;
    });
  }

  @override
  void didUpdateWidget(HtmlBlurIframe oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.blur != widget.blur) {
      setState(() {
        _generateIframe(); // fuerza cambio de ID y registro
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(key: ValueKey(_viewId), viewType: _viewId);
  }
}
