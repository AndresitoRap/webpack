import 'package:flutter/material.dart';
import 'package:packvision/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empaques Packvisión',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF004F9E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF004F9E),
          primary: Color(0xFF3EB7EA),
          secondary: Color(0xFF015081),
          tertiary: Color(0xFF052344),
        ),
        fontFamily: 'D-DINExp',
      ),
      home: Home(),
    );
  }
}
