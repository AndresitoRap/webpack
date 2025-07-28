import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/4pro/imageSequenceScroller.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/footer.dart';

import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

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
    scrollController.addListener(checkGreenPosition);
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

  // secuencia

  final ScrollController scrollController = ScrollController();
  final GlobalKey greenKey = GlobalKey();
  final GlobalKey redKey = GlobalKey();
  bool showContentAfterSequence = false;

  double greenYOffset = 0;
  bool isAnimatingGreen = false;

  void handlePinChange(bool isPinned) {
    if (!isPinned && !showContentAfterSequence) {
      setState(() {
        showContentAfterSequence = true;
      });
    }
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

  // final de secuencia
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double redPaddingTop = 294 * 5; // 8px por frame
    final List<Map<String, dynamic>> items = [
      {"icon": CupertinoIcons.shield, "text": "Protección superior para conservar la calidad de tus productos."},

      {"icon": CupertinoIcons.briefcase, "text": "Acabados premium que elevan la presentación de tu marca."},

      {"icon": CupertinoIcons.lock, "text": "Sellado seguro para mayor protección."},

      {"icon": CupertinoIcons.arrow_2_squarepath, "text": "Ideal para alimentos, suplementos, cosméticos y más."},
    ];

    final List<dynamic> localCards = [
      {
        "title": "4PRO SmartBag:\nsegura, funcional y diseñada para marcas inteligentes",
        "image": "assets/img/smartbag/4pro/card1.webp",
        "colorText": Colors.white,
      },
      {
        "title": "Sella. Protege. Impacta.\nZipper hermético, materiales premium y acabados que destacan en cualquier estantería.",
        "image": "assets/img/smartbag/4pro/card2.webp",
        "colorText": Colors.white,
      },
      {
        "title":
            "El empaque que entiende tu producto.\nVersatilidad para alimentos, cosméticos, suplementos y mucho más. Siempre listo para destacar.",
        "image": "assets/img/smartbag/4pro/card3.webp",
        "colorText": Colors.white,
      },
      {
        "title": "Tecnología en cada detalle.\nLa 4PRO SmartBag combina innovación, presencia visual y sostenibilidad, en una sola solución.",
        "image": "assets/img/smartbag/4pro/card4.webp",
        "colorText": Colors.white,
      },
    ];

    final screenWidth = widget.screenWidth;

    return Padding(
      padding: EdgeInsets.only(top: 45),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
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
                      visibilityKey: const Key("Simplemente-funcional"),
                      child: Container(
                        width: min(screenWidth, 1500),
                        height: 600,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(161, 255, 255, 255)),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child:
                                  screenWidth < 700
                                      ? Image.asset(
                                        "assets/img/smartbag/4Pro/prueba.png",
                                        cacheWidth: 800,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.centerLeft,
                                      )
                                      : Row(
                                        children: [
                                          Expanded(
                                            flex: 40,
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9, // o el ratio real de tu video
                                              child: VideoFlutter(
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
                                visibilityKey: const Key("Mas-Empaque"),
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
                                        shadowColor: WidgetStateProperty.all(Theme.of(context).primaryColor.withAlpha(70)),
                                        overlayColor: WidgetStateProperty.all(Colors.white.withAlpha(40)),
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
                    visibilityKey: const Key("Nuestro-empaque"),
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
                        height: min(screenWidth * 0.6, 550),
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
                                      Padding(
                                        padding: EdgeInsets.only(left: screenWidth * 0.02, top: screenWidth * 0.01),
                                        child: Text(
                                          card['title'],
                                          style: TextStyle(
                                            height: 0,
                                            color: card['colorText'] ?? Colors.white,
                                            fontSize: min(screenWidth * 0.03, 25),
                                            fontWeight: FontWeight.bold,
                                          ),
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
                              scrollControllerCards.animateTo(
                                scrollControllerCards.offset - 1000,
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
                              scrollControllerCards.animateTo(
                                scrollControllerCards.offset + 1000,
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
                    visibilityKey: const Key("una-familia"),
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
                                      child: SlideTransition(
                                        position: _imgSlide,
                                        child: Image.asset("assets/img/smartbag/4pro/top.webp", cacheWidth: 800),
                                      ),
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
                                      child: SlideTransition(
                                        position: _imgSlide2,
                                        child: Image.asset("assets/img/smartbag/4pro/down.webp", cacheWidth: 800),
                                      ),
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
                                child: SlideTransition(
                                  position: _imgSlide2,
                                  child: Image.asset("assets/img/smartbag/4pro/down.webp", cacheWidth: 800),
                                ),
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
                                child: SlideTransition(position: _imgSlide, child: Image.asset("assets/img/smartbag/4pro/top.webp", cacheWidth: 800)),
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
                    child: ScrollAnimatedWrapper(visibilityKey: const Key("Info4pro"), child: buildResponsiveInfoCards(context)),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),

            if (screenWidth >= 700) ...[
              // 👉 PC o Tablet → animación con secuencia
              Center(
                child: AnimatedContainer(
                  key: greenKey,
                  duration: Duration.zero,
                  curve: Curves.linear,
                  transform: Matrix4.translationValues(0, greenYOffset, 0),
                  width: screenHeight * 1.1,
                  child: ImageSequenceScroller(
                    framePrefix: 'assets/img/smartbag/4pro/frames/frame',
                    frameExtension: 'webp',
                    totalFrames: 294,
                    width: double.infinity,
                    externalScrollController: scrollController,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: redPaddingTop - 100), child: SizedBox(key: redKey, height: 100, width: double.infinity)),
            ] else ...[
              // 👉 Móvil → mostrar 4 imágenes fijas en columna
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // igual que el resto del diseño
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/smartbag/4pro/frames/frame0046.webp',
                      width: double.infinity,
                      fit: BoxFit.contain,
                      cacheWidth: 1920,
                      filterQuality: FilterQuality.high,
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/img/smartbag/4pro/frames/frame0111.webp',
                      width: double.infinity,
                      fit: BoxFit.contain,
                      cacheWidth: 1920,
                      filterQuality: FilterQuality.high,
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/img/smartbag/4pro/frames/frame0186.webp',
                      width: double.infinity,
                      fit: BoxFit.contain,
                      cacheWidth: 1920,
                      filterQuality: FilterQuality.high,
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/img/smartbag/4pro/frames/frame0250.webp',
                      width: double.infinity,
                      fit: BoxFit.contain,
                      cacheWidth: 1920,
                      filterQuality: FilterQuality.high,
                    ),
                  ],
                ),
              ),
            ],
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
                        visibilityKey: const Key("Unica-e-in"),
                        child: Text(
                          "UNICA E INIGUALABLE",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.05, 48), fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 50),
                      ScrollAnimatedWrapper(
                        visibilityKey: Key('Image-unica-e-in'),
                        child: Image.asset("assets/img/smartbag/4pro.webp", fit: BoxFit.cover, cacheWidth: 800, height: 400),
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
            ScrollAnimatedWrapper(
              visibilityKey: Key('image-text-valv-y-ps'),
              child:
                  screenWidth >= 1000
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildFeatureCard(
                            context,
                            height: screenHeight * 0.45,
                            width: screenWidth * 0.27,
                            title: "Peel Stick. ",
                            description:
                                "Práctico y versátil, este accesorio se adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
                            imagePath: "assets/img/smartbag/4pro/peel.webp",
                            isDowntext: false,
                          ),
                          SizedBox(width: 20),
                          buildFeatureCard(
                            context,
                            height: screenHeight * 0.45,
                            width: screenWidth * 0.27,
                            title: "Valvula. ",
                            description:
                                "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
                            imagePath: "assets/img/smartbag/4pro/valvulas.webp",
                          ),
                        ],
                      )
                      : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildFeatureCard(
                              context,
                              height: screenHeight * 0.45,
                              width: screenWidth * 0.9,
                              title: "Peel Stick. ",
                              description:
                                  "Práctico y versátil, este accesorio se adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
                              imagePath: "assets/img/smartbag/4pro/peel.webp",
                              isDowntext: false,
                            ),
                            SizedBox(height: 30),
                            buildFeatureCard(
                              context,
                              height: screenHeight * 0.45,
                              width: screenWidth * 0.9,
                              title: "Valvula. ",
                              description:
                                  "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
                              imagePath: "assets/img/smartbag/4pro/valvulas.webp",
                            ),
                          ],
                        ),
                      ),
            ),

            SizedBox(height: 100),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

Widget buildFeatureCard(
  BuildContext context, {
  required double height,
  required double width,
  required String title,
  required String description,
  required String imagePath,
  bool? isDowntext = true,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(color: const Color.fromARGB(161, 238, 238, 238), borderRadius: BorderRadius.circular(20)),
    child:
        isDowntext == true
            ? Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: min(screenWidth * 0.8, 400),
                      height: min(screenWidth * 0.8, 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(alignment: Alignment.bottomCenter, image: AssetImage(imagePath), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.03, 18), color: Theme.of(context).primaryColor),
                        ),
                        TextSpan(
                          text: description,
                          style: TextStyle(fontSize: min(screenWidth * 0.03, 18), color: Colors.black87, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.03, 18), color: Theme.of(context).primaryColor),
                        ),
                        TextSpan(
                          text: description,
                          style: TextStyle(fontSize: min(screenWidth * 0.03, 18), color: Colors.black87, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: min(screenWidth * 0.8, 400),
                      height: min(screenWidth * 0.8, 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(alignment: Alignment.bottomCenter, image: AssetImage(imagePath), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ],
            ),
  );
}
