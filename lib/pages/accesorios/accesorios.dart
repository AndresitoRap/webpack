import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class Accesorios extends StatelessWidget {
  const Accesorios({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final blue = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverStartAccesorios(screenWidth: screenWidth),
              SliverWithContainers(screenWidth: screenWidth, blue: blue),
              SliverToBoxAdapter(child: Footer()),
            ],
          ),

          Header(),
        ],
      ),
    );
  }
}

//Sliver inicial
class SliverStartAccesorios extends StatelessWidget {
  const SliverStartAccesorios({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200, minWidth: 800),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(), // evita scroll, solo para cortar
              child: Stack(
                children: [
                  if (screenWidth <= 600)
                    Stack(
                      children: [
                        // Imagen original detrás (visible y desenfocada)
                        Image.asset("assets/img/smartbag/5pro/cardLarge5.webp", fit: BoxFit.cover, width: 700, height: 400),

                        // Capa de desenfoque
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.black26, // Necesario para activar el filtro
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Texto con ancho flexible
                      Container(
                        width: 400,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personaliza con facilidad.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: (screenWidth * 0.05).clamp(30, 44),
                                color: screenWidth >= 600 ? Colors.black : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Elige entre válvulas o etiquetas Peel & Stick para destacar tus empaques.",
                              style: TextStyle(fontSize: (screenWidth * 0.03).clamp(18, 22), color: screenWidth >= 600 ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                      ),

                      // Imagen con tamaño fijo
                      if (screenWidth >= 600)
                        const SizedBox(
                          height: 500,
                          child: Image(image: AssetImage("assets/img/smartbag/5pro/cardLarge5.webp"), fit: BoxFit.fitHeight),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Sliver con los contenedores
class SliverWithContainers extends StatefulWidget {
  final double screenWidth;
  final Color blue;
  const SliverWithContainers({super.key, required this.screenWidth, required this.blue});

  @override
  State<SliverWithContainers> createState() => _SliverWithContainersState();
}

class _SliverWithContainersState extends State<SliverWithContainers> {
  final Set<int> hoverIndexes = {};
  String selectedTab = "Peel & Stick"; // o "Válvula"
  final List<String> tabs = ["Peel & Stick", "Válvula"];

  final Map<String, List<Map<String, dynamic>>> data = {
    "Peel & Stick": [
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Azul oscuro"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Beige"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Blanco"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Cobre"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Dorado"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Negro"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Rojo"},
      {"image": "assets/img/BIsotipo.webp", "label": "Peel & Stick Verde Oscuro"},
    ],
    "Válvula": [
      {"image": "assets/img/BIsotipo.webp", "label": "Válvula Desgasificadora"},
      {"image": "assets/img/BIsotipo.webp", "label": "Válvula Dosificadora"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    int selectedIndex = tabs.indexOf(selectedTab);
    final items = data[selectedTab]!;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: widget.screenWidth * 0.06),
        child: Column(
          children: [
            // Tabs
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double tabWidth = constraints.maxWidth / tabs.length;

                    return Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              tabs.map((tab) {
                                final isSelected = tab == selectedTab;
                                return GestureDetector(
                                  onTap: () => setState(() => selectedTab = tab),
                                  child: Container(
                                    width: tabWidth,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        tab,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                          color: isSelected ? widget.blue : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          left: selectedIndex * tabWidth,
                          bottom: 0,
                          child: Container(width: tabWidth, height: 2, color: widget.blue),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Círculos con íconos
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: KeyedSubtree(
                key: ValueKey<String>(selectedTab),
                child: Column(
                  key: ValueKey("content_$selectedTab"),
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      runSpacing: 30,
                      children: List.generate(items.length, (index) {
                        final item = items[index];
                        final isHovering = hoverIndexes.contains(index);

                        return MouseRegion(
                          onEnter: (_) => setState(() => hoverIndexes.add(index)),
                          onExit: (_) => setState(() => hoverIndexes.remove(index)),
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 140,
                                  height: 140,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
                                  child: Image.asset(item["image"]),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  item["label"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: isHovering ? TextDecoration.underline : TextDecoration.none,
                                    decorationColor: widget.blue,
                                    color: isHovering ? widget.blue : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: 1000,
                      child:
                          widget.screenWidth >= 1000
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildCardsForTab(),
                              )
                              : Column(
                                children: [
                                  ..._buildCardsForTab().expand((card) => [card, const SizedBox(height: 50)]),
                                ],
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCardsForTab() {
    if (selectedTab == "Peel & Stick") {
      return [
        _peelStickCard([
          TextSpan(text: "Diseñado para adaptarse a cualquier superficie con total precisión "),
          TextSpan(text: "Peel & Stick ", style: TextStyle(color: widget.blue, fontWeight: FontWeight.bold)),
          TextSpan(text: "transforma la forma en que presentas tus productos."),
        ], "assets/img/smartbag/5pro/cardmin2.webp"),
        _peelStickCard([
          TextSpan(text: "Peel & Stick ", style: TextStyle(color: widget.blue, fontWeight: FontWeight.bold)),
          TextSpan(text: "combina estética "),
          TextSpan(text: "premium ", style: TextStyle(color: widget.blue, fontWeight: FontWeight.bold)),
          TextSpan(text: "con funcionalidad avanzada."),
        ], "assets/img/smartbag/5pro/cardmin2.webp"),
      ];
    } else if (selectedTab == "Válvula") {
      return [
        _peelStickCard([
          TextSpan(text: "La "),
          TextSpan(text: "válvula desgasificadora ", style: TextStyle(color: widget.blue, fontWeight: FontWeight.bold)),
          TextSpan(text: "preserva el aroma y frescura del café mientras permite la salida controlada de gases."),
        ], "assets/img/smartbag/5pro/cardmin5.webp"),
        _peelStickCard([
          TextSpan(text: "Ideal para empaques al vacío, la "),
          TextSpan(text: "válvula dosificadora ", style: TextStyle(color: widget.blue, fontWeight: FontWeight.bold)),
          TextSpan(text: "garantiza dosificaciones limpias y precisas, sin comprometer el sello del empaque."),
        ], "assets/img/smartbag/5pro/cardmin5.webp"),
      ];
    }

    return []; // fallback
  }

  Widget _peelStickCard(List<InlineSpan> widget, String img) {
    final screenW = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 232, 234),
            borderRadius: BorderRadius.circular(22),
            image: DecorationImage(image: AssetImage(img)),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 6, spreadRadius: -1, offset: Offset(0, 4)),
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 4, spreadRadius: -1, offset: Offset(0, 2)),
            ],
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 400,
          child: Text.rich(
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.1, color: Colors.black87, fontSize: (screenW * 0.03).clamp(16, 24)),
            TextSpan(children: widget),
          ),
        ),
        // Text(text, textAlign: TextAlign.center)),
      ],
    );
  }
}
