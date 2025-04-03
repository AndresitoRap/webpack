import 'package:flutter/material.dart';
import 'package:webpack/pages/home.dart';
import 'package:webpack/pages/support/fast_help.dart';
import 'package:webpack/pages/support/support.dart';
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
        '/Soporte/Ayuda-Rápida/Chat': (context) => FastHelp(),
        '/Soporte/Ayuda-Rápida/Teléfono': (context) => FastHelp(),
        '/Soporte/Compras/Politicas-legales-y-reglamentarias': (context) => SupportHome(),
        '/Soporte/Compras/PQRS': (context) => SupportHome(),
        '/Soporte/Políticas/Terminos-y-privacidad': (context) => SupportHome(),
        '/Soporte/Políticas/Cookies': (context) => SupportHome(),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (context) => PageNotFound());
      },
    );
  }
}
