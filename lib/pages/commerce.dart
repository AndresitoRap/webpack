import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/ImageSequenceScroller%201.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

double computeYOffset({
  required BuildContext context,
  required GlobalKey targetKey,
  required GlobalKey limitKey,
  required double currentYOffset,
  required bool shouldAnimate,
  required void Function() onStartAnimation,
}) {
  if (!targetKey.currentContext!.mounted || !limitKey.currentContext!.mounted) return currentYOffset;

  final RenderBox targetBox = targetKey.currentContext!.findRenderObject() as RenderBox;
  final targetPos = targetBox.localToGlobal(Offset.zero);
  final targetCenterY = targetPos.dy + targetBox.size.height / 2;

  final screenHeight = MediaQuery.of(context).size.height;
  final screenCenterY = screenHeight / 2;

  final RenderBox limitBox = limitKey.currentContext!.findRenderObject() as RenderBox;
  final limitPos = limitBox.localToGlobal(Offset.zero);

  if ((targetCenterY - screenCenterY).abs() < 10 && !shouldAnimate) {
    onStartAnimation();
  }

  if (shouldAnimate) {
    final double maxYOffset = limitPos.dy - targetBox.size.height - 10;
    final double targetOffset = screenCenterY - targetCenterY;
    final double clampedTarget = min(max(0, targetOffset), maxYOffset - targetPos.dy);
    return clampedTarget; // Actualización directa para seguir el scroll sin delay
  }

  return currentYOffset;
}

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

