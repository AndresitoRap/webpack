import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/header.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEcoBag = route.contains('ecobag');
    final isSmartBag = route.contains('smartbag');
    final ecoColor = const Color.fromARGB(255, 75, 141, 44);
    final smartColor = const Color(0xFF004F9E);
    final color = isEcoBag ? ecoColor : (isSmartBag ? smartColor : Theme.of(context).primaryColor);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 404 visual
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("4", style: TextStyle(fontSize: min(screenWidth * 0.2, 400), fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                          child: Image.asset(
                            'assets/img/404.webp',
                            width: min(screenWidth * 0.2, 400),
                            height: min(screenWidth * 0.2, 400),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text("4", style: TextStyle(fontSize: min(screenWidth * 0.2, 400), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No hay NADA aquí...",
                    style: TextStyle(
                      fontSize: min(100, screenWidth * 0.08),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "...tal vez la página que estas buscando no fue encontrada o nunca existio.",
                    style: TextStyle(fontSize: min(25, screenWidth * 0.03), color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => navigateWithSlide(context, '/'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Volver al inicio", style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 10),
                            Icon(CupertinoIcons.arrow_right, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header flotante
          const Header(),
        ],
      ),
    );
  }
}
