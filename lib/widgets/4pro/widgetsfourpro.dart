import 'dart:math';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/header.dart';

import 'package:webpack/widgets/video.dart';

class InfoCardData {
  final String? imagePath;
  final String title;
  final String description;
  final bool isVideo;
  final String? videoPath;

  InfoCardData({this.imagePath, this.isVideo = false, this.videoPath, required this.title, required this.description});
}

class InfoCard extends StatefulWidget {
  final InfoCardData data;
  final double maxFontSize;
  final bool isup;

  const InfoCard({super.key, required this.data, required this.maxFontSize, this.isup = false});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  Widget _buildMediaContent() {
    if (widget.data.isVideo && widget.data.videoPath != null) {
      return AspectRatio(
        aspectRatio: 16 / 9, // puedes ajustar el aspecto según tu diseño
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: videoBlurNotifier,
                builder: (context, isBlur, _) {
                  return VideoFlutter(
                    src: widget.data.videoPath!,
                    blur: isBlur,
                    loop: false,
                    showControls: false,
                    fit: BoxFit.contain,
                    isPause: false,
                    retry: true,
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(widget.data.imagePath!, fit: BoxFit.contain));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(color: const Color.fromARGB(255, 237, 243, 255), borderRadius: BorderRadius.circular(16)),
      child:
          widget.isup
              ? Column(
                children: [
                  const SizedBox(height: 20),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.data.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: min(screenWidth * 0.015, 15),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: widget.data.description,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.015, 15), color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.015, 15), color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: _buildMediaContent()),
                ],
              )
              : Column(
                children: [
                  Expanded(child: _buildMediaContent()),
                  const SizedBox(height: 20),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.data.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: min(screenWidth * 0.015, 15),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: widget.data.description,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.015, 15), color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: max(10, screenWidth * 0.015)),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
    );
  }
}

Widget buildResponsiveInfoCards(BuildContext context) {
  final List<InfoCardData> items = [
    InfoCardData(
      imagePath: "assets/img/smartbag/4pro/cuatrilamina.webp",
      title: "Cuatro capas ",
      description:
          "una protección total. La 4PRO combina PET, BOPP y PE \npara ofrecer una barrera contra la humedad, la luz y el oxígeno,\n con una presentación elegante y segura.",
    ),
    InfoCardData(
      isVideo: true,
      videoPath: "assets/assets/videos/smartbag/4pro/accesorios.webm",
      imagePath: "assets/img/smartbag/4pro/accesorios.webp",
      title: "Agrega funcionalidad con accesorios inteligentes. ",
      description:
          "\nEl sistema Peel Stick permite abrir y cerrar la bolsa fácilmente.\n Las válvulas desgasificadoras conservan productos frescos por más tiempo.",
    ),
    InfoCardData(
      imagePath: "assets/img/smartbag/4pro/terminacion.webp",
      title: "Tu decides la terminación ",
      description:
          "brillante para un acabado \nmás reflectivo, Mate para una apariencia elegante y sobria, \ny Ventana para mostrar el producto sin perder protección.\n ",
    ),
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 700;

      if (isMobile) {
        return Column(
          children:
              items
                  .map(
                    (data) => SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(padding: const EdgeInsets.all(8.0), child: InfoCard(data: data, maxFontSize: 30)),
                    ),
                  )
                  .toList(),
        );
      } else {
        return SizedBox(
          width: min(constraints.maxWidth, 1300),
          height: 950, // Fuerza altura consistente en ambos lados
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 468, child: InfoCard(data: items[0], maxFontSize: 16, isup: true)),
                    SizedBox(height: 14),
                    SizedBox(height: 468, child: InfoCard(data: items[1], maxFontSize: 16, isup: true)),
                  ],
                ),
              ),
              SizedBox(width: 16), // ← control explícito del espacio horizontal
              Expanded(child: SizedBox(height: 950, child: InfoCard(data: items[2], maxFontSize: 16))),
            ],
          ),
        );
      }
    },
  );
}

