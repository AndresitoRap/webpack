import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webpack/class/cardproduct.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class SmartBag extends StatefulWidget {
  const SmartBag({super.key});

  @override
  State<SmartBag> createState() => _SmartBagState();
}

class _SmartBagState extends State<SmartBag> {
  //Seccion scrolleable
  final ScrollController _scrollController = ScrollController();
  List<bool> isHoverCardList = List.generate(fivePRO.length, (_) => false);
  List<bool> isHoverIconList = List.generate(fivePRO.length, (_) => false);
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                                Text(
                                  "SmartBag®",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: min(60, screenWidth * 0.1),
                                  ),
                                ),
                                Text(
                                  "Diseño que protege.\nTecnología que empaca.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 0,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: min(22, screenWidth * 0.04),
                                  ),
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
                            Text(
                              "SmartBag®",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: min(45, screenWidth * 0.1),
                              ),
                            ),
                            Text(
                              "Diseño que protege.\nTecnología que empaca.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 0,
                                color: Theme.of(context).primaryColor,
                                fontSize: min(22, screenWidth * 0.04),
                              ),
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
                    list: fivePRO,
                    scrollController: _scrollController,
                    ishoverlist: isHoverCardList,
                    ishovericonlist: isHoverIconList,
                    scrollControllerLeft: canScrollLeft,
                    scrollControllerRigth: canScrollRight,
                  ),
                  SizedBox(height: screenWidth * 0.1),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.1),
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                          child: Text(
                            "Nuestras lineas.",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: min(screenWidth * 0.06, 55),
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(7, (int index) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 3))],
                                    border: Border.all(color: Colors.black12, width: 1),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
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
