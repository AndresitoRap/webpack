import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

class PQRS extends StatelessWidget {
  const PQRS({super.key});

  @override
  Widget build(BuildContext context) {
    const iframeId = 'iframeFormEncuesta';
    const url = 'https://forms.office.com/r/qnhVaPYkUJ';

    // ✅ Registrar el iframe SOLO si no ha sido registrado antes
    // Esto evita errores por múltiples registros
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      iframeId,
      (int viewId) =>
          html.IFrameElement()
            ..src = url
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '1000px',
    );

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Column(
                children: [const SizedBox(height: 1000, child: HtmlElementView(viewType: iframeId)), const Footer()],
              ),
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}
