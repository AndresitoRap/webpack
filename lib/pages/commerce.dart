import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
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
    final section = widget.section.toLowerCase();
    final categoryName = widget.selectedSubcategorie.category.name.toLowerCase();
    Widget content;

    if (categoryName == 'smartbag') {
      switch (section) {
        case '4pro':
          content = FourPro(screenWidth: screenWidth, currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);
          break;

        case 'ecobag':
          content = FourProEco(
            screenWidth: screenWidth,
            currentRoute: currentRoute,
            subcategorie: widget.selectedSubcategorie,
            section: widget.section,
          );
          break;

        default:
          content = const Center(child: Text('Sub‑sección no encontrada'));
      }
    } else {
      switch (section) {
        case '4pro':
          content = FourProEco(
            screenWidth: screenWidth,
            currentRoute: currentRoute,
            subcategorie: widget.selectedSubcategorie,
            section: widget.section,
          );
          break;

        default:
          content = const Center(child: Text('Categoría no encontrada'));
      }
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

class _FourProState extends State<FourPro> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  bool scrollControllerLeft = false;
  bool scrollControllerRigth = true;

  late final AnimationController _imgCtrl;
  late final Animation<Offset> _imgSlide;
  late final Animation<double> _imgOpacity;

  late final AnimationController _imgCtrlDown;
  late final Animation<Offset> _imgSlide2;
  late final Animation<double> _imgOpacityDown;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_handleScroll);

    _imgCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _imgOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _imgCtrl, curve: Curves.easeOut));

    _imgSlide = Tween<Offset>(
      begin: const Offset(0.1, 0), // fuera a la derecha
      end: Offset.zero, // posición final
    ).animate(CurvedAnimation(parent: _imgCtrl, curve: Curves.easeOut));

    _imgCtrlDown = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    _imgOpacityDown = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _imgCtrlDown, curve: Curves.easeOut));

    _imgSlide2 = Tween<Offset>(
      begin: const Offset(-0.1, 0), // entra desde la izquierda
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imgCtrlDown, curve: Curves.easeOut));
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
    _imgCtrl.dispose();
    _imgCtrlDown.dispose();

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
                                      onPressed: () {
                                        final route = '${widget.subcategorie.route}/crea-tu-empaque';
                                        navigateWithSlide(context, route); // tu función personalizada
                                      },
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
                      padding: const EdgeInsets.only(top: 200, bottom: 50),
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
                  screenWidth >= 790
                      ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ScrollAnimatedWrapper(
                                  visibilityKey: Key('text-foto-4pro-familia'),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 50)),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Más que empaque, ",
                                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                "es identidad funcional. 4PRO SmartBag se adapta, protege y representa lo que tu marca realmente quiere decir.",
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: min(screenWidth * 0.020, 22), fontWeight: FontWeight.w500, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: VisibilityDetector(
                                  key: const Key('img-slide-anim'),
                                  onVisibilityChanged: (info) {
                                    if (info.visibleFraction > 0.5 && !_imgCtrl.isCompleted) {
                                      _imgCtrl.forward();
                                    }
                                  },
                                  child: FadeTransition(
                                    opacity: _imgOpacity,
                                    child: SlideTransition(position: _imgSlide, child: Image.asset("assets/img/smartbag/4pro/top.webp")),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: min(screenWidth * 0.1, 70)),
                          Row(
                            children: [
                              Expanded(
                                child: VisibilityDetector(
                                  key: const Key('img-slide-anim2'),
                                  onVisibilityChanged: (info) {
                                    if (info.visibleFraction > 0.5 && !_imgCtrlDown.isCompleted) {
                                      _imgCtrlDown.forward();
                                    }
                                  },
                                  child: FadeTransition(
                                    opacity: _imgOpacityDown,
                                    child: SlideTransition(position: _imgSlide2, child: Image.asset("assets/img/smartbag/4pro/down.webp")),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 50)),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Tecnología, confianza y diseño\n",
                                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:
                                              "en cada capa de la 4PRO SmartBag. Diseñada para quienes necesitan soluciones con impacto real y protección superior.",
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: min(screenWidth * 0.020, 22), fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          VisibilityDetector(
                            key: const Key('img-slide-anim2'),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0.5 && !_imgCtrlDown.isCompleted) {
                                _imgCtrlDown.forward();
                              }
                            },
                            child: FadeTransition(
                              opacity: _imgOpacityDown,
                              child: SlideTransition(position: _imgSlide2, child: Image.asset("assets/img/smartbag/4pro/down.webp")),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 100), vertical: 50),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Tecnología, confianza y diseño\n", style: TextStyle(color: Theme.of(context).primaryColor)),
                                  TextSpan(text: "en cada capa de la 4PRO SmartBag.\n"),
                                  TextSpan(text: "Diseñada para quienes necesitan soluciones\ncon impacto real y protección superior."),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: min(screenWidth * 0.025, 25), fontWeight: FontWeight.bold),
                            ),
                          ),
                          VisibilityDetector(
                            key: const Key('img-slide-anim'),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0.5 && !_imgCtrl.isCompleted) {
                                _imgCtrl.forward();
                              }
                            },
                            child: FadeTransition(
                              opacity: _imgOpacity,
                              child: SlideTransition(position: _imgSlide, child: Image.asset("assets/img/smartbag/4pro/top.webp")),
                            ),
                          ),
                          ScrollAnimatedWrapper(
                            visibilityKey: Key('text-foto-4pro-familia'),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 100), vertical: 50),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Más que empaque, ", style: TextStyle(color: Theme.of(context).primaryColor)),
                                    TextSpan(text: "es identidad funcional.\n"),
                                    TextSpan(text: "4PRO SmartBag se adapta, protege y representa\nlo que tu marca realmente quiere decir."),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: min(screenWidth * 0.025, 25), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                  //Contenedores
                  SizedBox(height: screenWidth >= 790 ? 200 : 60),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 400)),
                    child: ScrollAnimatedWrapper(visibilityKey: Key("Info4pro"), child: buildResponsiveInfoCards(context)),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
            Container(width: double.infinity, height: 100, child: Text("Secuencia de imagenes")),
            SizedBox(height: 100),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class FourProEco extends StatefulWidget {
  final double screenWidth;
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;

  const FourProEco({super.key, required this.screenWidth, required this.currentRoute, required this.subcategorie, required this.section});

  @override
  State<FourProEco> createState() => _FourProEcoState();
}

