import 'dart:ui';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/menu_data.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:webpack/main.dart';

//blur para los videos (HTML incrustado)
final ValueNotifier<bool> videoBlurNotifier = ValueNotifier(false);

class Header extends StatefulWidget {
  final void Function(bool)? onHoverChange;
  const Header({super.key, this.onHoverChange});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isHover = false;
  bool justOpened = false;
  int? hoveredIndex;
  String? ishoverother = "";
  bool showMobileMenu = false;
  int? hoveredMobileIndex;
  int? selectedMenuIndex;
  bool showSubmenu = false;

  String normalizeRoute(String input) {
    final replacements = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'Á': 'A',
      'É': 'E',
      'Í': 'I',
      'Ó': 'O',
      'Ú': 'U',
      'ñ': 'n',
      'Ñ': 'N',
      ' ': '-',
      '¿': '',
      '?': '',
      '¡': '',
      '!': '',
      '®': '',
    };

    String result = input;
    replacements.forEach((key, value) {
      result = result.replaceAll(key, value);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

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
                videoBlurNotifier.value = false;
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
                                    color:
                                        currentRoute.contains("EcoBag")
                                            ? Color.fromARGB(255, 41, 112, 9).withAlpha(170)
                                            : Theme.of(context).primaryColor.withAlpha(200),

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
                                                              cursor: SystemMouseCursors.click,
                                                              onEnter: (_) {
                                                                setState(() {
                                                                  if (showMobileMenu) {
                                                                    isHover = false;
                                                                    videoBlurNotifier.value = false;
                                                                  }
                                                                  ishoverother = "logo";
                                                                });
                                                              },
                                                              onExit: (_) {
                                                                setState(() {
                                                                  ishoverother = "";
                                                                });
                                                              },
                                                              child: TweenAnimationBuilder<double>(
                                                                tween: Tween<double>(begin: 210, end: ishoverother == "logo" ? 255 : 210),
                                                                duration: Duration(milliseconds: 200),
                                                                builder: (context, value, child) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      if (ModalRoute.of(context)?.settings.name != '/') {
                                                                        navigateWithSlide(context, '/');
                                                                      }
                                                                    },
                                                                    child:
                                                                        showSubmenu
                                                                            ? GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  showSubmenu = false;
                                                                                  selectedMenuIndex = null;
                                                                                });
                                                                              },
                                                                              child: MouseRegion(
                                                                                cursor: SystemMouseCursors.click,

                                                                                child: TweenAnimationBuilder<double>(
                                                                                  tween: Tween<double>(
                                                                                    begin: 200,
                                                                                    end: ishoverother == "back" ? 255 : 200,
                                                                                  ),
                                                                                  duration: Duration(milliseconds: 200),
                                                                                  builder: (context, value, child) {
                                                                                    return Icon(
                                                                                      CupertinoIcons.chevron_back,
                                                                                      key: ValueKey<bool>(showSubmenu),
                                                                                      color: Colors.white.withAlpha(value.toInt()),
                                                                                      size: 26,
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            )
                                                                            : AnimatedOpacity(
                                                                              opacity: isHover ? 0.0 : 1.0,
                                                                              duration: Duration(milliseconds: 300),
                                                                              child: Image.asset(
                                                                                "assets/img/WIsotipo.webp",
                                                                                height: 20,
                                                                                color: Colors.white.withAlpha(value.toInt()),
                                                                              ),
                                                                            ),
                                                                  );
                                                                },
                                                              ),
                                                            ),

                                                            Row(
                                                              children: [
                                                                // MouseRegion(
                                                                //   onEnter: (_) {
                                                                //     setState(() {
                                                                //       if (showMobileMenu) {
                                                                //         isHover = false;
                                                                //         videoBlurNotifier.value = false;
                                                                //       }
                                                                //       ishoverother = "search";
                                                                //     });
                                                                //   },
                                                                //   onExit: (_) {
                                                                //     setState(() {
                                                                //       ishoverother = "";
                                                                //     });
                                                                //   },
                                                                //   child: TweenAnimationBuilder<double>(
                                                                //     tween: Tween<double>(
                                                                //       begin: 200,
                                                                //       end: ishoverother == "search" ? 255 : 200,
                                                                //     ),
                                                                //     duration: Duration(milliseconds: 200),
                                                                //     builder: (context, value, child) {
                                                                //       return AnimatedOpacity(
                                                                //         opacity: isHover ? 0.0 : 1.0,
                                                                //         duration: Duration(milliseconds: 300),
                                                                //         child: Icon(
                                                                //           CupertinoIcons.search,
                                                                //           color: Colors.white.withAlpha(value.toInt()),
                                                                //           size: 20,
                                                                //         ),
                                                                //       );
                                                                //     },
                                                                //   ),
                                                                // ),
                                                                // SizedBox(width: screenWidth * 0.04),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    navigateWithSlide(context, "/cart");
                                                                  },
                                                                  child: MouseRegion(
                                                                    onEnter: (_) {
                                                                      setState(() {
                                                                        if (showMobileMenu) {
                                                                          isHover = false;
                                                                          videoBlurNotifier.value = false;
                                                                        }
                                                                        ishoverother = "bag";
                                                                      });
                                                                    },
                                                                    onExit: (_) {
                                                                      setState(() {
                                                                        ishoverother = "";
                                                                      });
                                                                    },
                                                                    cursor: SystemMouseCursors.click,
                                                                    child: TweenAnimationBuilder<double>(
                                                                      tween: Tween<double>(begin: 200, end: ishoverother == "bag" ? 255 : 200),
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
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(width: screenWidth * 0.03),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          if (isHover) {
                                                                            isHover = false;
                                                                            hoveredIndex = null;
                                                                            showSubmenu = false;
                                                                            videoBlurNotifier.value = false;
                                                                          } else {
                                                                            isHover = true;
                                                                            videoBlurNotifier.value = true;
                                                                            hoveredIndex = null;
                                                                          }
                                                                        });
                                                                      },
                                                                      child: MouseRegion(
                                                                        cursor: SystemMouseCursors.click,

                                                                        child: TweenAnimationBuilder<double>(
                                                                          tween: Tween<double>(begin: 200, end: ishoverother == "line" ? 255 : 200),
                                                                          duration: Duration(milliseconds: 200),
                                                                          builder: (context, value, child) {
                                                                            return AnimatedSwitcher(
                                                                              duration: Duration(milliseconds: 300),

                                                                              transitionBuilder: (child, animation) {
                                                                                return ScaleTransition(scale: animation, child: child);
                                                                              },
                                                                              child: Icon(
                                                                                isHover ? CupertinoIcons.xmark : CupertinoIcons.equal,
                                                                                key: ValueKey<bool>(isHover),
                                                                                color: Colors.white.withAlpha(value.toInt()),
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
                                                              child: SizeTransition(sizeFactor: animation, axisAlignment: -1.0, child: child),
                                                            );
                                                          },
                                                          child:
                                                              isHover
                                                                  ? Align(
                                                                    key: ValueKey("hover_menu"),
                                                                    alignment: Alignment.topLeft,
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                                                                      child:
                                                                          showSubmenu
                                                                              ? Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(bottom: 24.0),
                                                                                    child: MouseRegion(
                                                                                      cursor: SystemMouseCursors.click,
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          final path =
                                                                                              "/${MenuData.navbarItems[selectedMenuIndex!].replaceAll("®", "").replaceAll(" ", "")}";
                                                                                          if (ModalRoute.of(context)?.settings.name != path) {
                                                                                            navigateWithSlide(context, path);
                                                                                          }
                                                                                        },
                                                                                        child: Text(
                                                                                          'Descubre todo de ${MenuData.navbarItems[selectedMenuIndex!]}',
                                                                                          style: const TextStyle(
                                                                                            fontSize: 24,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  ...MenuData.submenus[selectedMenuIndex!].expand((section) {
                                                                                    return [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                                                        child: Text(
                                                                                          section['title'],
                                                                                          style: TextStyle(
                                                                                            color: Colors.white.withAlpha(200),
                                                                                            fontSize: 18,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(height: 8),
                                                                                      ...List<Widget>.from(
                                                                                        section['items'].map<Widget>((item) {
                                                                                          return MouseRegion(
                                                                                            cursor: SystemMouseCursors.click,
                                                                                            child: GestureDetector(
                                                                                              onTap: () {
                                                                                                String path = normalizeRoute(
                                                                                                  MenuData.navbarItems[selectedMenuIndex!],
                                                                                                );
                                                                                                String sectionTitle = normalizeRoute(
                                                                                                  section["title"],
                                                                                                );
                                                                                                String itemPath = normalizeRoute(item);

                                                                                                String fullRoute = "/$path/$sectionTitle/$itemPath";

                                                                                                if (ModalRoute.of(context)?.settings.name !=
                                                                                                    fullRoute) {
                                                                                                  navigateWithSlide(context, fullRoute);
                                                                                                }
                                                                                              },
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.symmetric(vertical: 4),
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontSize: 20,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }),
                                                                                      ),
                                                                                    ];
                                                                                  }),
                                                                                ],
                                                                              )
                                                                              : Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: List.generate(MenuData.navbarItems.length, (index) {
                                                                                  return DelayedDisplay(
                                                                                    slidingCurve: Curves.easeInOut,
                                                                                    delay: Duration(milliseconds: 40 * index),
                                                                                    fadingDuration: Duration(milliseconds: 300),
                                                                                    slidingBeginOffset: const Offset(0.0, 0.1),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                                                      child: MouseRegion(
                                                                                        cursor: SystemMouseCursors.click,
                                                                                        onEnter: (_) {
                                                                                          setState(() {
                                                                                            hoveredMobileIndex =
                                                                                                hoveredMobileIndex == index ? null : index;
                                                                                          });
                                                                                        },
                                                                                        onExit: (_) {
                                                                                          setState(() {
                                                                                            hoveredMobileIndex =
                                                                                                hoveredMobileIndex == index ? null : index;
                                                                                          });
                                                                                        },
                                                                                        child: GestureDetector(
                                                                                          onTap: () {
                                                                                            setState(() {
                                                                                              selectedMenuIndex = index;
                                                                                              showSubmenu = true;
                                                                                            });
                                                                                          },

                                                                                          child: Row(
                                                                                            children: [
                                                                                              Text(
                                                                                                MenuData.navbarItems[index],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 26,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              ),
                                                                                              Spacer(),
                                                                                              AnimatedOpacity(
                                                                                                opacity: hoveredMobileIndex == index ? 1.0 : 0.0,
                                                                                                duration: Duration(milliseconds: 300),
                                                                                                child: Icon(
                                                                                                  CupertinoIcons.chevron_right,
                                                                                                  color: Colors.white,
                                                                                                ),
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
                            color:
                                (ModalRoute.of(context)?.settings.name?.toLowerCase().contains("ecobag") ?? false)
                                    ? Color.fromARGB(255, 41, 112, 9).withAlpha(170)
                                    : Theme.of(context).primaryColor.withAlpha(200),
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
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (_) {
                                                setState(() {
                                                  isHover = false;
                                                  ishoverother = "logo";
                                                  videoBlurNotifier.value = false;
                                                });
                                              },
                                              onExit: (_) {
                                                setState(() {
                                                  ishoverother = "";
                                                });
                                              },
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (ModalRoute.of(context)?.settings.name != '/') {
                                                    navigateWithSlide(context, "/");
                                                  }
                                                },
                                                child: TweenAnimationBuilder<double>(
                                                  tween: Tween<double>(begin: 210, end: ishoverother == "logo" ? 255 : 210),
                                                  duration: Duration(milliseconds: 200),
                                                  curve: Curves.easeInOut,
                                                  builder: (context, value, child) {
                                                    return Image.asset(
                                                      "assets/img/WIsotipo.webp",
                                                      height: 20,
                                                      color: Colors.white.withAlpha(value.toInt()),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            ...List.generate(MenuData.navbarItems.length, (index) {
                                              return MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                onEnter: (_) {
                                                  setState(() {
                                                    isHover = true;
                                                    hoveredIndex = index;
                                                    videoBlurNotifier.value = true;
                                                  });
                                                },
                                                child: TweenAnimationBuilder<double>(
                                                  tween: Tween<double>(begin: 200, end: hoveredIndex == index ? 255 : 200),
                                                  duration: Duration(milliseconds: 200),
                                                  curve: Curves.easeInOut,
                                                  builder: (context, value, child) {
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        String currentPath = normalizeRoute("/${MenuData.navbarItems[index].replaceAll("®", "")}");
                                                        final currentRoute = ModalRoute.of(context)?.settings.name;

                                                        if (hoveredIndex != index) {
                                                          setState(() {
                                                            hoveredIndex = index;
                                                            isHover = true;
                                                            videoBlurNotifier.value = true;
                                                          });
                                                        } else {
                                                          if (currentRoute != currentPath) {
                                                            setState(() {
                                                              isHover = false;
                                                              videoBlurNotifier.value = false;
                                                              hoveredIndex = null;
                                                            });
                                                            await Future.delayed(Duration(milliseconds: 400));
                                                            navigateWithSlide(context, currentPath);
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        MenuData.navbarItems[index],
                                                        style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(value.toInt())),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }),
                                            Row(
                                              children: [
                                                // MouseRegion(
                                                //   onEnter: (_) {
                                                //     setState(() {
                                                //       isHover = false;
                                                //       ishoverother = "search";
                                                //       videoBlurNotifier.value = false;
                                                //     });
                                                //   },
                                                //   onExit: (_) {
                                                //     setState(() {
                                                //       ishoverother = "";
                                                //     });
                                                //   },
                                                //   child: TweenAnimationBuilder<double>(
                                                //     tween: Tween<double>(
                                                //       begin: 200,
                                                //       end: ishoverother == "search" ? 255 : 200,
                                                //     ),
                                                //     duration: Duration(milliseconds: 200),
                                                //     curve: Curves.easeInOut,
                                                //     builder: (context, value, child) {
                                                //       return Icon(
                                                //         CupertinoIcons.search,
                                                //         color: Colors.white.withAlpha(value.toInt()),
                                                //         size: 20,
                                                //       );
                                                //     },
                                                //   ),
                                                // ),
                                                // SizedBox(width: screenWidth * 0.04),
                                                GestureDetector(
                                                  onTap: () {
                                                    navigateWithSlide(context, "/cart");
                                                  },
                                                  child: MouseRegion(
                                                    onEnter: (_) {
                                                      setState(() {
                                                        isHover = false;
                                                        ishoverother = "bag";
                                                        videoBlurNotifier.value = false;
                                                      });
                                                    },
                                                    onExit: (_) {
                                                      setState(() {
                                                        ishoverother = "";
                                                      });
                                                    },
                                                    cursor: SystemMouseCursors.click,
                                                    child: TweenAnimationBuilder<double>(
                                                      tween: Tween<double>(begin: 200, end: ishoverother == "bag" ? 255 : 200),
                                                      duration: Duration(milliseconds: 200),
                                                      curve: Curves.easeInOut,
                                                      builder: (context, value, child) {
                                                        return Icon(CupertinoIcons.bag, color: Colors.white.withAlpha(value.toInt()), size: 20);
                                                      },
                                                    ),
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
                                              child: SizeTransition(sizeFactor: animation, axisAlignment: -1.0, child: child),
                                            );
                                          },
                                          child:
                                              isHover && hoveredIndex != null
                                                  ? Padding(
                                                    key: ValueKey<int>(hoveredIndex!),
                                                    padding: EdgeInsets.only(top: 50, bottom: 50, left: 50),
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
                                                                    style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(200)),
                                                                  ),
                                                                  SizedBox(height: 25),
                                                                  ...section["items"].asMap().entries.map<Widget>((entry) {
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
                                                                              String path = normalizeRoute(MenuData.navbarItems[hoveredIndex!]);
                                                                              String sectionTitle = normalizeRoute(section["title"]);
                                                                              String itemPath = normalizeRoute(item);

                                                                              String fullRoute = "/$path/$sectionTitle/$itemPath";

                                                                              if (ModalRoute.of(context)?.settings.name != fullRoute) {
                                                                                navigateWithSlide(context, fullRoute);
                                                                              }
                                                                            },
                                                                            child: Text(
                                                                              item,
                                                                              style: TextStyle(
                                                                                fontSize: isFirstColumn ? 22 : 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white.withAlpha(isFirstColumn ? 255 : 250),
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

class HtmlBackgroundVideo extends StatefulWidget {
  final String src;
  final bool blur;
  final bool loop;
  final VoidCallback? onEnded;

  const HtmlBackgroundVideo({super.key, required this.src, this.blur = false, required this.loop, this.onEnded});

  @override
  State<HtmlBackgroundVideo> createState() => _HtmlBackgroundVideoState();
}

class _HtmlBackgroundVideoState extends State<HtmlBackgroundVideo> {
  late final String _viewId;
  late html.VideoElement _videoElement;

  @override
  void initState() {
    super.initState();

    _viewId = 'html-video-${widget.src.hashCode}-${DateTime.now().millisecondsSinceEpoch}';

    _videoElement =
        html.VideoElement()
          ..src = widget.src
          ..autoplay = true
          ..loop = widget.loop
          ..muted = true
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = 'cover'
          ..style.transition = 'filter 0.5s ease-in-out'
          ..style.filter = widget.blur ? 'blur(30px)' : 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_viewId, (int viewId) => _videoElement);

    _videoElement.onEnded.listen((event) {
      if (widget.onEnded != null) {
        widget.onEnded!();
      }
    });
  }

  @override
  void didUpdateWidget(covariant HtmlBackgroundVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Solo cambia el filtro si el blur ha cambiado
    if (oldWidget.blur != widget.blur) {
      _videoElement.style.filter = widget.blur ? 'blur(10px)' : 'none';
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewId);
  }
}
