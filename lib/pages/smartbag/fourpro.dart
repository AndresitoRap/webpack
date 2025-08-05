import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/4pro/imagesequencescroller.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

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
    final Responsive r = Responsive.of(context);
    final blue = Theme.of(context).primaryColor;
    final isMobile = r.wp(100) < 850;
    final route = '${widget.subcategorie.route}/crea-tu-empaque';

    final double screenHeight = MediaQuery.of(context).size.height;
    final double redPaddingTop = 294 * 5; // 8px por frame

    final screenWidth = widget.screenWidth;

    return CustomScrollView(
      slivers: [
        Start4PROSliver(r: r, blue: blue, isMobile: isMobile, route: route),
        Scroll4FunctionsSliver(r: r, blue: blue, isMobile: isMobile),
        MultipleFunctionsSliver(r: r, blue: blue),
      ],
    );

    // Padding(
    //   padding: EdgeInsets.only(top: 45),
    //   child: SingleChildScrollView(
    //     controller: scrollController,
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [

    //         //Discover local
    //
    //         Padding(
    //           padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.1),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               // Botón izquierdo
    //               IconButton(
    //                 style: ButtonStyle(
    //                   backgroundColor: WidgetStateProperty.all(scrollControllerLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
    //                 ),
    //                 onPressed:
    //                     scrollControllerLeft
    //                         ? () {
    //                           scrollControllerCards.animateTo(
    //                             scrollControllerCards.offset - 1000,
    //                             duration: Duration(milliseconds: 200),
    //                             curve: Curves.easeInOut,
    //                           );
    //                         }
    //                         : null,
    //                 icon: Icon(Icons.arrow_back_ios_new_rounded),
    //               ),
    //               const SizedBox(width: 20),
    //               IconButton(
    //                 style: ButtonStyle(
    //                   backgroundColor: WidgetStateProperty.all(scrollControllerRigth ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
    //                 ),
    //                 onPressed:
    //                     scrollControllerRigth
    //                         ? () {
    //                           scrollControllerCards.animateTo(
    //                             scrollControllerCards.offset + 1000,
    //                             duration: Duration(milliseconds: 200),
    //                             curve: Curves.easeInOut,
    //                           );
    //                         }
    //                         : null,
    //                 icon: Icon(Icons.arrow_forward_ios_rounded),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           width: double.infinity,
    //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(161, 255, 255, 255)),
    //           child: Column(
    //             children: [
    //               ScrollAnimatedWrapper(
    //                 visibilityKey: const Key("una-familia"),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(top: 200, bottom: 50),
    //                   child: Center(
    //                     child: Text.rich(
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(fontSize: min(screenWidth * 0.04, 45), color: Colors.black, fontWeight: FontWeight.bold),

    //                       TextSpan(
    //                         children: [
    //                           TextSpan(text: "Una familia, "),
    //                           TextSpan(text: "múltiples funciones\n", style: TextStyle(color: Theme.of(context).primaryColor)),
    //                           TextSpan(text: "Siempre 4PRO."),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               screenWidth >= 790
    //                   ? Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Expanded(
    //                               child: ScrollAnimatedWrapper(
    //                                 visibilityKey: Key('text-foto-4pro-familia'),
    //                                 child: Padding(
    //                                   padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 50)),
    //                                   child: Text.rich(
    //                                     TextSpan(
    //                                       children: [
    //                                         TextSpan(
    //                                           text: "Más que empaque, ",
    //                                           style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    //                                         ),
    //                                         TextSpan(
    //                                           text:
    //                                               "es identidad funcional. 4PRO SmartBag se adapta, protege y representa lo que tu marca realmente quiere decir.",
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     textAlign: TextAlign.justify,
    //                                     style: TextStyle(fontSize: min(screenWidth * 0.020, 22), fontWeight: FontWeight.w500, color: Colors.black),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),

    //                             Expanded(
    //                               child: VisibilityDetector(
    //                                 key: const Key('img-slide-anim'),
    //                                 onVisibilityChanged: (info) {
    //                                   if (info.visibleFraction > 0.5 && !_imgCtrl.isCompleted) {
    //                                     _imgCtrl.forward();
    //                                   }
    //                                 },
    //                                 child: FadeTransition(
    //                                   opacity: _imgOpacity,
    //                                   child: SlideTransition(
    //                                     position: _imgSlide,
    //                                     child: Image.asset("assets/img/smartbag/4pro/top.webp", cacheWidth: 800),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(height: min(screenWidth * 0.1, 70)),
    //                         Row(
    //                           children: [
    //                             Expanded(
    //                               child: VisibilityDetector(
    //                                 key: const Key('img-slide-anim2'),
    //                                 onVisibilityChanged: (info) {
    //                                   if (info.visibleFraction > 0.5 && !_imgCtrlDown.isCompleted) {
    //                                     _imgCtrlDown.forward();
    //                                   }
    //                                 },
    //                                 child: FadeTransition(
    //                                   opacity: _imgOpacityDown,
    //                                   child: SlideTransition(
    //                                     position: _imgSlide2,
    //                                     child: Image.asset("assets/img/smartbag/4pro/down.webp", cacheWidth: 800),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),

    //                             Expanded(
    //                               child: Padding(
    //                                 padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 50)),
    //                                 child: Text.rich(
    //                                   TextSpan(
    //                                     children: [
    //                                       TextSpan(
    //                                         text: "Tecnología, confianza y diseño\n",
    //                                         style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    //                                       ),
    //                                       TextSpan(
    //                                         text:
    //                                             "en cada capa de la 4PRO SmartBag. Diseñada para quienes necesitan soluciones con impacto real y protección superior.",
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   textAlign: TextAlign.justify,
    //                                   style: TextStyle(fontSize: min(screenWidth * 0.020, 22), fontWeight: FontWeight.w500, color: Colors.black),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                   : Padding(
    //                     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

    //                     child: Column(
    //                       children: [
    //                         VisibilityDetector(
    //                           key: const Key('img-slide-anim2'),
    //                           onVisibilityChanged: (info) {
    //                             if (info.visibleFraction > 0.5 && !_imgCtrlDown.isCompleted) {
    //                               _imgCtrlDown.forward();
    //                             }
    //                           },
    //                           child: FadeTransition(
    //                             opacity: _imgOpacityDown,
    //                             child: SlideTransition(
    //                               position: _imgSlide2,
    //                               child: Image.asset("assets/img/smartbag/4pro/down.webp", cacheWidth: 800),
    //                             ),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 100), vertical: 50),
    //                           child: Text.rich(
    //                             TextSpan(
    //                               children: [
    //                                 TextSpan(text: "Tecnología, confianza y diseño\n", style: TextStyle(color: Theme.of(context).primaryColor)),
    //                                 TextSpan(text: "en cada capa de la 4PRO SmartBag.\n"),
    //                                 TextSpan(text: "Diseñada para quienes necesitan soluciones\ncon impacto real y protección superior."),
    //                               ],
    //                             ),
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(fontSize: min(screenWidth * 0.025, 25), fontWeight: FontWeight.bold),
    //                           ),
    //                         ),
    //                         VisibilityDetector(
    //                           key: const Key('img-slide-anim'),
    //                           onVisibilityChanged: (info) {
    //                             if (info.visibleFraction > 0.5 && !_imgCtrl.isCompleted) {
    //                               _imgCtrl.forward();
    //                             }
    //                           },
    //                           child: FadeTransition(
    //                             opacity: _imgOpacity,
    //                             child: SlideTransition(position: _imgSlide, child: Image.asset("assets/img/smartbag/4pro/top.webp", cacheWidth: 800)),
    //                           ),
    //                         ),
    //                         ScrollAnimatedWrapper(
    //                           visibilityKey: Key('text-foto-4pro-familia'),
    //                           child: Padding(
    //                             padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 100), vertical: 50),
    //                             child: Text.rich(
    //                               TextSpan(
    //                                 children: [
    //                                   TextSpan(text: "Más que empaque, ", style: TextStyle(color: Theme.of(context).primaryColor)),
    //                                   TextSpan(text: "es identidad funcional.\n"),
    //                                   TextSpan(text: "4PRO SmartBag se adapta, protege y representa\nlo que tu marca realmente quiere decir."),
    //                                 ],
    //                               ),
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(fontSize: min(screenWidth * 0.025, 25), fontWeight: FontWeight.bold),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //               //Contenedores
    //               SizedBox(height: screenWidth >= 790 ? 200 : 60),

    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: min(screenWidth * 0.1, 400)),
    //                 child: ScrollAnimatedWrapper(visibilityKey: const Key("Info4pro"), child: buildResponsiveInfoCards(context)),
    //               ),
    //               SizedBox(height: 200),
    //             ],
    //           ),
    //         ),

    //         if (screenWidth >= 700) ...[
    //           // 👉 PC o Tablet → animación con secuencia
    //           Center(
    //             child: AnimatedContainer(
    //               key: greenKey,
    //               duration: Duration.zero,
    //               curve: Curves.linear,
    //               transform: Matrix4.translationValues(0, greenYOffset, 0),
    //               width: screenHeight * 1.1,
    //               child: ImageSequenceScroller(
    //                 framePrefix: 'assets/img/smartbag/4pro/frames/frame',
    //                 frameExtension: 'webp',
    //                 totalFrames: 294,
    //                 width: double.infinity,
    //                 externalScrollController: scrollController,
    //               ),
    //             ),
    //           ),
    //           Padding(padding: EdgeInsets.only(top: redPaddingTop - 100), child: SizedBox(key: redKey, height: 100, width: double.infinity)),
    //         ] else ...[
    //           // 👉 Móvil → mostrar 4 imágenes fijas en columna
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // igual que el resto del diseño
    //             child: Column(
    //               children: [
    //                 Image.asset(
    //                   'assets/img/smartbag/4pro/frames/frame0046.webp',
    //                   width: double.infinity,
    //                   fit: BoxFit.contain,
    //                   cacheWidth: 1920,
    //                   filterQuality: FilterQuality.high,
    //                 ),
    //                 SizedBox(height: 16),
    //                 Image.asset(
    //                   'assets/img/smartbag/4pro/frames/frame0111.webp',
    //                   width: double.infinity,
    //                   fit: BoxFit.contain,
    //                   cacheWidth: 1920,
    //                   filterQuality: FilterQuality.high,
    //                 ),
    //                 SizedBox(height: 16),
    //                 Image.asset(
    //                   'assets/img/smartbag/4pro/frames/frame0186.webp',
    //                   width: double.infinity,
    //                   fit: BoxFit.contain,
    //                   cacheWidth: 1920,
    //                   filterQuality: FilterQuality.high,
    //                 ),
    //                 SizedBox(height: 16),
    //                 Image.asset(
    //                   'assets/img/smartbag/4pro/frames/frame0250.webp',
    //                   width: double.infinity,
    //                   fit: BoxFit.contain,
    //                   cacheWidth: 1920,
    //                   filterQuality: FilterQuality.high,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //         Stack(
    //           clipBehavior: Clip.none,
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.only(top: 100),
    //               width: double.infinity,
    //               height: 600,
    //               decoration: BoxDecoration(
    //                 gradient: LinearGradient(
    //                   begin: Alignment.topCenter,
    //                   end: Alignment.bottomCenter,
    //                   colors: [const Color.fromARGB(0, 255, 255, 255), Theme.of(context).primaryColor],
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               bottom: -80, // puedes ajustar este valor
    //               left: 0,
    //               right: 0,
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   ScrollAnimatedWrapper(
    //                     visibilityKey: const Key("Unica-e-in"),
    //                     child: Text(
    //                       "UNICA E INIGUALABLE",
    //                       style: TextStyle(color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.05, 48), fontWeight: FontWeight.bold),
    //                     ),
    //                   ),

    //                   const SizedBox(height: 50),
    //                   ScrollAnimatedWrapper(
    //                     visibilityKey: Key('Image-unica-e-in'),
    //                     child: Image.asset("assets/img/smartbag/4pro.webp", fit: BoxFit.cover, cacheWidth: 800, height: 400),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),

    //         ScrollAnimatedWrapper(
    //           visibilityKey: Key('texto-unica-e-ini'),
    //           child: Padding(
    //             padding: EdgeInsets.only(top: 100),
    //             child: Column(
    //               children: [
    //                 Center(
    //                   child: SizedBox(
    //                     width: min(screenWidth, 900),
    //                     child: Padding(
    //                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
    //                       child: Text.rich(
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(fontSize: min(screenWidth * 0.04, 25), height: 1.2, color: Colors.black54),
    //                         TextSpan(
    //                           children: [
    //                             TextSpan(
    //                               text: "La bolsa 4PRO está diseñada para durar más y rendir mejor. ",
    //                               style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
    //                             ),
    //                             TextSpan(
    //                               text:
    //                                   "Su estructura optimizada es más ligera y resistente, sin comprometer su capacidad de protección. Con materiales de alta barrera y acabados técnicos, 4PRO ofrece un empaque más eficiente, más funcional y con un impacto visual superior. Además, su diseño versátil se adapta perfectamente a distintos formatos y sistemas de cierre, lo que la convierte en la opción ideal para marcas que buscan innovación y rendimiento sin ocupar más espacio.",
    //                               style: TextStyle(fontWeight: FontWeight.w600),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 100),
    //         ScrollAnimatedWrapper(
    //           visibilityKey: Key('image-text-valv-y-ps'),
    //           child:
    //               screenWidth >= 1000
    //                   ? Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       buildFeatureCard(
    //                         context,
    //                         height: screenHeight * 0.45,
    //                         width: screenWidth * 0.27,
    //                         title: "Peel Stick. ",
    //                         description:
    //                             "Práctico y versátil, este accesorio se adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
    //                         imagePath: "assets/img/smartbag/4pro/peel.webp",
    //                         isDowntext: false,
    //                       ),
    //                       SizedBox(width: 20),
    //                       buildFeatureCard(
    //                         context,
    //                         height: screenHeight * 0.45,
    //                         width: screenWidth * 0.27,
    //                         title: "Valvula. ",
    //                         description:
    //                             "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
    //                         imagePath: "assets/img/smartbag/4pro/valvulas.webp",
    //                       ),
    //                     ],
    //                   )
    //                   : Center(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         buildFeatureCard(
    //                           context,
    //                           height: screenHeight * 0.45,
    //                           width: screenWidth * 0.9,
    //                           title: "Peel Stick. ",
    //                           description:
    //                               "Práctico y versátil, este accesorio se adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
    //                           imagePath: "assets/img/smartbag/4pro/peel.webp",
    //                           isDowntext: false,
    //                         ),
    //                         SizedBox(height: 30),
    //                         buildFeatureCard(
    //                           context,
    //                           height: screenHeight * 0.45,
    //                           width: screenWidth * 0.9,
    //                           title: "Valvula. ",
    //                           description:
    //                               "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
    //                           imagePath: "assets/img/smartbag/4pro/valvulas.webp",
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //         ),

    //         SizedBox(height: 100),

    //         const Footer(),
    //       ],
    //     ),
    //   ),
    // );
  }
}

