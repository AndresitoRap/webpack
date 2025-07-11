import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCardData {
  final String imagePath;
  final String title;
  final String description;

  InfoCardData({required this.imagePath, required this.title, required this.description});
}

class InfoCard extends StatelessWidget {
  final InfoCardData data;
  final double maxFontSize;
  final EdgeInsets padding;
  final bool isup;

  const InfoCard({super.key, required this.data, required this.maxFontSize, this.padding = const EdgeInsets.all(16), this.isup = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: padding,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 237, 243, 255), borderRadius: BorderRadius.circular(16)),
      child:
          isup
              ? Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(text: data.title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        TextSpan(text: data.description),
                      ],
                    ),
                    style: TextStyle(fontSize: min(screenWidth * 0.03, maxFontSize)),
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: Image.asset(data.imagePath)),
                ],
              )
              : Column(
                children: [
                  Expanded(child: Image.asset(data.imagePath)),
                  const SizedBox(height: 12),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(text: data.title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        TextSpan(text: data.description),
                      ],
                    ),
                    style: TextStyle(fontSize: min(screenWidth * 0.03, maxFontSize)),
                  ),
                ],
              ),
    );
  }
}

Widget buildResponsiveInfoCards(BuildContext context) {
  final List<InfoCardData> items = [
    InfoCardData(
      imagePath: "assets/img/smartbag/4pro/types.png",
      title: "Tu decides la terminación ",
      description:
          "brillante para un acabado más reflectivo, Mate para una apariencia elegante y sobria, y Ventana para mostrar el producto sin perder protección.",
    ),
    InfoCardData(
      imagePath: "assets/img/smartbag/valvula.webp",
      title: "Agrega funcionalidad con accesorios inteligentes. ",
      description:
          "El sistema Peel Stick permite abrir y cerrar la bolsa fácilmente. Las válvulas desgasificadoras conservan productos frescos por más tiempo.",
    ),
    InfoCardData(
      imagePath: "assets/img/smartbag/flowpack.webp",
      title: "Cuatro capas ",
      description:
          "una protección total. La 4PRO combina PET, BOPP y PE para ofrecer una barrera contra la humedad, la luz y el oxígeno, con una presentación elegante y segura.",
    ),
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 700;

      if (isMobile) {
        return Column(children: items.map((data) => SizedBox(height: 300, child: InfoCard(data: data, maxFontSize: 30))).toList());
      } else {
        return SizedBox(
          width: min(constraints.maxWidth, 1400),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 450, child: InfoCard(data: items[0], maxFontSize: 16, isup: true)),
                    SizedBox(height: 450, child: InfoCard(data: items[1], maxFontSize: 16, isup: true)),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 900,
                  child: InfoCard(data: items[2], maxFontSize: 16, padding: const EdgeInsets.only(right: 16, left: 16, top: 30, bottom: 50)),
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}
