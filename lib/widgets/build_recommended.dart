import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:webpack/class/cardproduct.dart';

Widget buildDialogContent(BuildContext context, int index) {
  final card = cardFindS[index];
  final screenWidth = MediaQuery.of(context).size.width;
  switch (index) {
    case 0:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                SizedBox(height: 50),
                screenWidth < 1070
                    //Celular
                    ? MobileStyle(
                      textSpan1: "La Bolsa Rosa de Sharon Shoshana ",
                      textSpan2:
                          "es un empaque de alta calidad y diseño elegante, ideal para resaltar tus productos. Disponible en presentaciones de 500 gramos, esta bolsa mate combina funcionalidad y estética para ofrecer una solución de empaque sofisticada.",
                      img: "lib/src/img/home/RosaSharon_Shoshana.webp",
                    )
                    //PC
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Image.asset("lib/src/img/home/RosaSharon_Shoshana.webp", fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "La Bolsa Rosa de Sharon ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "es un empaque de alta calidad y diseño elegante, ideal para resaltar tus productos. Disponible en presentaciones de 500 gramos, esta bolsa mate combina funcionalidad y estética para ofrecer una solución de empaque sofisticada.",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 125, 126, 129),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const SizedBox(height: 50),
                screenWidth < 1070
                    //Celular
                    ? MobileStyle(
                      textSpan1: "La Bolsa Rosa de Sharon Shoshana ",
                      textSpan2:
                          "es un empaque de alta calidad y diseño elegante, ideal para resaltar tus productos. Disponible en presentaciones de 500 gramos, esta bolsa mate combina funcionalidad y estética para ofrecer una solución de empaque sofisticada.",
                      img: "lib/src/img/home/RosaSharon_Shoshana.webp",
                    )
                    //PC
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Empaques Packvisión ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "la empresa que ofrece este producto, se especializa en empaques flexibles comprometidos con la calidad y orientados al mercado internacional. Su enfoque en el servicio y la asesoría garantiza que los clientes reciban productos que cumplen con altos estándares y se adaptan a sus necesidades específicas.",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 125, 126, 129),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Image.asset("lib/src/img/home/RosaSharon_Shoshana.webp", fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ],
      );
    case 1:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const SizedBox(height: 50),
                screenWidth < 1070
                    //Celular
                    ? MobileStyle(
                      textSpan1: "La Bolsa Rosa de Sharon Jade ",
                      textSpan2:
                          "es un empaque de alta calidad y diseño elegante, ideal para realzar la presentación de tus productos. Con una capacidad de 500 gramos, esta bolsa mate combina funcionalidad y estética, ofreciendo una solución de empaque sofisticada. El distintivo color jade aporta un toque de frescura y modernidad, haciendo que tus productos destaquen en el mercado.",
                      img: "lib/src/img/home/RosaSharon_Jade.webp",
                    )
                    //PC
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Image.asset("lib/src/img/home/RosaSharon_Jade.webp", fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "La Bolsa Rosa de Sharon Jade ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "es un empaque de alta calidad y diseño elegante, ideal para realzar la presentación de tus productos. Con una capacidad de 500 gramos, esta bolsa mate combina funcionalidad y estética, ofreciendo una solución de empaque sofisticada. El distintivo color jade aporta un toque de frescura y modernidad, haciendo que tus productos destaquen en el mercado.",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 125, 126, 129),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const SizedBox(height: 50),
                screenWidth < 1070
                    //Celular
                    ? MobileStyle(
                      textSpan1: "La Bolsa Rosa de Sharon Jade ",
                      textSpan2:
                          "es un empaque de alta calidad y diseño elegante, ideal para realzar la presentación de tus productos. Con una capacidad de 500 gramos, esta bolsa mate combina funcionalidad y estética, ofreciendo una solución de empaque sofisticada. El distintivo color jade aporta un toque de frescura y modernidad, haciendo que tus productos destaquen en el mercado.",
                      img: "lib/src/img/home/RosaSharon_Jade.webp",
                    )
                    //PC
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Empaques Packvisión ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "la empresa que ofrece este producto, se especializa en empaques flexibles comprometidos con la calidad y orientados al mercado internacional. Su enfoque en el servicio y la asesoría garantiza que los clientes reciban productos que cumplen con altos estándares y se adaptan a sus necesidades específicas.",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 125, 126, 129),
                                          fontWeight: FontWeight.bold,
                                          fontSize: min(28, screenWidth * 0.05),
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Image.asset("lib/src/img/home/RosaSharon_Jade.webp", fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ],
      );

    default:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(card.title, style: TextStyle(fontSize: 20)), Text(card.body, style: TextStyle(fontSize: 30))],
      );
  }
}

class MobileStyle extends StatelessWidget {
  final String textSpan1;
  final String textSpan2;
  final String img;
  const MobileStyle({super.key, required this.textSpan1, required this.textSpan2, required this.img});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: min(100, screenWidth * 0.07)),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$textSpan1 ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: min(22, screenWidth * 0.05),
                    height: 1.2,
                  ),
                ),
                TextSpan(
                  text: textSpan2,
                  style: TextStyle(
                    color: Color.fromARGB(255, 106, 107, 109),
                    fontWeight: FontWeight.bold,
                    fontSize: min(22, screenWidth * 0.05),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(img, fit: BoxFit.cover)),
        ),
      ],
    );
  }
}
