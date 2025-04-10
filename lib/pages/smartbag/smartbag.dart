import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:webpack/class/cardproduct.dart';
import 'package:webpack/class/categoriescard.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/ourlines.dart';

class SmartBag extends StatefulWidget {
  const SmartBag({super.key});

  @override
  State<SmartBag> createState() => _SmartBagState();
}

class _SmartBagState extends State<SmartBag> {
  //Seccion scrolleable
  final ScrollController _scrollController = ScrollController();
  List<bool> isHoverCardList = List.generate(cardFindS.length, (_) => false);
  List<bool> isHoverIconList = List.generate(cardFindS.length, (_) => false);
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

    for (final card in cardFindS) {
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
          LeafAnimation(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                      "SmartBag®",
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
                                      "SmartBag®",
                                      style: TextStyle(
                                        fontSize: min(60, screenWidth * 0.1),
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
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
                                        color: Theme.of(context).primaryColor,
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
                                  "SmartBag®",
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
                                  "SmartBag®",
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.1),
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
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
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: min(screenWidth, 2260),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: screenWidth * 0.055),
                        child: Container(
                          width: screenWidth,
                          height: min(screenHeight * 0.75, 1000),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Discover(
                    title: "Descubre Smart.",
                    list: cardFindS,
                    scrollController: _scrollController,
                    ishoverlist: isHoverCardList,
                    ishovericonlist: isHoverIconList,
                    scrollControllerLeft: canScrollLeft,
                    scrollControllerRigth: canScrollRight,
                  ),
                  SizedBox(height: screenWidth * 0.1),
                  OurLines(
                    text: "Nuestras lineas.",
                    list: categoriesCard,
                    ecoOrSmartColor: Theme.of(context).primaryColor,
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
      image: 'lib/src/img/smartbag/fall${_random.nextInt(3) + 1}.webp',
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
              child: Transform.rotate(
                angle: leaf.rotation + leaf.y * 0.01,
                child: Image.asset(leaf.image, width: leaf.size),
              ),
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

  LeafData({
    required this.image,
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.rotation,
  });
}
