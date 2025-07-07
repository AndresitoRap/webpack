import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 45),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: screenWidth,
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Text(
                          widget.selectedSubcategorie.title,
                          style: TextStyle(height: 0, fontWeight: FontWeight.bold, fontSize: min(40, screenWidth * 0.06)),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          widget.selectedSubcategorie.description,
                          style: TextStyle(
                            height: 0,
                            fontWeight: FontWeight.bold,
                            color:
                                currentRoute.contains("EcoBag")
                                    ? Color.fromARGB(255, 41, 112, 9).withAlpha(170)
                                    : Theme.of(context).primaryColor.withAlpha(200),
                            fontSize: min(50, screenWidth * 0.06),
                          ),
                        ),
                        Image.asset(widget.selectedSubcategorie.img, height: 600),
                        SizedBox(height: 100),
                        TextButton(
                          onPressed: () {
                            final base = currentRoute.contains("EcoBag") ? "EcoBag" : "SmartBag";
                            final route = '/$base/Explora-$base/${widget.section}/crea-tu-empaque';
                            navigateWithSlide(context, route);
                          },
                          child: Text("Ir a comprar"),
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
          Header(),
        ],
      ),
    );
  }
}
