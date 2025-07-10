import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class Commerce extends StatefulWidget {
  final String section;
  final Subcategorie selectedSubcategorie;
  const Commerce({super.key, required this.section, required this.selectedSubcategorie});

  @override
  State<Commerce> createState() => _CommerceState();
}

class _CommerceState extends State<Commerce> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    print(widget.section);

    Widget content;

    switch (widget.section.toLowerCase()) {
      case '4pro':
        content = FourPro(screenWidth: screenWidth, currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);

        break;

      default:
        content = Center(child: Text('Sección no encontrada'));
    }

    return Scaffold(body: Stack(children: [content, Header()]));
  }
}

class FourPro extends StatefulWidget {
  final double screenWidth;
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;

  const FourPro({super.key, required this.screenWidth, required this.currentRoute, required this.subcategorie, required this.section});

  @override
  State<FourPro> createState() => _FourProState();
}

class _FourProState extends State<FourPro> {
  final ScrollController scrollController = ScrollController();
  bool scrollControllerLeft = false;
  bool scrollControllerRigth = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final position = scrollController.position;
    setState(() {
      scrollControllerLeft = position.pixels > 0;
      scrollControllerRigth = position.pixels < position.maxScrollExtent;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"icon": CupertinoIcons.shield, "text": "Protección superior para conservar la calidad de tus productos."},

      {"icon": CupertinoIcons.briefcase, "text": "Acabados premium que elevan la presentación de tu marca."},

      {"icon": CupertinoIcons.lock, "text": "Sellado seguro para mayor protección."},

      {"icon": CupertinoIcons.arrow_2_squarepath, "text": "Ideal para alimentos, suplementos, cosméticos y más."},
    ];

    final List<dynamic> localCards = [
      {
        "title": "La nueva 4PRO SmartBag.\nDiseñada para marcas inteligentes. Segura, funcional y con un diseño que habla por sí solo.",
        "image": "assets/img/home/eco.webp",
      },
      {
        "title": "Sella. Protege. Impacta.\nZipper hermético, materiales premium y acabados que destacan en cualquier estantería.",
        "image": "assets/img/home/eco.webp",
      },
      {
        "title":
            "El empaque que entiende tu producto.\nVersatilidad para alimentos, cosméticos, suplementos y mucho más. Siempre listo para destacar.",
        "image": "assets/img/home/eco.webp",
      },
      {
        "title": "Tecnología en cada detalle.\nLa 4PRO SmartBag combina innovación, presencia visual y sostenibilidad, en una sola solución.",
        "image": "assets/img/home/eco.webp",
      },
    ];

    final screenWidth = widget.screenWidth;

    return Padding(
      padding: EdgeInsets.only(top: 45),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TABS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),

