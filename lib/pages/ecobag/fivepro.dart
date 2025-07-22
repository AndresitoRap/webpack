import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/pages/ecobag/ecobag.dart';
import 'package:webpack/widgets/footer.dart';

class FiveProEco extends StatefulWidget {
  const FiveProEco({super.key});

  @override
  State<FiveProEco> createState() => _FiveProEcoState();
}

class _FiveProEcoState extends State<FiveProEco> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 850;
    final green = Color.fromARGB(255, 75, 141, 44);

    return CustomScrollView(
      slivers: [
        SliverToStartFiveProEco(screenHeight: screenHeight, screenWidth: screenWidth, isMobile: isMobile, green: green),
        SliverWithNewStandar(green: green, screenWidth: screenWidth),
        SliverAboutFiveProEco(screenWidth: screenWidth, green: green, isMobile: isMobile),
        SliverWithProteccionEcobag5pro(screenWidth: screenWidth, green: green, isMobile: isMobile),
        SliverVideo5ProEcobag(screenWidth: screenWidth, green: green, isMobile: isMobile),
        SliverAboutMoreInfo5ProEco(screenWidth: screenWidth, green: green, isMobile: isMobile),
        SliverWithVideoScrollabe(isMobile: isMobile, screenWidth: screenWidth, green: green),
        SliverWithCareUs(screenWidth: screenWidth),
        SliverWithPrallax(screenHeight: screenHeight, screenWidth: screenWidth, green: green),
        SliverToBoxAdapter(child: SizedBox(height: 500)),
        SliverToBoxAdapter(child: Footer()),
      ],
    );
  }
}

class SliverWithPrallax extends StatefulWidget {
  const SliverWithPrallax({super.key, required this.screenHeight, required this.screenWidth, required this.green});

  final double screenHeight;
  final double screenWidth;
  final Color green;

  @override
  State<SliverWithPrallax> createState() => _SliverWithPrallaxState();
}

class _SliverWithPrallaxState extends State<SliverWithPrallax> with TickerProviderStateMixin {
  double _scrollOffset = 0;

  late final List<_ParallaxContainer> _bubbles;

  @override
  void initState() {
    super.initState();

    final centerX = widget.screenWidth / 2;
    final centerY = widget.screenHeight / 2;

    _bubbles = [
      _ParallaxContainer(top: centerY - 300, left: centerX - 400, size: 100, asset: 'assets/img/ecobag/hoja1.webp', parallaxFactor: 2.0),
      _ParallaxContainer(top: centerY + 200, left: centerX - 300, size: 90, asset: 'assets/img/ecobag/hoja1.webp', parallaxFactor: 1.5),
      _ParallaxContainer(top: centerY - 350, left: centerX + 300, size: 110, asset: 'assets/img/ecobag/hoja1.webp', parallaxFactor: -2.2),
      _ParallaxContainer(top: centerY + 250, left: centerX + 350, size: 120, asset: 'assets/img/ecobag/hoja1.webp', parallaxFactor: -1.7),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.axis == Axis.vertical) {
          setState(() {
            _scrollOffset = scrollNotification.metrics.pixels;
          });
        }
        return true;
      },
      child: SliverToBoxAdapter(
        child: SizedBox(
          height: widget.screenHeight * 1.5, // Increased height for more scroll range
          width: widget.screenWidth,
          child: Stack(
            children: [
              // Background with subtle parallax
              // Parallax elements (icons)
              ..._bubbles.map((circle) => circle.build(_scrollOffset)),
              // Main text centered
              // Parallax text
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(0, -_scrollOffset * 0.3), // efecto de parallax más notorio
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "5PRO EcoBag®.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: widget.green, fontSize: (widget.screenWidth * 0.1).clamp(30, 60)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Haz que tu producto hable por ti.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withAlpha(180),
                            fontSize: (widget.screenWidth * 0.08).clamp(20, 50),
                          ),
                        ),
                      ],
                    ),
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

class _ParallaxContainer {
  final double top;
  final double left;
  final double size;
  final String asset;
  final double parallaxFactor;

  _ParallaxContainer({required this.top, required this.left, required this.size, required this.asset, required this.parallaxFactor});

