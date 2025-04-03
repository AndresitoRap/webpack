import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/menu_data.dart';
import 'package:delayed_display/delayed_display.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isHover = false;
  bool justOpened = false;
  int? hoveredIndex;
  String? ishoverother = "";
  bool showMobileMenu = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (showMobileMenu && screenWidth >= 850) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          showMobileMenu = false;
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
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: value, sigmaY: value), child: Container()),
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
            child:
                screenWidth <= 850
                    ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showMobileMenu = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: double.infinity,
                        height:
                            isHover && screenWidth <= 850
                                ? MediaQuery.of(context).size.height
                                : isHover && screenWidth > 850
                                ? 340
                                : 48,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    height: isHover ? MediaQuery.of(context).size.height : 48,
                                    color: Theme.of(context).primaryColor.withAlpha(200),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                                        child: SingleChildScrollView(
                                          physics: NeverScrollableScrollPhysics(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: isHover ? MediaQuery.of(context).size.height : 12,
                                                  left: 15,
                                                  right: 15,
                                                ),
                                                child: Center(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(maxWidth: 1024),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                  end: ishoverother == "logo" ? 255 : 210,
                                                                ),
                                                                duration: Duration(milliseconds: 200),
                                                                builder: (context, value, child) {
                                                                  return AnimatedOpacity(
                                                                    opacity: isHover ? 0.0 : 1.0,
                                                                    duration: Duration(milliseconds: 300),
                                                                    child: Image.asset(
                                                                      "lib/src/img/WIsotipo.png",
                                                                      height: 20,
                                                                      color: Colors.white.withAlpha(value.toInt()),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
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
                                                                      end: ishoverother == "search" ? 255 : 200,
                                                                    ),
                                                                    duration: Duration(milliseconds: 200),
                                                                    builder: (context, value, child) {
                                                                      return AnimatedOpacity(
                                                                        opacity: isHover ? 0.0 : 1.0,
                                                                        duration: Duration(milliseconds: 300),
                                                                        child: Icon(
                                                                          CupertinoIcons.search,
                                                                          color: Colors.white.withAlpha(value.toInt()),
                                                                          size: 20,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(width: screenWidth * 0.04),
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
                                                                      end: ishoverother == "bag" ? 255 : 200,
                                                                    ),
                                                                    duration: Duration(milliseconds: 200),
                                                                    builder: (context, value, child) {
                                                                      return AnimatedOpacity(
                                                                        opacity: isHover ? 0.0 : 1.0,
                                                                        duration: Duration(milliseconds: 300),
                                                                        child: Icon(
                                                                          CupertinoIcons.bag,
                                                                          color: Colors.white.withAlpha(value.toInt()),
                                                                          size: 20,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(width: screenWidth * 0.03),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          if (isHover) {
                                                                            // Si ya está abierto, cerramos
                                                                            isHover = false;
                                                                            hoveredIndex = null;
                                                                          } else {
                                                                            // Si está cerrado, abrimos
                                                                            isHover = true;
                                                                            hoveredIndex = null;
                                                                          }
                                                                        });
                                                                      },
                                                                      child: MouseRegion(
                                                                        onEnter: (_) {
                                                                          setState(() {
                                                                            ishoverother = "line";
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
                                                                            end: ishoverother == "line" ? 255 : 200,
                                                                          ),
                                                                          duration: Duration(milliseconds: 200),
                                                                          builder: (context, value, child) {
                                                                            return AnimatedSwitcher(
                                                                              duration: Duration(milliseconds: 300),

                                                                              transitionBuilder: (child, animation) {
                                                                                return ScaleTransition(
                                                                                  scale: animation,
                                                                                  child: child,
                                                                                );
                                                                              },
                                                                              child: Icon(
                                                                                isHover
                                                                                    ? CupertinoIcons.xmark
                                                                                    : CupertinoIcons.equal,
                                                                                key: ValueKey<bool>(isHover),
                                                                                color: Colors.white.withAlpha(
                                                                                  value.toInt(),
                                                                                ),
                                                                                size: 26,
                                                                              ),
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

                                                        AnimatedSwitcher(
                                                          duration: Duration(milliseconds: 300),
                                                          transitionBuilder: (child, animation) {
                                                            return FadeTransition(
                                                              opacity: animation,
                                                              child: SizeTransition(
                                                                sizeFactor: animation,
                                                                axisAlignment: -1.0,
                                                                child: child,
                                                              ),
                                                            );
                                                          },
                                                          child:
                                                              isHover
                                                                  ? Align(
                                                                    key: ValueKey("hover_menu"),
                                                                    alignment: Alignment.topLeft,
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(
                                                                        top: 20,
                                                                        left: 15,
                                                                        right: 15,
                                                                      ),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: List.generate(
                                                                          MenuData.navbarItems.length,
                                                                          (index) {
                                                                            return DelayedDisplay(
                                                                              slidingCurve: Curves.easeInOut,
                                                                              delay: Duration(milliseconds: 40 * index),
                                                                              fadingDuration: Duration(
                                                                                milliseconds: 300,
                                                                              ),
                                                                              slidingBeginOffset: const Offset(
                                                                                0.0,
                                                                                0.1,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(
                                                                                  vertical: 10.0,
                                                                                ),
                                                                                child: GestureDetector(
                                                                                  onTap: () {},
                                                                                  child: Text(
                                                                                    MenuData.navbarItems[index],
                                                                                    style: TextStyle(
                                                                                      fontSize: 26,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  : SizedBox(key: ValueKey("empty")),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                    )
                    : AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: double.infinity,

                      height: isHover ? 387 : 46,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            color: Theme.of(context).primaryColor.withAlpha(200),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 1024),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  end: ishoverother == "logo" ? 255 : 210,
                                                ),
                                                duration: Duration(milliseconds: 200),
                                                curve: Curves.easeInOut,
                                                builder: (context, value, child) {
                                                  return Image.asset(
                                                    "lib/src/img/WIsotipo.png",
                                                    height: 20,
                                                    color: Colors.white.withAlpha(value.toInt()),
                                                  );
                                                },
                                              ),
                                            ),
                                            ...List.generate(MenuData.navbarItems.length, (index) {
                                              return MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                onEnter: (_) {
                                                  setState(() {
                                                    isHover = true;
                                                    hoveredIndex = index;
                                                  });
                                                },
                                                child: TweenAnimationBuilder<double>(
                                                  tween: Tween<double>(
                                                    begin: 200,
                                                    end: hoveredIndex == index ? 255 : 200,
                                                  ),
                                                  duration: Duration(milliseconds: 200),
                                                  curve: Curves.easeInOut,
                                                  builder: (context, value, child) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        String path =
                                                            "/${MenuData.navbarItems[index].replaceAll("®", "")}";
                                                        Navigator.pushNamed(context, path);
                                                      },
                                                      child: Text(
                                                        MenuData.navbarItems[index],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white.withAlpha(value.toInt()),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }),
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
                                                      end: ishoverother == "search" ? 255 : 200,
                                                    ),
                                                    duration: Duration(milliseconds: 200),
                                                    curve: Curves.easeInOut,
                                                    builder: (context, value, child) {
                                                      return Icon(
                                                        CupertinoIcons.search,
                                                        color: Colors.white.withAlpha(value.toInt()),
                                                        size: 20,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: screenWidth * 0.04),
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
                                                      end: ishoverother == "bag" ? 255 : 200,
                                                    ),
                                                    duration: Duration(milliseconds: 200),
                                                    curve: Curves.easeInOut,
                                                    builder: (context, value, child) {
                                                      return Icon(
                                                        CupertinoIcons.bag,
                                                        color: Colors.white.withAlpha(value.toInt()),
                                                        size: 20,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        AnimatedSwitcher(
                                          duration: Duration(milliseconds: 300),
                                          transitionBuilder: (Widget child, Animation<double> animation) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: SizeTransition(
                                                sizeFactor: animation,
                                                axisAlignment: -1.0,
                                                child: child,
                                              ),
                                            );
                                          },
                                          child:
                                              isHover && hoveredIndex != null
                                                  ? Padding(
                                                    key: ValueKey<int>(hoveredIndex!),
                                                    padding: EdgeInsets.only(top: 50, bottom: 50),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:
                                                          MenuData.submenus[hoveredIndex!].asMap().entries.map((entry) {
                                                            int idx = entry.key;
                                                            Map<String, dynamic> section = entry.value;
                                                            bool isFirstColumn = idx == 0;

                                                            return Padding(
                                                              padding: EdgeInsets.only(right: isFirstColumn ? 100 : 50),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    section["title"],
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Colors.white.withAlpha(200),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 25),
                                                                  ...section["items"].asMap().entries.map<Widget>((
                                                                    entry,
                                                                  ) {
                                                                    int itemIndex = entry.key;
                                                                    String item = entry.value;
                                                                    return DelayedDisplay(
                                                                      delay: Duration(milliseconds: itemIndex * 100),
                                                                      fadingDuration: Duration(milliseconds: 300),
                                                                      slidingBeginOffset: const Offset(0.0, 0.2),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(bottom: 3),
                                                                        child: MouseRegion(
                                                                          cursor: SystemMouseCursors.click,
                                                                          child: GestureDetector(
                                                                            onTap: () {
                                                                              String path = MenuData
                                                                                  .navbarItems[hoveredIndex!]
                                                                                  .replaceAll("®", "")
                                                                                  .replaceAll(" ", "");
                                                                              String sectionTitle = section["title"]
                                                                                  .toString()
                                                                                  .replaceAll(" ", "-");
                                                                              String itemPath = item.replaceAll(
                                                                                " ",
                                                                                "-",
                                                                              );
                                                                              String fullRoute =
                                                                                  "/$path/$sectionTitle/$itemPath";
                                                                              Navigator.pushNamed(context, fullRoute);
                                                                            },
                                                                            child: Text(
                                                                              item,
                                                                              style: TextStyle(
                                                                                fontSize: isFirstColumn ? 22 : 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white.withAlpha(
                                                                                  isFirstColumn ? 255 : 250,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ],
                                                              ),
                                                            );
                                                          }).toList(),
                                                    ),
                                                  )
                                                  : SizedBox.shrink(),
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
      ],
    );
  }
}
