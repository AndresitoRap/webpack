import 'dart:async';
import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/4pro/imagesequencescroller.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class FiveProEco extends StatelessWidget {
  final Responsive r;
  final Subcategorie subcategorie;
  const FiveProEco({super.key, required this.r, required this.subcategorie});

  @override
  Widget build(BuildContext context) {
    final isMobile = r.wp(100) < 850;
    final green = const Color(0xFF4B8D2C);
    final route = '${subcategorie.route}/crea-tu-empaque';
    final ScrollController scroll = ScrollController();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFFF8),
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          Start5PROSliver(isMobile: isMobile, r: r, green: green, route: route),
          FiveSealsOfTrustSliver(green: green, r: r, isMobile: isMobile),
          Scroll4FunctionsSliver(r: r, isMobile: isMobile, green: green),
          BigPowerBigResponsabilitySliver(r: r, green: green, isMobile: isMobile),
          VideoSliver5PROEcoSliver(r: r, green: green),
          NowBreatheSliver(isMobile: isMobile, r: r, green: green),
          MoreInformation5PRO(r: r, green: green, isMobile: isMobile),
          VideoScrollableSliver(isMobile: isMobile, r: r, scroll: scroll),
          WeCareUsSliver(r: r, green: green, isMobile: isMobile),
          ParallaxSliver(r: r, green: green, scrollController: scroll),

          // SliverWithParallax(green: green, screenHeight: r.hp(100), screenWidth: r.wp(100), scrollController: scroll, isMobile: isMobile),
          SliverToBoxAdapter(child: Footer()),
        ],
      ),
    );
  }
}

//---------Intro de 5PRO Ecobag------------
class Start5PROSliver extends StatefulWidget {
  final bool isMobile;
  final Responsive r;
  final Color green;
  final String route;
  const Start5PROSliver({super.key, required this.isMobile, required this.r, required this.green, required this.route});

  @override
  State<Start5PROSliver> createState() => _Start5PROSliverState();
}