  Widget build(double scrollOffset) {
    return Positioned(top: top - (scrollOffset * 2) * parallaxFactor, left: left, child: Image.asset(asset, width: size, height: size));
  }
}

//Inicio de la página
class SliverToStartFiveProEco extends StatefulWidget {
  const SliverToStartFiveProEco({super.key, required this.screenHeight, required this.screenWidth, required this.isMobile, required this.green});

  final bool isMobile;
  final double screenHeight;
  final double screenWidth;
  final Color green;

  @override
  State<SliverToStartFiveProEco> createState() => _SliverToStartFiveProEcoState();
}

class _SliverToStartFiveProEcoState extends State<SliverToStartFiveProEco> with TickerProviderStateMixin {
  late AnimationController _bagController;
  late Animation<double> _bagScale;
  late Animation<double> _bagOpacity;

  late AnimationController _textController;
  late Animation<double> _textScale;
  late Animation<double> _textOpacity;

  late Animation<Offset> _bagFloatOffset;
  late AnimationController _bagFloatController;

  @override
  void initState() {
    super.initState();

    _bagController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _bagOpacity = CurvedAnimation(parent: _bagController, curve: Curves.easeIn);
    _bagFloatController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true); // Movimiento continuo arriba-abajo

    _bagFloatOffset = Tween<Offset>(
      begin: const Offset(0, -0.02),
      end: const Offset(0, 0.02),
    ).animate(CurvedAnimation(parent: _bagFloatController, curve: Curves.easeInOut));

    _textOpacity = CurvedAnimation(parent: _textController, curve: Curves.easeIn);

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await _bagController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();
  }

