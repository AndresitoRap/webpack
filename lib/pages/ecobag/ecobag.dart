import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:webpack/class/cardproduct.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/ourlines.dart';

class EcoBag extends StatefulWidget {
  const EcoBag({super.key});

  @override
  State<EcoBag> createState() => _EcoBagState();
}

class _EcoBagState extends State<EcoBag> {
  //Seccion scrolleable
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerDiscover = ScrollController();
  double scrollProgress = 0.0; // Va de 0.0 (sin scroll) a 1.0 (scroll máximo definido)
  List<bool> isHoverCardList = List.generate(cardFindE.length, (_) => false);
  List<bool> isHoverIconList = List.generate(cardFindE.length, (_) => false);
  bool canScrollLeft = false;
  bool canScrollRight = true;

  void _updateScrollButtons() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    setState(() {
      canScrollLeft = currentScroll > 0;
      canScrollRight = currentScroll < maxScroll;
    });
  }

  //Seccion scrolleable 2 (Familias)
  final ScrollController _scrollControllerfamily = ScrollController();
  bool canScrollLeftFamily = false;
  bool canScrollRightFamily = true;

  void _updateScrollButtonsFamily() {
    final maxScroll = _scrollControllerfamily.position.maxScrollExtent;
    final currentScroll = _scrollControllerfamily.position.pixels;

    setState(() {
      canScrollLeftFamily = currentScroll > 0;
      canScrollRightFamily = currentScroll < maxScroll;
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollControllerfamily.addListener(_updateScrollButtonsFamily);
    _scrollController.addListener(_updateScrollButtons);
    _scrollController.addListener(() {
      final offset = _scrollController.offset.clamp(0, 200);
      setState(() {
        scrollProgress = offset / 200; // de 0.0 a 1.0
      });
    });
  }

  @override
  void dispose() {
    _scrollControllerfamily.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final card in cardFindE) {
      precacheImage(AssetImage(card.image), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const LeafAnimation(),
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 200, width: screenWidth, color: Colors.grey),

                  SizedBox(height: 50),
                  SizedBox(height: 50),
                  screenWidth >= 1000
                      ? Center(
                        child: SizedBox(
                          width: 1124,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Text(
                                      "EcoBag®",
                                      style: TextStyle(
                                        fontSize: min(60, screenWidth * 0.1),
                                        fontWeight: FontWeight.bold,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 4
                                              ..color = Theme.of(context).scaffoldBackgroundColor,
                                      ),
                                    ),
                                    Text(
                                      "EcoBag®",
                                      style: TextStyle(
                                        fontSize: min(60, screenWidth * 0.1),
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 75, 141, 44),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Text(
                                      "Diseño que protege.\nTecnología que empaca.",
                                      style: TextStyle(
                                        fontSize: min(22, screenWidth * 0.04),
                                        height: 0,
                                        fontWeight: FontWeight.bold,
                                        foreground:
                                            Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 4
                                              ..color = Theme.of(context).scaffoldBackgroundColor,
                                      ),
                                    ),
                                    Text(
                                      "Diseño que protege.\nTecnología que empaca.",
                                      style: TextStyle(
                                        fontSize: min(22, screenWidth * 0.04),
                                        height: 0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 75, 141, 44),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      : Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  "EcoBag®",
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.1),
                                    fontWeight: FontWeight.bold,
                                    foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 4
                                          ..color = Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                                Text(
                                  "EcoBag®",
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.1),
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 75, 141, 44),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Text(
                                  "Diseño que protege.\nTecnología que empaca.",
                                  style: TextStyle(
                                    fontSize: min(22, screenWidth * 0.04),
                                    height: 0,
                                    fontWeight: FontWeight.bold,
                                    foreground:
                                        Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 4
                                          ..color = Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                                Text(
                                  "Diseño que protege.\nTecnología que empaca.",
                                  style: TextStyle(
                                    fontSize: min(22, screenWidth * 0.04),
                                    height: 0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 75, 141, 44),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  SizedBox(height: 20),
                  Center(
                    child: Builder(
                      builder: (context) {
                        final borderRadius = BorderRadius.circular(30 * scrollProgress);
                        final horizontalPadding = screenWidth * 0.055 * scrollProgress;

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
                          child: ClipRRect(
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
                                        src: 'assets/videos/ecobag/EcobagInicio.webm',
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
                  SizedBox(height: 20),
                  Discover(
                    title: "Descubre Eco.",
                    list: cardFindE,
                    scrollController: _scrollControllerDiscover,
                    ishoverlist: isHoverCardList,
                    ishovericonlist: isHoverIconList,
                    scrollControllerLeft: canScrollLeft,
                    scrollControllerRigth: canScrollRight,
                  ),
                  SizedBox(height: screenWidth * 0.1),
                  OurLines(
                    text: "Nuestas Ecolineas.",
                    list: subcategorieEco,
                    ecoOrSmartColor: Color.fromARGB(255, 75, 141, 44),
                    scrollControllerfamily: _scrollControllerfamily,
                    canScrollLeftFamily: canScrollLeftFamily,
                    canScrollRightFamily: canScrollRightFamily,
                  ),
                  Footer(),
                ],
              ),
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}

class LeafAnimation extends StatefulWidget {
  const LeafAnimation({super.key});

  @override
  State<LeafAnimation> createState() => _LeafAnimationState();
}

class _LeafAnimationState extends State<LeafAnimation> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final List<LeafData> _leaves = [];
  final Random _random = Random();

  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();

    // Inicializar las hojas
    for (int i = 0; i < 10; i++) {
      _leaves.add(_generateLeaf());
    }

    // Crear ticker que se actualiza constantemente
    _ticker = createTicker((Duration elapsed) {
      setState(() {
        for (int i = 0; i < _leaves.length; i++) {
          _leaves[i].y += _leaves[i].speed;

          // Si se fue de la pantalla, reemplazar por una nueva
          if (_leaves[i].y > screenHeight + _leaves[i].size) {
            _leaves[i] = _generateLeaf(); // reemplazar hoja
          }
        }
      });
    });

    _ticker.start();
  }

  LeafData _generateLeaf() {
    return LeafData(
      image: 'assets/img/ecobag/hoja${_random.nextInt(3) + 1}.webp',
      x: _random.nextDouble(),
      y: -50.0 - _random.nextDouble() * 300,
      speed: 1.0 + _random.nextDouble() * 2.0,
      size: 40.0 + _random.nextDouble() * 30,
      rotation: _random.nextDouble() * pi,
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children:
          _leaves.map((leaf) {
            return Positioned(
              left: leaf.x * screenWidth,
              top: leaf.y,
              child: Transform.rotate(angle: leaf.rotation + leaf.y * 0.01, child: Image.asset(leaf.image, width: leaf.size)),
            );
          }).toList(),
    );
  }
}

class LeafData {
  final String image;
  final double x;
  double y;
  final double speed;
  final double size;
  final double rotation;

  LeafData({required this.image, required this.x, required this.y, required this.speed, required this.size, required this.rotation});
}
