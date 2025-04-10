import 'package:flutter/material.dart';
import 'package:webpack/pages/catalog/catalog.dart';
import 'package:webpack/pages/ecobag/ecobag.dart';
import 'package:webpack/pages/home.dart';
import 'package:webpack/pages/smartbag/smartbag.dart';
import 'package:webpack/pages/support/dataproccessing.dart';
import 'package:webpack/pages/support/legalpolicies.dart';
import 'package:webpack/pages/support/pqrs.dart';
import 'package:webpack/pages/support/whatsapppage.dart';
import 'package:webpack/pages/support/support.dart';
import 'package:webpack/pages/us/aboutus.dart';
import 'package:webpack/pages/us/us.dart';
import 'package:webpack/widgets/page_not_found.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 245, 255),
        primaryColor: Color(0xFF004F9E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF004F9E),
          primary: Color(0xFF3EB7EA),
          secondary: Color(0xFF015081),
          tertiary: Color(0xFF052344),
        ),
        fontFamily: 'D-DINExp',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/Soporte': (context) => SupportHome(),
        '/Soporte/Ayuda-Rápida/Whatsapp': (context) => WhatsappPage(),
        '/Soporte/Ayuda-Rápida/Teléfono': (context) => WhatsappPage(),
        '/Soporte/Politicas/Politicas-legales-y-reglamentarias': (context) => LegalPolicies(),
        '/Soporte/Politicas/Tratamiento-de-datos': (context) => DataProccessing(),
        '/Soporte/Tú-opinion/Encuesta-de-satisfacción-y-PQRS': (context) => PQRS(),
        '/Nosotros': (context) => Us(),
        '/Nosotros/Quienes-somos?/Identidad-corporativa': (context) => AboutUs(),
        '/Nosotros/Quienes-somos?/Nuestros-valores': (context) => Us(),
        '/Catálogo': (context) => Catalog(),
        '/Catálogo/Nuestros-Catálogos/Catálogo': (context) => Catalog(),
        '/SmartBag': (context) => SmartBag(),
        '/SmartBag/Explora-SmartBag/X': (context) => SmartBag(),
        '/EcoBag': (context) => EcoBag(),
        '/EcoBag/Explora-EcoBag/X': (context) => EcoBag(),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (context) => PageNotFound());
      },
    );
  }
}