//Letras 4pro ecobag
class AnimatedLetter extends StatefulWidget {
  final String char;
  final bool visible;
  final TextStyle textStyle;

  const AnimatedLetter({super.key, required this.char, required this.visible, required this.textStyle});

  @override
  State<AnimatedLetter> createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.visible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedLetter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(opacity: _opacityAnimation, child: Text(widget.char, style: widget.textStyle)),
    );
  }
}

//Flores

class LeafWithBagReveal extends StatefulWidget {
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;
  const LeafWithBagReveal({super.key, required this.currentRoute, required this.subcategorie, required this.section});

  @override
  State<LeafWithBagReveal> createState() => _LeafWithBagRevealState();
}

class _LeafWithBagRevealState extends State<LeafWithBagReveal> with TickerProviderStateMixin {
  late AnimationController _main;
  late AnimationController _bag;
  late AnimationController _textController;
  bool showText1 = false;
  bool showText2 = false;

  late AnimationController _buttonFadeController;
  late Animation<double> _buttonOpacity;

  bool started = false;
  bool generarHojas = true;

  final List<_Leaf> hojas = [];
  final rand = Random();

  @override
  void initState() {
    super.initState();

    _main = AnimationController(vsync: this, duration: const Duration(seconds: 7));

    _bag = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _buttonFadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _buttonOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _buttonFadeController, curve: Curves.easeInOut));
  }

  void _iniciar() {
    if (started) return;
    started = true;

    _main.forward(); // ⬅️ solo una vez, no loop
    _generar();

    Future.delayed(const Duration(seconds: 1), () => _bag.forward());
    Future.delayed(const Duration(milliseconds: 1800), () => generarHojas = false);

    _main.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        generarHojas = false;
      }
    });

    Future.delayed(const Duration(seconds: 1), () => _bag.forward());

    _bag.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showText1 = true);

        // Espera el tiempo de la animación del primer texto (~1.5s)
        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() => showText2 = true);
          Future.delayed(const Duration(milliseconds: 1500), () {
            _buttonFadeController.forward();
          });
        });
      }
    });
  }

  Future<void> _generar() async {
    while (mounted && generarHojas) {
      await Future.delayed(const Duration(milliseconds: 10));

      if (!generarHojas) break;

      final now = _main.value;

      setState(() {
        hojas.add(
          _Leaf(
            waveMultiplier: 2 + rand.nextDouble() * 2, // entre 2 y 4 ondas

            inicio: now,

            dur: 0.15 + rand.nextDouble() * 0.05, // entre 0.15 y 0.2

            rot: (rand.nextDouble() - .5) * pi / 2,
            scale: .6 + rand.nextDouble() * .6,
            offsetY: (rand.nextDouble() - 0.5) * 80,
            curveFactor: 100 + rand.nextDouble() * 100, // entre 100 y 200
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _main.dispose();
    _bag.dispose();
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return VisibilityDetector(
      key: const Key('leaf-reveal'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > .1) _iniciar();
      },
      child: SizedBox(
        height: 600,
        width: double.infinity,
        child: ClipRect(
          child: Stack(
            children: [
              // 🌿 Hojas animadas (deja como estaba)
              AnimatedBuilder(
                animation: _main,
                builder: (_, __) {
                  final tGlobal = _main.value;
                  hojas.removeWhere((h) => (tGlobal - h.inicio) / h.dur > 1);

                  const hojaAncho = 60.0;
                  const centerY = 300.0;

                  return Stack(
                    children:
                        hojas.map((h) {
                          final t = ((tGlobal - h.inicio) / h.dur).clamp(0.0, 1.0);
                          final easedT = t;
                          final x = lerpDouble(-hojaAncho, screenWidth + hojaAncho, easedT)!;
                          final y = centerY + -sin(easedT * pi * 2) * (h.curveFactor * 0.4) + sin(easedT * pi * 4 + h.rot) * 4 + h.offsetY;

                          return Positioned(
                            left: x,
                            top: y,
                            child: Transform.rotate(
                              angle: sin(t * pi * 2) * 0.4 + h.rot,
                              child: Transform.scale(scale: h.scale, child: Image.asset('assets/img/ecobag/hoja1.webp', width: hojaAncho)),
                            ),
                          );
                        }).toList(),
                  );
                },
              ),

              // 👜 Bolsa + Texto como grupo centrado
              Center(
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-2.2, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: _bag, curve: Curves.easeOut)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // <- solo el ancho del contenido
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Image.asset('assets/img/ecobag/discover1_Top.webp', fit: BoxFit.fitHeight)),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: min(screenWidth * 0.06, 100)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // TEXTO 1 ─ Máquina de escribir + responsive
                              if (showText1)
                                FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown, // reduce si hace falta, no lo agranda de más
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        '¿Qué esperas?',
                                        textStyle: const TextStyle(
                                          fontSize: 42, // tamaño “máximo”
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                          color: Color.fromARGB(255, 75, 141, 44),
                                          height: 1.2, // nunca uses 0 aquí
                                        ),
                                        speed: const Duration(milliseconds: 100),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                // reserva espacio con un Text invisible dentro de FittedBox
                                FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Opacity(
                                    opacity: 0,
                                    child: const Text(
                                      '¿Qué esperas?',
                                      style: TextStyle(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                        color: Color.fromARGB(255, 75, 141, 44),
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 8),

                              // TEXTO 2 ─ Máquina de escribir + responsive
                              if (showText2)
                                FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        '¡Crea tu Ecobag®!',
                                        textStyle: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                          color: Color.fromARGB(255, 75, 141, 44),
                                          height: 1.2,
                                        ),
                                        speed: const Duration(milliseconds: 100),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Opacity(
                                    opacity: 0,
                                    child: const Text(
                                      '¡Crea tu Ecobag®!',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                        color: Color.fromARGB(255, 75, 141, 44),
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 16), // separación opcional

                              FadeTransition(
                                opacity: _buttonOpacity,
                                child: TextButton.icon(
                                  onPressed: () {
                                    final route = '${widget.subcategorie.route}/crea-tu-empaque';
                                    navigateWithSlide(context, route); // tu función personalizada
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  icon: const Icon(Icons.arrow_forward_rounded, size: 24, color: Colors.black),
                                  label: const Text('Ir a crear'),
                                ),
                              ),
                            ],
                          ),
                        ),
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

class _Leaf {
  final double inicio;
  final double dur;
  final double rot;
  final double scale;
  final double offsetY;
  final double curveFactor; // ⬅️ nuevo
  final double waveMultiplier; // nuevo

  _Leaf({
    required this.inicio,
    required this.dur,
    required this.rot,
    required this.scale,
    required this.offsetY,
    required this.curveFactor,
    required this.waveMultiplier,
  });
}

//Lluvia
class SmartbagRain extends StatefulWidget {
  const SmartbagRain({super.key});

  @override
  State<SmartbagRain> createState() => _SmartbagRainState();
}

class _SmartbagRainState extends State<SmartbagRain> with TickerProviderStateMixin {
  final Random rand = Random();
  final List<_RainDrop> drops = [];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();

    // Generar gotas iniciales
    for (int i = 0; i < 25; i++) {
      drops.add(_RainDrop(x: rand.nextDouble() * 400, delay: rand.nextDouble(), speed: 2 + rand.nextDouble() * 3, size: 20 + rand.nextDouble() * 20));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          children:
              drops.map((drop) {
                double t = (_controller.value + drop.delay) % 1.0;
                double y = t * MediaQuery.of(context).size.height;
                return Positioned(
                  top: y,
                  left: drop.x,
                  child: Opacity(
                    opacity: (1 - t).clamp(0.0, 1.0),
                    child: Transform.rotate(angle: t * pi / 3, child: Icon(Icons.shopping_bag, size: drop.size, color: Colors.blue.withOpacity(0.6))),
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}

class _RainDrop {
  final double x;
  final double delay;
  final double speed;
  final double size;

  _RainDrop({required this.x, required this.delay, required this.speed, required this.size});
}

//Finally image
