import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class OurLines extends StatelessWidget {
  const OurLines({
    super.key,
    required this.text,
    required this.list,
    required this.ecoOrSmartColor,
    required ScrollController scrollControllerfamily,
    required this.canScrollLeftFamily,
    required this.canScrollRightFamily,
  }) : _scrollControllerfamily = scrollControllerfamily;

  final ScrollController _scrollControllerfamily;
  final String text;
  final bool canScrollLeftFamily;
  final bool canScrollRightFamily;
  final dynamic list;
  final Color ecoOrSmartColor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.07),
      width: screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.07, 55)),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollControllerfamily,
            child: Row(
              children: List.generate(list.length, (int index) {
                final double horizontalPadding = screenWidth * 0.06;
                final categorie = list[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? horizontalPadding : 0,
                        right: index == 7 - 1 ? horizontalPadding : 50,
                        top: 80,
                      ),
                      child: SizedBox(
                        width: min(300, screenWidth),
                        height: 590,
                        child: Column(
                          crossAxisAlignment: screenWidth >= 800 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 250,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(image: AssetImage(categorie.img), fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              categorie.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ecoOrSmartColor,
                                fontSize: min(40, screenWidth * 0.04),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(categorie.description, style: TextStyle(fontSize: min(16, screenWidth * 0.03))),
                            SizedBox(height: 10),
                            Text(
                              categorie.sdescription,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(16, screenWidth * 0.03)),
                            ),
                            Spacer(),
                            Icon(Boxicons.bxs_ruler, size: 30, color: ecoOrSmartColor),
                            Text(categorie.dimentions, style: TextStyle(fontSize: min(16, screenWidth * 0.03))),

                            SizedBox(height: 10),
                            categorie.enabled
                                ? MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: ecoOrSmartColor,
                                      ),
                                      child: Text("Saber más", style: TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                  ),
                                )
                                : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(255, 216, 216, 216),
                                  ),
                                  child: Text("Saber más", style: TextStyle(color: Colors.grey, fontSize: 16)),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      canScrollLeftFamily ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80),
                    ),
                  ),
                  onPressed:
                      canScrollLeftFamily
                          ? () {
                            _scrollControllerfamily.animateTo(
                              _scrollControllerfamily.offset - 500,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                          }
                          : null,
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const SizedBox(width: 20),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      canScrollRightFamily ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80),
                    ),
                  ),
                  onPressed:
                      canScrollRightFamily
                          ? () {
                            _scrollControllerfamily.animateTo(
                              _scrollControllerfamily.offset + 500,
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
    );
  }
}
