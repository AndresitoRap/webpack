import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

        SliverToBoxAdapter(child: Container(color: Colors.white, width: screenWidth)),
      ],
    );
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

  @override
  void initState() {
    super.initState();

    _bagController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _bagOpacity = CurvedAnimation(parent: _bagController, curve: Curves.easeIn);
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
            final double baseTextSize = (constraints.maxWidth * 0.06).clamp(30.0, 60.0);
            final double imageHeight = (constraints.maxHeight * 0.35).clamp(180.0, 400.0);

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
                    FadeTransition(
                      opacity: _bagOpacity,
                      child: ScaleTransition(scale: _bagScale, child: Image.asset('assets/img/ecobag/5pro.webp', height: imageHeight)),
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

            Container(
              width: 1120,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 100),
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
