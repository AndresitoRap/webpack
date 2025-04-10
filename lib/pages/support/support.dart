import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class SupportHome extends StatelessWidget {
  const SupportHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  // Banner superior
                  Container(
                    width: screenWidth,
                    height: 800,
                    color: const Color.fromARGB(255, 209, 218, 237),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset("lib/src/img/support/support_home.webp", height: 300),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "¡Bienvenido! ¿Cómo podemos ayudarte? 💙",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: min(40, screenWidth * 0.04),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Hola, ¿Estás atascado en algún lugar? No te preocupes, estamos aquí para ayudarte.",
                                  style: TextStyle(fontSize: min(20, screenWidth * 0.025)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Responsive Cards
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
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, card.route);
                                  },
                                  child: Container(
                                    width: itemWidth.clamp(260, 350),
                                    height: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(card.icon, size: 36, color: Theme.of(context).primaryColor),
                                        const SizedBox(height: 12),
                                        Text(
                                          card.title,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(card.description),
                                        const SizedBox(height: 12),
                                        Text(
                                          card.linkText,
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Footer(),
                ],
              ),
            ),
          ),
          const Header(),
        ],
      ),
    );
  }
}

// Modelo de tarjeta
class SupportCardData {
  final IconData icon;
  final String title;
  final String description;
  final String linkText;
  final String route;

  SupportCardData({
    required this.icon,
    required this.title,
    required this.description,
    required this.linkText,
    required this.route,
  });
}

// Lista de tarjetas
final List<SupportCardData> _supportCards = [
  SupportCardData(
    icon: CupertinoIcons.chat_bubble_text,
    title: "Ayuda Rápida",
    description:
        "¿Tienes una pregunta rápida o necesitas asistencia inmediata? Aquí puedes encontrar respuestas al instante.",
    linkText: "Contactarme con un asesor",
    route: "/Soporte/Ayuda-Rápida/Whatsapp",
  ),
  SupportCardData(
    icon: CupertinoIcons.doc_text,
    title: "Políticas",
    description: "Infórmate sobre nuestros términos de uso, tratamiento de datos, cookies y más detalles legales.",
    linkText: "Ver nuestras políticas",
    route: "/Soporte/Politicas/Politicas-legales-y-reglamentarias",
  ),
  SupportCardData(
    icon: CupertinoIcons.heart_circle,
    title: "Tu Opinión",
    description:
        "Tu experiencia es fundamental para seguir mejorando. Déjanos tus comentarios, responde la encuesta o registra una PQRS fácilmente.",
    linkText: "Compartir mi experiencia",
    route: "/Soporte/Tú-opinion/Encuesta-de-satisfacción-y-PQRS",
  ),
];
