import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/discover.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class Commerce extends StatefulWidget {
  final String section;
  final Subcategorie selectedSubcategorie;
  const Commerce({super.key, required this.section, required this.selectedSubcategorie});

  @override
  State<Commerce> createState() => _CommerceState();
}

class _CommerceState extends State<Commerce> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    print(widget.section);

    Widget content;

    switch (widget.section.toLowerCase()) {
      case '4pro':
        content = FourPro(screenWidth: screenWidth, currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);

        break;

      default:
        content = Center(child: Text('Sección no encontrada'));
    }

    return Scaffold(body: Stack(children: [content, Header()]));
  }
}

class FourPro extends StatefulWidget {
  final double screenWidth;
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;

  const FourPro({super.key, required this.screenWidth, required this.currentRoute, required this.subcategorie, required this.section});

  @override
  State<FourPro> createState() => _FourProState();
}

class _FourProState extends State<FourPro> {
  int activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"icon": CupertinoIcons.shield, "text": "Protección superior para conservar la calidad de tus productos."},

      {"icon": CupertinoIcons.briefcase, "text": "Acabados premium que elevan la presentación de tu marca."},

      {"icon": CupertinoIcons.lock, "text": "Sellado seguro para mayor protección."},

      {"icon": CupertinoIcons.arrow_2_squarepath, "text": "Ideal para alimentos, suplementos, cosméticos y más."},
    ];

    final List<dynamic> localCards = [
      {"title": "Cierre seguro", "body": "Zipper y sellado hermético para mayor protección.", "image": "assets/img/home/eco.webp", "isblack": false},
      {"title": "Material premium", "body": "Fabricado con materiales de alta calidad.", "image": "assets/img/home/eco.webp", "isblack": true},
      {"title": "Alta versatilidad", "body": "Úsalo para alimentos, cosméticos y más.", "image": "assets/img/home/eco.webp", "isblack": false},
    ];
    final ScrollController scrollController = ScrollController();
    bool scrollControllerLeft = false;
    bool scrollControllerRigth = true;
    final screenWidth = widget.screenWidth;

    return Padding(
      padding: EdgeInsets.only(top: 45),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TABS
              ScrollAnimatedWrapper(
                visibilityKey: Key('tabs'),
                child: Center(
                  child: SizedBox(
                    width: min(screenWidth, 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "4PRO",
                          style: TextStyle(
                            fontSize: min(screenWidth * 0.035, 36),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Center(
                    child: ScrollAnimatedWrapper(
                      visibilityKey: Key("Simplemente-funcional"),
                      child: Container(
                        width: min(screenWidth, 1500),
                        height: 500,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(255, 210, 210, 210)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Simplemente \nfuncional.",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.04, 40), letterSpacing: 1.2),
                                  ),
                                  SizedBox(height: 5),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
                                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                                    ),
                                    child: Text("Armar mi 4Pro", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Nuestro-empaque"),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 100),
                      width: min(screenWidth * 0.95, 1300),
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(CupertinoIcons.bag, size: min(screenWidth * 0.07, 40), color: Theme.of(context).primaryColor),
                          ),
                          Expanded(
                            child: Text(
                              "Nuestro empaque más versátil, resistente y elegante. Diseñado para brindar protección, presencia y funcionalidad en un solo producto. Ideal para marcas que quieren destacar.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: min(screenWidth * 0.025, 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('Items'),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: min(screenWidth, 1100),
                      child:
                          screenWidth < 900
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    items.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Row(
                                          children: [
                                            Icon(item["icon"], size: 28, color: Theme.of(context).primaryColor),
                                            const SizedBox(width: 12),
                                            Expanded(child: Text(item["text"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:
                                    items.map((item) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(item["icon"], size: 32, color: Theme.of(context).primaryColor),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: min(screenWidth * 0.18, 200),
                                            child: Text(
                                              item["text"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                              ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 50),
                child: Text("4 Funciones, 4PRO", style: TextStyle(fontSize: min(screenWidth * 0.03, 60), fontWeight: FontWeight.bold)),
              ),

              //Discover local
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                child: Row(
                  children: List.generate(localCards.length, (int index) {
                    final card = localCards[index];
                    final double horizontalPadding = screenWidth * 0.01;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? horizontalPadding : 0,
                        right: index == localCards.length - 1 ? horizontalPadding : 20,
                      ),
                      child: Container(
                        width: min(screenWidth * 0.52, 380),
                        height: min(screenWidth * 0.93, 700),
                        padding: EdgeInsets.only(top: 22, left: 22),
                        margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          image: DecorationImage(image: AssetImage(card['image']), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: MouseRegion(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeInBack,
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                  child: Icon(Icons.add_rounded, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card['title'],
                                    style: TextStyle(
                                      height: 0,
                                      color: card['isblack'] ? Colors.black : Colors.white,
                                      fontSize: min(screenWidth * 0.02, 20),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    card['body'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 0,
                                      color: card['isblack'] ? Colors.black : Colors.white,
                                      fontSize: min(screenWidth * 0.03, 25),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                        backgroundColor: WidgetStateProperty.all(scrollControllerLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                      ),
                      onPressed:
                          scrollControllerLeft
                              ? () {
                                scrollController.animateTo(
                                  scrollController.offset - 500,
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
                        backgroundColor: WidgetStateProperty.all(scrollControllerRigth ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                      ),
                      onPressed:
                          scrollControllerRigth
                              ? () {
                                scrollController.animateTo(
                                  scrollController.offset + 500,
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

              SizedBox(height: 200),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
