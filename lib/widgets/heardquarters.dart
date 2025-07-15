import 'dart:math';
// Gráficos y filtros: siempre vienen de dart:ui
import 'dart:ui' as ui show ImageFilter, Canvas, Paint;
import 'dart:ui_web' as ui_web show platformViewRegistry;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class HeardquartersCards {
  final String img;
  final String name;
  final double latitude;
  final double longitude;
  final String map;

  HeardquartersCards({required this.img, required this.name, required this.latitude, required this.longitude, required this.map});
}

final List<HeardquartersCards> cardHQ = [
  HeardquartersCards(
    img: "assets/img/home/Carvajal.webp",
    name: "Carvajal - Bogotá D.C",
    latitude: 4.60971,
    longitude: -74.08175,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
  HeardquartersCards(
    img: "assets/img/home/Norte.webp",
    name: "Nogal - Bogotá D.C",
    latitude: 4.6610239150862025,
    longitude: -74.05414093434182,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
  HeardquartersCards(
    img: "assets/img/home/Mosquera.webp",
    name: "Mosquera - Cundinamarca",
    latitude: 4.695486,
    longitude: -74.190506,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
];

class Headquarters extends StatefulWidget {
  const Headquarters({super.key});

  @override
  State<Headquarters> createState() => _HeadquartersState();
}

class _HeadquartersState extends State<Headquarters> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.06, left: screenWidth * 0.06, top: 50),
          child: Text("Sedes.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.06, 55))),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cardHQ.length,
            itemBuilder: (context, index) {
              final sede = cardHQ[index];
              final isTabletOrPC = screenWidth <= 1000; // puedes ajustar este valor si deseas

              return ScrollAnimatedWrapper(
                visibilityKey: Key('Headquartes-${sede.name}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _showHeadquarterDialog(context, sede);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 120),
                        child:
                            isTabletOrPC
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 180, child: Image.asset(sede.img)),
                                    const SizedBox(height: 24),
                                    Text("${sede.name}.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.03, 30))),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Encuéntranos",
                                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.020, 20)),
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(CupertinoIcons.location, color: Theme.of(context).primaryColor, size: min(screenWidth * 0.020, 20)),
                                      ],
                                    ),
                                  ],
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sede ${sede.name}.",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.03, 30)),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Encuéntranos",
                                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.020, 20)),
                                            ),
                                            const SizedBox(width: 5),
                                            Icon(CupertinoIcons.placemark, color: Theme.of(context).primaryColor, size: min(screenWidth * 0.020, 20)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 120, child: Image.asset(sede.img)),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 100),
      ],
    );
  }

  void _showHeadquarterDialog(BuildContext context, HeardquartersCards headquarter) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double dialogWidth = screenWidth.clamp(350.0, 700.0);
    final double dialogHeight = screenHeight * 0.85;

    final String viewId = 'iframe-${headquarter.name.toLowerCase()}';

    // Solo registrar si no existe
    if (!_isViewRegistered(viewId)) {
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(
        viewId,
        (int viewId) =>
            html.IFrameElement()
              ..src = headquarter.map
              ..style.border = 'none'
              ..style.width = '100%'
              ..style.height = '100%',
      );
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: dialogWidth,
                  constraints: BoxConstraints(maxHeight: dialogHeight),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(160),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 10)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.xmark_circle_fill), color: Colors.transparent, iconSize: 0),
                          Text(
                            "Sede ${headquarter.name}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(CupertinoIcons.xmark_circle_fill),
                            color: Theme.of(context).primaryColor,
                            iconSize: 30,
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.transparent),
                          child: HtmlElementView(viewType: viewId),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final Set<String> _registeredViews = {};

  bool _isViewRegistered(String viewId) {
    if (_registeredViews.contains(viewId)) return true;
    _registeredViews.add(viewId);
    return false;
  }
}
