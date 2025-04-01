import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

class HeardquartersCards {
  final String img;
  final String name;
  final double latitude;
  final double longitude;

  HeardquartersCards({required this.img, required this.name, required this.latitude, required this.longitude});
}

final List<HeardquartersCards> cardHQ = [
  HeardquartersCards(img: "lib/src/img/Carvajal.jpg", name: "Carvajal", latitude: 4.60971, longitude: -74.08175),
  HeardquartersCards(
    img: "lib/src/img/Carvajal.jpg",
    name: "Nogal",
    latitude: 4.6610239150862025,
    longitude: -74.05414093434182,
  ),
  HeardquartersCards(img: "lib/src/img/Carvajal.jpg", name: "Mosquera", latitude: 4.695486, longitude: -74.190506),
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
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Theme.of(context).colorScheme.tertiary, Theme.of(context).primaryColor],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.1, left: screenWidth * 0.1, top: 50),
            child: Text(
              "Sedes.",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.06, 55)),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
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
                        color: const Color.fromARGB(255, 203, 203, 203),
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
      ),
    );
  }

  void _showHeadquarterDialog(BuildContext context, HeardquartersCards headquarter) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey),
                        child: FlutterMap(
                          options: MapOptions(
                            center: latlng.LatLng(headquarter.latitude, headquarter.longitude),
                            zoom: 15, // Nivel de zoom
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'], // Subdominios de OpenStreetMap
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 40.0,
                                  height: 40.0,
                                  point: latlng.LatLng(headquarter.latitude, headquarter.longitude),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: const Icon(CupertinoIcons.location_solid, color: Colors.white, size: 24),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
}
