import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class FivePro extends StatelessWidget {
  const FivePro({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final blue = Theme.of(context).primaryColor;
    final isMobile = screenWidth < 850;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SilverStart(screenHeight: screenHeight, screenWidth: screenWidth, blue: blue),
              SliverAboutFivePro(screenWidth: screenWidth, blue: blue, isMobile: isMobile),
            ],
          ),
        ],
      ),
    );
  }
}

//Inicio
class SilverStart extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Color blue;
  const SilverStart({super.key, required this.screenHeight, required this.screenWidth, required this.blue});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 45),
        child: Container(
          height: screenHeight - 45,
          width: screenWidth,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Image.asset('assets/img/smartbag/5pro.webp', width: screenWidth * 0.8, height: screenHeight * 0.6, fit: BoxFit.cover),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.4, left: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("5PRO", style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: (screenWidth * 0.4).clamp(40, 60))),
                      Text(
                        "5 Soluciones para tí",
                        style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: (screenWidth * 0.4).clamp(40, 60)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStatePropertyAll(3),
                              backgroundColor: WidgetStatePropertyAll(blue),
                              foregroundColor: const WidgetStatePropertyAll(Colors.white),
                            ),
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Text("Crear mi 5PRO", style: TextStyle(fontSize: (screenWidth * 0.3).clamp(16, 22))),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Cinco formas de ver, crear, sentir,\nconectar y transformar el mundo.",
                            style: TextStyle(fontSize: (screenWidth * 0.3).clamp(16, 22), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Fila con la informacion de 5pro
class SliverAboutFivePro extends StatefulWidget {
  final double screenWidth;
  final Color blue;
  final bool isMobile;
  const SliverAboutFivePro({super.key, required this.screenWidth, required this.blue, required this.isMobile});

  @override
  State<SliverAboutFivePro> createState() => _SliverAboutFiveProState();
}

class _SliverAboutFiveProState extends State<SliverAboutFivePro> {
  final ScrollController _scrollController = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScroll);
  }

  void _checkScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    setState(() {
      canScrollLeft = offset > 0;
      canScrollRight = offset < maxScroll;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth =
        widget.isMobile
            ? widget.screenWidth *
                0.7 // más ancho en mobile
            : (widget.screenWidth * 0.8).clamp(0, 1000);

    final double cardHeight =
        widget.isMobile
            ? widget.screenWidth *
                0.9 // cuadrado en mobile
            : (widget.screenWidth * 0.5).clamp(0, 500);

    final List<String> nuestra5pro = [
      'Protección superior para todo tipo de producto',
      'Diseño que realza tu marca y cautiva al cliente',
      'Materiales sostenibles y compromiso ecológico',
      'Tecnología de sellado y cierre avanzada',
      'Adaptabilidad total: múltiples formatos y capacidades',
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: widget.screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white, const Color.fromARGB(0, 255, 255, 255)],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: widget.screenWidth * 0.06),
              child: Text(
                "Nuestra 5pro.",
                style: TextStyle(fontSize: (widget.screenWidth * 0.2).clamp(30, 60), fontWeight: FontWeight.bold, color: widget.blue),
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(nuestra5pro.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? widget.screenWidth * 0.06 : 0,
                        right: index == 4 ? widget.screenWidth * 0.06 : 20,
                        bottom: 50,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(widget.screenWidth * 0.01),
                        height: cardHeight,
                        width: cardWidth,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              nuestra5pro[index],
                              style: TextStyle(fontSize: (widget.screenWidth * 0.04).clamp(0, 26), fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ArrowButton(
                    enabled: canScrollLeft,
                    icon: CupertinoIcons.chevron_left,
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - (widget.screenWidth * 0.6),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  _ArrowButton(
                    enabled: canScrollRight,
                    icon: CupertinoIcons.chevron_right,
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset + (widget.screenWidth * 0.6),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "No solo es un 5\nes una 5PRO.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: (widget.screenWidth * 0.05).clamp(30, 60)),
                ),
              ),
            ),
            AnimatedCardDeck(),
            //cards
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final bool enabled;
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.enabled, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon),
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(enabled ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80))),
    );
  }
}

class AnimatedCardDeck extends StatefulWidget {
  @override
  State<AnimatedCardDeck> createState() => _AnimatedCardDeckState();
}

class _AnimatedCardDeckState extends State<AnimatedCardDeck> with TickerProviderStateMixin {
  final List<String> items = [
    'Diseño que comunica',
    'Estructura protectora',
    'Sostenibilidad real',
    'Versatilidad de formatos',
    'Tecnología 5 capas',
  ];

  late Timer _timer;
  int currentIndex = 0;
  int previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) => _nextCard());
  }

  void _nextCard() {
    setState(() {
      previousIndex = currentIndex;
      currentIndex = (currentIndex + 1) % items.length;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 400;
    final double cardHeight = 600;
    final double centerX = MediaQuery.of(context).size.width / 2 - cardWidth / 2;

    // Primero generamos todas las tarjetas con su contenido ya animado
    final List<Widget> cards = [];

    for (int i = 0; i < items.length; i++) {
      // Cálculo de posición relativa
      int rel = (i - currentIndex + items.length) % items.length;
      if (rel > items.length / 2) rel -= items.length;

      double offsetX = rel * 120.0;
      double scale = rel == 0 ? 1.0 : 0.9;
      double opacity = rel.abs() == 1 ? 0.2 : (rel == 0 ? 1.0 : 0.0);

      final card = AnimatedPositioned(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        top: 40,
        left: centerX + offsetX,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: IgnorePointer(ignoring: rel != 0, child: _buildCard(items[i], cardWidth, cardHeight, rel == 0)),
          ),
        ),
      );

      // Guardamos la del centro para dibujarla al final
      if (rel == 0) {
        cards.add(card); // guardamos al final
      } else {
        cards.insert(0, card); // las demás se insertan primero
      }
    }

    return SizedBox(width: double.infinity, height: 900, child: Stack(clipBehavior: Clip.none, children: cards));
  }

  Widget _buildCard(String text, double width, double height, bool isCenter) {
    return Material(
      elevation: isCenter ? 12 : 4,
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 200, width: double.infinity, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16))),
              const SizedBox(height: 20),
              Text(text, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
