import 'dart:math' show min;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/menu_data.dart';
import 'package:webpack/class/ourservices.dart';
import 'package:webpack/class/packwithcon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  //Empaques con conciencia
  int? _expandedIndex;
  List<int> cardIndex = List.generate(cardPWC.length, (index) => index);

  //Nuestros servicios
  List<bool> isHoverCardList = List.generate(cardOS.length, (_) => false);
  List<bool> isHoverIconList = List.generate(cardOS.length, (_) => false);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("lib/src/img/Packvision.png"),
                      Image.asset("lib/src/img/Bag&paint.png"),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.tertiary,
                        Theme.of(context).primaryColor,
                      ],
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.065,
                      vertical: 200,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: screenWidth * 0.05,
                              ),
                              child: Text(
                                "Empaques con conciencia.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: min(screenWidth * 0.06, 60),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenWidth * 0.3,
                              child: Stack(
                                children:
                                    cardIndex.map((index) {
                                      bool isExpanded = _expandedIndex == index;
                                      double leftPosition;
                                      if (_expandedIndex == null) {
                                        leftPosition =
                                            index *
                                            (screenWidth * 0.21 +
                                                screenWidth * 0.012);
                                      } else {
                                        if (isExpanded) {
                                          leftPosition = 0;
                                        } else {
                                          int stackIndex =
                                              cardIndex.indexOf(index) - 1;
                                          leftPosition =
                                              screenWidth * 0.5 +
                                              screenWidth * 0.02 +
                                              stackIndex * 20.0;
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenWidth * 0.04,
                      ),
                      child: Text(
                        "Nuestros servicios.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: min(screenWidth * 0.06, 55),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: List.generate(cardOS.length, (int index) {
                          final card = cardOS[index];
                          final double horizontalPadding = screenWidth * 0.1;
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? horizontalPadding : 0,
                              right:
                                  index == cardOS.length - 1
                                      ? horizontalPadding
                                      : 20,
                            ),
                            child: AnimatedScale(
                              scale: isHoverCardList[index] ? 1.02 : 1.0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: MouseRegion(
                                onEnter:
                                    (_) => setState(
                                      () => isHoverCardList[index] = true,
                                    ),
                                onExit:
                                    (_) => setState(
                                      () => isHoverCardList[index] = false,
                                    ),
                                child: Container(
                                  width: min(screenWidth * 0.52, 380),
                                  height: min(screenWidth * 0.93, 700),
                                  padding: EdgeInsets.only(top: 22, left: 22),
                                  margin: EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),

                                    image: DecorationImage(
                                      image: AssetImage(card.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: MouseRegion(
                                          onEnter:
                                              (_) => setState(
                                                () =>
                                                    isHoverIconList[index] =
                                                        true,
                                              ),
                                          onExit:
                                              (_) => setState(
                                                () =>
                                                    isHoverIconList[index] =
                                                        false,
                                              ),
                                          child: AnimatedContainer(
                                            duration: Duration(
                                              milliseconds: 200,
                                            ),
                                            curve: Curves.easeInBack,
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  isHoverIconList[index]
                                                      ? Theme.of(
                                                        context,
                                                      ).primaryColor
                                                      : Theme.of(context)
                                                          .primaryColor
                                                          .withAlpha(200),
                                            ),
                                            child: Icon(
                                              Icons.add_rounded,
                                              color:
                                                  isHoverIconList[index]
                                                      ? Colors.white
                                                      : Colors.white.withAlpha(
                                                        200,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            card.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: min(
                                                screenWidth * 0.03,
                                                25,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            card.body,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: min(
                                                screenWidth * 0.04,
                                                30,
                                              ),
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
                          );
                        }),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.03,
                        horizontal: screenWidth * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                canScrollLeft
                                    ? Colors.grey.withAlpha(100)
                                    : Colors.grey.withAlpha(80),
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
                                canScrollLeft
                                    ? Colors.grey.withAlpha(100)
                                    : Colors.grey.withAlpha(80),
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
              ],
            ),
          ),
          Header(),
        ],
      ),
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
        image: DecorationImage(
          image: AssetImage(card.image),
          fit: BoxFit.cover,
        ),
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: screenWidth * 0.012,
                  ),
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
                isExpanded
                    ? CupertinoIcons.xmark_circle_fill
                    : CupertinoIcons.add_circled_solid,
                color:
                    isExpanded ? Theme.of(context).primaryColor : Colors.white,
                size: screenWidth * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isHover = false;
  int? hoveredIndex;
  String? ishoverother = "";
  bool showMobileMenu = false;
  int? selectedMobileIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (showMobileMenu && screenWidth >= 850) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          showMobileMenu = false;
          selectedMobileIndex = null;
        });
      });
    }

    return Stack(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: isHover ? 10.0 : 0.0),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                child: Container(),
              ),
            );
          },
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: MouseRegion(
            onExit: (_) {
              setState(() {
                isHover = false;
                hoveredIndex = null;
                ishoverother = "";
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: isHover ? 300 : 44,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: Theme.of(context).primaryColor.withAlpha(200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: 10,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 1024),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MouseRegion(
                                      onEnter: (_) {
                                        setState(() {
                                          isHover = false;
                                          ishoverother = "logo";
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          ishoverother = "";
                                        });
                                      },
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween<double>(
                                          begin: 210,
                                          end:
                                              ishoverother == "logo"
                                                  ? 255
                                                  : 210,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        builder: (context, value, child) {
                                          return Image.asset(
                                            "lib/src/img/WIsotipo.png",
                                            height: 20,
                                            color: Colors.white.withAlpha(
                                              value.toInt(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    if (screenWidth > 850)
                                      ...List.generate(
                                        MenuData.navbarItems.length,
                                        (index) {
                                          return MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            onEnter: (_) {
                                              setState(() {
                                                isHover = true;
                                                hoveredIndex = index;
                                              });
                                            },
                                            child: TweenAnimationBuilder<
                                              double
                                            >(
                                              tween: Tween<double>(
                                                begin: 200,
                                                end:
                                                    hoveredIndex == index
                                                        ? 255
                                                        : 200,
                                              ),
                                              duration: Duration(
                                                milliseconds: 200,
                                              ),
                                              curve: Curves.easeInOut,
                                              builder: (context, value, child) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Text(
                                                    MenuData.navbarItems[index],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white
                                                          .withAlpha(
                                                            value.toInt(),
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    Row(
                                      children: [
                                        MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              isHover = false;
                                              ishoverother = "search";
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              ishoverother = "";
                                            });
                                          },
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween<double>(
                                              begin: 200,
                                              end:
                                                  ishoverother == "search"
                                                      ? 255
                                                      : 200,
                                            ),
                                            duration: Duration(
                                              milliseconds: 200,
                                            ),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return Icon(
                                                CupertinoIcons.search,
                                                color: Colors.white.withAlpha(
                                                  value.toInt(),
                                                ),
                                                size: 18,
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.03),
                                        MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              isHover = false;
                                              ishoverother = "bag";
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              ishoverother = "";
                                            });
                                          },
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween<double>(
                                              begin: 200,
                                              end:
                                                  ishoverother == "bag"
                                                      ? 255
                                                      : 200,
                                            ),
                                            duration: Duration(
                                              milliseconds: 200,
                                            ),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return Icon(
                                                CupertinoIcons.bag,
                                                color: Colors.white.withAlpha(
                                                  value.toInt(),
                                                ),
                                                size: 18,
                                              );
                                            },
                                          ),
                                        ),
                                        if (screenWidth < 850)
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.03,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showMobileMenu = true;
                                                    selectedMobileIndex = null;
                                                  });
                                                },
                                                child: MouseRegion(
                                                  onEnter: (_) {
                                                    setState(() {
                                                      isHover = false;
                                                      ishoverother = "line";
                                                    });
                                                  },
                                                  onExit: (_) {
                                                    setState(() {
                                                      ishoverother = "";
                                                    });
                                                  },
                                                  child: TweenAnimationBuilder<
                                                    double
                                                  >(
                                                    tween: Tween<double>(
                                                      begin: 200,
                                                      end:
                                                          ishoverother == "line"
                                                              ? 255
                                                              : 200,
                                                    ),
                                                    duration: Duration(
                                                      milliseconds: 200,
                                                    ),
                                                    curve: Curves.easeInOut,
                                                    builder: (
                                                      context,
                                                      value,
                                                      child,
                                                    ) {
                                                      return Icon(
                                                        CupertinoIcons
                                                            .line_horizontal_3,
                                                        color: Colors.white
                                                            .withAlpha(
                                                              value.toInt(),
                                                            ),
                                                        size: 18,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (isHover && hoveredIndex != null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 50,
                                      bottom: 50,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          MenuData.submenus[hoveredIndex!]
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                                int idx = entry.key;
                                                Map<String, dynamic> section =
                                                    entry.value;
                                                bool isFirstColumn = idx == 0;
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    right:
                                                        isFirstColumn
                                                            ? 100
                                                            : 50,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        section["title"],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white
                                                              .withAlpha(200),
                                                        ),
                                                      ),
                                                      SizedBox(height: 25),
                                                      ...section["items"].asMap().entries.map<
                                                        Widget
                                                      >((entry) {
                                                        String item =
                                                            entry.value;
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                bottom: 3,
                                                              ),
                                                          child: MouseRegion(
                                                            cursor:
                                                                SystemMouseCursors
                                                                    .click,
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    isFirstColumn
                                                                        ? 22
                                                                        : 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white
                                                                    .withAlpha(
                                                                      isFirstColumn
                                                                          ? 255
                                                                          : 250,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ],
                                                  ),
                                                );
                                              })
                                              .toList(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showMobileMenu && screenWidth < 850)
          Positioned.fill(
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (selectedMobileIndex != null)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMobileIndex = null;
                            });
                          },
                          child: Icon(CupertinoIcons.back, color: Colors.white),
                        ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showMobileMenu = false;
                            selectedMobileIndex = null;
                          });
                        },
                        child: Icon(CupertinoIcons.clear, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child:
                        selectedMobileIndex == null
                            ? ListView.builder(
                              itemCount: MenuData.navbarItems.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedMobileIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      MenuData.navbarItems[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                            : ListView(
                              children: [
                                ...MenuData.submenus[selectedMobileIndex!].map((
                                  section,
                                ) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        section['title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      ...List.generate(
                                        (section['items'] as List).length,
                                        (i) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            section['items'][i],
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  );
                                }),
                              ],
                            ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
