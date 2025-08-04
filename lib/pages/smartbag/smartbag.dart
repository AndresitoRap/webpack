import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import 'package:webpack/class/cardproduct.dart' show cardFindS;
import 'package:webpack/class/categories.dart';
import 'package:webpack/utils/responsive.dart';
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
    final Responsive r = Responsive.of(context);
    final blue = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              //Sliver con el inicio
              StartSliver(r: r, blue: blue),

              //Sliver con el texto y la información
              TitleSliver(r: r),
            ],
          ),
          Header(),
        ],
      ),
    );

    // Scaffold(
    //   body: Stack(
    //     children: [
    //       SingleChildScrollView(
    //         controller: _scrollController,
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(vertical: 45),
    //           child:
    //               SizedBox(height: 20),
    //               Center(
    //                 child: Center(
    //                   child: Builder(
    //                     builder: (context) {
    //                       final borderRadius = BorderRadius.circular(30 * scrollProgress);
    //                       final horizontalPadding = screenWidth * 0.055 * scrollProgress;

    //                       return Padding(
    //                         padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
    //                         child: ClipRRect(
    //                           borderRadius: borderRadius,
    //                           child: SizedBox(
    //                             width: double.infinity,
    //                             height: min(screenHeight * 0.8, 1100),
    //                             child: Stack(
    //                               fit: StackFit.expand,
    //                               children: [
    //                                 ValueListenableBuilder<bool>(
    //                                   valueListenable: videoBlurNotifier,
    //                                   builder: (context, isBlur, _) {
    //                                     return VideoFlutter(
    //                                       src: 'assets/assets/videos/smartbag/SmartbagInicio.webm',
    //                                       blur: isBlur,
    //                                       loop: true,
    //                                       showControls: true,
    //                                       fit: BoxFit.cover,
    //                                     );
    //                                   },
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: 20),

    //               Discover(
    //                 title: "Descubre Smart.",
    //                 titleColor: Theme.of(context).primaryColor,
    //                 list: cardFindS,
    //                 scrollController: _scrollControllerDiscover,
    //                 ishoverlist: isHoverCardList,
    //                 ishovericonlist: isHoverIconList,
    //                 scrollControllerLeft: canScrollLeft,
    //                 scrollControllerRigth: canScrollRight,
    //               ),
    //               SizedBox(height: screenWidth * 0.1),
    //               OurLines(
    //                 text: "Nuestras lineas.",
    //                 titleColor: Theme.of(context).primaryColor,
    //                 list: subcategorieSmart,
    //                 ecoOrSmartColor: Theme.of(context).primaryColor,
    //                 scrollControllerfamily: _scrollControllerfamily,
    //                 canScrollLeftFamily: canScrollLeftFamily,
    //                 canScrollRightFamily: canScrollRightFamily,
    //               ),

    //               Footer(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Header(),
    //     ],
    //   ),
    // );
  }
}

//---------Inicio con los cliparts------------

class StartSliver extends StatefulWidget {
  final Responsive r;
  final Color blue;

  const StartSliver({super.key, required this.r, required this.blue});

  @override
  State<StartSliver> createState() => _StartSliverState();
}

class _StartSliverState extends State<StartSliver> {
  final ScrollController _scrollController = ScrollController();
  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;

    setState(() {
      _showRightArrow = current < maxScroll - 10;
      _showLeftArrow = current > 10;
    });
  }

  void _scrollBy(double offset) {
    final newPosition = _scrollController.offset + offset;
    _scrollController.animateTo(
      newPosition.clamp(_scrollController.position.minScrollExtent, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listHeader = [
      {'title': '4PRO', 'image': 'assets/img/smartbag/clipart/cpa_4pro.svg', 'route': ''},
      {'title': '5PRO', 'image': 'assets/img/smartbag/clipart/cpa_5pro.svg', 'route': ''},
      {'title': 'Doypack', 'image': 'assets/img/smartbag/clipart/cpa_doypack.svg', 'route': ''},
      {'title': 'Flowpack', 'image': 'assets/img/smartbag/clipart/cpa_flowpack.svg', 'route': ''},
      {'title': 'Cojin', 'image': 'assets/img/smartbag/clipart/cpa_cojin.svg', 'route': ''},
      {'title': 'Piramidal', 'image': 'assets/img/smartbag/clipart/cpa_piramidal.svg', 'route': ''},
      {'title': 'Standpack', 'image': 'assets/img/smartbag/clipart/cpa_standpack.svg', 'route': ''},
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          width: widget.r.wp(100),
          color: const Color(0xC5E0F0FF),
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: widget.r.wp(100)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        listHeader.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, item['route']!);
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(item['image']!, height: 70),
                                    const SizedBox(height: 8),
                                    Text(item['title']!, style: TextStyle(fontSize: widget.r.fs(1.1, max(14, 16)), color: widget.blue)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),

              // FLECHA IZQUIERDA
              if (widget.r.wp(100) < 750) ...[
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: _arrow(_showLeftArrow, -0.2, -150, CupertinoIcons.chevron_left, [
                    const Color.fromARGB(255, 224, 240, 255),
                    const Color.fromARGB(0, 255, 255, 255),
                  ]),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: _arrow(_showRightArrow, 0.2, 150, CupertinoIcons.chevron_right, [
                    const Color.fromARGB(0, 255, 255, 255),

                    const Color.fromARGB(255, 224, 240, 255),
                  ]),
                ),

                // FLECHA DERECHA
              ],
            ],
          ),
        ),
      ),
    );
  }

  AnimatedSlide _arrow(bool showscroll, double offset, double scroll, IconData icon, List<Color> colors) {
    return AnimatedSlide(
      offset: showscroll ? Offset.zero : Offset(offset, 0),
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: showscroll ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () => _scrollBy(scroll), // scroll a la izquierda
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(gradient: LinearGradient(colors: colors, begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Icon(icon, color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}

//---------Titulo------------

class TitleSliver extends StatelessWidget {
  const TitleSliver({super.key, required this.r});

  final Responsive r;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            r.wp(100) >= 1000
                ? Center(
                  child: SizedBox(
                    width: 1124,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SmartBag®",
                            style: TextStyle(fontSize: r.fs(4, 80), fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "Diseño que protege.\nTecnología que empaca.",
                            style: TextStyle(fontSize: r.fs(1.6, 30), height: 0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("SmartBag®", style: TextStyle(fontSize: r.fs(3, 70), fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                      Text(
                        "Diseño que protege.\nTecnología que empaca.",
                        style: TextStyle(fontSize: r.fs(2, 28), height: 0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
