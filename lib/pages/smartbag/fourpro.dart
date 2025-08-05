import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/4pro/imagesequencescroller.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class FourPro extends StatelessWidget {
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;

  const FourPro({super.key, required this.currentRoute, required this.subcategorie, required this.section});

  // final de secuencia
  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    final blue = Theme.of(context).primaryColor;
    final isMobile = r.wp(100) < 850;
    final route = '${subcategorie.route}/crea-tu-empaque';
    final ScrollController scroll = ScrollController();

    return CustomScrollView(
      controller: scroll,
      slivers: [
        Start4PROSliver(r: r, blue: blue, isMobile: isMobile, route: route),
        Scroll4FunctionsSliver(r: r, blue: blue, isMobile: isMobile),
        MultipleFunctionsSliver(r: r, blue: blue, isMobile: isMobile),
        ValvePeelAndLeafSliver(r: r, blue: blue, isMobile: isMobile),
        VideoScrollableSliver(isMobile: isMobile, r: r, scroll: scroll),
        Finally4PROSliver(blue: blue, r: r, isMobile: isMobile),
        //Footer
        SliverToBoxAdapter(child: Footer()),
      ],
    );
  }
}

//---------Inicio de la pantalla en 4pro------------
class Start4PROSliver extends StatelessWidget {
  const Start4PROSliver({super.key, required this.r, required this.blue, required this.isMobile, required this.route});

