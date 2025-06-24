import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:webpack/class/cardproduct.dart';

/// Returns the correct CardProduct list based on isSmartBag flag.
List<CardProduct> getCardProductList({bool isSmartBag = true}) {
  return isSmartBag ? cardFindS : cardFindE;
}

/// Builds the dialog content for a CardProduct, using dynamic data.
Widget buildDialogContent(BuildContext context, int index, {required bool isSmartBag}) {
  final selectedList = getCardProductList(isSmartBag: isSmartBag);
  final card = selectedList[index];
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            screenWidth < 1070
                // Celular
                ? MobileStyle(description: card.descriptionTop, imagePath: card.imageTop)
                // PC
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: AspectRatio(aspectRatio: 3 / 4, child: Image.asset(card.imageTop, fit: BoxFit.cover))),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Column(
                          children: [
                            Text(
                              card.descriptionTop,
                              style: TextStyle(
                                color: Color.fromARGB(255, 125, 126, 129),
                                fontWeight: FontWeight.bold,
                                fontSize: min(28, screenWidth * 0.05),
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            screenWidth < 1070
                // Celular
                ? MobileStyle(description: "Empaques Packvisión ${card.descriptionDown ?? ""}", imagePath: card.imageDown)
                // PC
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: card.descriptionDown ?? "",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 125, 126, 129),
                                      fontWeight: FontWeight.bold,
                                      fontSize: min(28, screenWidth * 0.05),
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(flex: 1, child: AspectRatio(aspectRatio: 3 / 4, child: Image.asset(card.imageDown, fit: BoxFit.cover))),
                  ],
                ),
          ],
        ),
      ),
    ],
  );
}

class MobileStyle extends StatelessWidget {
  final String description;
  final String imagePath;
  const MobileStyle({super.key, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: min(100, screenWidth * 0.07)),
          child: Text(
            description,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: min(22, screenWidth * 0.05), height: 1.2),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(aspectRatio: 3 / 4, child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(imagePath, fit: BoxFit.cover))),
      ],
    );
  }
}
