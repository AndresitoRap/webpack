import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webpack/class/cardproduct.dart' show cardFindS, cardFindE;
import 'package:webpack/class/categories.dart';
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
  late VideoPlayerController _videoController;

  void _updateScrollButtons() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    setState(() {
      canScrollLeft = currentScroll > 0;
      canScrollRight = currentScroll < maxScroll;
    });
  }

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
    _videoController = VideoPlayerController.asset('assets/videos/smartbag/SmartbagInicio.webm')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });
    _scrollControllerfamily.addListener(_updateScrollButtonsFamily);
    _scrollController.addListener(_updateScrollButtons);
  }

  @override
  void dispose() {
    _videoController.dispose();
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child:
                              _videoController.value.isInitialized
                                  ? SizedBox(
                                    width: double.infinity,
                                    height: min(screenHeight * 0.8, 1100),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      clipBehavior: Clip.hardEdge,
                                      child: SizedBox(
                                        width: _videoController.value.size.width,
                                        height: _videoController.value.size.height,
                                        child: VideoPlayer(_videoController),
                                      ),
                                    ),
                                  )
                                  : Container(width: double.infinity, height: min(screenHeight * 0.8, 1100), color: Colors.grey),
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
                    list: subcategorieSmart,
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