  final Responsive r;
  final Color blue;
  final bool isMobile;
  final String route;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"icon": CupertinoIcons.shield, "text": "Protección superior para conservar la calidad de tus productos."},

      {"icon": CupertinoIcons.briefcase, "text": "Acabados premium que elevan la presentación de tu marca."},

      {"icon": CupertinoIcons.lock, "text": "Sellado seguro para mayor protección."},

      {"icon": CupertinoIcons.arrow_2_squarepath, "text": "Ideal para alimentos, suplementos, cosméticos y más."},
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 45, bottom: 45),
        child: SizedBox(
          width: r.wp(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollAnimatedWrapper(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                  child: Center(
                    child: SizedBox(
                      width: r.wp(100, max: 1500),
                      child: Text("4PRO", style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.fs(4, 70))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6)),

                child: Center(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: r.wp(100, max: 1500),
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color.fromARGB(161, 255, 255, 255),
                      image: isMobile ? DecorationImage(image: AssetImage("assets/img/smartbag/4Pro/prueba.png"), fit: BoxFit.cover) : null,
                    ),
                    child: isMobile ? _buildPhone(context) : _buildDesktop(context),
                  ),
                ),
              ),
              ScrollAnimatedWrapper(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: r.wp(8), vertical: r.hp(5)),
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(8),
                      width: r.wp(100, max: 1300),
                      decoration: BoxDecoration(color: const Color.fromARGB(161, 255, 255, 255), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(CupertinoIcons.bag, size: r.wp(10, max: 30), color: blue),
                          ),
                          Expanded(
                            child: Text(
                              "Nuestro empaque más versátil, resistente y elegante. Diseñado para brindar protección, presencia y funcionalidad en un solo producto. Ideal para marcas que quieren destacar.",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: r.fs(1.1, 23)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ScrollAnimatedWrapper(
                child: Center(
                  child: SizedBox(
                    width: r.wp(90, max: 1200),
                    child: isMobile ? _buildPhoneItems(context, items, r) : _buildDesktopItems(items, context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildPhone(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: r.wp(5), right: r.wp(10)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: r.wp(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScrollAnimatedWrapper(
                    child: Text("La funcionalidad perfecta.", style: TextStyle(height: 0.99, fontWeight: FontWeight.bold, fontSize: r.fs(1.5, 26))),
                  ),
                  SizedBox(height: 16),
                  ScrollAnimatedWrapper(
                    child: Text(
                      "Más que un empaque funcional, es una declaración visual. Versátil, sofisticado y técnicamente superior, cada detalle ha sido concebido para transmitir la esencia de su marca.",
                      style: TextStyle(height: 0.99, fontSize: r.fs(1.15, 24)),
                    ),
                  ),
                  SizedBox(height: 14),
                  ScrollAnimatedWrapper(
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(blue), foregroundColor: const WidgetStatePropertyAll(Colors.white)),
                      onPressed: () {
                        navigateWithSlide(context, route);
                      },
                      child: Text("Crear mi 4PRO", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _buildDesktop(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: r.wp(9)),
          child: ScrollAnimatedWrapper(
            duration: Duration(milliseconds: 800),
            delay: Duration(milliseconds: 1000),
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("La funcionalidad perfecta", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(2, 50))),
                  SizedBox(height: 5),
                  Text(
                    "Más que un empaque funcional, es una declaración visual. Versátil, sofisticado y técnicamente superior, cada detalle ha sido concebido para transmitir la esencia de su marca.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: r.fs(1, 22)),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(blue), foregroundColor: const WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      navigateWithSlide(context, route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text("Crear mi 4PRO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child:
                isMobile
                    ? Image.asset("assets/img/smartbag/4Pro/prueba.png", cacheWidth: 800, fit: BoxFit.cover, alignment: Alignment.centerLeft)
                    : Row(
                      children: [
                        Expanded(
                          flex: 40,
                          child: AspectRatio(
                            aspectRatio: 16 / 9, // o el ratio real de tu video
                            child: ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return VideoFlutter(
                                  src: 'assets/videos/smartbag/4pro/4pro.webm',
                                  loop: false,
                                  isPause: false,
                                  fit: BoxFit.contain,
                                  blur: isBlur,
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(flex: 6, child: SizedBox()),
                      ],
                    ),
          ),
        ),
      ],
    );
  }

  Padding _buildPhoneItems(BuildContext context, List<Map<String, dynamic>> items, Responsive r) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Icon(item["icon"], size: 28, color: blue),
                    const SizedBox(width: 12),
                    Expanded(child: Text(item["text"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  Row _buildDesktopItems(List<Map<String, dynamic>> items, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          items.map((item) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item["icon"], size: 32, color: blue),
                const SizedBox(height: 8),
                SizedBox(
                  width: r.wp(18, max: 200),
                  child: Text(item["text"], textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          }).toList(),
    );
  }
}

//---------Scroll 4 funciones, 4pro------------
class Scroll4FunctionsSliver extends StatefulWidget {
  const Scroll4FunctionsSliver({super.key, required this.r, required this.blue, required this.isMobile});

  final bool isMobile;
  final Responsive r;
  final Color blue;

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
    final List<Map<String, dynamic>> localCards = [
      {
        "title": "4 Funciones, 4PRO.",
        "subtitle": "El empaque 4PRO SmartBag®: seguro, funcional y diseñado para la visión de tu marca.",
        "image": "assets/img/smartbag/4pro/card1.webp",
        "down": false,
      },
      {
        "title": "Sella. Protege. Impacta.",
        "subtitle":
            "El zipper hermético, los materiales de alta calidad y los acabados que cautivan, aseguran que tu producto no solo se conserve, sino que domine la atención en cualquier estantería.",
        "image": "assets/img/smartbag/4pro/card2.webp",
        "down": true,
      },
      {
        "title": "El empaque que se adapta a tu visión.",
        "subtitle":
            "Una versatilidad sin límites para alimentos, cosméticos, suplementos y más. Porque tu producto no solo merece protección, sino la oportunidad de destacar en cualquier lugar.",
        "image": "assets/img/smartbag/4pro/card3.webp",
        "down": false,
      },
      {
        "title": "Innovación que se ve y se siente.",
        "subtitle":
            "4PRO SmartBag® la tecnología que fusiona un diseño impactante con un compromiso real por la sostenibilidad. Todo en un solo empaque.",
        "image": "assets/img/smartbag/4pro/card4.webp",
        "down": true,
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: widget.r.wp(100),
        padding: EdgeInsets.only(bottom: widget.r.dp(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Text("4 Funciones, 4PRO.", style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: widget.r.fs(2, 50))),
              ),
            ),
            SizedBox(height: widget.r.hp(3)),
            SizedBox(
              height: widget.r.wp(60, max: 550) + 40,
              child: SingleChildScrollView(
                controller: _scroll,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Row(
                  children: List.generate(localCards.length, (index) {
                    final card = localCards[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        width: widget.r.wp(80, max: 1000),
                        height: widget.r.wp(60, max: 550),
                        padding: EdgeInsets.all(widget.r.dp(2, max: 60)),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 20),
                          image: DecorationImage(image: AssetImage(card['image']), fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: card['down'] == true ? MainAxisAlignment.end : MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              card['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.r.fs(1.4, 32),
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(130))],
                              ),
                            ),
                            Text(
                              card['subtitle'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.r.fs(1, 25),
                                shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(130))],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Padding(
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
                    SizedBox(width: widget.r.wp(2)),
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
            ),
          ],
        ),
      ),
    );
  }
}

//---------Una familia, multiples funciones------------
class MultipleFunctionsSliver extends StatelessWidget {
  const MultipleFunctionsSliver({super.key, required this.r, required this.blue, required this.isMobile});

  final Responsive r;
  final Color blue;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: r.wp(100),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Center(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: r.fs(2.5, 70), color: Colors.black87, fontWeight: FontWeight.bold),
                  TextSpan(children: [TextSpan(text: "Una familia, "), TextSpan(text: "múltiples funciones", style: TextStyle(color: blue))]),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Center(
                child: Text(
                  "Siempre 4PRO.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: r.fs(2.5, 70), color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: r.dp(5, max: 100)),
              child: Column(children: isMobile ? _buildPhone(context) : _buildDesktop(context)),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPhone(BuildContext context) {
    return [
      SlideFadeIn(fromLeft: true, child: Image.asset("assets/img/smartbag/4pro/top.webp")),
      SizedBox(height: r.dp(4)),

      ScrollAnimatedWrapper(
        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: r.dp(1.5, max: 26)),
          TextSpan(
            children: [
              TextSpan(text: "Más que empaque, es identidad funcional. "),
              TextSpan(text: "4PRO SmartBag se adapta, protege y representa ", style: TextStyle(color: blue)),
              TextSpan(text: "lo que tu marca realmente quiere decir."),
            ],
          ),
        ),
      ),
      SizedBox(height: r.dp(4)),
      SlideFadeIn(fromLeft: false, child: Image.asset("assets/img/smartbag/4pro/down.webp")),
      SizedBox(height: r.dp(4)),

      ScrollAnimatedWrapper(
        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: r.dp(1.5, max: 26)),
          TextSpan(
            children: [
              TextSpan(text: "Tecnología, confianza y diseño en cada capa de la 4PRO SmartBag. ", style: TextStyle(color: blue)),
              TextSpan(text: "Diseñada para quienes necesitan soluciones con impacto real y protección superior."),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildDesktop(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: ScrollAnimatedWrapper(
              child: Text.rich(
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: r.dp(1.5, max: 26)),
                TextSpan(
                  children: [
                    TextSpan(text: "Más que empaque, es identidad funcional. "),
                    TextSpan(text: "4PRO SmartBag se adapta, protege y representa ", style: TextStyle(color: blue)),
                    TextSpan(text: "lo que tu marca realmente quiere decir."),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: SlideFadeIn(fromLeft: false, child: Image.asset("assets/img/smartbag/4pro/top.webp"))),
        ],
      ),
      SizedBox(height: r.dp(5, max: 100)),
      Row(
        children: [
          Expanded(child: SlideFadeIn(fromLeft: true, child: Image.asset("assets/img/smartbag/4pro/down.webp"))),

          Expanded(
            child: ScrollAnimatedWrapper(
              child: Text.rich(
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: r.dp(1.5, max: 26)),
                TextSpan(
                  children: [
                    TextSpan(text: "Tecnología, confianza y diseño en cada capa de la 4PRO SmartBag. ", style: TextStyle(color: blue)),
                    TextSpan(text: "Diseñada para quienes necesitan soluciones con impacto real y protección superior."),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }
}

class SlideFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool fromLeft;

  const SlideFadeIn({super.key, required this.child, this.duration = const Duration(milliseconds: 1200), this.fromLeft = true});

  @override
  State<SlideFadeIn> createState() => _SlideFadeInState();
}

class _SlideFadeInState extends State<SlideFadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _slideAnimation = Tween<Offset>(
      begin: Offset(widget.fromLeft ? -1.0 : 1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.3 && !_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('slide-fade-${widget.key ?? UniqueKey()}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => FadeTransition(opacity: _fadeAnimation, child: SlideTransition(position: _slideAnimation, child: widget.child)),
      ),
    );
  }
}

//---------Información valvula, peel, laminas------------
class ValvePeelAndLeafSliver extends StatelessWidget {
  const ValvePeelAndLeafSliver({super.key, required this.r, required this.isMobile, required this.blue});
  final bool isMobile;
  final Color blue;
  final Responsive r;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: r.dp(3, max: 40), horizontal: r.wp(6)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(1, max: 400)),
          child: ScrollAnimatedWrapper(child: isMobile ? _buildMobile() : _buildDesktop()),
        ),
      ),
    );
  }

  Column _buildMobile() {
    return Column(
      children: [
        ScrollAnimatedWrapper(
          child: Container(
            padding: EdgeInsets.all(r.dp(2, max: 40)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFEDF3FF)),
            child: Column(
              children: [
                Image.asset("assets/img/smartbag/4pro/cuatrilamina.webp"),
                SizedBox(height: r.hp(1, max: 40)),

                Text(
                  "Protección superior con cuatro capas.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.dp(1.4, max: 28)),
                ),
                SizedBox(height: r.hp(1, max: 40)),
                Text(
                  textAlign: TextAlign.center,
                  "La tecnología 4PRO, con su combinación de PET, BOPP y PE, crea una barrera robusta contra la humedad, la luz y el oxígeno, garantizando la frescura y calidad de tu producto. Su diseño, además de ser funcional, ofrece una presentación elegante y segura.",
                  style: TextStyle(color: Colors.black87, fontSize: r.dp(1.2, max: 24)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: r.hp(1, max: 40)),

        ScrollAnimatedWrapper(
          child: Container(
            padding: EdgeInsets.all(r.dp(2, max: 40)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFEDF3FF)),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: videoBlurNotifier,
                          builder: (context, isBlur, _) {
                            return VideoFlutter(
                              src: "assets/videos/smartbag/4pro/accesorios.webm",
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
                ),

                SizedBox(height: r.hp(1, max: 40)),
                Text(
                  textAlign: TextAlign.center,

                  "Accesorios inteligentes para una funcionalidad óptima.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.dp(1.4, max: 28)),
                ),
                SizedBox(height: r.hp(1, max: 40)),
                Text(
                  textAlign: TextAlign.center,
                  "El sistema Peel Stick permite abrir y cerrar la bolsa de forma sencilla, mientras que las válvulas desgasificadoras conservan tus productos frescos por más tiempo, maximizando su vida útil.",
                  style: TextStyle(color: Colors.black87, fontSize: r.dp(1.2, max: 24)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: r.hp(1, max: 40)),

        ScrollAnimatedWrapper(
          child: Container(
            padding: EdgeInsets.all(r.dp(2, max: 40)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFEDF3FF)),
            child: Column(
              children: [
                Image.asset("assets/img/smartbag/4pro/terminacion.webp"),
                SizedBox(height: r.hp(1, max: 40)),

                Text("Tú decides la terminación", style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.dp(1.4, max: 28))),
                SizedBox(height: r.hp(1, max: 40)),
                Text(
                  textAlign: TextAlign.center,
                  "La bolsa 4PRO, con su estructura optimizada, es más ligera y resistente, ofreciendo una protección superior y prolongando la vida útil del producto. Con materiales de alta barrera y acabados técnicos, 4PRO es la solución de empaque eficiente y funcional que busca, con un diseño versátil que se adapta a distintos formatos, ideal para marcas que buscan la innovación.",
                  style: TextStyle(color: Colors.black87, fontSize: r.dp(1.2, max: 24)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _buildDesktop() {
    final List<Map<String, String>> cards = [
      {
        "image": "assets/img/smartbag/4pro/cuatrilamina.webp",
        "video": "",
        "title": "Protección superior con cuatro capas.",
        "text":
            "La tecnología 4PRO, con su combinación de PET, BOPP y PE, crea una barrera robusta contra la humedad, la luz y el oxígeno, garantizando la frescura y calidad de tu producto. Su diseño, además de ser funcional, ofrece una presentación elegante y segura.",
      },
      {
        "image": "",
        "video": "assets/videos/smartbag/4pro/accesorios.webm",
        "title": "Accesorios inteligentes para una funcionalidad óptima.",
        "text":
            "El sistema Peel Stick permite abrir y cerrar la bolsa de forma sencilla, mientras que las válvulas desgasificadoras conservan tus productos frescos por más tiempo, maximizando su vida útil.",
      },
      {
        "image": "assets/img/smartbag/4pro/terminacion.webp",
        "video": "",
        "title": "Tú decides la terminación",
        "text":
            "La bolsa 4PRO, con su estructura optimizada, es más ligera y resistente, ofreciendo una protección superior y prolongando la vida útil del producto. Con materiales de alta barrera y acabados técnicos, 4PRO es la solución de empaque eficiente y funcional que busca, con un diseño versátil que se adapta a distintos formatos, ideal para marcas que buscan la innovación.",
      },
    ];

    final double totalHeight = 950;
    final double spacing = r.hp(1, max: 40);
    final double halfHeight = (totalHeight - spacing) / 2;

    return Container(
      width: r.wp(100),
      padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(3, max: 40)),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Columna izquierda con 2 cards que suman el mismo alto
              Expanded(
                child: Column(
                  children: [_buildInfoCard(cards[0], height: halfHeight), SizedBox(height: spacing), _buildInfoCard(cards[1], height: halfHeight)],
                ),
              ),
              SizedBox(width: r.wp(2, max: 32)),
              // Card derecha de altura total
              Expanded(child: _buildInfoCard(cards[2], height: totalHeight)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(Map<String, String> data, {required double height}) {
    final bool isVideo = (data["video"] ?? "").isNotEmpty;
    final bool isImage = (data["image"] ?? "").isNotEmpty;

    return Container(
      height: height,
      padding: EdgeInsets.all(r.dp(2, max: 40)),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFEDF3FF)),
      child: Column(
        children: [
          if (isImage)
            Expanded(child: Image.asset(data["image"]!, fit: BoxFit.contain))
          else if (isVideo)
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: videoBlurNotifier,
                    builder: (context, isBlur, _) {
                      return VideoFlutter(
                        src: data["video"]!,
                        loop: false,
                        blur: isBlur,
                        showControls: false,
                        fit: BoxFit.contain,
                        isPause: false,
                        retry: true,
                      );
                    },
                  ),
                ),
              ),
            ),
          SizedBox(height: r.hp(1, max: 24)),
          Text(data["title"]!, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.dp(1.2, max: 22))),
          SizedBox(height: r.hp(1, max: 20)),
          Text(data["text"]!, textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontSize: r.dp(1.1, max: 20))),
        ],
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
  required BuildContext context,
  required GlobalKey targetKey,
  required GlobalKey limitKey,
  required double currentYOffset,
  required bool shouldAnimate,
  required void Function() onStartAnimation,
}) {
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
                framePrefix: 'assets/img/smartbag/4pro/frames/frame',
                frameExtension: 'webp',
                totalFrames: 294,
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
            ['0046', '0111', '0186', '0250'].map((frame) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  'assets/img/smartbag/4pro/frames/frame$frame.webp',
                  width: double.infinity,
                  fit: BoxFit.contain,
                  cacheWidth: 1920,
                  filterQuality: FilterQuality.high,
                ),
              );
            }).toList(),
      ),
    );
  }
}

//---------Final de 4pro------------
class Finally4PROSliver extends StatelessWidget {
  const Finally4PROSliver({super.key, required this.blue, required this.r, required this.isMobile});

  final Color blue;
  final Responsive r;
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 100),
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color.fromARGB(0, 255, 255, 255), blue],
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScrollAnimatedWrapper(
                      child: Text("UNICA E INIGUALABLE", style: TextStyle(color: blue, fontSize: r.fs(3, 50), fontWeight: FontWeight.bold)),
                    ),

                    ScrollAnimatedWrapper(child: Image.asset("assets/img/smartbag/4pro.webp", fit: BoxFit.cover, cacheWidth: 800, height: 400)),
                  ],
                ),
              ),
            ],
          ),
          ScrollAnimatedWrapper(
            child: Padding(
              padding: EdgeInsets.only(top: 100, left: r.wp(6), right: r.wp(6)),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 1000,
                      child: Column(
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "La bolsa 4PRO está diseñada para durar más y rendir mejor.",
                            style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.fs(2.6, 45)),
                          ),
                          SizedBox(height: r.hp(2, max: 40)),
                          Text(
                            textAlign: TextAlign.center,
                            "Su estructura optimizada es más ligera y resistente, sin comprometer su capacidad de protección. Con materiales de alta barrera y acabados técnicos, 4PRO ofrece un empaque más eficiente, más funcional y con un impacto visual superior.\n\nAdemás, su diseño versátil se adapta perfectamente a distintos formatos y sistemas de cierre, lo que la convierte en la opción ideal para marcas que buscan innovación y rendimiento sin ocupar más espacio.",
                            style: TextStyle(fontSize: r.fs(2, 25)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(vertical: r.dp(3, max: 100)), child: isMobile ? _buildPhone() : _buildDesktop()),
        ],
      ),
    );
  }

  Column _buildPhone() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(2)),

          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text.rich(
                    style: TextStyle(fontSize: r.fs(1.7, 30)),
                    TextSpan(
                      children: [
                        TextSpan(text: "Peel Stick: ", style: TextStyle(fontWeight: FontWeight.bold, color: blue)),
                        TextSpan(
                          text:
                              "Práctico y versátil, este accesorio de adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset("assets/img/smartbag/4pro/peel.webp"),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(2)),
          child: Container(
            padding: EdgeInsets.all(r.dp(2, max: 40)),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Image.asset("assets/img/smartbag/4pro/valvulas.webp"),

                Text.rich(
                  style: TextStyle(fontSize: r.fs(1.7, 30)),
                  TextSpan(
                    children: [
                      TextSpan(text: "Válvula: ", style: TextStyle(fontWeight: FontWeight.bold, color: blue)),
                      TextSpan(
                        text:
                            "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _buildDesktop() {
    return Container(
      height: r.dp(60, max: 700),
      width: 1200,
      margin: EdgeInsets.symmetric(horizontal: r.wp(6)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(2), vertical: r.dp(2)),

              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text.rich(
                        style: TextStyle(fontSize: r.fs(1.2, 24)),
                        TextSpan(
                          children: [
                            TextSpan(text: "Peel Stick: ", style: TextStyle(fontWeight: FontWeight.bold, color: blue)),
                            TextSpan(
                              text:
                                  "Práctico y versátil, este accesorio de adhiere fácilmente a cualquier superficie plana, ofreciendo funcionalidad sin comprometer el diseño.",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Image.asset("assets/img/smartbag/4pro/peel.webp")),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(2), vertical: r.dp(2)),
              child: Container(
                padding: EdgeInsets.all(r.dp(2, max: 40)),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Expanded(child: Image.asset("assets/img/smartbag/4pro/valvulas.webp")),

                    Text.rich(
                      style: TextStyle(fontSize: r.fs(1.2, 24)),
                      TextSpan(
                        children: [
                          TextSpan(text: "Válvula: ", style: TextStyle(fontWeight: FontWeight.bold, color: blue)),
                          TextSpan(
                            text:
                                "Diseñada para ofrecer un flujo controlado de aire o producto, la válvula mantiene la frescura y protege el contenido con cada uso.",
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
    );
  }
}
