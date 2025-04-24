import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class Us extends StatefulWidget {
  const Us({super.key});

  @override
  State<Us> createState() => _UsState();
}

class _UsState extends State<Us> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: screenWidth,
                  height: screenWidth >= 1200 ? null : 600,
                  color: Theme.of(context).colorScheme.tertiary,
                  child:
                      screenWidth >= 1200
                          ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: screenWidth / 2.8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nosotros",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: min(100, screenWidth * 0.09),
                                        ),
                                      ),
                                      Text(
                                        textAlign: TextAlign.justify,
                                        "Somos una empresa colombiana comprometida con la innovación, el diseño y la producción de empaques flexibles de alta calidad que protegen, conservan y realzan los productos de todos los sectores. A través de tecnología de punta y un enfoque humano, construimos relaciones duraderas con nuestros clientes, siendo su aliado estratégico y confiable en soluciones de empaque.",

                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: min(20, screenWidth * 0.09),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.1),
                                SizedBox(
                                  height: 800,
                                  child: Opacity(
                                    opacity: (screenWidth * 0.0003).clamp(0.0, 1.0),
                                    child: Image.asset("assets/img/us/us.webp", fit: BoxFit.contain),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Stack(
                            children: [
                              Positioned(
                                bottom: -200,
                                right: -100,
                                child: SizedBox(
                                  height: 800,
                                  child: Opacity(
                                    opacity: (screenWidth * 0.0003).clamp(0.0, 1.0),
                                    child: Image.asset("assets/img/us/us.webp", fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nosotros",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: min(100, screenWidth * 0.09),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth >= 1000 ? screenWidth * 0.6 : null,
                                      child: Text(
                                        textAlign: TextAlign.justify,
                                        "Somos una empresa colombiana comprometida con la innovación, el diseño y la producción de empaques flexibles de alta calidad que protegen, conservan y realzan los productos de todos los sectores. A través de tecnología de punta y un enfoque humano, construimos relaciones duraderas con nuestros clientes, siendo su aliado estratégico y confiable en soluciones de empaque.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: min(20, screenWidth * 0.09),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Divider(thickness: 1, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  "Nuestros valores",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(50, screenWidth * 0.1)),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Text(
                    textAlign: TextAlign.center,
                    "En PACKVISION SAS, compartimos los valores que inspiran cada paso que damos. Son un reflejo del compromiso que tenemos con cada uno de los procesos para así llegar al producto final, conoce nuestros valores:",
                    style: TextStyle(fontSize: min(16, screenWidth * 0.1)),
                  ),
                ),
                SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double width = constraints.maxWidth;
                    int crossAxisCount = 1;
                    if (width >= 1100) {
                      crossAxisCount = 3;
                    } else if (width >= 700) {
                      crossAxisCount = 2;
                    }
                    double itemWidth = (width - 32) / crossAxisCount;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children:
                          _supportCards.map((card) {
                            return Container(
                              width: itemWidth.clamp(260, 350),
                              height: 250,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(card.icon, size: 36, color: Theme.of(context).primaryColor),
                                  const SizedBox(height: 12),
                                  Text(card.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text(card.description),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
                SizedBox(height: 30),
                Footer(),
              ],
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}

// Modelo de tarjeta
class Values {
  final IconData icon;
  final String title;
  final String description;

  Values({required this.icon, required this.title, required this.description});
}

// Lista de tarjetas
final List<Values> _supportCards = [
  Values(
    icon: CupertinoIcons.check_mark_circled,
    title: "Verdad",
    description:
        "Hemos adecuado nuestro propósito como empresa, con lo que expresamos en nuestros productos, procesos y relaciones con todas las personas que interactuamos.",
  ),
  Values(icon: CupertinoIcons.compass, title: "Liderazgo", description: "Nos esforzamos a dar forma a un futuro."),
  Values(
    icon: CupertinoIcons.person_2,
    title: "Unidad",
    description: "Trabajamos en equipo integrando toda la empresa hacia nuestra visión y misión.",
  ),
  Values(
    icon: CupertinoIcons.globe,
    title: "Responsabilidad Social",
    description:
        "Toda nuestra organización está comprometida con acciones sociales, para contribuir al desarrollo económico sostenible, con el fin de mejorar la calidad de vida de nuestros asociados.",
  ),
  Values(
    icon: CupertinoIcons.lock_open,
    title: "Honestidad",
    description:
        "Tenemos integrados nuestros procesos para apoyar la verdad, la justicia y la amabilidad con todas las personas que interactuamos.",
  ),
  Values(
    icon: CupertinoIcons.heart_fill,
    title: "Pasión",
    description: "Disfrutamos y Amamos profundamente cada proceso, y cada empaque que elaboramos en nuestra empresa.",
  ),
  Values(
    icon: CupertinoIcons.star_circle,
    title: "Calidad",
    description: "Buscamos en nuestros procesos la excelencia, trabajamos cada día para ello.",
  ),
  Values(
    icon: CupertinoIcons.hand_raised,
    title: "Lealtad",
    description:
        "Somos fieles, respetamos los valores y los compromisos establecidos con las personas que interactuamos.",
  ),
];
