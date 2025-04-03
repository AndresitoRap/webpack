import 'dart:math' show min;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/ourrecommended.dart';
import 'package:webpack/class/packwithcon.dart';
import 'package:webpack/widgets/build_recommended.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/heardquarters.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  //Empaques con conciencia
  int? _expandedIndex;
  List<int> cardIndex = List.generate(cardPWC.length, (index) => index);

  //Nuestros recomendados
  List<bool> isHoverCardList = List.generate(cardOR.length, (_) => false);
  List<bool> isHoverIconList = List.generate(cardOR.length, (_) => false);
  final ScrollController _scrollController = ScrollController();
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtons);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 720;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child:
                      screenWidth > 800
                          ? Padding(
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image.asset("lib/src/img/Packvision.png", fit: BoxFit.contain)),
                                Expanded(child: Image.asset("lib/src/img/Bag&paint.png", fit: BoxFit.contain)),
                              ],
                            ),
                          )
                          : Padding(
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image.asset("lib/src/img/Packvision.png", fit: BoxFit.contain)),
                                Expanded(child: Image.asset("lib/src/img/Bag&paint.png", fit: BoxFit.contain)),
                              ],
                            ),
                          ),
                ),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.tertiary, Theme.of(context).primaryColor],
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenWidth * 0.05,
                              top: isMobile ? screenWidth * 0.1 : screenWidth * 0.05,
                              left: screenWidth * 0.1,
                            ),
                            child: Text(
                              "Empaques con conciencia.",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: min(screenWidth * 0.03, 60),
                              ),
                            ),
                          ),
                          isMobile
                              ? Column(
                                children:
                                    cardIndex.map((index) {
                                      final card = cardPWC[index];
                                      final bool isExpanded = _expandedIndex == index;
                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: double.infinity,
                                        height: isExpanded ? screenWidth * 0.95 : screenWidth * 0.6,
                                        margin: const EdgeInsets.only(bottom: 12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
                                        ),
                                        child: Stack(
                                          children: [
                                            // Título
                                            Positioned(
                                              top: 16,
                                              left: 0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor.withAlpha(230),
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(8),
                                                    bottomRight: Radius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  card.title,
                                                  style: TextStyle(
                                                    fontSize: screenWidth * 0.03,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (isExpanded)
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 400,
                                                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                                                  decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [Colors.transparent, Colors.white, Colors.white],
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: Text(
                                                          card.description,
                                                          style: TextStyle(
                                                            color: Theme.of(context).primaryColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: screenWidth * 0.03,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            Positioned(
                                              bottom: 12,
                                              right: 12,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _expandedIndex = isExpanded ? null : index;
                                                  });
                                                },
                                                child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: Container(
                                                    width: 36,
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          isExpanded
                                                              ? const Color(0xff004f9f)
                                                              : Theme.of(context).primaryColor,
                                                    ),
                                                    child: Icon(
                                                      isExpanded ? CupertinoIcons.xmark : CupertinoIcons.add,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              )
                              //PC
                              : Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: screenWidth * 0.05),
                                  child: SizedBox(
                                    height: screenWidth * 0.3,
                                    child: Stack(
                                      children:
                                          cardIndex.map((index) {
                                            bool isExpanded = _expandedIndex == index;
                                            double leftPosition;
                                            if (_expandedIndex == null) {
                                              leftPosition = index * (screenWidth * 0.21 + screenWidth * 0.012);
                                            } else {
                                              if (isExpanded) {
                                                leftPosition = 0;
                                              } else {
                                                int stackIndex = cardIndex.indexOf(index) - 1;
                                                leftPosition =
                                                    screenWidth * 0.5 + screenWidth * 0.02 + stackIndex * 20.0;
                                              }
                                            }
                                            return AnimatedPositioned(
                                              duration: Duration(milliseconds: 300),
                                              left: leftPosition,
                                              child: AnimatedPositionedCard(
                                                index: index,
                                                isExpanded: isExpanded,
                                                screenWidth: screenWidth,
                                                card: cardPWC[index],
                                                onExpand: () {
                                                  setState(() {
                                                    _expandedIndex = index;
                                                  });
                                                },
                                                onCollapse: () {
                                                  setState(() {
                                                    _expandedIndex = null;
                                                  });
                                                },
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenWidth * 0.04),
                      child: Text(
                        "Nuestros recomendados.",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.06, 55)),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: List.generate(cardOR.length, (int index) {
                          final card = cardOR[index];
                          final double horizontalPadding = screenWidth * 0.1;
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? horizontalPadding : 0,
                              right: index == cardOR.length - 1 ? horizontalPadding : 20,
                            ),
                            child: AnimatedScale(
                              scale: isHoverCardList[index] ? 1.02 : 1.0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (_) => setState(() => isHoverCardList[index] = true),
                                onExit: (_) => setState(() => isHoverCardList[index] = false),
                                child: GestureDetector(
                                  onTap: () {
                                    ourservicesdialog(context, index);
                                  },
                                  child: Container(
                                    width: min(screenWidth * 0.52, 380),
                                    height: min(screenWidth * 0.93, 700),
                                    padding: EdgeInsets.only(top: 22, left: 22),
                                    margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: MouseRegion(
                                            onEnter: (_) => setState(() => isHoverIconList[index] = true),
                                            onExit: (_) => setState(() => isHoverIconList[index] = false),
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 200),
                                              curve: Curves.easeInBack,
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    isHoverIconList[index]
                                                        ? Theme.of(context).primaryColor
                                                        : Theme.of(context).primaryColor.withAlpha(200),
                                              ),
                                              child: AnimatedOpacity(
                                                opacity: isHoverIconList[index] ? 1 : 0.5,
                                                duration: Duration(milliseconds: 300),
                                                child: Icon(Icons.add_rounded, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              card.title,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: min(screenWidth * 0.03, 25),
                                              ),
                                            ),
                                            Text(
                                              card.body,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: min(screenWidth * 0.04, 30),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                canScrollLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80),
                              ),
                            ),
                            onPressed:
                                canScrollLeft
                                    ? () {
                                      _scrollController.animateTo(
                                        _scrollController.offset - 500,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                    : null,
                            icon: Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                canScrollRight ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80),
                              ),
                            ),
                            onPressed:
                                canScrollRight
                                    ? () {
                                      _scrollController.animateTo(
                                        _scrollController.offset + 500,
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
                  ],
                ),
                Headquarters(),
                Footer(),
              ],
            ),
          ),
          Header(),
        ],
      ),
    );
  }

  void ourservicesdialog(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final card = cardOR[index];
        final ScrollController scrollController = ScrollController();
        return LayoutBuilder(
          builder: (context, constraints) {
            return Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 50),
                            width: min(screenWidth * 0.9, 1260),
                            padding: EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: min(76, screenWidth * 0.09)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 60),
                                  Text(
                                    card.title,
                                    style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    card.body,
                                    style: TextStyle(
                                      fontSize: min(50, screenWidth * 0.06),
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  buildDialogContent(context, index),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          right: 10,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              CupertinoIcons.xmark_circle_fill,
                              size: 40,
                              color: const Color.fromARGB(255, 71, 71, 71),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AnimatedPositionedCard extends StatelessWidget {
  final int index;
  final bool isExpanded;
  final double screenWidth;
  final CardPackWithConscience card;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;

  const AnimatedPositionedCard({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.screenWidth,
    required this.card,
    required this.onExpand,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: Duration(milliseconds: 300),
      width: isExpanded ? screenWidth * 0.5 : screenWidth * 0.21,
      height: screenWidth * 0.3,
      margin: EdgeInsets.only(right: 120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            child: Container(
              height: screenWidth * 0.03,
              width: screenWidth * 0.10,
              padding: EdgeInsets.only(left: screenWidth * 0.01),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(200),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenWidth * 0.01),
                  bottomRight: Radius.circular(screenWidth * 0.01),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  card.title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: screenWidth * 0.012),
                ),
              ),
            ),
          ),
          if (isExpanded)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: screenWidth * 0.13),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.white, Colors.white],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: screenWidth * 0.01,
                    left: screenWidth * 0.01,
                    right: screenWidth * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        card.description,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: screenWidth * 0.013,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              onPressed: isExpanded ? onCollapse : onExpand,
              icon: Icon(
                isExpanded ? CupertinoIcons.xmark_circle_fill : CupertinoIcons.add_circled_solid,
                color: isExpanded ? Theme.of(context).primaryColor : Colors.white,
                size: screenWidth * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