class _FourProEcoState extends State<FourProEco> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _entryAnimations;
  late Animation<double> _arcAnimation;
  final int cardCount = 5; // Número de cards
  final double cardWidth = 150; // Ancho de cada card
  final double arcRadius = 300; // Radio del arco

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10), // Duración total del ciclo
      vsync: this,
    )..repeat(); // Repite la animación continuamente

    // Animaciones de entrada (de izquierda a derecha)
    _entryAnimations = List.generate(
      cardCount,
      (index) => Tween<double>(begin: -widget.screenWidth, end: 0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.1, // Retraso para cada card
            (index * 0.1) + 0.3, // Duración de entrada
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    // Animación del movimiento en arco
    _arcAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.linear), // Comienza después de la entrada
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: screenHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 41, 112, 9), Colors.transparent],
            ),
          ),
          child: Stack(
            children: List.generate(cardCount, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Posición inicial en X (entrada)
                  double xOffset = _entryAnimations[index].value;
                  // Si la animación de entrada ha terminado, aplicar movimiento en arco
                  if (_controller.value > (index * 0.1 + 0.3)) {
                    // Calcular posición en el arco
                    double angle = _arcAnimation.value + (index * (pi / (cardCount + 1)));
                    xOffset = widget.screenWidth / 2 + arcRadius * cos(angle) - cardWidth / 2;
                  }

                  return Positioned(
                    left: xOffset,
                    top: screenHeight * 0.4 + arcRadius * sin((index * (pi / (cardCount + 1))) + _arcAnimation.value),
                    child: Transform.rotate(
                      angle: _arcAnimation.value * 0.1, // Rotación suave para efecto dinámico
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          width: cardWidth,
                          height: 200,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Producto ${index + 1}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Descripción del producto en la 4PRO SmartBag.',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
