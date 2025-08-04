import 'dart:ui' as ui;
import 'dart:ui_web';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:webpack/main.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    final blue = Theme.of(context).primaryColor;
    final green = const Color(0xFF4B8D2C);
    final isMobile = r.wp(100) < 850;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              //Video de inicio
              IntroVideoSliver(r: r),

              //Empaques con conciencia
              PackagingWithConscienceSliver(r: r, isMobile: isMobile, blue: blue),

              //El futuro esta en un empaque
              TheFutureSliver(r: r),

              //Por que packvision
              WhyPackvisionSliver(r: r, blue: blue),

              //Video/Foto SmartBag y Ecobag
              SmartAndEcoSliver(r: r, isMobile: isMobile),

              //Productos
              ProductsSliver(r: r, blue: blue, green: green),

              //Servicios
              SliverCarrouselServices(),

              //Sedes
              SliverHeadquarters(r: r, isMobile: isMobile, blue: blue),

              //Footer
              SliverToBoxAdapter(child: Footer()),
            ],
          ),
          //Header
          Header(),
        ],
      ),
    );
  }
}

//---------Inicio con video------------
class IntroVideoSliver extends StatefulWidget {
  const IntroVideoSliver({super.key, required this.r});
  final Responsive r;

  @override
  State<IntroVideoSliver> createState() => _IntroVideoSliverState();
}

class _IntroVideoSliverState extends State<IntroVideoSliver> {
  bool _videoEnded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _videoEnded = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: widget.r.wp(100),
        height: widget.r.hp(100),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: videoBlurNotifier,
              builder: (context, isBlur, _) {
                return VideoFlutter(
                  src: 'assets/videos/paint.webm',
                  blur: isBlur,
                  loop: false,
                  retry: false,
                  onEnded: () => setState(() => _videoEnded = true),
                );
              },
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: _videoEnded ? 1.0 : 0.0,
              child: Container(
                color: Colors.white60,
                alignment: Alignment.center,
                child: Image.asset('assets/img/home/packvision.webp', width: widget.r.wp(70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------Empaques con conciencia------------
class PackagingWithConscienceSliver extends StatefulWidget {
  final Responsive r;
  final bool isMobile;
  final Color blue;
  const PackagingWithConscienceSliver({super.key, required this.r, required this.isMobile, required this.blue});

  @override
  State<PackagingWithConscienceSliver> createState() => _PackagingWithConscienceSliverState();
}

class _PackagingWithConscienceSliverState extends State<PackagingWithConscienceSliver> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> cards = [
    {
      "id": 0,
      "title": "Asesoría",
      "description":
          "Ofrecemos asesoría personalizada y especializada para cada etapa de tu proyecto. Nuestro equipo de expertos te acompaña desde la conceptualización hasta la implementación, brindándote soluciones a medida, soporte constante y recomendaciones estratégicas para que tomes las mejores decisiones y logres tus objetivos con éxito.",
      "image": "assets/img/home/asesoria.webp",
    },
    {
      "id": 1,
      "title": "Calidad",
      "description":
          "Nos comprometemos con los más altos estándares de calidad en cada detalle de nuestros productos y servicios. Cada proceso es cuidadosamente supervisado y controlado para garantizar resultados consistentes, duraderos y a la altura de tus expectativas, porque sabemos que la excelencia marca la diferencia.",
      "image": "assets/img/home/calidad.webp",
    },
    {
      "id": 2,
      "title": "Cumplimiento",
      "description":
          "Sabemos lo importante que es el tiempo para ti y tu negocio, por eso garantizamos cumplimiento puntual en cada entrega. Nuestro compromiso es brindarte confianza y seguridad a través de una planificación eficiente, tiempos claros y un seguimiento riguroso que asegure el respeto por los plazos acordados.",
      "image": "assets/img/home/cumplimiento.webp",
    },
    {
      "id": 3,
      "title": "Servicios",
      "description":
          "Contamos con un portafolio de servicios integrales diseñados para impulsar tu negocio. Desde consultoría técnica y desarrollo de soluciones hasta soporte postventa, trabajamos contigo para ofrecerte un acompañamiento completo, adaptado a tus necesidades y enfocado en el crecimiento sostenible de tus proyectos.",
      "image": "assets/img/home/servicios.webp",
    },
  ];

  int? _expandedIndex;
  late final AnimationController _textAnimationController;
  late final Animation<double> _textFadeAnimation;
  late final Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _textFadeAnimation = CurvedAnimation(parent: _textAnimationController, curve: Curves.easeInOut);
    _textSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(_textFadeAnimation);
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: widget.r.wp(100),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [widget.blue, widget.blue.withAlpha(200)]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: widget.r.hp(5)),
              child: ScrollAnimatedWrapper(
                child: Text(
                  "Empaques con conciencia.",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: widget.r.fs(3, 80)),
                ),
              ),
            ),
            ScrollAnimatedWrapper(child: widget.isMobile ? _buildMobileCards() : _buildDesktopCards()),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileCards() {
    return Column(children: cards.map((card) => _ExpandableCard(card: card, r: widget.r, blue: widget.blue)).toList());
  }

