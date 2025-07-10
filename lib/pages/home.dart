import 'dart:math' show max, min;
import 'dart:ui' show ImageFilter;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/packwithcon.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/heardquarters.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  final ScrollController _scrollControllerWhyPk = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = true;
  bool _scrollLocked = false; // Start locked for video
  int? _expandedIndex;
  //Cards
  bool isHovering = false;

  // Animation controller for card animations
  late AnimationController _textAnimationController;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  void _updateScrollButtons() {
    final maxScroll = _scrollControllerWhyPk.position.maxScrollExtent;
    final currentScroll = _scrollControllerWhyPk.position.pixels;

    if (mounted) {
      setState(() {
        canScrollLeft = currentScroll > 0;
        canScrollRight = currentScroll < maxScroll;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize animations
    final isMobile = MediaQueryData.fromView(WidgetsBinding.instance.window).size.width < 720;
    _textAnimationController = AnimationController(
      vsync: this,
      duration: isMobile ? const Duration(milliseconds: 500) : const Duration(milliseconds: 420),
    );
    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textAnimationController, curve: isMobile ? Curves.easeInOut : const Interval(0.6, 1.0, curve: Curves.easeInOut)),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOutCubic));

    // Debounce scroll listener to reduce setState calls
    _scrollControllerWhyPk.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollButtons());
    });

    // Unlock scroll after video ends
    Future.delayed(const Duration(milliseconds: 3800), () {
      if (mounted) {
        setState(() => _scrollLocked = false);
      }
    });

    // Update headquarters offset after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _scrollController.dispose();
    _scrollControllerWhyPk.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 720;

    final items = [
      {
        'icon': CupertinoIcons.car,
        'title': "Empaque que trasciende",
        'text': "Diseñamos experiencias, no solo empaques. Cada detalle potencia tu producto desde el primer contacto.",
      },
      {
        'icon': CupertinoIcons.cube_box,
        'title': "Hecho para lo esencial",
        'text': "Cuidamos lo que hace único a tu producto. Protección, aroma, sabor y forma garantizados.",
      },
      {
        'icon': CupertinoIcons.paperplane,
        'title': "Pensado para el planeta",
        'text': "EcoBag reduce el impacto ambiental con materiales compostables y estructuras sostenibles.",
      },
      {
        'icon': CupertinoIcons.star,
        'title': "Diseño sin límites",
        'text': "Texturas, formas y acabados que hablan por tu marca. Comunica calidad sin decir una palabra.",
      },
      {
        'icon': CupertinoIcons.arrow_2_circlepath,
        'title': "Tecnología multicapa",
        'text': "SmartBag ofrece hasta 5 capas de protección para frescura, resistencia y elegancia superior.",
      },
      {
        'icon': CupertinoIcons.arrowshape_turn_up_right_fill,
        'title': "Listo para alta velocidad",
        'text': "Flowpack: solución perfecta para líneas automáticas. Rápido, preciso y visualmente impactante.",
      },
      {
        'icon': CupertinoIcons.doc_on_doc,
        'title': "Personalización total",
        'text': "Desde válvulas y zipper hasta ventanas y tintas. Tu empaque refleja tu identidad.",
      },
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: _scrollLocked ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Hero Section
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: videoBlurNotifier,
                        builder:
                            (context, isBlur, _) => HtmlBackgroundVideo(
                              src: 'assets/assets/videos/paint.webm',
                              blur: isBlur,
                              loop: false,
                              onEnded: () {
                                if (mounted) {
                                  setState(() => _scrollLocked = false);
                                }
                              },
                            ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        opacity: _scrollLocked ? 0 : 1,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(color: Colors.white70, child: Center(child: Image.asset("assets/img/home/Packvision.webp"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Empaques con Conciencia
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.tertiary, Theme.of(context).primaryColor],
                    ),
                  ),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: const Key('Empaques-con-conciencia'),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenWidth * 0.05,
                              top: isMobile ? screenWidth * 0.1 : screenWidth * 0.05,
                              left: screenWidth * 0.06,
                            ),
                            child: Text(
                              "Empaques con conciencia.",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.03, 60)),
                            ),
                          ),
                          isMobile
                              ? Column(
                                children:
                                    cardPWC.map((card) {
                                      final index = cardPWC.indexOf(card);
                                      final isExpanded = _expandedIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          final isExpanded = _expandedIndex == index;
                                          if (isExpanded) {
                                            _textAnimationController.duration = const Duration(milliseconds: 200);
                                            _textAnimationController.reverse().then((_) {
                                              if (mounted) setState(() => _expandedIndex = null);
                                            });
                                          } else {
                                            setState(() {
                                              _expandedIndex = index;
                                              _textAnimationController.duration = const Duration(milliseconds: 400);
                                              _textAnimationController.forward(from: 0);
                                            });
                                          }
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                          width: double.infinity,
                                          height: isExpanded ? screenWidth * 0.95 : screenWidth * 0.6,
                                          margin: const EdgeInsets.only(bottom: 12),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              // Imagen de fondo fuera del rebuild para evitar parpadeo
                                              Positioned.fill(child: Image.asset(card.image, fit: BoxFit.cover)),
                                              Positioned(
                                                top: 16,
                                                left: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor.withAlpha(230),
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(8),
                                                      bottomRight: Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    card.title,
                                                    style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              if (isExpanded)
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: FadeTransition(
                                                    opacity: _textFadeAnimation,
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                                                      decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          stops: [0.0, 0.12, 0.3], // degradado subido
                                                          colors: [Colors.transparent, Colors.white70, Colors.white],
                                                        ),
                                                      ),
                                                      child: SlideTransition(
                                                        position: _textSlideAnimation,
                                                        child: Text(
                                                          card.description,
                                                          style: TextStyle(
                                                            color: Theme.of(context).primaryColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: screenWidth * 0.03,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              Positioned(
                                                bottom: 10,
                                                right: 10,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (isExpanded) {
                                                      _textAnimationController.duration = const Duration(milliseconds: 200);
                                                      _textAnimationController.reverse().then((_) {
                                                        if (mounted) setState(() => _expandedIndex = null);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _expandedIndex = index;
                                                        _textAnimationController.duration = const Duration(milliseconds: 400);
                                                        _textAnimationController.forward(from: 0);
                                                      });
                                                    }
                                                  },
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: Container(
                                                      width: 36,
                                                      height: 36,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: !isExpanded ? Colors.white : Theme.of(context).primaryColor,
                                                      ),
                                                      child: TweenAnimationBuilder<double>(
                                                        key: ValueKey<bool>(isExpanded),
                                                        tween: Tween<double>(begin: 0, end: isExpanded ? 0.785 : 0.0),
                                                        duration: const Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                        builder: (context, angle, _) {
                                                          return Transform.rotate(
                                                            angle: angle,
                                                            child: TweenAnimationBuilder<Color?>(
                                                              tween: ColorTween(
                                                                begin: isExpanded ? Theme.of(context).primaryColor : Colors.white,
                                                                end: isExpanded ? Colors.white : Theme.of(context).primaryColor,
                                                              ),
                                                              duration: const Duration(milliseconds: 300),
                                                              builder: (context, iconColor, _) {
                                                                return Icon(Icons.add_rounded, size: 24, color: iconColor);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              )
                              : Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.05),
                                child: SizedBox(
                                  height: screenWidth * 0.3,
                                  child: Stack(
                                    children:
                                        cardPWC.map((card) {
                                          final index = cardPWC.indexOf(card);
                                          final isExpanded = _expandedIndex == index;
                                          double leftPosition;
                                          if (_expandedIndex == null) {
                                            leftPosition = index * (screenWidth * 0.21 + screenWidth * 0.012);
                                          } else {
                                            leftPosition =
                                                isExpanded ? 0 : screenWidth * 0.5 + screenWidth * 0.02 + (cardPWC.indexOf(card) - 1) * 20.0;
                                          }
                                          return AnimatedPositioned(
                                            duration: const Duration(milliseconds: 300),
                                            left: leftPosition,
                                            child: AnimatedPositionedCard(
                                              index: index,
                                              isAnotherExpanded: _expandedIndex != null && _expandedIndex != index,
                                              isExpanded: isExpanded,
                                              screenWidth: screenWidth,
                                              card: card,
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
                                        }).toList(),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Future Section
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 50),
                  child: Column(
                    children: [
                      ScrollAnimatedWrapper(
                        visibilityKey: const Key('foto-home'),
                        child: Image.asset('assets/img/home/home1.webp', width: min(screenWidth * 0.5, 1120)),
                      ),
                      ScrollAnimatedWrapper(
                        visibilityKey: const Key('foto-home-text'),
                        child: Text(
                          "El futuro está en el empaque.",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.04, 50)),
                        ),
                      ),
                      SizedBox(height: 10),

                      ScrollAnimatedWrapper(
                        visibilityKey: const Key('foto-home-description'),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Convierte tu producto en una experiencia inolvidable. Con Packvision, llevas tu marca al siguiente nivel con empaques que combinan innovación, sostenibilidad y diseño de alto impacto. Elige SmartBag si buscas elegancia, funcionalidad y presencia premium en el punto de venta. Opta por EcoBag si tu marca apuesta por lo ecológico, con materiales sostenibles y una menor huella ambiental.",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.03, 30), height: 1, color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
                // Why Packvision Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScrollAnimatedWrapper(
                      visibilityKey: const Key('porque-pkv'),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 60),
                        child: Text(
                          "¿Por qué Packvision?",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: min(screenWidth * 0.03, 50)),
                        ),
                      ),
                    ),
                    ScrollAnimatedWrapper(
                      visibilityKey: const Key('Contenedores-porque-pv'),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollControllerWhyPk,
                        child: Row(
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            final double horizontalPadding = screenWidth * 0.06;
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? horizontalPadding : 0,
                                right: index == items.length - 1 ? horizontalPadding : 20,
                                bottom: 50,
                              ),
                              child: Container(
                                width: max(350, screenWidth * 0.25), // mínimo 250px
                                height: max(230, screenWidth * 0.15), // mínimo 180px
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(item['icon'] as IconData, size: 40, color: Theme.of(context).primaryColor),
                                    const SizedBox(height: 20),
                                    Text(
                                      item['title'] as String,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: min(screenWidth * 0.032, 23),
                                      ),
                                    ),
                                    SizedBox(height: max(6, screenWidth * 0.006)),
                                    Text(
                                      item['text'] as String,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(color: Colors.black87, fontSize: max(15, screenWidth * 0.0015)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(canScrollLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                            ),
                            onPressed:
                                canScrollLeft
                                    ? () => _scrollControllerWhyPk.animateTo(
                                      _scrollControllerWhyPk.offset - 450,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    )
                                    : null,
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(canScrollRight ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                            ),
                            onPressed:
                                canScrollRight
                                    ? () => _scrollControllerWhyPk.animateTo(
                                      _scrollControllerWhyPk.offset + 450,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    )
                                    : null,
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ), // Placeholder Section
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: max(20, screenWidth * 0.01)),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: const Key('contenedores-foto-home'),
                    child: SizedBox(
                      height: isMobile ? null : screenWidth * 0.26,
                      child:
                          isMobile
                              ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildImage('assets/img/home/smart.webp', const BorderRadius.vertical(top: Radius.circular(24)), isMobile: true),
                                  const SizedBox(height: 3.5),
                                  _buildImage('assets/img/home/eco.webp', const BorderRadius.vertical(bottom: Radius.circular(24)), isMobile: true),
                                ],
                              )
                              : LayoutBuilder(
                                builder: (context, constraints) {
                                  final width = constraints.maxWidth;

                                  return SizedBox(
                                    width: width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ValueListenableBuilder<bool>(
                                            valueListenable: videoBlurNotifier,
                                            builder: (context, isBlur, _) {
                                              return ClipRRect(
                                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
                                                child: HtmlBackgroundVideo(
                                                  src: 'assets/videos/smartbag/smart1.webm',
                                                  blur: isBlur,
                                                  loop: true,
                                                  showControls: false,
                                                  isPause: false,
                                                  fit: BoxFit.fill,
                                                ),
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
                                                child: HtmlBackgroundVideo(
                                                  src: 'assets/videos/ecobag/eco1.webm',
                                                  blur: isBlur,
                                                  loop: true,
                                                  showControls: false,
                                                  isPause: false,
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                    ),
                  ),
                ),

                // Product Grid Section
                Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 800;
                      final crossAxisCount = isWide ? 2 : 1;
                      final cards = [
                        {
                          'title': '4PRO',
                          'subtitle': 'Variedad de colores.',
                          'image': 'assets/img/ecobag/4pro.webp',
                          'color1': const Color.fromARGB(210, 252, 252, 252),
                          'color2': const Color.fromARGB(255, 220, 248, 208),
                          'isEcobag': true,
                        },
                        {
                          'title': '5PRO',
                          'subtitle': 'Evolución para tí.',
                          'image': 'assets/img/smartbag/5pro.webp',

                          'color1': const Color.fromARGB(210, 252, 252, 252),
                          'color2': const Color.fromARGB(255, 208, 224, 248),
                          'isEcobag': false,
                        },
                        {
                          'title': 'Flowpack',
                          'subtitle': 'Alto estilo, alta presencia.',
                          'image': 'assets/img/ecobag/flowpack.webp',
                          'color1': const Color.fromARGB(210, 252, 252, 252),
                          'color2': const Color.fromARGB(255, 220, 248, 208),
                          'isEcobag': true,
                        },
                        {
                          'title': 'Cojín',
                          'subtitle': 'Compacto y perfecto.',
                          'image': 'assets/img/smartbag/cojin.webp',
                          'color1': const Color.fromARGB(210, 252, 252, 252),
                          'color2': const Color.fromARGB(255, 208, 224, 248),
                          'isEcobag': false,
                        },
                        {
                          'title': 'DoyPack',
                          'subtitle': 'No hay mejor selle que este.',
                          'image': 'assets/img/ecobag/doypack.webp',

                          'color1': const Color.fromARGB(210, 252, 252, 252),
                          'color2': const Color.fromARGB(255, 220, 248, 208),
                          'isEcobag': true,
                        },

                        {
                          'title': 'Accesorios',
                          'subtitle': 'Válvulas y peel.',
                          'image': 'assets/img/smartbag/valvula.webp',

                          'color1': const Color.fromARGB(210, 252, 252, 252),
                          'color2': const Color.fromARGB(255, 208, 224, 248),
                          'isEcobag': false,
                        },
                      ];

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cards.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: isWide ? 1.5 : 1,
                        ),
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [(card['color1'] as Color).withAlpha(120), (card['color2'] as Color).withAlpha(120)],
                                  ),
                                ),
                                child: ScrollAnimatedWrapper(
                                  visibilityKey: Key('conocer-cotizar-${card['title']! as String}'),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 8),
                                      Expanded(child: Image.asset(card['image']! as String, fit: BoxFit.cover)),
                                      Text(
                                        card['title']! as String,
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: card['isEcobag'] == true ? const Color.fromARGB(255, 75, 141, 44) : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      if (card['isEcobag'] == true)
                                        const Text("Materiales sostenibles", style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 75, 141, 44))),
                                      const SizedBox(height: 8),
                                      Text(
                                        card['subtitle']! as String,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: min(screenWidth * 0.025, 22), color: Colors.black87, fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            PopupMenuButton<String>(
                                              tooltip: "",
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              elevation: 8,
                                              color: Colors.white,
                                              onSelected: (value) {
                                                String base;
                                                if (value == 'ecobag') {
                                                  base = 'EcoBag';
                                                } else if (value == 'smartbag') {
                                                  base = 'SmartBag';
                                                } else {
                                                  return; // por si acaso
                                                }

                                                final route = '/$base/Explora-$base/${card['title']}';
                                                navigateWithSlide(context, route); // tu función personalizada
                                              },
                                              itemBuilder:
                                                  (context) => [
                                                    PopupMenuItem(
                                                      value: 'ecobag',
                                                      child: Row(
                                                        children: const [
                                                          Icon(CupertinoIcons.tree, color: Color.fromARGB(255, 75, 141, 44)),
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
                                                          SizedBox(width: 10),
                                                          Text('Smartbag', style: TextStyle(fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],

                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(16),

                                                  child: Material(
                                                    elevation: 4,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            card['isEcobag'] == true
                                                                ? const Color.fromARGB(255, 75, 141, 44)
                                                                : Theme.of(context).primaryColor,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                                                        child: Text("Conocer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            PopupMenuButton<String>(
                                              tooltip: "",
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              elevation: 8,
                                              color: Colors.white,

                                              onSelected: (value) {
                                                String base;
                                                if (value == 'ecobag') {
                                                  base = 'EcoBag';
                                                } else if (value == 'smartbag') {
                                                  base = 'SmartBag';
                                                } else {
                                                  return; // por si acaso
                                                }

                                                final route = '/$base/Explora-$base/${card['title']}/crea-tu-empaque';
                                                navigateWithSlide(context, route); // tu función personalizada
                                              },
                                              itemBuilder:
                                                  (context) => [
                                                    PopupMenuItem(
                                                      value: 'ecobag',
                                                      child: Row(
                                                        children: const [
                                                          Icon(CupertinoIcons.tree, color: Color.fromARGB(255, 75, 141, 44)),
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
                                                          SizedBox(width: 10),
                                                          Text('Smartbag', style: TextStyle(fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],

                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  return MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    onEnter: (_) => setState(() => isHovering = true),
                                                    onExit: (_) => setState(() => isHovering = false),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(16),
                                                      child: Material(
                                                        elevation: 4,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16),
                                                            border: Border.all(
                                                              color:
                                                                  isHovering == true
                                                                      ? (card['isEcobag'] == true
                                                                          ? const Color.fromARGB(255, 101, 192, 59)
                                                                          : Theme.of(context).colorScheme.primary)
                                                                      : Colors.black,
                                                            ),
                                                            color:
                                                                isHovering == true
                                                                    ? (card['isEcobag'] == true
                                                                        ? const Color.fromARGB(255, 75, 141, 44)
                                                                        : Theme.of(context).primaryColor)
                                                                    : Colors.white,
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 22),
                                                            child: Text(
                                                              "Crear mi ${card['title']}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                color: isHovering == true ? Colors.white : Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
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
                        },
                      );
                    },
                  ),
                ),
                //Carrousel Servicios
                ScrollAnimatedWrapper(visibilityKey: Key('Carrousel-services'), child: CarrouselServices()),
                // Headquarters Section
                Container(width: screenWidth, decoration: const BoxDecoration(color: Colors.white), child: Headquarters()),
                // Footer
                const Footer(),
              ],
            ),
          ),
          const Header(),
        ],
      ),
    );
  }
}

class AnimatedPositionedCard extends StatelessWidget {
  final int index;
  final bool isExpanded;
  final bool isAnotherExpanded;
  final double screenWidth;
  final CardPackWithConscience card;
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
  });

  @override
  Widget build(BuildContext context) {
    final double width =
        isExpanded
            ? screenWidth * 0.5
            : isAnotherExpanded
            ? screenWidth *
                0.32 // colapsadas más anchas si otra está expandida
            : screenWidth * 0.21;

    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      width: width,
      height: screenWidth * 0.3,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(card.image, fit: BoxFit.cover)),
          Positioned(
            top: 20,
            left: 0,
            child: Container(
              height: screenWidth * 0.03,
              width: screenWidth * 0.10,
              padding: EdgeInsets.only(left: screenWidth * 0.01),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(200),
                borderRadius: BorderRadius.only(topRight: Radius.circular(screenWidth * 0.01), bottomRight: Radius.circular(screenWidth * 0.01)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(card.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: screenWidth * 0.012)),
              ),
            ),
          ),
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
                      colors: [Colors.transparent, Colors.white70, Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.01, left: screenWidth * 0.01, right: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeTransition(
                          opacity: textFadeAnimation,
                          child: SlideTransition(
                            position: textSlideAnimation,
                            child: Text(
                              card.description,
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: screenWidth * 0.013, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: screenWidth * 0.005,
            right: screenWidth * 0.005,
            child: TweenAnimationBuilder<double>(
              key: ValueKey<bool>(isExpanded),
              tween: Tween<double>(begin: 0, end: isExpanded ? 0.785 : 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (context, angle, _) {
                return Transform.rotate(
                  angle: angle,
                  child: IconButton(
                    onPressed: isExpanded ? onCollapse : onExpand,
                    icon: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: isExpanded ? Colors.white : Theme.of(context).primaryColor,
                        end: isExpanded ? Theme.of(context).primaryColor : Colors.white,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, color, _) {
                        return Icon(CupertinoIcons.add_circled_solid, color: color, size: screenWidth * 0.03);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildImage(String path, BorderRadius borderRadius, {bool isMobile = false}) {
  final child = ClipRRect(borderRadius: borderRadius, child: Image.asset(path, fit: BoxFit.cover));

  return isMobile ? Flexible(fit: FlexFit.loose, child: child) : Expanded(child: child);
}

class CarrouselServices extends StatefulWidget {
  const CarrouselServices({super.key});

  @override
  State<CarrouselServices> createState() => _CarrouselServicesState();
}

class _CarrouselServicesState extends State<CarrouselServices> with TickerProviderStateMixin {
  int _currentIndexServices = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 700)); // Increased duration for smoother animation
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut); // Smoother fade curve
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 2.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)); // Adjusted start position and curve
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: 4,
        options: CarouselOptions(
          height: 600,
          enlargeCenterPage: false,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.easeInOut,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndexServices = index;
            });
            _controller.reset();
            _controller.forward();
          },
        ),
        itemBuilder: (context, index, realIndex) {
          final imageUrls = [
            'assets/img/home/cumplimiento.webp',
            'assets/img/home/cumplimiento.webp',
            'assets/img/home/cumplimiento.webp',
            'assets/img/home/cumplimiento.webp',
          ];
          bool isCenter = index == _currentIndexServices;
          final titles = ['Publicidad', 'Fotografía', 'Diseño', 'Modelado 3D'];
          final texts = [
            'Campañas visuales que conectan con tu audiencia',
            'Capturamos la esencia de tu marca en cada imagen',
            'Creatividad que comunica y deja huella',
            'Visualizaciones realistas para productos impactantes',
          ]; // Different text for each image
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: const Color.fromARGB(255, 205, 205, 205)),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                  },
                  child: Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: isCenter ? 1.0 : 0.3,
                        duration: Duration(milliseconds: 500),
                        child: Image.network(imageUrls[index % imageUrls.length], fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Colors.transparent],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final isWide = MediaQuery.of(context).size.width >= 1000;
                          return Positioned(
                            bottom: isWide ? 30 : 40,
                            left: isWide ? 30 : 20,
                            right: 20,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity: isCenter ? _fadeAnimation.value : 0.0,
                              child: Transform.translate(
                                offset: _slideAnimation.value * (isCenter ? 50 : 0),
                                child:
                                    isWide
                                        ? Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Theme.of(context).primaryColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5),
                                                child: Text(
                                                  titles[index % titles.length],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: min(MediaQuery.of(context).size.width * 0.03, 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              // para que el texto tenga espacio y pueda hacer wrap
                                              child: Text(
                                                texts[index % texts.length],
                                                maxLines: 2,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: min(MediaQuery.of(context).size.width * 0.025, 20),

                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        : Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              texts[index % texts.length],
                                              maxLines: 2,
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: min(MediaQuery.of(context).size.width * 0.03, 25),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Theme.of(context).primaryColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5),
                                                child: Text(
                                                  titles[index % titles.length],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: min(MediaQuery.of(context).size.width * 0.025, 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
