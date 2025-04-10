import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class WhatsappPage extends StatefulWidget {
  const WhatsappPage({super.key});

  @override
  State<WhatsappPage> createState() => _WhatsappPageState();
}

class _WhatsappPageState extends State<WhatsappPage> {
  bool _whatsapp = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = constraints.maxWidth;
                    bool isTabletOrSmaller = screenWidth < 1024;

                    return Container(
                      height: isTabletOrSmaller ? null : 700,
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 20),
                      width: screenWidth,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 209, 218, 237)),

                      child:
                          isTabletOrSmaller
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 100),
                                  // Texto
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "¿Tienes preguntas?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: min(50, screenWidth * 0.06),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "¡Hablemos por WhatsApp! ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: min(40, screenWidth * 0.06),
                                                ),
                                              ),
                                              TextSpan(
                                                text: "\nNuestro equipo está listo para ayudarte.",
                                                style: TextStyle(fontSize: 23),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MouseRegion(
                                    onEnter: (_) {
                                      setState(() {
                                        _whatsapp = true;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        _whatsapp = false;
                                      });
                                    },
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final url = Uri.parse("https://web.whatsapp.com/send?phone=573178689125");
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        } else {
                                          throw 'No se pudo abrir el enlace: $url';
                                        }
                                      },

                                      child: AnimatedScale(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        scale: _whatsapp ? 1.05 : 1,
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeInBack,
                                          margin: EdgeInsets.only(top: 20),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: _whatsapp ? Color.fromARGB(255, 28, 165, 78) : Color(0xff25d366),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Boxicons.bxl_whatsapp, color: Colors.white, size: 30),
                                              SizedBox(width: screenWidth * 0.005),
                                              Text(
                                                "Ir a Whatsapp",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Imagen
                                  Transform.translate(
                                    offset: Offset(screenWidth * 0.4, screenWidth * 0.3),
                                    child: Transform.scale(
                                      scale: 1.6,
                                      child: Image.asset("lib/src/img/support/support_chat.png"),
                                    ),
                                  ),
                                ],
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Texto
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "¿Tienes preguntas?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: min(50, screenWidth * 0.06),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "¡Hablemos por WhatsApp! ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: min(30, screenWidth * 0.05),
                                                ),
                                              ),
                                              TextSpan(
                                                text: "Nuestro equipo está listo para ayudarte.",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              _whatsapp = true;
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              _whatsapp = false;
                                            });
                                          },
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () async {
                                              final url = Uri.parse("https://web.whatsapp.com/send?phone=573178689125");
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url, mode: LaunchMode.externalApplication);
                                              } else {
                                                throw 'No se pudo abrir el enlace: $url';
                                              }
                                            },
                                            child: AnimatedScale(
                                              duration: Duration(milliseconds: 200),
                                              curve: Curves.easeInOut,
                                              scale: _whatsapp ? 1.05 : 1,
                                              child: AnimatedContainer(
                                                duration: Duration(milliseconds: 200),
                                                curve: Curves.easeInBack,
                                                margin: EdgeInsets.only(top: 20),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color:
                                                      _whatsapp ? Color.fromARGB(255, 28, 165, 78) : Color(0xff25d366),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Boxicons.bxl_whatsapp, color: Colors.white, size: 30),
                                                    SizedBox(width: screenWidth * 0.005),
                                                    Text(
                                                      "Ir a Whatsapp",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Imagen que se desborda un poco hacia abajo
                                  Expanded(
                                    child: Transform.translate(
                                      offset: const Offset(0, 50),
                                      child: Image.asset("lib/src/img/support/support_chat.png"),
                                    ),
                                  ),
                                ],
                              ),
                    );
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "Estamos para ayudarte",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: min(30, screenWidth * 0.05),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          _supportCardsPerson.map((card) {
                            return Container(
                              width: itemWidth.clamp(260, 350),
                              height: 300,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    card.zone,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(child: Image.asset(card.img)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Icon(CupertinoIcons.phone_fill, color: Theme.of(context).primaryColor),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Text(card.name), Text("(601) 746 05 33 ${card.ext}")],
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Icon(CupertinoIcons.phone_fill, color: Theme.of(context).primaryColor),
                                  //     Text("(601) 746 05 33 ${card.ext}"),
                                  //   ],
                                  // ),
                                ],
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 100),
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
class SupportCardPerson {
  final String name;
  final String ext;
  final String zone;
  final String img;

  SupportCardPerson({required this.name, required this.ext, required this.zone, required this.img});
}

// Lista de tarjetas
final List<SupportCardPerson> _supportCardsPerson = [
  SupportCardPerson(
    name: "Laura palacios",
    ext: "104",
    zone: "Asesora Comercial",
    img: "lib/src/img/support/Adviser1.png",
  ),
  SupportCardPerson(
    name: "Yeimi Guaqueta",
    ext: "103",
    zone: "Asesora Comercial",
    img: "lib/src/img/support/Adviser2.png",
  ),
  SupportCardPerson(
    name: "Elena  Cifuentes",
    ext: "512",
    zone: "Servicio al cliente",
    img: "lib/src/img/support/Customer_Service.png",
  ),
  SupportCardPerson(
    name: "Fernanda Téllez",
    ext: "109",
    zone: "Asesora Comercial",
    img: "lib/src/img/support/Adviser3.png",
  ),
  SupportCardPerson(
    name: "Hasem Cifuentes",
    ext: "508",
    zone: "Asesora Comercial",
    img: "lib/src/img/support/Adviser4.png",
  ),
];