              child: ScrollAnimatedWrapper(
                visibilityKey: Key('tabs'),
                child: Center(
                  child: SizedBox(
                    width: min(screenWidth, 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "4PRO",
                          style: TextStyle(
                            fontSize: min(screenWidth * 0.035, 56),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),

              child: Column(
                children: [
                  Center(
                    child: ScrollAnimatedWrapper(
                      visibilityKey: Key("Simplemente-funcional"),
                      child: Container(
                        width: min(screenWidth, 1500),
                        height: 600,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(161, 255, 255, 255)),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child:
                                  screenWidth < 700
                                      ? Image.asset("assets/img/smartbag/4Pro/prueba.png", fit: BoxFit.cover, alignment: Alignment.centerLeft)
                                      : Row(
                                        children: [
                                          Expanded(
                                            flex: 100,
                                            child: AspectRatio(
                                              aspectRatio: 16 / 16, // o el ratio real de tu video
                                              child: HtmlBackgroundVideo(
                                                src: 'assets/videos/smartbag/4pro/4pro.webm',
                                                loop: false,
                                                isPause: false,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Expanded(flex: 6, child: SizedBox()), // para balancear
                                        ],
                                      ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.1),
                              child: ScrollAnimatedWrapper(
                                visibilityKey: Key("Mas-Empaque"),
                                duration: Duration(milliseconds: 800),
                                delay: screenWidth < 700 ? Duration.zero : Duration(milliseconds: 550),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Simplemente \nfuncional.",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.04, 40), letterSpacing: 1.2),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Más que empaque, es lenguaje visual, versátil, \nsofisticado, y técnicamente ideal.",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: max(10, screenWidth * 0.01), letterSpacing: 1.2),
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor),
                                        foregroundColor: WidgetStateProperty.all(Colors.white),
                                        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 28, vertical: 18)),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8), // 🔽 Antes: 30
                                          ),
                                        ),
                                        elevation: WidgetStateProperty.all(6),
                                        shadowColor: WidgetStateProperty.all(Theme.of(context).primaryColor.withOpacity(0.3)),
                                        overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
                                      ),
                                      child: Text("Armar mi 4PRO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Nuestro-empaque"),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 100),
                      width: min(screenWidth * 0.95, 1300),
                      decoration: BoxDecoration(color: const Color.fromARGB(161, 255, 255, 255), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(CupertinoIcons.bag, size: min(screenWidth * 0.07, 40), color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                            child: Text(
                              "Nuestro empaque más versátil, resistente y elegante. Diseñado para brindar protección, presencia y funcionalidad en un solo producto. Ideal para marcas que quieren destacar.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: min(screenWidth * 0.025, 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('Items'),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: min(screenWidth, 1100),
                      child:
                          screenWidth < 900
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    items.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Row(
                                          children: [
                                            Icon(item["icon"], size: 28, color: Theme.of(context).primaryColor),
                                            const SizedBox(width: 12),
                                            Expanded(child: Text(item["text"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:
                                    items.map((item) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(item["icon"], size: 32, color: Theme.of(context).primaryColor),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: min(screenWidth * 0.18, 200),
                                            child: Text(
                                              item["text"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                              ),
                    ),
                  ),
                ],
              ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: Key('4funciones'),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),
                child: Text(
                  "4 Funciones, 4PRO",
                  style: TextStyle(fontSize: min(screenWidth * 0.03, 60), color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            //Discover local
            ScrollAnimatedWrapper(
              visibilityKey: Key('4funciones-cards'),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                child: Row(
                  children: List.generate(localCards.length, (int index) {
                    final card = localCards[index];
                    final double horizontalPadding = screenWidth * 0.06;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? horizontalPadding : 0,
                        right: index == localCards.length - 1 ? horizontalPadding : 20,
                      ),
                      child: Container(
                        width: min(screenWidth * 0.8, 1000),
                        height: min(screenWidth * 0.6, 700),
                        padding: EdgeInsets.only(top: 22, left: 22),
                        margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          image: DecorationImage(image: AssetImage(card['image']), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        card['title'],
                                        style: TextStyle(
                                          height: 0,
                                          color: Colors.white,
                                          fontSize: min(screenWidth * 0.03, 25),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 1, child: SizedBox(width: 100)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Botón izquierdo
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(scrollControllerLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                    ),
                    onPressed:
                        scrollControllerLeft
                            ? () {
                              scrollController.animateTo(
                                scrollController.offset - 1000,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            }
                            : null,
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(scrollControllerRigth ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                    ),
                    onPressed:
                        scrollControllerRigth
                            ? () {
                              scrollController.animateTo(
                                scrollController.offset + 1000,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            }
                            : null,
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(161, 255, 255, 255)),
              child: Column(
                children: [
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("una-familia"),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200, bottom: 100),
                      child: Center(
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: min(screenWidth * 0.04, 45), color: Colors.black, fontWeight: FontWeight.bold),

                          TextSpan(
                            children: [
                              TextSpan(text: "Una familia, "),
                              TextSpan(text: "múltiples funciones\n", style: TextStyle(color: Theme.of(context).primaryColor)),
                              TextSpan(text: "Siempre 4PRO."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('foto4pro'),
                    child: SizedBox(
                      height: min(screenWidth * 0.9, 1200),
                      child: Image.asset('assets/img/smartbag/discover5_Top.webp', height: MediaQuery.of(context).size.height * 0.9),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Textsfoto4pro"),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 100), vertical: 100),
                      width: min(screenWidth, 1100),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: min(screenWidth * 0.03, 25), height: 1.2, color: Colors.black),
                            children: [
                              const TextSpan(text: "Más que una bolsa, una solución inteligente. "),
                              const TextSpan(text: "Fabricada con polímeros avanzados y refuerzos termosellados, "),
                              TextSpan(
                                text: "la 4PRO SmartBag resiste peso, humedad y uso intensivo sin perder estética. ",
                                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(text: "Ideal para alimentos, suplementos o cosmética. "),
                              TextSpan(
                                text: "Su diseño optimiza la logística y mejora la experiencia del usuario. ",
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                              const TextSpan(text: "Alto rendimiento, pensado para hoy y mañana."),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  //Contenedores
                  Padding(padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 400)), child: buildResponsiveInfoCards(context)),
                  SizedBox(height: 200),
                ],
              ),
            ),
            const SizedBox(height: 100),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),

              child: Center(
                child: Container(
                  width: min(screenWidth, 1000),
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), spreadRadius: 2, blurRadius: 10)],
                  ),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key("porque4pro2"),
                    child: Row(
                      children: [
                        Image.asset("assets/img/BLogo.webp", height: 50),
                        SizedBox(width: 40),
                        Expanded(
                          child: Text.rich(
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withAlpha(200), fontSize: min(screenWidth * 0.03, 20)),
                            TextSpan(
                              children: [
                                TextSpan(text: "En PackVision entendimos que el mercado actual exige mucho más que un simple empaque; "),
                                TextSpan(
                                  text: "busca una experiencia completa que combine protección avanzada, ",
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                ),
                                TextSpan(text: "presentación visual impecable y funcionalidad práctica para el consumidor final. "),
                                TextSpan(text: "Por eso desarrollamos la 4PRO SmartBag, ", style: TextStyle(color: Theme.of(context).primaryColor)),
                                TextSpan(
                                  text:
                                      "una solución diseñada para elevar la percepción de tu producto, mantener su frescura por más tiempo y facilitar su uso diario. ",
                                ),
                                TextSpan(
                                  text:
                                      "La 4PRO combina tecnología de empaque multicapa, materiales de alta barrera y detalles como válvulas y cierres inteligentes ",
                                ),
                                TextSpan(
                                  text: "para que tu marca se destaque no solo por lo que ofrece, sino por cómo lo entrega.",
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 200),
            Footer(),
          ],
        ),
      ),
    );
  }
}

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
          width: min(constraints.maxWidth, 1100),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 350, child: InfoCard(data: items[0], maxFontSize: 16, isup: true)),
                    SizedBox(height: 350, child: InfoCard(data: items[1], maxFontSize: 16, isup: true)),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 700,
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
