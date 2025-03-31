import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/menu_data.dart';

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
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 10),
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
                                        tween: Tween<double>(begin: 210, end: ishoverother == "logo" ? 255 : 210),
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
                                    if (screenWidth > 850)
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
                                            tween: Tween<double>(begin: 200, end: hoveredIndex == index ? 255 : 200),
                                            duration: Duration(milliseconds: 200),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return GestureDetector(
                                                onTap: () {},
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
                                            tween: Tween<double>(begin: 200, end: ishoverother == "search" ? 255 : 200),
                                            duration: Duration(milliseconds: 200),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return Icon(
                                                CupertinoIcons.search,
                                                color: Colors.white.withAlpha(value.toInt()),
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
                                            tween: Tween<double>(begin: 200, end: ishoverother == "bag" ? 255 : 200),
                                            duration: Duration(milliseconds: 200),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return Icon(
                                                CupertinoIcons.bag,
                                                color: Colors.white.withAlpha(value.toInt()),
                                                size: 18,
                                              );
                                            },
                                          ),
                                        ),
                                        if (screenWidth < 850)
                                          Row(
                                            children: [
                                              SizedBox(width: screenWidth * 0.03),
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
                                                  child: TweenAnimationBuilder<double>(
                                                    tween: Tween<double>(
                                                      begin: 200,
                                                      end: ishoverother == "line" ? 255 : 200,
                                                    ),
                                                    duration: Duration(milliseconds: 200),
                                                    curve: Curves.easeInOut,
                                                    builder: (context, value, child) {
                                                      return Icon(
                                                        CupertinoIcons.line_horizontal_3,
                                                        color: Colors.white.withAlpha(value.toInt()),
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
                                                    style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(200)),
                                                  ),
                                                  SizedBox(height: 25),
                                                  ...section["items"].asMap().entries.map<Widget>((entry) {
                                                    String item = entry.value;
                                                    return Padding(
                                                      padding: EdgeInsets.only(bottom: 3),
                                                      child: MouseRegion(
                                                        cursor: SystemMouseCursors.click,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: isFirstColumn ? 22 : 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white.withAlpha(isFirstColumn ? 255 : 250),
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
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      MenuData.navbarItems[index],
                                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              },
                            )
                            : ListView(
                              children: [
                                ...MenuData.submenus[selectedMobileIndex!].map((section) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            section['items'][i],
                                            style: TextStyle(color: Colors.white70, fontSize: 14),
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
