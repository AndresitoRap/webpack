import 'dart:math';
import 'dart:ui';
import 'dart:ui_web' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'dart:html' as html;

class HeardquartersCards {
  final String img;
  final String name;
  final double latitude;
  final double longitude;
  final String map;

  HeardquartersCards({
    required this.img,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.map,
  });
}

final List<HeardquartersCards> cardHQ = [
  HeardquartersCards(
    img: "lib/src/img/home/Carvajal.webp",
    name: "Carvajal",
    latitude: 4.60971,
    longitude: -74.08175,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
  HeardquartersCards(
    img: "lib/src/img/home/Norte.webp",
    name: "Nogal",
    latitude: 4.6610239150862025,
    longitude: -74.05414093434182,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
  HeardquartersCards(
    img: "lib/src/img/home/Mosquera.webp",
    name: "Mosquera",
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(cardHQ.length, (int index) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _showHeadquarterDialog(context, cardHQ[index]);
                  },
                  child: Container(
                    height: screenWidth * 0.20,
                    width: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 3, color: Colors.black54),
                      image: DecorationImage(image: AssetImage(cardHQ[index].img)),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              cardHQ[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.02),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location_fill,
                                  color: Theme.of(context).primaryColor,
                                  size: screenWidth * 0.02,
                                ),
                                SizedBox(width: screenWidth * 0.006),
                                Text("Encuentranos!", style: TextStyle(fontSize: screenWidth * 0.015)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  void _showHeadquarterDialog(BuildContext context, HeardquartersCards headquarter) {
    final screenWidth = MediaQuery.of(context).size.width;

    final String viewId = 'iframe-${headquarter.name.toLowerCase()}';

    // Solo registrar si no existe
    if (!_isViewRegistered(viewId)) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
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
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
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
                          IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.xmark_circle_fill),
                            color: Colors.transparent,
                            iconSize: 0,
                          ),
                          Text(
                            "Sede ${headquarter.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
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
                      Container(
                        height: screenWidth * 0.4,
                        width: screenWidth * 0.5,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.transparent),
                        child: HtmlElementView(viewType: viewId),

                        // FlutterMap(
                        //   options: MapOptions(
                        //     center: latlng.LatLng(headquarter.latitude, headquarter.longitude),
                        //     zoom: 15, // Nivel de zoom
                        //   ),
                        //   children: [
                        //     TileLayer(
                        //       urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.webp",
                        //       subdomains: ['a', 'b', 'c'], // Subdominios de OpenStreetMap
                        //     ),
                        //     MarkerLayer(
                        //       markers: [
                        //         Marker(
                        //           width: 40.0,
                        //           height: 40.0,
                        //           point: latlng.LatLng(headquarter.latitude, headquarter.longitude),
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: Theme.of(context).primaryColor,
                        //               border: Border.all(color: Colors.white, width: 2),
                        //             ),
                        //             child: const Icon(CupertinoIcons.location_solid, color: Colors.white, size: 24),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
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