  @override
  void dispose() {
    _bagController.dispose();
    _textController.dispose();
    _bagFloatController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: widget.screenWidth,
        constraints: BoxConstraints(minHeight: widget.screenHeight - 100),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double baseTextSize = (constraints.maxWidth * 0.06).clamp(30.0, 90.0);
            final double imageHeight = (constraints.maxHeight * 0.35).clamp(180.0, 500.0);

            _bagScale = Tween<double>(
              begin: widget.isMobile ? 0.6 : 0.7,
              end: widget.isMobile ? 1.8 : 1.3,
            ).animate(CurvedAnimation(parent: _bagController, curve: Curves.fastEaseInToSlowEaseOut));

            _textScale = Tween<double>(
              begin: widget.isMobile ? 0.6 : 0.7,
              end: widget.isMobile ? 2.0 : 2.6,
            ).animate(CurvedAnimation(parent: _textController, curve: Curves.fastEaseInToSlowEaseOut));

            return widget.isMobile
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _bagOpacity,
                      child: ScaleTransition(scale: _bagScale, child: Image.asset('assets/img/ecobag/5pro.webp', height: imageHeight)),
                    ),
                    SizedBox(height: widget.screenWidth * 0.3),
                    FadeTransition(
                      opacity: _textOpacity,
                      child: ScaleTransition(
                        scale: _textScale,
                        child: Text(
                          '5PRO Ecobag',
                          style: TextStyle(fontSize: baseTextSize, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: widget.green),
                        ),
                      ),
                    ),
                  ],
                )
                : Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 100,
                      left: 200,
                      child: FadeTransition(
                        opacity: _textOpacity,
                        child: ScaleTransition(
                          scale: _textScale,
                          child: Text(
                            '5PRO ',
                            style: TextStyle(fontSize: baseTextSize, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: widget.green),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 70,
                      right: 200,
                      child: FadeTransition(
                        opacity: _textOpacity,
                        child: ScaleTransition(
                          scale: _textScale,
                          child: Text(
                            'Ecobag ',
                            style: TextStyle(fontSize: baseTextSize, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: widget.green),
                          ),
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _bagOpacity,
                      child: SlideTransition(
                        position: _bagFloatOffset,
                        child: ScaleTransition(
                          scale: _bagScale,
                          child: Transform.rotate(
                            angle: math.pi * 2.1,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(onTap: () {}, child: Image.asset('assets/img/ecobag/5pro.webp', height: imageHeight)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }
}

//Sección: Nuevo estandar
class SliverWithNewStandar extends StatelessWidget {
  const SliverWithNewStandar({super.key, required this.green, required this.screenWidth});

  final Color green;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: green,
        width: screenWidth,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 200, horizontal: screenWidth * 0.06),
            width: 1150,
            child: Column(
              children: [
                Text(
                  "Nuevo estándar.\n5 sellos de confianza.",
                  style: TextStyle(color: Colors.white, fontSize: (screenWidth * 0.09).clamp(24, 60), height: 0.9, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Text(
                  "Presentamos la 5PRO Ecobag. Diseñada con cinco sellos de alta tecnología, pensada para la resistencia, la sostenibilidad y el rendimiento. Creada para enfrentar cualquier desafío con estilo y fuerza, es la solución de empaque definitiva para marcas conscientes que no se conforman.",
                  style: TextStyle(color: Colors.white, fontSize: (screenWidth * 0.3).clamp(18, 24), height: 0.9, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),

                Container(
                  height: 700,
                  width: screenWidth,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey),
                  child: Image.asset("assets/img/ecobag/5pro/bags.png", fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Contenedores con información
class SliverAboutFiveProEco extends StatefulWidget {
  final double screenWidth;
  final Color green;
  final bool isMobile;
  const SliverAboutFiveProEco({super.key, required this.screenWidth, required this.green, required this.isMobile});

  @override
  State<SliverAboutFiveProEco> createState() => _SliverAboutFiveProEcoState();
}

class _SliverAboutFiveProEcoState extends State<SliverAboutFiveProEco> {
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

    final List<String> nuestraEcoBag5Pro = [
      'Sello de sustentabilidad con estilo profesional',
      'Diseño 5PRO: elegante, resistente y consciente',
      'Fabricada con materiales reciclables y compostables',
      'Sellado hermético y tecnología multipunto',
      'Ideal para marcas que buscan impacto y responsabilidad',
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
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
                style: TextStyle(fontSize: (widget.screenWidth * 0.2).clamp(30, 50), fontWeight: FontWeight.bold, color: widget.green),
              ),
            ),

            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(nuestraEcoBag5Pro.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? widget.screenWidth * 0.06 : 0,
                        right: index == 4 ? widget.screenWidth * 0.06 : 20,
                        bottom: 50,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: cardHeight,
                        width: cardWidth,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              nuestraEcoBag5Pro[index],
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

//Protección ecobag
class SliverWithProteccionEcobag5pro extends StatelessWidget {
  const SliverWithProteccionEcobag5pro({super.key, required this.screenWidth, required this.green, required this.isMobile});

  final double screenWidth;
  final Color green;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final textSize = (screenWidth * 0.05).clamp(16.0, 20.0);
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: screenWidth * 0.06),
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          width: screenWidth < 450 ? screenWidth : screenWidth.clamp(450, 1120),

          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              // Icon(CupertinoIcons.tortoise_fill, color: green, size: 80),
              SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                "Gran protección viene en una 5PRO ECOBAG.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.1).clamp(30, 45), height: 0.95),
              ),
              SizedBox(height: 100),
              isMobile
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      children: [
                        Text.rich(
                          style: TextStyle(fontSize: textSize, color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
                          TextSpan(
                            children: [
                              TextSpan(text: "Desde su estructura multicapa hasta sus"),
                              TextSpan(text: "materiales ecoamigables, ", style: TextStyle(color: green)),
                              TextSpan(
                                text:
                                    "todo está pensado para proteger tu producto sin comprometer el planeta. Su diseño inteligente se adapta a tu contenido sin exponerlo.",
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),
                        Text.rich(
                          style: TextStyle(fontSize: textSize, color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
                          TextSpan(
                            children: [
                              TextSpan(text: "Su empaque actúa como una defensa natural, "),
                              TextSpan(text: "creada para conservar, resistir y proteger, sin dejar huella. ", style: TextStyle(color: green)),
                              TextSpan(
                                text:
                                    "Utilizamos materiales compostables y estructuras inteligentes que entienden lo que tu producto necesita, sin comprometer su integridad.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text.rich(
                          style: TextStyle(fontSize: textSize, color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
                          TextSpan(
                            children: [
                              TextSpan(text: "Desde su estructura multicapa hasta sus"),
                              TextSpan(text: "materiales ecoamigables, ", style: TextStyle(color: green)),
                              TextSpan(
                                text:
                                    "todo está pensado para proteger tu producto sin comprometer el planeta. Su diseño inteligente se adapta a tu contenido sin exponerlo.",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text.rich(
                          style: TextStyle(fontSize: textSize, color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
                          TextSpan(
                            children: [
                              TextSpan(text: "Su empaque actúa como una defensa natural, "),
                              TextSpan(text: "creada para conservar, resistir y proteger, sin dejar huella. ", style: TextStyle(color: green)),
                              TextSpan(
                                text:
                                    "Utilizamos materiales compostables y estructuras inteligentes que entienden lo que tu producto necesita, sin comprometer su integridad.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

//Video 5pro Ecobag
class SliverVideo5ProEcobag extends StatelessWidget {
  final double screenWidth;
  final Color green;
  final bool isMobile;
  const SliverVideo5ProEcobag({super.key, required this.screenWidth, required this.green, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 50),
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Siente el terminado. 5PRO. Papel, Válvula. Perfecto",
                    textStyle: TextStyle(fontSize: (screenWidth * 0.2).clamp(30, 50), fontWeight: FontWeight.bold),
                    colors: [green, Colors.white, green],
                  ),
                ],
              ),
            ),

            Center(child: Container(width: (screenWidth).clamp(0, 1800).toDouble(), height: 800, color: Colors.grey)),

            SizedBox(
              width: 1120,
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.06, left: screenWidth * 0.06, top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ahora tu producto respira... y dura más.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.1).clamp(30, 50)),
                    ),
                    SizedBox(height: 30),
                    Text.rich(
                      style: TextStyle(fontSize: (screenWidth * 0.05).clamp(16, 20), color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Nuestra válvula inteligente te da control total sobre la frescura y la protección. Ya sea que busques conservar aromas delicados o prolongar la vida útil, la válvula se adapta a ",
                          ),
                          TextSpan(text: "lo que necesitas. ", style: TextStyle(color: green)),
                          TextSpan(
                            text:
                                "Libera automáticamente la presión interna, mantiene condiciones óptimas y evita contaminaciones sin que tengas que hacer nada.",
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
      ),
    );
  }
}

//Sección de información de 5pro
class SliverAboutMoreInfo5ProEco extends StatefulWidget {
  final double screenWidth;
  final Color green;
  final bool isMobile;

  const SliverAboutMoreInfo5ProEco({super.key, required this.screenWidth, required this.green, required this.isMobile});

  @override
  State<SliverAboutMoreInfo5ProEco> createState() => _SliverAboutMoreInfo5ProEcoState();
}

class _SliverAboutMoreInfo5ProEcoState extends State<SliverAboutMoreInfo5ProEco> {
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
    final List<String> nuestra5pro = [
      'Disponible en estructuras de 3 y 4 láminas, con papeles kraft de alta resistencia y barreras intermedias biodegradables. Ideal para conservar aromas, texturas y frescura.',
      'Terminación 100% papel: kraft natural o blanco, con opción de ventana troquelada. Transmite autenticidad, sostenibilidad y compromiso ambiental.',
      'Compatible con válvula desgasificadora, perfecta para productos que continúan liberando gases como el café recién tostado o granos fermentados.',
      'Diseñada para ser sellada en líneas automáticas y semi-automáticas. Su estructura laminada garantiza un cierre seguro y sin fugas.',
      'Soporta impresión flexográfica y digital sobre papel. Acabados disponibles: mate natural o barniz protector para mejor resistencia y presencia en góndola.',
    ];

    final cardSize = (widget.screenWidth * 0.450).clamp(0, 450).toDouble();
    final paddingSide = widget.screenWidth * 0.06;

    return SliverToBoxAdapter(
      child: SizedBox(
        width: widget.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(nuestra5pro.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? paddingSide : 0,
                      right: index == nuestra5pro.length - 1 ? paddingSide : 20,
                      bottom: 50,
                    ),
                    child: SizedBox(
                      width: cardSize,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            height: cardSize,
                            width: cardSize,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey),
                            child: Image.asset("assets/img/smartbag/5pro.webp"),
                          ),
                          const SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Text(
                              nuestra5pro[index],
                              style: TextStyle(
                                fontSize: (widget.screenWidth * 0.03).clamp(12, 18),
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withAlpha(180),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSide, vertical: 40),
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
          ],
        ),
      ),
    );
  }
}

//Video scrollable
class SliverWithVideoScrollabe extends StatelessWidget {
  const SliverWithVideoScrollabe({super.key, required this.isMobile, required this.screenWidth, required this.green});

  final bool isMobile;
  final double screenWidth;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 120),
        color: Colors.white,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Text(
                "Mayor vida util",
                style: TextStyle(fontSize: (screenWidth * 0.1).clamp(30, 60), fontWeight: FontWeight.w600, height: 0.95),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 10),
              child: Text(
                "El zipper resiste más que\nel contenido que protege.",
                style: TextStyle(fontSize: (screenWidth * 0.1).clamp(30, 60), color: green, fontWeight: FontWeight.w600, height: 0.95),
              ),
            ),
            Container(
              height: 600,
              width: screenWidth,
              color: green,
              child: Center(child: Text("Video scroll de la bolsa ventana abriendose con el zipper y botando granos de cafe")),
            ),
          ],
        ),
      ),
    );
  }
}

//Te importa nos importa
class SliverWithCareUs extends StatelessWidget {
  const SliverWithCareUs({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: min(screenWidth, 1600),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.06, horizontal: screenWidth * 0.06),
            child: Column(
              children: [
                Text(
                  "Te importa. Nos importa.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44), fontSize: min(screenWidth * 0.06, 70)),
                ),
                SizedBox(height: screenWidth >= 1000 ? 50 : 100),
                Text(
                  textAlign: TextAlign.center,
                  "Desde empaques como 5PRO Ecobag®, diseñados para proteger tu producto y destacar tu marca, hasta soluciones como Ecobag®, que combinan funcionalidad con conciencia ambiental. Usamos materiales reciclables, desarrollamos opciones versátiles como válvulas y cierres herméticos, y te ofrecemos formatos pensados para cada necesidad, siempre con una visión sustentable. Porque cada detalle cuenta cuando quieres hacer las cosas bien.",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87, fontSize: min(screenWidth * 0.026, 25), height: 0),
                ),
                SizedBox(height: screenWidth >= 1000 ? 50 : 100),

                SizedBox(
                  width: min(screenWidth, 1600),
                  child:
                      screenWidth > 900
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in [
                                (
                                  CupertinoIcons.leaf_arrow_circlepath,
                                  "Sostenibilidad real.",
                                  "Usamos materiales reciclables y procesos responsables en toda la línea 5PRO y Ecobag®.",
                                ),
                                (
                                  CupertinoIcons.shield_lefthalf_fill,
                                  "Protección garantizada",
                                  "Empaques que conservan aroma, frescura y calidad con barrera multicapa y protección UV.",
                                ),
                                (
                                  CupertinoIcons.cube_box,
                                  "Diseño funcional",
                                  "Opciones como válvulas, zippers y acabados premium para destacar tu producto con estilo.",
                                ),
                              ])
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: _buildBenefitBox(icon: item.$1, title: item.$2, description: item.$3, context: context),
                                  ),
                                ),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var item in [
                                (
                                  CupertinoIcons.leaf_arrow_circlepath,
                                  "Sostenibilidad real.",
                                  "Usamos materiales reciclables y procesos responsables en toda la línea 4PRO y Ecobag®.",
                                ),
                                (
                                  CupertinoIcons.shield_lefthalf_fill,
                                  "Protección garantizada",
                                  "Empaques que conservan aroma, frescura y calidad con barrera multicapa y protección UV.",
                                ),
                                (
                                  CupertinoIcons.cube_box,
                                  "Diseño funcional",
                                  "Opciones como válvulas, zippers y acabados premium para destacar tu producto con estilo.",
                                ),
                              ])
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: _buildBenefitBox(icon: item.$1, title: item.$2, description: item.$3, context: context),
                                ),
                            ],
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitBox({required IconData icon, required String title, required String description, required BuildContext context}) {
    final screenw = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: min(screenw * 0.1, 40), color: Color(0xFF4B8D2C)),
          const SizedBox(height: 20),
          Text(title, textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenw * 0.03, 24))),
          const SizedBox(height: 10),
          Text(description, textAlign: TextAlign.start, style: TextStyle(fontSize: min(screenw * 0.025, 22), fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
