import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'dart:html' as html;

class DataProccessing extends StatefulWidget {
  const DataProccessing({super.key});

  @override
  State<DataProccessing> createState() => _DataProccessingState();
}

class _DataProccessingState extends State<DataProccessing> {
  bool ishover = false;
  bool isdownload = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: screenWidth * 0.06),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isMobile ? 1 : 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Protege tu información", style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 10),
                            Text(
                              "Tratamiento de datos personales",
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Conoce cómo protegemos tu información y cuáles son tus derechos según la ley de habeas data. Descarga el documento completo en formato PDF y mantente informado.",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onEnter: (_) {
                                    setState(() {
                                      ishover = true;
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      ishover = false;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      downloadPDF();
                                      setState(() {
                                        isdownload = true;
                                      });
                                    },
                                    child: AnimatedScale(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      scale: ishover ? 1.1 : 1,
                                      child: AnimatedContainer(
                                        duration: Duration(microseconds: 300),
                                        curve: Curves.easeInOut,
                                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color:
                                              ishover
                                                  ? Theme.of(context).colorScheme.tertiary
                                                  : Theme.of(context).primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(CupertinoIcons.arrow_down_doc_fill, color: Colors.white),
                                            SizedBox(width: screenWidth * 0.01),
                                            Text(
                                              isdownload ? "PDF descargado" : "Descargar PDF",
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!isMobile)
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset("lib/src/img/support/dataproccesing.png"),
                          ),
                        ),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
          const Header(),
        ],
      ),
    );
  }
}

void downloadPDF() {
  final url = 'lib/src/pdf/support/Tratamiento-de-Datos.pdf';
  final anchor =
      html.AnchorElement(href: url)
        ..setAttribute('download', 'tratamiento_de_datos.pdf')
        ..click();
}
