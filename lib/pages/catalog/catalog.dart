import 'package:flutter/material.dart';
import 'dart:ui_web';
// Solo disponible para Web
import 'dart:html' as html;

import 'package:webpack/widgets/header.dart';

class Catalog extends StatelessWidget {
  const Catalog({super.key});

  @override
  Widget build(BuildContext context) {
    // Registramos el view para Web
    // ignore: undefined_prefixed_name
    platformViewRegistry.registerViewFactory(
      'fliphtml5-frame',
      (int viewId) =>
          html.IFrameElement()
            ..src = 'https://fliphtml5.com/bookcase/xgefo'
            ..style.border = 'none',
    );

    return const Scaffold(
      body: Stack(children: [Padding(padding: EdgeInsets.only(top: 45), child: HtmlElementView(viewType: 'fliphtml5-frame')), Header()]),
    );
  }
}