//Smartbag
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
  final ScrollController scrollControllerCards = ScrollController();
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
    scrollControllerCards.addListener(_handleScroll);

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
    final position = scrollControllerCards.position;
    setState(() {
      scrollControllerLeft = position.pixels > 0;
      scrollControllerRigth = position.pixels < position.maxScrollExtent;
    });
  }

  @override
  void dispose() {
    _imgCtrl.dispose();
    _imgCtrlDown.dispose();

    scrollControllerCards.dispose();
    super.dispose();
  }

  void checkGreenPosition() {
    final double newYOffset = computeYOffset(
      context: context,
      targetKey: greenKey,
      limitKey: redKey,
      currentYOffset: greenYOffset,
      shouldAnimate: isAnimatingGreen,
      onStartAnimation: () {
        isAnimatingGreen = true;
      },
    );

    setState(() {
      greenYOffset = newYOffset;
    });
  }

  final ScrollController scrollController = ScrollController();
  final GlobalKey greenKey = GlobalKey();
  final GlobalKey redKey = GlobalKey();
  bool showContentAfterSequence = false;

  double greenYOffset = 0;
  bool isAnimatingGreen = false;

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
    final double redPaddingTop = 588 * 5;

    return Padding(
      padding: EdgeInsets.only(top: 45),
      child: SingleChildScrollView(
        controller: scrollController,
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
                                                src: '/assets/assets/videos/smartbag/4pro/4pro.webm',
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
                controller: scrollControllerCards,
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
                      ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                        child: Column(
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
                        ),
                      )
                      : Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

                        child: Column(
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
            //Secuencia de imagenes
            Center(
              child: AnimatedContainer(
                key: greenKey,
                duration: Duration.zero,
                curve: Curves.linear,
                transform: Matrix4.translationValues(0, greenYOffset, 0),
                width: MediaQuery.of(context).size.height * 1.5,
                child: ImageSequenceScroller(
                  framePrefix: 'assets/img/smartbag/4pro/frames/frame',
                  frameExtension: 'webp',
                  totalFrames: 588,
                  width: double.infinity,
                  externalScrollController: scrollController,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: redPaddingTop, bottom: 1000), child: Container(key: redKey, height: 100, width: double.infinity)),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color.fromARGB(0, 255, 255, 255), Theme.of(context).primaryColor],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80, // puedes ajustar este valor
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScrollAnimatedWrapper(
                        visibilityKey: Key("Unica-e-in"),
                        child: Text(
                          "UNICA E INIGUALABLE",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.05, 48), fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 50),
                      ScrollAnimatedWrapper(
                        visibilityKey: Key('Image-unica-e-in'),
                        child: Image.asset("assets/img/smartbag/4pro.webp", fit: BoxFit.cover, height: 400),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('texto-unica-e-ini'),
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: min(screenWidth, 900),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: min(screenWidth * 0.04, 25), height: 1.2, color: Colors.black54),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "La bolsa 4PRO está diseñada para durar más y rendir mejor. ",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                                ),
                                TextSpan(
                                  text:
                                      "Su estructura optimizada es más ligera y resistente, sin comprometer su capacidad de protección. Con materiales de alta barrera y acabados técnicos, 4PRO ofrece un empaque más eficiente, más funcional y con un impacto visual superior. Además, su diseño versátil se adapta perfectamente a distintos formatos y sistemas de cierre, lo que la convierte en la opción ideal para marcas que buscan innovación y rendimiento sin ocupar más espacio.",
                                  style: TextStyle(fontWeight: FontWeight.w600),
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
            ),
            SizedBox(height: 100),
            Center(
              child: SizedBox(
                width: min(screenWidth, 1000),
                child: Column(
                  children: [
                    // FILA DE IMÁGENES (niveladas)
                    ScrollAnimatedWrapper(
                      visibilityKey: Key('Image-valv-y-ps'),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: min(screenWidth * 0.3, 300),
                                  height: min(screenWidth * 0.3, 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[200],
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/404.webp"), // tu imagen
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: min(screenWidth * 0.3, 300),
                                  height: min(screenWidth * 0.3, 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[200],
                                    image: DecorationImage(
                                      image: AssetImage("assets/img/404.webp"), // tu imagen
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // FILA DE TEXTOS (independiente, no afecta el alineado de arriba)
                    ScrollAnimatedWrapper(
                      visibilityKey: Key('image-text-valv-y-ps'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Peel Stick. ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: min(screenWidth * 0.03, 18),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "Práctico y versátil, este accesorio se adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
                                      style: TextStyle(fontSize: min(screenWidth * 0.03, 18), color: Colors.black87, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Valvula. ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: min(screenWidth * 0.03, 18),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
                                      style: TextStyle(fontSize: min(screenWidth * 0.03, 18), color: Colors.black87, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
            Footer(),
          ],
        ),
      ),
    );
  }
}

//Ecobag

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
  final String textLine1 = "4PRO";
  final String textLine2 = "EcoBag";
  bool _showImage = false;

  final List<bool> visibleLettersLine1 = [];
  final List<bool> visibleLettersLine2 = [];

  final Duration delayBetweenLetters = const Duration(milliseconds: 100);

  //Scroll colores
  final ScrollController _scrollColors = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;
  String selectedColor = "Kraft Azul";
  final ScrollController _scrollController = ScrollController();

  double scrollProgress = 0.0; // va de 0.0 a 1.0 según el scroll
  final GlobalKey _videoKey = GlobalKey();

  final List<Map<String, dynamic>> colors = [
    {"name": "Kraft Azul", "color": const Color.fromARGB(225, 18, 97, 161), "image": "assets/img/ecobag/4pro.webp"},
    {"name": "Kraft Blanco", "color": const Color.fromARGB(255, 199, 199, 199), "image": "assets/img/ecobag/4pro.webp"},
    {"name": "Kraft Beige", "color": const Color.fromARGB(255, 211, 163, 96), "image": "assets/img/ecobag/4pro.webp"},
    {"name": "Kraft Natural", "color": const Color.fromARGB(255, 242, 183, 135), "image": "assets/img/ecobag/4pro/Kraft_natural.webp"},
    {"name": "Kraft Natural Negro", "color": Colors.black87, "image": "assets/img/ecobag/4pro/Kraft_negro.webp"},
    {"name": "Kraft Natural Rojo", "color": Colors.red, "image": "assets/img/ecobag/4pro/Kraft_rojo.webp"},
    {"name": "Kraft Verde Oscuro", "color": Colors.green, "image": "assets/img/ecobag/4pro/Kraft_verde.webp"},
    {"name": "Kraft Verde Manzana Biche", "color": Colors.lightGreen, "image": "assets/img/ecobag/4pro.webp"},
  ];

  void _updateArrowVisibility() {
    if (!_scrollColors.hasClients || !_scrollColors.position.hasContentDimensions) return;

    final offset = _scrollColors.offset;
    final maxScroll = _scrollColors.position.maxScrollExtent;

    setState(() {
      _showLeftArrow = offset > 10;
      _showRightArrow = offset < maxScroll - 10;
    });
  }

  void _scrollRight() {
    final newOffset = (_scrollColors.offset + 200).clamp(0.0, _scrollColors.position.maxScrollExtent);
    _scrollColors.animateTo(newOffset, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  void _scrollLeft() {
    final newOffset = (_scrollColors.offset - 200).clamp(0.0, _scrollColors.position.maxScrollExtent);
    _scrollColors.animateTo(newOffset, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() {
        _showImage = true;
      });
    });

    //Scroll colores
    _scrollColors.addListener(_updateArrowVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateArrowVisibility());

    // Listener de scroll principal
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // RenderBox del widget
    final box = _videoKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Distancia desde el widget hasta la parte superior visible
    final widgetTop = box.localToGlobal(Offset.zero).dy;
    final viewportHeight = MediaQuery.of(context).size.height;

    // Queremos que la animación empiece cuando el widget
    // entra en los primeros 200 px del viewport
    final raw = (viewportHeight - widgetTop).clamp(0, 200);
    final progress = raw / 180;

    setState(() => scrollProgress = progress);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Aquí es seguro usar context para precargar
    for (var item in colors) {
      precacheImage(AssetImage(item["image"]), context);
    }
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < textLine1.length; i++) {
      await Future.delayed(delayBetweenLetters);
      setState(() {
        visibleLettersLine1.add(true);
      });
    }

    await Future.delayed(const Duration(milliseconds: 300)); // pequeño delay entre líneas

    for (int i = 0; i < textLine2.length; i++) {
      await Future.delayed(delayBetweenLetters);
      setState(() {
        visibleLettersLine2.add(true);
      });
    }
  }

  @override
  void dispose() {
    _scrollColors.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = widget.screenWidth;
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedItem = colors.firstWhere((item) => item["name"] == selectedColor, orElse: () => colors.first);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 255, 252),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight,
              child: SizedBox(
                height: screenHeight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _showImage ? 1.0 : 0.0,
                        duration: const Duration(seconds: 2), // duración del fade in
                        curve: Curves.easeInOut,
                        child: SizedBox(height: 500, width: 500, child: Image.asset("assets/img/ecobag/4pro.webp", fit: BoxFit.cover)),
                      ),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(textLine1.length, (index) {
                          return AnimatedLetter(
                            char: textLine1[index],
                            visible: index < visibleLettersLine1.length,
                            key: ValueKey("line1-$index"),
                            textStyle: TextStyle(fontSize: min(screenWidth * 0.1, 130), fontWeight: FontWeight.bold, color: Colors.black),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(textLine2.length, (index) {
                          return AnimatedLetter(
                            char: textLine2[index],
                            visible: index < visibleLettersLine2.length,
                            key: ValueKey("line2-$index"),
                            textStyle: TextStyle(
                              fontSize: min(screenWidth * 0.1, 90),
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 75, 141, 44),
                            ),
                          );
                        }),
                      ),
                      AnimatedOpacity(
                        opacity: _showImage ? 1.0 : 0.0,
                        duration: const Duration(seconds: 2), // duración del fade in
                        curve: Curves.easeInOut,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white),
                              overlayColor: WidgetStatePropertyAll(Color.fromARGB(255, 222, 240, 213)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedTextKit(
                                repeatForever: false,
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    "Crear mi Ecobag® 4PRO",
                                    textStyle: TextStyle(fontSize: 20),
                                    colors: [Color.fromARGB(255, 75, 141, 44), Color.fromARGB(255, 75, 141, 44), Colors.white],
                                    speed: Duration(milliseconds: 500),
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
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 40),
              width: min(screenWidth, 1720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('nuevaforma-text'),

                    child: Text(
                      "Nueva forma de ver\nla sustentabilidad",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 75, 141, 44),
                        fontSize: min(screenWidth * 0.08, 70),
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('ecobag4pronacio-text'),

                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: min(screenWidth, 700),
                        child: Text(
                          "Ecobag® 4PRO nació de la necesidad de redefinir el empaque sostenible. Su diseño integra materiales responsables con el medio ambiente y un enfoque funcional que no sacrifica estilo ni eficiencia. Estructura reforzada, resistencia superior y acabado elegante, es ideal para marcas que buscan destacar y, al mismo tiempo, reducir su huella ecológica.",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black54, fontSize: min(screenWidth * 0.032, 25), height: 1.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('resistenciaconestilo-text'),

                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 800,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(255, 242, 248, 240)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            style: TextStyle(fontSize: min(screenWidth * 0.032, 23)),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Resistencia con estilo. Ecobag® 4PRO ",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44)),
                                ),
                                TextSpan(
                                  text:
                                      "está disponible en una gama de colores vibrantes y naturales que reflejan el compromiso con la sostenibilidad y el diseño contemporáneo.",
                                ),
                              ],
                            ),
                          ),
                          if (screenWidth >= 990) SizedBox(height: 100),
                          Expanded(child: Center(child: Image.asset("assets/img/ecobag/4pro/Bags.png", fit: BoxFit.contain))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenWidth >= 800 ? 200 : 50),

            ScrollAnimatedWrapper(
              visibilityKey: Key('Packvision-conecta'),
              child: Column(
                children: [
                  Text(
                    "PackVision®",
                    style: TextStyle(
                      color: Color.fromARGB(255, 75, 141, 44),
                      fontWeight: FontWeight.bold,
                      fontSize: min(screenWidth * 0.08, 60),
                      height: 0,
                    ),
                  ),
                  Text(
                    "Conecta con lo esencial.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: min(screenWidth * 0.08, 60), height: 0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    width: 1000,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Más que tecnología, es una forma de repensar el empaque. Con Ecobag® 4PRO, visualizas cada detalle con intención: desde el material hasta el impacto ambiental. Explora opciones sostenibles, adapta tu diseño a lo que el planeta necesita y toma decisiones que marcan la diferencia. Rápido, simple y responsable.",
                        style: TextStyle(fontSize: min(screenWidth * 0.025, 23), color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: double.infinity,
                height: 800,
                constraints: BoxConstraints(minHeight: 800),
                child: ScrollAnimatedWrapper(
                  visibilityKey: Key("Change-bag"),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Sombra desde abajo
                      Positioned(
                        bottom: -70,
                        left: 0,
                        right: 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [selectedItem["color"].withAlpha(50), const Color.fromARGB(0, 255, 255, 255)],
                            ),
                          ),
                        ),
                      ),

                      // Imagen bajada y cortada
                      screenWidth <= 1000
                          ? Positioned(
                            bottom: -100,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                // Lista horizontal
                                SizedBox(
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: SingleChildScrollView(
                                          controller: _scrollColors,
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children:
                                                colors
                                                    .map(
                                                      (item) =>
                                                          _buildColorLabel(item["name"], item["color"], isSelected: selectedColor == item["name"]),
                                                    )
                                                    .toList(),
                                          ),
                                        ),
                                      ),
                                      // Flechas
                                      if (_showLeftArrow)
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.centerRight,
                                                end: Alignment.centerLeft,
                                                colors: [Colors.white60, Colors.white],
                                              ),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(CupertinoIcons.chevron_left, color: Color(0xFF4B8D2C)),
                                              onPressed: _scrollLeft,
                                            ),
                                          ),
                                        ),

                                      // Flecha derecha
                                      if (_showRightArrow)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [Colors.white60, Colors.white],
                                              ),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(CupertinoIcons.chevron_right, color: Color(0xFF4B8D2C)),
                                              onPressed: _scrollRight,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Imagen centrada
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  switchInCurve: Curves.easeInOut,
                                  switchOutCurve: Curves.easeInOut,
                                  transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child),
                                  child: SizedBox(
                                    key: ValueKey(selectedItem["image"]),
                                    height: 700,
                                    child: Image.asset(selectedItem["image"], fit: BoxFit.fitHeight),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Stack(
                            children: [
                              Positioned(
                                bottom: -100,
                                left: 200,
                                right: 0,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400), // ⏱️ velocidad del fade
                                  switchInCurve: Curves.easeInOut, // suavizado
                                  switchOutCurve: Curves.easeInOut,
                                  transitionBuilder: (Widget child, Animation<double> anim) => FadeTransition(opacity: anim, child: child),
                                  child: SizedBox(
                                    height: 800,
                                    child: Image.asset(selectedItem["image"], key: ValueKey(selectedItem["image"]), fit: BoxFit.fitHeight),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 700,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                                    child: ListView(
                                      children:
                                          colors
                                              .map(
                                                (item) =>
                                                    _buildColorLabelColumn(item["name"], item["color"], isSelected: selectedColor == item["name"]),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                  SizedBox(width: 710),
                                ],
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: screenWidth >= 800 ? 200 : 50),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Protege-imapacta"),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.06, 60), height: 0.9),
                        TextSpan(
                          children: [
                            TextSpan(text: "4PRO Ecobag®", style: TextStyle(color: Color.fromARGB(255, 75, 141, 44))),
                            TextSpan(text: "\nProtege. Impacta. Transforma."),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth <= 1000 ? 50 : 100),
                    child: Text.rich(
                      style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                      TextSpan(
                        children: [
                          TextSpan(text: "Disponible en versiones de "),
                          TextSpan(text: "3 y 4 láminas ", style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold)),
                          TextSpan(text: "para adaptarse a tus necesidades de protección, frescura y sostenibilidad."),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child:
                        screenWidth <= 1000
                            ? Column(
                              children: [
                                Text.rich(
                                  style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Las bolsas Ecobag 4PRO están compuestas por 3 láminas que trabajan juntas para mantener "),
                                      TextSpan(
                                        text: "la frescura y resistencia en cada empaque. ",
                                        style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: "Esta estructura optimiza el rendimiento sin sacrificar flexibilidad ni sostenibilidad."),
                                    ],
                                  ),
                                ),
                                Image.asset("assets/img/ecobag/4pro/Kraft_negro.webp", height: 600, fit: BoxFit.fitHeight),
                                Text.rich(
                                  style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Cuando tu diseño requiere una ventana frontal, "),
                                      TextSpan(
                                        text: "se añade una cuarta lámina que protege sin comprometer la visibilidad del producto. ",
                                        style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: " La capa adicional mantiene la integridad del empaque mientras ofrece una experiencia visual única.",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                            : SizedBox(
                              width: 1200,
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Text.rich(
                                            style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Las bolsas Ecobag 4PRO están compuestas por 3 láminas que trabajan juntas para mantener ",
                                                ),
                                                TextSpan(
                                                  text: "la frescura y resistencia en cada empaque. ",
                                                  style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: "Esta estructura optimiza el rendimiento sin sacrificar flexibilidad ni sostenibilidad.",
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: screenWidth <= 1000 ? 50 : 100),
                                          Text.rich(
                                            style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                            TextSpan(
                                              children: [
                                                TextSpan(text: "Cuando tu diseño requiere una ventana frontal, "),
                                                TextSpan(
                                                  text: "se añade una cuarta lámina que protege sin comprometer la visibilidad del producto. ",
                                                  style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " La capa adicional mantiene la integridad del empaque mientras ofrece una experiencia visual única.",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Image.asset("assets/img/ecobag/4pro/Kraft_negro.webp", fit: BoxFit.fitHeight, height: 600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth <= 1000 ? 50 : 150),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: SizedBox(
                width: min(screenWidth, 1720),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        "Con sistema de cierre.",
                        style: TextStyle(
                          fontSize: min(screenWidth * 0.06, 50),
                          color: Color.fromARGB(255, 75, 141, 44),
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.start,
                        "Preserva la frescura con válvula y\nPeel & Stick sin complicaciones.",
                        style: TextStyle(fontSize: min(screenWidth * 0.06, 50), fontWeight: FontWeight.bold, height: 0),
                      ),
                      SizedBox(height: 30),

                      Text(
                        "La Ecobag 4PRO con sistema de válvula y sello Peel & Stick ofrece una solución versátil y práctica para preservar la frescura de tus productos. Su diseño multicapa permite una conservación prolongada, mientras que la válvula garantiza una liberación controlada de gases. El cierre Peel & Stick aporta facilidad de uso y reutilización sin comprometer el sellado. Todo en un empaque sostenible, inteligente y visualmente impactante.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: min(screenWidth * 0.03, 25), fontWeight: FontWeight.w500, height: 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Center(
              child: Center(
                child: Builder(
                  builder: (context) {
                    final borderRadius = BorderRadius.circular(30 * scrollProgress);
                    final horizontalPadding = screenWidth * 0.055 * scrollProgress;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
                      child: ClipRRect(
                        key: _videoKey,
                        borderRadius: borderRadius,
                        child: Container(
                          width: double.infinity,
                          height: min(screenHeight * 0.8, 1100),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ValueListenableBuilder<bool>(
                                valueListenable: videoBlurNotifier,
                                builder: (context, isBlur, _) {
                                  return HtmlBackgroundVideo(
                                    src: 'assets/assets/videos/smartbag/SmartbagInicio.webm',
                                    blur: isBlur,
                                    loop: true,
                                    showControls: true,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorLabel(String text, Color color, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = text;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(color: isSelected ? color : Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: 40,
                decoration: BoxDecoration(color: isSelected ? color : Colors.transparent, borderRadius: BorderRadius.circular(1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorLabelColumn(String text, Color color, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = text;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Row(
            children: [
              Icon(Icons.circle, color: isSelected ? Colors.white : color, size: 16),
              const SizedBox(width: 10),
              Text(text, style: TextStyle(color: isSelected ? Colors.white : color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