//Inicio de la pantalla de 4PRO
class Start4PROSliver extends StatelessWidget {
  const Start4PROSliver({super.key, required this.r, required this.blue, required this.isMobile, required this.route});

  final Responsive r;
  final Color blue;
  final bool isMobile;
  final String route;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"icon": CupertinoIcons.shield, "text": "Protección superior para conservar la calidad de tus productos."},

      {"icon": CupertinoIcons.briefcase, "text": "Acabados premium que elevan la presentación de tu marca."},

      {"icon": CupertinoIcons.lock, "text": "Sellado seguro para mayor protección."},

      {"icon": CupertinoIcons.arrow_2_squarepath, "text": "Ideal para alimentos, suplementos, cosméticos y más."},
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Container(
          width: r.wp(100),
          height: r.hp(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollAnimatedWrapper(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                  child: Center(
                    child: SizedBox(
                      width: r.wp(100, max: 1500),
                      child: Text("4PRO", style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.fs(4, 70))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6)),

                child: Center(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: r.wp(100, max: 1500),
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color.fromARGB(161, 255, 255, 255),
                      image: isMobile ? DecorationImage(image: AssetImage("assets/img/smartbag/4Pro/prueba.png"), fit: BoxFit.cover) : null,
                    ),
                    child: isMobile ? _buildPhone(context) : _buildDesktop(context),
                  ),
                ),
              ),
              ScrollAnimatedWrapper(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: r.wp(8), vertical: r.hp(5)),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(8),
                      width: r.wp(100, max: 1300),
                      decoration: BoxDecoration(color: const Color.fromARGB(161, 255, 255, 255), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(CupertinoIcons.bag, size: r.wp(10, max: 30), color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                            child: Text(
                              "Nuestro empaque más versátil, resistente y elegante. Diseñado para brindar protección, presencia y funcionalidad en un solo producto. Ideal para marcas que quieren destacar.",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: r.fs(1.1, 23)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ScrollAnimatedWrapper(
                child: Center(
                  child: SizedBox(
                    width: r.wp(90, max: 1200),
                    child: isMobile ? _buildPhoneItems(context, items, r) : _buildDesktopItems(items, context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildPhone(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: r.wp(5), right: r.wp(10)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: r.wp(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScrollAnimatedWrapper(
                    child: Text("La funcionalidad perfecta.", style: TextStyle(height: 0.99, fontWeight: FontWeight.bold, fontSize: r.fs(1.5, 26))),
                  ),
                  SizedBox(height: 16),
                  ScrollAnimatedWrapper(
                    child: Text(
                      "Más que un empaque funcional, es una declaración visual. Versátil, sofisticado y técnicamente superior, cada detalle ha sido concebido para transmitir la esencia de su marca.",
                      style: TextStyle(height: 0.99, fontSize: r.fs(1.15, 24)),
                    ),
                  ),
                  SizedBox(height: 14),
                  ScrollAnimatedWrapper(
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(blue), foregroundColor: const WidgetStatePropertyAll(Colors.white)),
                      onPressed: () {
                        navigateWithSlide(context, route);
                      },
                      child: Text("Crear mi 4PRO", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _buildDesktop(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: r.wp(9)),
          child: ScrollAnimatedWrapper(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 1000),
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("La funcionalidad perfecta", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(2, 50))),
                  SizedBox(height: 5),
                  Text(
                    "Más que un empaque funcional, es una declaración visual. Versátil, sofisticado y técnicamente superior, cada detalle ha sido concebido para transmitir la esencia de su marca.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: r.fs(1, 22)),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(blue), foregroundColor: const WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      navigateWithSlide(context, route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text("Crear mi 4PRO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child:
                isMobile
                    ? Image.asset("assets/img/smartbag/4Pro/prueba.png", cacheWidth: 800, fit: BoxFit.cover, alignment: Alignment.centerLeft)
                    : Row(
                      children: [
                        Expanded(
                          flex: 40,
                          child: AspectRatio(
                            aspectRatio: 16 / 9, // o el ratio real de tu video
                            child: ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return VideoFlutter(
                                  src: 'assets/videos/smartbag/4pro/4pro.webm',
                                  loop: false,
                                  isPause: false,
                                  fit: BoxFit.contain,
                                  blur: isBlur,
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(flex: 6, child: SizedBox()),
                      ],
                    ),
          ),
        ),
      ],
    );
  }

  Padding _buildPhoneItems(BuildContext context, List<Map<String, dynamic>> items, Responsive r) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }

  Row _buildDesktopItems(List<Map<String, dynamic>> items, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          items.map((item) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item["icon"], size: 32, color: Theme.of(context).primaryColor),
                const SizedBox(height: 8),
                SizedBox(
                  width: r.wp(18, max: 200),
                  child: Text(item["text"], textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          }).toList(),
    );
  }
}

//Scroll 4 funciones 4 pro
class Scroll4FunctionsSliver extends StatefulWidget {
  const Scroll4FunctionsSliver({super.key, required this.r, required this.blue, required this.isMobile});

  final bool isMobile;
  final Responsive r;
  final Color blue;

  @override
  State<Scroll4FunctionsSliver> createState() => _Scroll4FunctionsSliverState();
}

class _Scroll4FunctionsSliverState extends State<Scroll4FunctionsSliver> {
  final ScrollController _scroll = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_checkScroll);
  }

  void _checkScroll() {
    final maxScroll = _scroll.position.maxScrollExtent;
    final offset = _scroll.offset;
    setState(() {
      _canScrollLeft = offset > 0;
      _canScrollRight = offset < maxScroll;
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> localCards = [
      {
        "title": "4 Funciones, 4PRO.",
        "subtitle": "El empaque 4PRO SmartBag®: seguro, funcional y diseñado para la visión de tu marca.",
        "image": "assets/img/smartbag/4pro/card1.webp",
        "down": false,
      },
      {
        "title": "Sella. Protege. Impacta.",
        "subtitle":
            "El zipper hermético, los materiales de alta calidad y los acabados que cautivan, aseguran que tu producto no solo se conserve, sino que domine la atención en cualquier estantería.",
        "image": "assets/img/smartbag/4pro/card2.webp",
        "down": true,
      },
      {
        "title": "El empaque que se adapta a tu visión.",
        "subtitle":
            "Una versatilidad sin límites para alimentos, cosméticos, suplementos y más. Porque tu producto no solo merece protección, sino la oportunidad de destacar en cualquier lugar.",
        "image": "assets/img/smartbag/4pro/card3.webp",
        "down": false,
      },
      {
        "title": "Innovación que se ve y se siente.",
        "subtitle":
            "4PRO SmartBag® la tecnología que fusiona un diseño impactante con un compromiso real por la sostenibilidad. Todo en un solo empaque.",
        "image": "assets/img/smartbag/4pro/card4.webp",
        "down": true,
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: widget.r.wp(100),
        padding: EdgeInsets.only(bottom: widget.r.dp(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Text("4 Funciones, 4PRO.", style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: widget.r.fs(2, 50))),
              ),
            ),
            SizedBox(height: widget.r.hp(3)),
            SizedBox(
              height: widget.r.wp(60, max: 550) + 40,
              child: ListView.builder(
                controller: _scroll,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                itemCount: localCards.length,
                itemBuilder: (context, index) {
                  final card = localCards[index];

                  return ScrollAnimatedWrapper(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Container(
                        width: widget.r.wp(80, max: 1000),
                        height: widget.r.wp(60, max: 550),
                        padding: EdgeInsets.all(widget.r.dp(2, max: 60)),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 20),
                          image: DecorationImage(image: AssetImage(card['image']), fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: card['down'] == true ? MainAxisAlignment.end : MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              card['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.r.fs(1.4, 32),
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(130))],
                              ),
                            ),
                            Text(
                              card['subtitle'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.r.fs(1, 25),
                                shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(130))],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(8), vertical: widget.r.dp(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ArrowButton(
                      enabled: _canScrollLeft,
                      icon: CupertinoIcons.chevron_left,
                      onTap: () {
                        _scroll.animateTo(_scroll.offset - widget.r.wp(60), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                    ),
                    SizedBox(width: widget.r.wp(2)),
                    ArrowButton(
                      enabled: _canScrollRight,
                      icon: CupertinoIcons.chevron_right,
                      onTap: () {
                        _scroll.animateTo(_scroll.offset + widget.r.wp(60), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Multiples funciones, valvula y peel información
class MultipleFunctionsSliver extends StatelessWidget {
  const MultipleFunctionsSliver({super.key, required this.r, required this.blue});

  final Responsive r;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: r.wp(100),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Center(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: r.fs(2.5, 70), color: Colors.black87, fontWeight: FontWeight.bold),
                  TextSpan(children: [TextSpan(text: "Una familia, "), TextSpan(text: "múltiples funciones", style: TextStyle(color: blue))]),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Center(
                child: Text(
                  "Siempre 4PRO.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: r.fs(2.5, 70), color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
