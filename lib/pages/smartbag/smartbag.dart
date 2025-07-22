import 'dart:math';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webpack/class/cardproduct.dart' show cardFindS;
import 'package:webpack/class/categories.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

import 'package:webpack/widgets/ourlines.dart';
import 'package:webpack/widgets/video.dart';

class SmartBag extends StatefulWidget {
  const SmartBag({super.key});

  @override
  State<SmartBag> createState() => _SmartBagState();
}

class _SmartBagState extends State<SmartBag> {
  //Seccion scrolleable
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerDiscover = ScrollController();
  double scrollProgress = 0.0; // va de 0.0 a 1.0 según el scroll
  List<bool> isHoverCardList = List.generate(cardFindS.length, (_) => false);
  List<bool> isHoverIconList = List.generate(cardFindS.length, (_) => false);
  bool canScrollLeft = false;
  bool canScrollRight = true;
  bool isVideoShrunk = false;
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
    _scrollControllerfamily.addListener(_updateScrollButtonsFamily);
    _scrollController.addListener(_updateScrollButtons);

    // Listener de scroll principal
    _scrollController.addListener(() {
      final offset = _scrollController.offset.clamp(0, 200);
      final progress = offset / 200;

      setState(() {
        scrollProgress = progress;
      });
    });
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
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 200, width: screenWidth, color: Colors.grey),

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
                    child: Center(
                      child: Builder(
                        builder: (context) {
                          final borderRadius = BorderRadius.circular(30 * scrollProgress);
                          final horizontalPadding = screenWidth * 0.055 * scrollProgress;

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox(
                                width: double.infinity,
                                height: min(screenHeight * 0.8, 1100),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ValueListenableBuilder<bool>(
                                      valueListenable: videoBlurNotifier,
                                      builder: (context, isBlur, _) {
                                        return VideoFlutter(
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
                  SizedBox(height: 20),

                  Discover(
                    title: "Descubre Smart.",
                    titleColor: Theme.of(context).primaryColor,
                    list: cardFindS,
                    scrollController: _scrollControllerDiscover,
                    ishoverlist: isHoverCardList,
                    ishovericonlist: isHoverIconList,
                    scrollControllerLeft: canScrollLeft,
                    scrollControllerRigth: canScrollRight,
                  ),
                  SizedBox(height: screenWidth * 0.1),
                  OurLines(
                    text: "Nuestras lineas.",
                    titleColor: Theme.of(context).primaryColor,
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