  Widget _buildDesktopCards() {
    final screenWidth = widget.r.wp(100);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.05),
      child: SizedBox(
        height: screenWidth * 0.3,
        child: Stack(
          children: List.generate(cards.length, (index) {
            final card = cards[index];
            final isExpanded = _expandedIndex == index;
            double leftPosition =
                _expandedIndex == null
                    ? index * (screenWidth * 0.21 + screenWidth * 0.012)
                    : isExpanded
                    ? 0
                    : screenWidth * 0.5 + screenWidth * 0.02 + (index - 1) * 20.0;

            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: leftPosition,
              child: AnimatedPositionedCard(
                index: index,
                isAnotherExpanded: _expandedIndex != null && _expandedIndex != index,
                isExpanded: isExpanded,
                screenWidth: screenWidth,
                card: card,
                blue: widget.blue,
                r: widget.r,
                onExpand: () {
                  setState(() {
                    _expandedIndex = index;
                    _textAnimationController.forward(from: 0);
                  });
                },
                onCollapse: () {
                  setState(() {
                    _textAnimationController.reverse();
                    _expandedIndex = null;
                  });
                },
                textFadeAnimation: _textFadeAnimation,
                textSlideAnimation: _textSlideAnimation,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _ExpandableCard extends StatefulWidget {
  final Map<String, dynamic> card;
  final Responsive r;
  final Color blue;

  const _ExpandableCard({required this.card, required this.r, required this.blue});

  @override
  State<_ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<_ExpandableCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(_fade);
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward(from: 0) : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.r.hp(2), horizontal: widget.r.wp(6)),
      child: GestureDetector(
        onTap: _toggle,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,

            height: _isExpanded ? widget.r.hp(40) : widget.r.hp(30),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(child: Image.asset(widget.card['image'], fit: BoxFit.cover)),
                Positioned(
                  top: 16,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(230),
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    child: Text(widget.card['title'], style: const TextStyle(color: Colors.white)),
                  ),
                ),
                if (_isExpanded)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: _fade,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.12, 0.3],
                            colors: [Color.fromARGB(0, 255, 255, 255), Colors.white70, Colors.white],
                          ),
                        ),
                        child: SlideTransition(
                          position: _slide,
                          child: Text(
                            widget.card['description'],
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: _isExpanded ? 0.0 : 0.125, end: _isExpanded ? 0.125 : 0.0),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    builder: (context, turns, child) {
                      return TweenAnimationBuilder<Color?>(
                        tween: ColorTween(begin: _isExpanded ? Colors.white : widget.blue, end: _isExpanded ? widget.blue : Colors.white),
                        duration: const Duration(milliseconds: 400),
                        builder: (context, color, _) {
                          return Transform.rotate(
                            angle: turns * 2 * 3.1416, // turns → radians
                            child: Icon(CupertinoIcons.add_circled_solid, color: color, size: widget.r.dp(3, max: 30)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedPositionedCard extends StatelessWidget {
  final int index;
  final bool isExpanded;
  final bool isAnotherExpanded;
  final double screenWidth;
  final Map<String, dynamic> card;
  final Color blue;
  final Responsive r;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;
  final Animation<double> textFadeAnimation;
  final Animation<Offset> textSlideAnimation;

  const AnimatedPositionedCard({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.isAnotherExpanded,
    required this.screenWidth,
    required this.card,
    required this.onExpand,
    required this.onCollapse,
    required this.textFadeAnimation,
    required this.textSlideAnimation,
    required this.blue,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final double width =
        isExpanded
            ? screenWidth * 0.5
            : isAnotherExpanded
            ? screenWidth * 0.32
            : screenWidth * 0.21;

    final double padding = screenWidth * 0.01;
    final double fontSizeTitle = screenWidth * 0.012;
    final double fontSizeDescription = screenWidth * 0.013;
    final double iconSize = screenWidth * 0.03;

    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      width: width,
      height: screenWidth * 0.3,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Reutilizable y estable
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(card['image'], fit: BoxFit.cover, gaplessPlayback: true, filterQuality: FilterQuality.low),
          ),

          // Título fijo
          Positioned(
            top: 20,
            left: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: fontSizeTitle * 2.5,
                  width: fontSizeTitle * 8,
                  padding: EdgeInsets.only(left: padding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withAlpha(200),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(padding), bottomRight: Radius.circular(padding)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(card['title'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeTitle)),
                  ),
                ),
              ),
            ),
          ),

          // Descripción solo si está expandido
          if (isExpanded)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: textFadeAnimation,
                child: Container(
                  padding: EdgeInsets.only(top: screenWidth * 0.13),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.5, 0.7],
                      colors: [Color.fromARGB(0, 255, 255, 255), Colors.white54, Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: padding + 40, left: padding, top: screenWidth * 0.01, bottom: screenWidth * 0.01),
                    child: SlideTransition(
                      position: textSlideAnimation,
                      child: Text(
                        card['description'],
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: fontSizeDescription, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Botón de acción
          Positioned(
            bottom: 10,
            right: 10,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: isExpanded ? 0.0 : 0.125, end: isExpanded ? 0.125 : 0.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              builder: (context, turns, child) {
                return TweenAnimationBuilder<Color?>(
                  tween: ColorTween(begin: isExpanded ? Colors.white : blue, end: isExpanded ? blue : Colors.white),
                  duration: const Duration(milliseconds: 400),
                  builder: (context, color, _) {
                    return Transform.rotate(
                      angle: turns * 2 * 3.1416, // turns → radians
                      child: IconButton(
                        onPressed: isExpanded ? onCollapse : onExpand,
                        icon: Icon(CupertinoIcons.add_circled_solid, color: color, size: r.dp(5, max: 40)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//---------El futuro esta en el empaque------------
class TheFutureSliver extends StatelessWidget {
  final Responsive r;
  const TheFutureSliver({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(10)),
        child: SizedBox(
          width: 1120,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScrollAnimatedWrapper(child: Image.asset('assets/img/home/home1.webp', width: r.wp(90))),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),

                  child: ScrollAnimatedWrapper(
                    child: Text(
                      "El futuro está en el empaque.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: r.fs(4, 50)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ScrollAnimatedWrapper(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Convierte tu producto en una experiencia inolvidable. Con Packvision, llevas tu marca al siguiente nivel con empaques que combinan innovación, sostenibilidad y diseño de alto impacto. Elige SmartBag si buscas elegancia, funcionalidad y presencia premium en el punto de venta. Opta por EcoBag si tu marca apuesta por lo ecológico, con materiales sostenibles y una menor huella ambiental.",
                      style: TextStyle(fontSize: r.fs(2, 26), height: 1, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//---------Por qué Packvision------------
class WhyPackvisionSliver extends StatelessWidget {
  const WhyPackvisionSliver({super.key, required this.r, required this.blue});

  final Responsive r;
  final ui.Color blue;

  @override
  Widget build(BuildContext context) {
    final items = const [
      (
        icon: CupertinoIcons.car,
        title: "Empaque que trasciende",
        description: "Diseñamos experiencias, no solo empaques. Cada detalle potencia tu producto desde el primer contacto.",
      ),
      (
        icon: CupertinoIcons.cube_box,
        title: "Hecho para lo esencial",
        description: "Cuidamos lo que hace único a tu producto. Protección, aroma, sabor y forma garantizados.",
      ),
      (
        icon: CupertinoIcons.paperplane,
        title: "Pensado para el planeta",
        description: "EcoBag reduce el impacto ambiental con materiales compostables y estructuras sostenibles.",
      ),
      (
        icon: CupertinoIcons.star,
        title: "Diseño sin límites",
        description: "descriptionuras, formas y acabados que hablan por tu marca. Comunica calidad sin decir una palabra.",
      ),
      (
        icon: CupertinoIcons.arrow_2_circlepath,
        title: "Tecnología multicapa",
        description: "SmartBag ofrece hasta 5 capas de protección para frescura, resistencia y elegancia superior.",
      ),
      (
        icon: CupertinoIcons.arrowshape_turn_up_right_fill,
        title: "Listo para alta velocidad",
        description: "Flowpack: solución perfecta para líneas automáticas. Rápido, preciso y visualmente impactante.",
      ),
      (
        icon: CupertinoIcons.doc_on_doc,
        title: "Personalización total",
        description: "Desde válvulas y zipper hasta ventanas y tintas. Tu empaque refleja tu identidad.",
      ),
    ];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScrollAnimatedWrapper(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(3)),
              child: Text("¿Por qué Packvision?", style: TextStyle(color: blue, fontWeight: FontWeight.bold, fontSize: r.dp(3))),
            ),
          ),
          ScrollAnimatedWrapper(child: ScrollWhyPv(r: r, blue: blue, items: items)),
        ],
      ),
    );
  }
}

class ScrollWhyPv extends StatefulWidget {
  const ScrollWhyPv({super.key, required this.r, required this.items, required this.blue});

  final Responsive r;
  final Color blue;
  final List<({String description, IconData icon, String title})> items;

  @override
  State<ScrollWhyPv> createState() => _ScrollWhyPvState();
}

class _ScrollWhyPvState extends State<ScrollWhyPv> {
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
    return Column(
      children: [
        SizedBox(
          height: widget.r.dp(30, max: 550),
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: widget.r.wp(4, max: 20), vertical: widget.r.wp(2)),
            itemCount: widget.items.length,
            separatorBuilder: (_, __) => SizedBox(width: widget.r.wp(2, max: 20)),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? widget.r.wp(6) : 0,
                  right: index == widget.items.length - 1 ? widget.r.wp(6) : 0,
                  bottom: 50,
                ),

                child: Container(
                  width: widget.r.wp(60, max: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 1))],
                  ),
                  padding: EdgeInsets.all(widget.r.dp(2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.icon, color: widget.blue, size: widget.r.dp(10, max: 40)),
                      SizedBox(height: widget.r.hp(1)),
                      Text(item.title, style: TextStyle(fontSize: widget.r.dp(2, max: 30), fontWeight: FontWeight.bold, color: widget.blue)),
                      SizedBox(height: widget.r.hp(1)),
                      Text(item.description, style: TextStyle(fontSize: widget.r.dp(1.4, max: 23), color: Colors.black87)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: widget.r.dp(2, max: 20), horizontal: widget.r.wp(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ArrowButton(
                enabled: canScrollLeft,
                icon: CupertinoIcons.chevron_left,
                onTap: () {
                  _scrollController.animateTo(
                    _scrollController.offset - widget.r.wp(40),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              SizedBox(width: widget.r.wp(1.2)),
              _ArrowButton(
                enabled: canScrollRight,
                icon: CupertinoIcons.chevron_right,
                onTap: () {
                  _scrollController.animateTo(
                    _scrollController.offset + widget.r.wp(40),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ),
      ],
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

//---------SmartBag® y EcoBag®------------
class SmartAndEcoSliver extends StatelessWidget {
  final Responsive r;
  final bool isMobile;
  const SmartAndEcoSliver({super.key, required this.r, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: r.wp(6), vertical: r.dp(5, max: 50)),
        child: ScrollAnimatedWrapper(child: isMobile ? _mobile(r) : _desktop()),
      ),
    );
  }

  Widget _desktop() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: width * 0.3,
          width: width,
          child: Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: videoBlurNotifier,
                  builder: (context, isBlur, _) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
                      child: VideoFlutter(src: 'assets/videos/smartbag/smart1.webm', blur: isBlur, loop: true, showControls: false, fit: BoxFit.fill),
                    );
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: videoBlurNotifier,
                  builder: (context, isBlur, _) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
                      child: VideoFlutter(src: 'assets/videos/ecobag/eco1.webm', blur: isBlur, loop: true, showControls: false, fit: BoxFit.fill),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mobile(Responsive r) {
    return SizedBox(
      height: r.dp(40),
      width: r.dp(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset('assets/img/home/smart.webp', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 3.5),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.asset('assets/img/home/eco.webp', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

//---------Sección de productos SmartBag® y EcoBag®------------
class ProductsSliver extends StatelessWidget {
  final Responsive r;
  final Color green, blue;
  const ProductsSliver({super.key, required this.r, required this.green, required this.blue});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cards = [
      {'title': '4PRO', 'subtitle': 'Variedad de colores.', 'image': 'assets/img/ecobag/4pro.webp', 'isEcobag': true},
      {'title': '5PRO', 'subtitle': 'Evolución para tí.', 'image': 'assets/img/smartbag/5pro.webp', 'isEcobag': false},
      {'title': 'Flowpack', 'subtitle': 'Alto estilo, alta presencia.', 'image': 'assets/img/ecobag/flowpack.webp', 'isEcobag': true},
      {'title': 'Cojín', 'subtitle': 'Compacto y perfecto.', 'image': 'assets/img/smartbag/cojin.webp', 'isEcobag': false},
      {'title': 'DoyPack', 'subtitle': 'No hay mejor selle que este.', 'image': 'assets/img/ecobag/doypack.webp', 'isEcobag': true},
      {'title': 'Accesorios', 'subtitle': 'Válvulas y peel.', 'image': 'assets/img/smartbag/valvula.webp', 'isEcobag': false},
    ];

    final crossAxisCount = r.wp(100) > 800 ? 2 : 1;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: r.wp(100) > 800 ? 1.5 : 1,
        ),
        delegate: SliverChildBuilderDelegate(childCount: cards.length, (context, index) {
          final card = cards[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey, image: DecorationImage(image: AssetImage(card['image']))),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Spacer(),
                    Text(
                      card['title'],
                      style: TextStyle(fontSize: r.dp(4, max: 24), fontWeight: FontWeight.bold, color: card['isEcobag'] == true ? green : blue),
                    ),
                    if (card['isEcobag']) Text("Materiales sostenibles", style: TextStyle(fontSize: r.dp(1, max: 10), color: Color(0xFF4B8D2C))),
                    const SizedBox(height: 8),
                    Text(
                      card['subtitle'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: r.dp(3, max: 20), color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 20),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        children: [
                          _PopupButton(label: 'Conocer', color: card['isEcobag'] == true ? green : blue, routeBase: '', routeSuffix: ''),
                          _PopupButton(
                            label: "Crear mi ${card['title']}",
                            color: card['isEcobag'] == true ? green : blue,
                            routeBase: '',
                            routeSuffix: '',
                            outlined: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PopupButton extends StatefulWidget {
  final String label;
  final String routeBase;
  final String routeSuffix;
  final Color color;
  final bool outlined;

  const _PopupButton({required this.label, required this.routeBase, required this.routeSuffix, required this.color, this.outlined = false});

  @override
  State<_PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<_PopupButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: "",
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        String base;
        if (value == 'ecobag') {
          base = 'EcoBag';
        } else if (value == 'smartbag') {
          base = 'SmartBag';
        } else {
          return;
        }
        final route = '/$base/Explora-$base/${widget.routeBase}${widget.routeSuffix}';
        navigateWithSlide(context, route);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'ecobag',
              child: Row(
                children: const [
                  Icon(CupertinoIcons.tree, color: Color(0xFF4B8D2C)),
                  SizedBox(width: 10),
                  Text('Ecobag', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'smartbag',
              child: Row(
                children: [
                  Icon(CupertinoIcons.lightbulb, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 10),
                  const Text('Smartbag', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovering = true),
        onExit: (_) => setState(() => isHovering = false),
        cursor: SystemMouseCursors.click,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.outlined ? (isHovering ? widget.color : Colors.white) : widget.color,
            ),
            child: Text(
              widget.label,
              style: TextStyle(fontWeight: FontWeight.bold, color: widget.outlined ? (isHovering ? Colors.white : Colors.black) : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//---------Servicios------------
class SliverCarrouselServices extends StatefulWidget {
  const SliverCarrouselServices({super.key});

  @override
  State<SliverCarrouselServices> createState() => _SliverCarrouselServicesState();
}

class _SliverCarrouselServicesState extends State<SliverCarrouselServices> with TickerProviderStateMixin {
  int _currentIndexServices = 0;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<Map<String, String>> services = [
    {'title': 'Publicidad', 'text': 'Campañas visuales que conectan con tu audiencia', 'image': 'assets/img/home/cumplimiento.webp'},
    {'title': 'Fotografía', 'text': 'Capturamos la esencia de tu marca en cada imagen', 'image': 'assets/img/home/cumplimiento.webp'},
    {'title': 'Diseño', 'text': 'Creatividad que comunica y deja huella', 'image': 'assets/img/home/cumplimiento.webp'},
    {'title': 'Modelado 3D', 'text': 'Visualizaciones realistas para productos impactantes', 'image': 'assets/img/home/cumplimiento.webp'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= 1000;

    return SliverToBoxAdapter(
      child: ScrollAnimatedWrapper(
        visibilityKey: const Key('services_carousel'),
        child: CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: services.length,
          options: CarouselOptions(
            height: 600,
            viewportFraction: 0.8,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: false,
            autoPlayCurve: Curves.easeInOut,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() => _currentIndexServices = index);
              _controller
                ..reset()
                ..forward();
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final bool isCenter = index == _currentIndexServices;
            return _ServiceSlideItem(
              list: services[index],
              isCenter: isCenter,
              isWide: isWide,
              fadeAnimation: _fadeAnimation,
              slideAnimation: _slideAnimation,
              onTap: () {
                if (_currentIndexServices != index) {
                  _carouselController.animateToPage(index);
                }
              },
              screenWidth: screenWidth,
            );
          },
        ),
      ),
    );
  }
}

class _ServiceSlideItem extends StatelessWidget {
  final Map<String, String> list;
  final bool isCenter, isWide;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onTap;
  final double screenWidth;

  const _ServiceSlideItem({
    required this.isCenter,
    required this.isWide,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onTap,
    required this.screenWidth,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedOpacity(
                opacity: isCenter ? 1.0 : 0.3,
                duration: const Duration(milliseconds: 500),
                child: Image.asset(list['image']!, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 200,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black54, Colors.transparent]),
                  ),
                ),
              ),
              if (isCenter)
                AnimatedBuilder(
                  animation: fadeAnimation,
                  builder:
                      (context, _) => Positioned(
                        bottom: isWide ? 30 : 40,
                        left: isWide ? 30 : 20,
                        right: 20,
                        child: AnimatedOpacity(
                          opacity: fadeAnimation.value,
                          duration: const Duration(milliseconds: 400),
                          child: Transform.translate(
                            offset: slideAnimation.value * 50,
                            child: isWide ? _buildDesktop(context) : _buildMobile(context),
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

  Column _buildMobile(BuildContext context) {
    return Column(
      children: [
        Text(
          list['text']!,

          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(0, 25), fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(list['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.025).clamp(0, 20))),
          ),
        ),
      ],
    );
  }

  Row _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(list['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.03).clamp(0, 25))),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            list['text']!,
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: (screenWidth * 0.025).clamp(0, 20), fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

//---------Sedes------------
class SliverHeadquarters extends StatelessWidget {
  final Responsive r;
  final bool isMobile;
  final Color blue;
  SliverHeadquarters({super.key, required this.r, required this.isMobile, required this.blue});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardHQ = [
      {
        "img": "assets/img/home/carvajal.webp",
        "name": "Carvajal - Bogotá D.C",
        "latitude": 4.60971,
        "longitude": -74.08175,
        "map":
            "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
      },
      {
        "img": "assets/img/home/norte.webp",
        "name": "Nogal - Bogotá D.C",
        "latitude": 4.6610239150862025,
        "longitude": -74.05414093434182,
        "map":
            "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
      },
      {
        "img": "assets/img/home/mosquera.webp",
        "name": "Mosquera - Cundinamarca",
        "latitude": 4.695486,
        "longitude": -74.190506,
        "map":
            "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
      },
    ];

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(10, max: 50)),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.only(bottom: r.hp(5, max: 20)),
                child: Text("Sedes.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.dp(10, max: 40))),
              ),
            );
          }

          final sede = cardHQ[index - 1];
          return ScrollAnimatedWrapper(
            visibilityKey: Key('headquarter_card_${sede['name']}'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _showHeadquarterDialog(context, sede);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.dp(5, max: 50)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
                    ),
                    child: isMobile ? _buildMobile(sede) : _buildDesktop(sede),
                  ),
                ),
              ),
            ),
          );
        }, childCount: cardHQ.length + 1),
      ),
    );
  }

  Row _buildDesktop(Map<String, dynamic> sede) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sede ${sede['name']}.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.dp(2, max: 30))),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Encuéntranos", style: TextStyle(color: blue, fontSize: r.dp(1.5, max: 20))),
                const SizedBox(width: 5),
                Icon(CupertinoIcons.placemark, color: blue, size: r.dp(1.5, max: 20)),
              ],
            ),
          ],
        ),
        SizedBox(height: 120, child: Image.asset(sede['img'])),
      ],
    );
  }

  Column _buildMobile(Map<String, dynamic> sede) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image.asset(sede['img'])),
        const SizedBox(height: 24),
        Text("${sede['name']}.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.dp(2, max: 30))),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Encuéntranos", style: TextStyle(color: blue, fontSize: r.dp(1.5, max: 20))),
            const SizedBox(width: 5),
            Icon(CupertinoIcons.location, color: blue, size: r.dp(1.5, max: 20)),
          ],
        ),
      ],
    );
  }

  //Cuadro de alerta
  void _showHeadquarterDialog(BuildContext context, Map<String, dynamic> headquarter) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double dialogWidth = screenWidth.clamp(350.0, 700.0);
    final double dialogHeight = screenHeight * 0.85;

    final String viewId = 'iframe-${headquarter['name'].toLowerCase().replaceAll(' ', '-')}';

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: dialogWidth,
                  constraints: BoxConstraints(maxHeight: dialogHeight),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(180),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 10)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 30), // Para simetría
                          Text(
                            "Sede ${headquarter['name']}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(CupertinoIcons.xmark_circle_fill),
                            color: Theme.of(context).primaryColor,
                            iconSize: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: buildHeadquarterIframe(viewId, headquarter['map']))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final Set<String> _registeredViewTypes = {};

  Widget buildHeadquarterIframe(String viewId, String url) {
    if (!_registeredViewTypes.contains(viewId)) {
      platformViewRegistry.registerViewFactory(viewId, (int _) {
        final iframe =
            web.HTMLIFrameElement()
              ..src = url
              ..style.border = 'none'
              ..style.width = '100%'
              ..style.height = '100%'
              ..allowFullscreen = true;

        return iframe;
      });
      _registeredViewTypes.add(viewId);
    }

    return HtmlElementView(viewType: viewId);
  }
}