class _Start5PROSliverState extends State<Start5PROSliver> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<Offset> _floatAnim;

  @override
  void initState() {
    super.initState();

    // Animación flotante
    _floatController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _floatAnim = Tween<Offset>(
      begin: const Offset(0, -0.02),
      end: const Offset(0, 0.02),
    ).animate(CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(width: widget.r.wp(100), height: widget.r.hp(100), child: widget.isMobile ? _buildPhone(context) : _buildDesktop()),
    );
  }

  ScrollAnimatedWrapper _buildPhone(BuildContext context) {
    return ScrollAnimatedWrapper(
      child: Column(
        children: [
          Expanded(child: SlideTransition(position: _floatAnim, child: Image.asset("img/ecobag/5pro/inicio.webp", fit: BoxFit.fitWidth))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () => navigateWithSlide(context, widget.route),
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(widget.green), foregroundColor: WidgetStatePropertyAll(Colors.white)),
              child: Text("Crear mi 5PRO", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text.rich(
              style: TextStyle(fontWeight: FontWeight.bold, color: widget.green, fontSize: widget.r.fs(10, 70), height: 0.99),
              textAlign: TextAlign.center,
              TextSpan(children: [TextSpan(text: "5PRO\n"), TextSpan(text: "ECOBAG®")]),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildDesktop extends StatelessWidget {
  const _buildDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

//---------5 Sellos de confianza------------
class FiveSealsOfTrustSliver extends StatelessWidget {
  const FiveSealsOfTrustSliver({super.key, required this.green, required this.r, required this.isMobile});

  final Color green;
  final Responsive r;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: green,
        width: r.wp(100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(20, max: 120)),
          child: Center(
            child: SizedBox(
              width: 1200,
              child: Column(
                children: [
                  ScrollAnimatedWrapper(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Nuevo estandar.\n5 Sellos de confianza.",
                      style: TextStyle(color: Colors.white, fontSize: r.fs(4, 60), fontWeight: FontWeight.bold, height: 0.96),
                    ),
                  ),
                  SizedBox(height: isMobile ? 60 : 40),
                  ScrollAnimatedWrapper(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Presentamos la 5PRO Ecobag. Diseñada con cinco sellos de alta tecnología, pensada para la resistencia, la sostenibilidad y el rendimiento. Creada para enfrentar cualquier desafío con estilo y fuerza, es la solución de empaque definitiva para marcas conscientes que no se conforman.",
                      style: TextStyle(color: Colors.white, fontSize: r.fs(2, 30), height: 0.99),
                    ),
                  ),
                  SizedBox(height: isMobile ? 60 : 40),

                  ScrollAnimatedWrapper(
                    child: Container(
                      height: r.wp(100, max: 700),
                      width: r.wp(100, max: 700),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Color.fromARGB(255, 122, 194, 88)),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: videoBlurNotifier,
                        builder: (context, isBlur, _) {
                          return VideoFlutter(
                            src: 'assets/videos/ecobag/5pro/loop.webm',
                            blur: isBlur,
                            loop: true,
                            showControls: true,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
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

//---------Scroll Nuestra 5 Pro------------
class Scroll4FunctionsSliver extends StatefulWidget {
  const Scroll4FunctionsSliver({super.key, required this.r, required this.green, required this.isMobile});

  final bool isMobile;
  final Responsive r;
  final Color green;

  @override
  State<Scroll4FunctionsSliver> createState() => _Scroll4FunctionsSliverState();
}

class _Scroll4FunctionsSliverState extends State<Scroll4FunctionsSliver> {
  final ScrollController _scroll = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_checkScroll);
  }

  void _checkScroll() {
    final maxScroll = _scroll.position.maxScrollExtent;
    final offset = _scroll.offset;
    setState(() {
      _canScrollLeft = offset > 0;
      _canScrollRight = offset < maxScroll;
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> nuestraEcoBag5Pro = [
      {'text': 'Sello de sustentabilidad con estilo profesional', 'image': 'img/ecobag/5pro/cardLarge1.webp'},
      {'text': 'Diseño 5PRO: elegante, resistente y consciente', 'image': 'img/ecobag/5pro/cardLarge2.webp'},
      {'text': 'Fabricada con materiales reciclables y compostables', 'image': 'img/ecobag/5pro/cardLarge3.webp'},
      {'text': 'Sellado hermético y tecnología multipunto', 'image': 'img/ecobag/5pro/cardLarge4.webp'},
      {'text': 'Ideal para marcas que buscan impacto y responsabilidad', 'image': 'img/ecobag/5pro/cardLarge5.webp'},
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: widget.r.wp(100),
        padding: EdgeInsets.only(bottom: widget.r.dp(7), top: widget.r.hp(10, max: 100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Text("Nuestra 5PRO", style: TextStyle(fontWeight: FontWeight.bold, color: widget.green, fontSize: widget.r.fs(4, 60))),
              ),
            ),
            SizedBox(height: widget.r.hp(3)),
            SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
              child: Row(
                children: List.generate(nuestraEcoBag5Pro.length, (index) {
                  final card = nuestraEcoBag5Pro[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: widget.r.wp(80, max: 1000),
                      height: widget.r.hp(widget.isMobile ? 40 : 60, max: 600),
                      padding: EdgeInsets.all(widget.r.dp(2, max: 60)),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 20),
                        image: DecorationImage(image: AssetImage(card['image']), fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            card['text'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.r.fs(2, 32),
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(widget.isMobile ? 150 : 130))],
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
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(8), vertical: widget.r.dp(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ArrowButton(
                    enabled: _canScrollLeft,
                    icon: CupertinoIcons.chevron_left,
                    onTap: () {
                      _scroll.animateTo(_scroll.offset - widget.r.wp(60), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                  ),
                  SizedBox(width: widget.r.wp(3, max: 30)),
                  ArrowButton(
                    enabled: _canScrollRight,
                    icon: CupertinoIcons.chevron_right,
                    onTap: () {
                      _scroll.animateTo(_scroll.offset + widget.r.wp(60), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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

//---------Grande poder, grande proteccion------------
class BigPowerBigResponsabilitySliver extends StatelessWidget {
  const BigPowerBigResponsabilitySliver({super.key, required this.r, required this.green, required this.isMobile});

  final Responsive r;
  final Color green;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ScrollAnimatedWrapper(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(10, max: 70)),
          child: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              width: r.wp(100, max: 1300),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(CupertinoIcons.tortoise_fill, size: r.dp(12, max: 100), color: green),
                  Text(
                    textAlign: TextAlign.center,
                    "Gran protección viene en una 5PRO ECOBAG.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(3, 45), height: 0.95),
                  ),
                  SizedBox(height: isMobile ? 40 : 50),
                  isMobile ? _buildPhone() : _buildDesktop(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildDesktop() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(16, max: 70)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text.rich(
              style: TextStyle(fontSize: r.fs(1.8, 22), color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
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
          SizedBox(width: 40),
          Expanded(
            child: Text.rich(
              style: TextStyle(fontSize: r.fs(1.8, 22), color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
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
    );
  }

  Padding _buildPhone() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
      child: Column(
        children: [
          Text.rich(
            style: TextStyle(fontSize: r.fs(2, 26), color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
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
            style: TextStyle(fontSize: r.fs(2, 26), color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
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
    );
  }
}

//---------Video 5PRO------------
class VideoSliver5PROEcoSliver extends StatelessWidget {
  final Responsive r;
  final Color green;
  const VideoSliver5PROEcoSliver({super.key, required this.r, required this.green});

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final sliverHeight = r.hp(80, max: 1100);
        final offset = constraints.scrollOffset;

        // 📌 Queremos que empiece apenas entra y termine cuando se ve el 30%
        final visibleStart = 0.0; // entra
        final visibleEnd = sliverHeight * 0.3; // 30% visible

        double progress = ((offset - visibleStart) / (visibleEnd - visibleStart)).clamp(0.0, 1.0);

        final borderRadius = BorderRadius.circular(30 * progress);
        final pdh = r.wp(4) * progress;

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollAnimatedWrapper(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(2, max: 20)),
                  child: Text(
                    "Siente el terminado. 5PRO. Papel, Válvula. Perfecto",
                    style: TextStyle(color: green, fontSize: r.fs(3.5, 50), fontWeight: FontWeight.bold, height: 0.99),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: pdh),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: SizedBox(
                    width: double.infinity,
                    height: r.hp(80, max: 1100),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: videoBlurNotifier,
                      builder: (context, isBlur, _) {
                        return VideoFlutter(
                          src: 'assets/videos/ecobag/5pro/video.webm',
                          blur: isBlur,
                          loop: true,
                          showControls: true,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
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

//---------Ahora respira mejor con la 5PRO------------
class NowBreatheSliver extends StatelessWidget {
  const NowBreatheSliver({super.key, required this.isMobile, required this.r, required this.green});

  final bool isMobile;
  final Responsive r;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: SizedBox(
                width: 1120,
                child: Padding(
                  padding: EdgeInsets.only(right: r.wp(6), left: r.wp(6), top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ahora tu producto respira... y dura más.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(3, 50))),
                      SizedBox(height: 30),
                      Text.rich(
                        style: TextStyle(fontSize: r.fs(1.9, 22), color: Colors.black.withAlpha(150), fontWeight: FontWeight.w700),
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
            ),
          ],
        ),
      ),
    );
  }
}

//---------Cards con información de 5PRO------------
class MoreInformation5PRO extends StatefulWidget {
  final Responsive r;
  final Color green;
  final bool isMobile;

  const MoreInformation5PRO({super.key, required this.r, required this.green, required this.isMobile});

  @override
  State<MoreInformation5PRO> createState() => _MoreInformation5PROState();
}

class _MoreInformation5PROState extends State<MoreInformation5PRO> {
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
    final List<dynamic> nuestra5pro = [
      {
        'text':
            'Disponible en estructuras de 3 y 4 láminas, con papeles kraft de alta resistencia y barreras intermedias biodegradables. Ideal para conservar aromas, texturas y frescura.',
        'image': 'img/ecobag/5pro/cardShort1.webp',
      },
      {
        'text':
            'Terminación 100% papel: kraft natural o blanco, con opción de ventana troquelada. Transmite autenticidad, sostenibilidad y compromiso ambiental.',
        'image': 'img/ecobag/5pro/cardShort2.webp',
      },
      {
        'text':
            'Compatible con válvula desgasificadora, perfecta para productos que continúan liberando gases como el café recién tostado o granos fermentados.',
        'image': 'img/ecobag/5pro/cardShort3.webp',
      },
      {
        'text': 'Diseñada para ser sellada en líneas automáticas y semi-automáticas. Su estructura laminada garantiza un cierre seguro y sin fugas.',
        'image': 'img/ecobag/5pro/cardShort4.webp',
      },
      {
        'text':
            'Soporta impresión flexográfica y digital sobre papel. Acabados disponibles: mate natural o barniz protector para mejor resistencia y presencia en góndola.',
        'image': 'img/ecobag/5pro/cardShort5.webp',
      },
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.r.hp(16, max: 50)),
        child: SizedBox(
          width: widget.r.wp(100),
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
                        left: index == 0 ? widget.r.wp(6) : 0,
                        right: index == nuestra5pro.length - 1 ? widget.r.wp(6) : 20,
                        bottom: 50,
                      ),
                      child: SizedBox(
                        width: widget.r.wp(70, max: 500),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              height: widget.r.wp(70, max: 500),

                              width: widget.r.wp(70, max: 500),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(image: AssetImage(nuestra5pro[index]['image'])),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Text(
                                nuestra5pro[index]['text'],
                                style: TextStyle(fontSize: widget.r.fs(1.8, 20), fontWeight: FontWeight.w600, color: Colors.black.withAlpha(180)),
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
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ArrowButton(
                      enabled: canScrollLeft,
                      icon: CupertinoIcons.chevron_left,
                      onTap: () {
                        _scrollController.animateTo(
                          _scrollController.offset - widget.r.wp(70),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    ArrowButton(
                      enabled: canScrollRight,
                      icon: CupertinoIcons.chevron_right,
                      onTap: () {
                        _scrollController.animateTo(
                          _scrollController.offset + widget.r.wp(70),
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
      ),
    );
  }
}

//---------Scrollable video------------
class VideoScrollableSliver extends StatefulWidget {
  final bool isMobile;
  final Responsive r;
  final ScrollController scroll;

  const VideoScrollableSliver({super.key, required this.isMobile, required this.r, required this.scroll});

  @override
  State<VideoScrollableSliver> createState() => _VideoScrollableSliverState();
}

double computeYOffset({
  required bool isMobile,
  required BuildContext context,
  required GlobalKey targetKey,
  required GlobalKey limitKey,
  required double currentYOffset,
  required bool shouldAnimate,
  required void Function() onStartAnimation,
}) {
  if (!isMobile) {
    if (!targetKey.currentContext!.mounted || !limitKey.currentContext!.mounted) return currentYOffset;

    final RenderBox targetBox = targetKey.currentContext!.findRenderObject() as RenderBox;
    final targetPos = targetBox.localToGlobal(Offset.zero);
    final targetCenterY = targetPos.dy + targetBox.size.height / 2;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenCenterY = screenHeight / 2;

    final RenderBox limitBox = limitKey.currentContext!.findRenderObject() as RenderBox;
    final limitPos = limitBox.localToGlobal(Offset.zero);

    if ((targetCenterY - screenCenterY).abs() < 10 && !shouldAnimate) {
      onStartAnimation();
    }

    if (shouldAnimate) {
      final double maxYOffset = limitPos.dy - targetBox.size.height - 10;
      final double targetOffset = screenCenterY - targetCenterY;
      final double clampedTarget = min(max(0, targetOffset), maxYOffset - targetPos.dy);
      return clampedTarget; // Actualización directa para seguir el scroll sin delay
    }

    return currentYOffset;
  }
  return 0;
}

class _VideoScrollableSliverState extends State<VideoScrollableSliver> {
  final GlobalKey greenKey = GlobalKey();
  final GlobalKey redKey = GlobalKey();

  double greenYOffset = 0.0;
  bool isAnimatingGreen = false;

  @override
  void initState() {
    super.initState();
    widget.scroll.addListener(_handleScroll);
  }

  @override
  void dispose() {
    widget.scroll.removeListener(_handleScroll);
    super.dispose();
  }

  void _handleScroll() {
    final newYOffset = computeYOffset(
      isMobile: widget.isMobile,
      context: context,
      targetKey: greenKey,
      limitKey: redKey,
      currentYOffset: greenYOffset,
      shouldAnimate: isAnimatingGreen,
      onStartAnimation: () {
        isAnimatingGreen = true;
      },
    );

    setState(() {
      greenYOffset = newYOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMobile) return SliverToBoxAdapter(child: _buildMobile());

    final screenHeight = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          // 🔹 Animación secuencial con desplazamiento
          Center(
            child: AnimatedContainer(
              key: greenKey,
              duration: Duration.zero,
              curve: Curves.linear,
              transform: Matrix4.translationValues(0, greenYOffset, 0),
              width: screenHeight * 1.1,
              child: ImageSequenceScroller(
                framePrefix: 'img/ecobag/5pro/frames/frame',
                frameExtension: 'webp',
                totalFrames: 227,
                width: double.infinity,
                externalScrollController: widget.scroll,
                pixelsPerFrame: 5.0,
                frameCalculationMode: 'clamp',
              ),
            ),
          ),

          // 🔴 Punto de corte que marca el final del scroll controlado
          Padding(padding: const EdgeInsets.only(top: 294 * 5), child: SizedBox(key: redKey, height: 100, width: double.infinity)),
        ],
      ),
    );
  }

  Padding _buildMobile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
      child: Column(
        children:
            ['0041', '0072', '0106', '0199'].map((frame) {
              return ScrollAnimatedWrapper(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Image.asset(
                    'img/ecobag/5pro/frames/frame$frame.webp',
                    width: double.infinity,
                    fit: BoxFit.contain,
                    cacheWidth: 1920,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

//---------Parallax------------
class ParallaxSliver extends StatefulWidget {
  const ParallaxSliver({super.key, required this.r, required this.green, required this.scrollController});

  final Responsive r;
  final Color green;
  final ScrollController scrollController;

  @override
  State<ParallaxSliver> createState() => _ParallaxSliverState();
}

class _ParallaxSliverState extends State<ParallaxSliver> {
  double _localScrollOffset = 0;
  final GlobalKey _key = GlobalKey();

  late final List<_ParallaxIcon> _icons;

  void _updateScrollOffset() {
    if (!mounted) return;

    final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    // Esto hace que el efecto solo se active cuando entra al viewport
    final offsetVisible = position.dy < screenHeight + 400 && position.dy > -renderBox.size.height;

    if (offsetVisible) {
      setState(() {
        _localScrollOffset = screenHeight - position.dy;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_updateScrollOffset);

    final centerY = widget.r.hp(90);

    final List<String> leafAssets = ['img/ecobag/hoja1.webp', 'img/ecobag/hoja2.webp', 'img/ecobag/hoja3.webp'];

    final random = Random();

    _icons = List.generate(20, (index) {
      // Rango de dispersión horizontal y vertical
      final double top = centerY - 200 + random.nextDouble() * 400; // entre -200 y +200 desde el centro
      final double leftPercent = 0.1 + random.nextDouble() * 0.8;

      final String asset = leafAssets[random.nextInt(leafAssets.length)];
      final double scale = 0.8 + random.nextDouble() * 0.6; // entre 0.8 y 1.4
      final double verticalSpeed = 0.4 + random.nextDouble() * 0.3; // entre 0.4 y 0.7
      final double horizontalShift = -20 + random.nextDouble() * 40; // entre -20 y +20

      return _ParallaxIcon(
        initialTop: top,
        leftPercent: leftPercent,
        asset: asset,
        scale: scale,
        verticalSpeed: verticalSpeed,
        horizontalShift: horizontalShift,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        key: _key,

        child: Stack(
          alignment: Alignment.center,
          children: [
            ..._icons.map((icon) => icon.build(_localScrollOffset, widget.r.wp(100))),

            // Fondo o decoraciones con parallax (por ejemplo)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                  child: Stack(
                    children: [
                      Text(
                        "5PRO EcoBag®.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widget.r.fs(3, 50),
                          foreground:
                              Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.white,
                        ),
                      ),
                      Text(
                        "5PRO EcoBag®.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: widget.green, fontSize: widget.r.fs(3, 50)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                  child: Stack(
                    children: [
                      Text(
                        "Haz que tu producto hable por ti.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: widget.r.fs(2.5, 40),
                          fontWeight: FontWeight.bold,
                          foreground:
                              Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2.5
                                ..color = Colors.white,
                        ),
                      ),
                      Text(
                        "Haz que tu producto hable por ti.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: widget.r.fs(2.5, 40), fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Image.asset("img/ecobag/5pro/end.webp", width: widget.r.wp(100, max: 600), fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: widget.r.hp(10, max: 20)),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(widget.green), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text("Crear mi 5PRO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(2, 26))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// //Inicio de la página
// class SliverToStartFiveProEco extends StatefulWidget {
//   const SliverToStartFiveProEco({super.key, required this.screenHeight, required this.screenWidth, required this.isMobile, required this.green});

//   final bool isMobile;
//   final double screenHeight;
//   final double screenWidth;
//   final Color green;

//   @override
//   State<SliverToStartFiveProEco> createState() => _SliverToStartFiveProEcoState();
// }

// class _SliverToStartFiveProEcoState extends State<SliverToStartFiveProEco> with TickerProviderStateMixin {
//   late AnimationController _bagController;
//   late Animation<double> _bagScale;
//   late Animation<double> _bagOpacity;

//   late AnimationController _textController;
//   late Animation<double> _textScale;
//   late Animation<double> _textOpacity;

//   late Animation<Offset> _bagFloatOffset;
//   late AnimationController _bagFloatController;

//   @override
//   void initState() {
//     super.initState();

//     _bagController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
//     _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

//     _bagOpacity = CurvedAnimation(parent: _bagController, curve: Curves.easeIn);
//     _bagFloatController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
//       ..repeat(reverse: true); // Movimiento continuo arriba-abajo

//     _bagFloatOffset = Tween<Offset>(
//       begin: const Offset(0, -0.02),
//       end: const Offset(0, 0.02),
//     ).animate(CurvedAnimation(parent: _bagFloatController, curve: Curves.easeInOut));

//     _textOpacity = CurvedAnimation(parent: _textController, curve: Curves.easeIn);

//     _startAnimationSequence();
//   }

//   void _startAnimationSequence() async {
//     await _bagController.forward();
//     await Future.delayed(const Duration(milliseconds: 200));
//     _textController.forward();
//   }

//   @override
//   void dispose() {
//     _bagController.dispose();
//     _textController.dispose();
//     _bagFloatController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Container(
//         width: widget.screenWidth,
//         constraints: BoxConstraints(minHeight: widget.screenHeight - 100),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final double baseTextSize = (constraints.maxWidth * 0.06).clamp(30.0, 90.0);
//             final double imageHeight = (constraints.maxHeight * 0.35).clamp(180.0, 500.0);

//             _bagScale = Tween<double>(
//               begin: widget.isMobile ? 0.6 : 0.7,
//               end: widget.isMobile ? 1.8 : 1.3,
//             ).animate(CurvedAnimation(parent: _bagController, curve: Curves.fastEaseInToSlowEaseOut));

//             _textScale = Tween<double>(
//               begin: widget.isMobile ? 0.6 : 0.7,
//               end: widget.isMobile ? 2.0 : 2.6,
//             ).animate(CurvedAnimation(parent: _textController, curve: Curves.fastEaseInToSlowEaseOut));

//             return widget.isMobile
//                 ? Padding(
//                   padding: EdgeInsetsGeometry.symmetric(vertical: 45),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       FadeTransition(
//                         opacity: _bagOpacity,
//                         child: ScaleTransition(scale: _bagScale, child: Image.asset('img/ecobag/5pro/inicio.webp', height: imageHeight)),
//                       ),
//                       SizedBox(height: widget.screenWidth * 0.3),
//                       FadeTransition(
//                         opacity: _textOpacity,
//                         child: ScaleTransition(
//                           scale: _textScale,
//                           child: Text(
//                             '5PRO Ecobag',
//                             style: TextStyle(fontSize: baseTextSize, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: widget.green),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//                 : Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Positioned(
//                       top: 100,
//                       left: 200,
//                       child: FadeTransition(
//                         opacity: _textOpacity,
//                         child: ScaleTransition(
//                           scale: _textScale,
//                           child: Text(
//                             '5PRO ',
//                             style: TextStyle(fontSize: baseTextSize, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: widget.green),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 70,
//                       right: 200,
//                       child: FadeTransition(
//                         opacity: _textOpacity,
//                         child: ScaleTransition(
//                           scale: _textScale,
//                           child: Text(
//                             'Ecobag ',
//                             style: TextStyle(fontSize: baseTextSize, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: widget.green),
//                           ),
//                         ),
//                       ),
//                     ),
//                     FadeTransition(
//                       opacity: _bagOpacity,
//                       child: SlideTransition(
//                         position: _bagFloatOffset,
//                         child: ScaleTransition(
//                           scale: _bagScale,
//                           child: Transform.rotate(
//                             angle: math.pi * 2.1,
//                             child: MouseRegion(
//                               cursor: SystemMouseCursors.click,
//                               child: GestureDetector(onTap: () {}, child: Image.asset('img/ecobag/5pro/inicio.webp', height: imageHeight)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//           },
//         ),
//       ),
//     );
//   }
// }

// //Sección de información de 5pro

class _ParallaxIcon {
  final double initialTop;
  final double leftPercent; // 0.0 - 1.0
  final String asset;
  final double scale;
  final double verticalSpeed;
  final double horizontalShift;

  _ParallaxIcon({
    required this.initialTop,
    required this.leftPercent,
    required this.asset,
    required this.scale,
    required this.verticalSpeed,
    required this.horizontalShift,
  });

  Widget build(double scrollOffset, double screenWidth) {
    return Positioned(
      top: initialTop - scrollOffset * verticalSpeed,
      left: screenWidth * leftPercent + scrollOffset * 0.15 * (horizontalShift / 20),
      child: Transform.scale(scale: scale, child: Opacity(opacity: 0.75, child: Image.asset(asset, width: 50, height: 50))),
    );
  }
}
