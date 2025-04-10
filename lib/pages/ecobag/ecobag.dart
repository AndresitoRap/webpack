import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webpack/class/cardproduct.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class EcoBag extends StatefulWidget {
  const EcoBag({super.key});

  @override
  State<EcoBag> createState() => _EcoBagState();
}

class _EcoBagState extends State<EcoBag> {
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
                                  "EcoBag®",
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
                              "EcoBag®",
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
                      width: screenWidth,
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
                    title: "Descubre Eco.",
                    list: fivePRO,
                    scrollController: _scrollController,
                    ishoverlist: isHoverCardList,
                    ishovericonlist: isHoverIconList,
                    scrollControllerLeft: canScrollLeft,
                    scrollControllerRigth: canScrollRight,
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
