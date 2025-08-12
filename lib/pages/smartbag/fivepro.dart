import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class FivePro extends StatelessWidget {
  final Responsive r;
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;
  const FivePro({super.key, required this.currentRoute, required this.subcategorie, required this.section, required this.r});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final blue = Theme.of(context).primaryColor;
    final isMobile = r.wp(100) < 850;
    final route = '${subcategorie.route}/crea-tu-empaque';

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              IntroSliver(r: r, blue: blue, isMobile: isMobile, route: route),

              Our5PROSliver(r: r, blue: blue, isMobile: isMobile),
              ValveFunctionSliver(r: r, blue: blue, isMobile: isMobile),
              MoreInformation5PROSliver(r: r, blue: blue, isMobile: isMobile),
              GreatSolutionsSliver(r: r, blue: blue, isMobile: isMobile),
              StandOutSliver(r: r, blue: blue, isMobile: isMobile),
              UndecidedSliver(r: r, isMobile: isMobile),
              End5PROSliver(blue: blue, route: route, r: r),
            ],
          ),
        ],
      ),
    );
  }
}

//---------Inicio de la pantalla en 5PRO------------

class IntroSliver extends StatelessWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;
  final String route;
  const IntroSliver({super.key, required this.blue, required this.isMobile, required this.route, required this.r});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: r.hp(100),
        width: r.wp(100),
        child: Stack(
          children: [
            Positioned(
              bottom: 180,
              right: -100,
              child: Transform.rotate(
                angle: math.pi * 1.5,
                child: ScrollAnimatedWrapper(
                  child: Stack(
                    children: [
                      Text(
                        "5PRO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: r.fs(60, 120),
                          height: 0,
                          foreground:
                              Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = blue.withAlpha(60),
                        ),
                      ),
                      Text(
                        "5PRO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(0, 255, 255, 255),
                          fontSize: r.fs(60, 120),
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isMobile
                ? Padding(
                  padding: EdgeInsets.only(top: 45, left: r.wp(6), right: r.wp(6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScrollAnimatedWrapper(
                        child: Text(
                          "5PRO",
                          textAlign: TextAlign.justify,
                          style: TextStyle(height: 0, fontSize: r.fs(20, 120), color: blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ScrollAnimatedWrapper(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "5 Soluciones para tí",
                            textAlign: TextAlign.justify,
                            style: TextStyle(height: 0, fontSize: r.fs(2.4, 30), color: blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      ScrollAnimatedWrapper(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: r.hp(2, max: 30)),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white), backgroundColor: WidgetStatePropertyAll(blue)),
                            child: Text("Crear mi 5PRO", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      ScrollAnimatedWrapper(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: r.hp(3)),

                          child: Text(
                            "Cinco formas de ver, crear, sentir, conectar y transformar el mundo.",
                            style: TextStyle(height: 0.99, fontWeight: FontWeight.bold, fontSize: r.fs(2.4, 28)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(child: ScrollAnimatedWrapper(child: Image.asset("img/smartbag/5pro/5proStart.webp", fit: BoxFit.contain))),
                      ),
                    ],
                  ),
                )
                : Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 60, left: r.wp(6)),
                          width: 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ScrollAnimatedWrapper(
                                child: Text(
                                  "5PRO",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(height: 0, fontSize: r.fs(40, 160), color: blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                              ScrollAnimatedWrapper(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    "5 Soluciones para tí",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(height: 0, fontSize: r.fs(5, 40), color: blue, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              ScrollAnimatedWrapper(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  width: 420,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          navigateWithSlide(context, route);
                                        },
                                        style: ButtonStyle(
                                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                                          backgroundColor: WidgetStatePropertyAll(blue),
                                        ),
                                        child: Text("Crear mi 5PRO", style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Cinco formas de ver, crear, sentir, conectar y transformar el mundo.",
                                          style: TextStyle(height: 0.99, fontWeight: FontWeight.bold, fontSize: r.fs(1.2, 20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IgnorePointer(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: r.wp(10)),
                          child: SizedBox(
                            width: r.hp(100),
                            height: r.hp(100),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return VideoFlutter(src: "assets/videos/smartbag/5pro/inicio.webm", fit: BoxFit.fitHeight, loop: false, blur: isBlur);
                              },
                            ),
                          ),
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

//---------Fila con la información de 5PRO------------

class Our5PROSliver extends StatefulWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;
  const Our5PROSliver({super.key, required this.r, required this.blue, required this.isMobile});

  @override
  State<Our5PROSliver> createState() => _Our5PROSliverState();
}

class _Our5PROSliverState extends State<Our5PROSliver> {
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
            ? widget.r.wp(100) *
                0.7 // más ancho en mobile
            : (widget.r.wp(100) * 0.8).clamp(0, 1000);

    final double cardHeight =
        widget.isMobile
            ? widget.r.wp(100) *
                0.9 // cuadrado en mobile
            : (widget.r.wp(100) * 0.5).clamp(0, 500);

    final List<Map<String, dynamic>> nuestra5pro = [
      {
        'text': 'Protección superior \npara todo tipo de producto',
        'image': 'img/smartbag/5pro/cardLarge1.webp',

        'TextStyle': TextStyle(color: Colors.grey[100], fontSize: widget.r.fs(1.4, 26), fontWeight: FontWeight.bold),
        'alignment': Alignment.topLeft,

        'textAlign': null,
      },
      {
        'text': 'Empaque que se destaca \nen cualquier entorno',
        'image': 'img/smartbag/5pro/cardLarge2.webp',

        'TextStyle': TextStyle(
          color: Colors.white,
          fontSize: widget.r.fs(1.4, 26),
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 8.0, color: Colors.black.withAlpha(200), offset: Offset(2, 2))],
        ),
        'alignment': Alignment.centerLeft,
        'textAlign': TextAlign.left,
      },
      {
        'text': 'Materiales sostenibles \ny compromiso ecológico',
        'image': 'img/smartbag/5pro/cardLarge3.webp',

        'TextStyle': TextStyle(
          color: Colors.white,
          fontSize: widget.r.fs(1.4, 26),
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 8.0, color: Colors.black.withAlpha(130), offset: Offset(2, 2))],
        ),
        'alignment': Alignment.topCenter,
        'textAlign': TextAlign.center,
      },
      {
        'text': 'Tecnología de sellado \ny cierre avanzada',
        'image': 'img/smartbag/5pro/cardLarge4.webp',

        'TextStyle': TextStyle(color: Colors.black, fontSize: widget.r.fs(1.4, 26), fontWeight: FontWeight.bold),
        'alignment': Alignment.bottomLeft,
        'textAlign': null,
      },
      {
        'text': 'Adaptabilidad total: múltiples \nformatos y capacidades',
        'image': 'img/smartbag/5pro/cardLarge5.webp',
        'TextStyle': TextStyle(color: Colors.black, fontSize: widget.r.fs(1.4, 26), fontWeight: FontWeight.bold),
        'alignment': Alignment.topLeft,
        'textAlign': null,
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: widget.r.wp(100),
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
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 30 : 45, horizontal: widget.r.wp(6)),
                child: Text("Nuestra 5PRO.", style: TextStyle(fontSize: widget.r.fs(5, 50), fontWeight: FontWeight.bold, color: widget.blue)),
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(nuestra5pro.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? widget.r.wp(6) : 0, right: index == 4 ? widget.r.wp(6) : 20, bottom: 50, top: 50),
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(50, 50, 105, 0.15), blurRadius: 5, spreadRadius: 0, offset: Offset(0, 2)),
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 1, spreadRadius: 0, offset: Offset(0, 1)),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(nuestra5pro[index]['image'], fit: BoxFit.cover, filterQuality: FilterQuality.high),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: nuestra5pro[index]["alignment"],
                                child: Text(
                                  nuestra5pro[index]["text"],
                                  textAlign: nuestra5pro[index]["textAlign"],
                                  style: nuestra5pro[index]["TextStyle"],
                                ),
                              ),
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
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ArrowButton(
                    enabled: canScrollLeft,
                    icon: CupertinoIcons.chevron_left,
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - (widget.r.wp(60) * 0.6),
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
                        _scrollController.offset + (widget.r.wp(60) * 0.6),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),

            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: widget.isMobile ? 30 : 60),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "No solo es 5,\nes 5PRO.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: widget.r.fs(5, 50)),
                  ),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Padding(padding: EdgeInsets.only(bottom: 20), child: widget.isMobile ? _buildMobile(context) : AnimatedCardDeck()),
            ),
            //cards
          ],
        ),
      ),
    );
  }

  Padding _buildMobile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Image.asset("img/smartbag/5pro/cardshort1.webp", fit: BoxFit.contain)),
                  Expanded(child: Image.asset("img/smartbag/5pro/cardshort2.webp", fit: BoxFit.contain)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Image.asset("img/smartbag/5pro/cardshort3.webp", fit: BoxFit.contain)),
                  Expanded(child: Image.asset("img/smartbag/5pro/cardshort4.webp", fit: BoxFit.contain)),
                ],
              ),
              SizedBox(height: 10),

              Image.asset("img/smartbag/5pro/cardshort5.webp", fit: BoxFit.contain),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: widget.r.wp(8, max: 50)),
            child: Text.rich(
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black.withAlpha(200), fontSize: widget.r.fs(1.9, 26), fontWeight: FontWeight.bold),
              TextSpan(
                children: [
                  TextSpan(text: 'Diseño que comunica', style: TextStyle(color: widget.blue)),
                  TextSpan(text: ', una gran '),
                  TextSpan(text: 'Estructura protectora', style: TextStyle(color: widget.blue)),
                  TextSpan(text: ' que conserva, y una '),
                  TextSpan(text: 'Sostenibilidad real', style: TextStyle(color: widget.blue)),
                  TextSpan(text: ' que respalda tu compromiso ambiental.\n\n'),
                  TextSpan(text: 'Con '),
                  TextSpan(text: 'Versatilidad de formatos', style: TextStyle(color: widget.blue)),
                  TextSpan(text: ' y una '),
                  TextSpan(text: 'Tecnología de 5 selles', style: TextStyle(color: widget.blue)),
                  TextSpan(text: ', 5PRO se adapta a cada necesidad.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButtonContinue extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _ArrowButtonContinue({required this.enabled, required this.onPrevious, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color.fromARGB(31, 158, 158, 158)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              onPressed: enabled ? onPrevious : null,
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[600]),
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(enabled ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80))),
            ),
            IconButton(
              alignment: Alignment.centerRight,
              onPressed: enabled ? onNext : null,
              icon: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(enabled ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80))),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCardDeck extends StatefulWidget {
  const AnimatedCardDeck({super.key});

  @override
  State<AnimatedCardDeck> createState() => _AnimatedCardDeckState();
}

class _AnimatedCardDeckState extends State<AnimatedCardDeck> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'image': 'img/smartbag/5pro/cardshort1.webp',
      'text': 'Diseño que comunica',
      'info':
          'Un empaque atractivo transmite la personalidad de tu marca y capta la atención en segundos. Nuestro diseño está pensado para conectar con tu cliente desde el primer vistazo.',
    },
    {
      'id': 2,
      'image': 'img/smartbag/5pro/cardshort2.webp',
      'text': 'Estructura protectora',
      'info':
          'La estructura multicapa protege tu producto de la humedad, el oxígeno y la luz, alargando su vida útil y manteniéndolo en óptimas condiciones.',
    },
    {
      'id': 3,
      'image': 'img/smartbag/5pro/cardshort3.webp',
      'text': 'Sostenibilidad real',
      'info':
          'Usamos materiales reciclables y procesos eficientes para reducir el impacto ambiental, sin comprometer la calidad ni la funcionalidad del empaque.',
    },
    {
      'id': 4,
      'image': 'img/smartbag/5pro/cardshort4.webp',
      'text': 'Versatilidad de formatos',
      'info':
          'Ofrecemos múltiples presentaciones: doypack, sachet, bottom, 4 sellos, con zipper, válvula o ventana. Adaptamos el empaque a tu producto y tu mercado.',
    },
    {
      'id': 5,
      'image': 'img/smartbag/5pro/cardshort5.webp',
      'text': 'Tecnología 5 capas',
      'info':
          'Nuestro sistema de 5 capas combina materiales de alta barrera que brindan máxima resistencia, sellado perfecto y una excelente presentación en góndola.',
    },
  ];

  late Timer _timer;
  int currentIndex = 0;
  int? currentCenterId;
  bool _isTransitioning = false;
  bool _isCenterExiting = false;
  bool _isMovingBackward = false;

  @override
  void initState() {
    super.initState();
    currentCenterId = items[currentIndex]['id'];
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      if (!_isTransitioning) {
        _moveToNextCard();
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _startAutoSlide();
  }

  void _moveToNextCard() async {
    if (_isTransitioning) return;
    _isTransitioning = true;
    _isMovingBackward = false;

    int nextCenterIndex = (currentIndex + 1) % items.length;

    setState(() {
      _isCenterExiting = true;
    });

    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      _isCenterExiting = false;
      currentIndex = nextCenterIndex;
      currentCenterId = items[currentIndex]['id'];
    });

    _isTransitioning = false;
    _resetTimer(); // Reinicia el temporizador después de cada transición
  }

  void _moveToPreviousCard() async {
    if (_isTransitioning) return;
    _isTransitioning = true;
    _isMovingBackward = true;

    int previousCenterIndex = (currentIndex - 1 + items.length) % items.length;

    setState(() {
      _isCenterExiting = true;
    });

    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      _isCenterExiting = false;
      currentIndex = previousCenterIndex;
      currentCenterId = items[currentIndex]['id'];
    });

    _isTransitioning = false;
    _resetTimer(); // Reinicia el temporizador después de cada transición
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 500;
    final double cardHeight = 600;
    final double centerX = MediaQuery.of(context).size.width / 2 - cardWidth / 2;

    final positions = [
      {'left': centerX, 'top': 0.0, 'scale': 1.0, 'opacity': 1.0}, // Centro arriba (frente)
      {'left': centerX + 200, 'top': 0.0, 'scale': 0.9, 'opacity': .2}, // Derecha cercana
      {'left': centerX + 300, 'top': 0.0, 'scale': 0.7, 'opacity': .001}, // Derecha lejana
      {'left': centerX - 300, 'top': 0.0, 'scale': 0.7, 'opacity': .001}, // Izquierda lejana
      {'left': centerX - 200, 'top': 0.0, 'scale': 0.9, 'opacity': .2}, // Izquierda cercana
    ];

    final Map<int, int> zIndexOrder = {
      0: 5, // centro
      1: 4, // derecha cercana
      4: 3, // izquierda cercana
      2: 2, // derecha lejana
      3: 1, // izquierda lejana
    };

    final List<Map<String, dynamic>> cards = [];
    for (int i = 0; i < items.length; i++) {
      int posIndex = (i - currentIndex + items.length) % items.length;
      int displayPosIndex;
      switch (posIndex) {
        case 0:
          displayPosIndex = 0; // Centro
          break;
        case 1:
          displayPosIndex = 1; // Derecha cercana
          break;
        case 2:
          displayPosIndex = 2; // Derecha lejana
          break;
        case 3:
          displayPosIndex = 3; // Izquierda lejana
          break;
        case 4:
          displayPosIndex = 4; // Izquierda cercana
          break;
        default:
          displayPosIndex = 3; // Por defecto lejana izquierda
      }
      var pos = positions[displayPosIndex];

      if (_isCenterExiting && posIndex == 0) {
        pos = {
          'left': _isMovingBackward ? centerX + 450 : centerX - 450, // Derecha si retrocede, izquierda si avanza
          'top': 10.0, // Sube un poco para simular movimiento curvo
          'scale': 0.9,
          'opacity': 1.0,
        };
      }

      double targetOpacity = pos['opacity']!;

      final card = AnimatedPositioned(
        key: ValueKey(items[i]['id']),
        duration: Duration(milliseconds: displayPosIndex == 0 ? (_isCenterExiting ? 800 : 1000) : 1000),
        curve: Curves.easeInOut,
        top: pos['top']!,
        left: pos['left']!,
        child: AnimatedScale(
          duration: const Duration(seconds: 1),
          scale: pos['scale']!,
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: displayPosIndex == 0 ? 1000 : 800),
            opacity: targetOpacity,
            curve: Curves.easeInOut,
            child: IgnorePointer(
              ignoring: displayPosIndex != 0,
              child: _buildCard(items[i]['text'], items[i]['info'], cardWidth, cardHeight, displayPosIndex == 0),
            ),
          ),
        ),
      );

      cards.add({'widget': card, 'z': zIndexOrder[displayPosIndex]!});
    }
    cards.sort((a, b) => a['z'].compareTo(b['z']));

    return SizedBox(
      width: double.infinity,
      height: 1000,
      child: Column(
        children: [
          SizedBox(height: 650, child: Stack(clipBehavior: Clip.none, children: cards.map<Widget>((e) => e['widget'] as Widget).toList())),
          const SizedBox(height: 0),
          _ArrowButtonContinue(enabled: true, onPrevious: _moveToPreviousCard, onNext: _moveToNextCard),
        ],
      ),
    );
  }

  Widget _buildCard(String text, String info, double width, double height, bool isCenter) {
    final widthText = MediaQuery.of(context).size.width;

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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(items.firstWhere((e) => e['text'] == text)['image'], fit: BoxFit.cover, height: 300, width: double.infinity),
              ),
              const SizedBox(height: 30),
              Text(
                text,
                style: TextStyle(fontSize: (widthText * 0.03).clamp(20, 26), fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                info,
                style: TextStyle(fontSize: (widthText * 0.02).clamp(15, 22), fontWeight: FontWeight.bold, height: 0.9, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------Información acerca de la valvula------------
class ValveFunctionSliver extends StatelessWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;
  const ValveFunctionSliver({super.key, required this.r, required this.blue, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: r.wp(100),
        padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Text("Valvula integrada", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54, fontSize: r.fs(1.8, 28))),
            ),
            SizedBox(height: 10),
            ScrollAnimatedWrapper(
              child: Text(
                "Tan funcional que parece tener vida propia.",
                style: TextStyle(fontWeight: FontWeight.w600, color: blue, fontSize: r.fs(5, 50)),
              ),
            ),

            ScrollAnimatedWrapper(
              child: Container(
                padding: EdgeInsets.only(top: 40),
                width: r.wp(90),
                height: r.wp(90, max: 600),
                child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset("img/smartbag/5pro/large.webp", fit: BoxFit.cover)),
              ),
            ),
            ScrollAnimatedWrapper(child: isMobile ? _buildMobile() : _builldDesktop(context)),
          ],
        ),
      ),
    );
  }

  SizedBox _builldDesktop(BuildContext context) {
    return SizedBox(
      height: r.hp(60),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: r.fs(1.6, 24), fontWeight: FontWeight.w800, color: Colors.black.withAlpha(160), height: 1.5),
              TextSpan(
                children: [
                  TextSpan(text: "La precisión de una válvula. Integrada sin esfuerzo. "),
                  TextSpan(text: "La válvula de desgasificación ", style: TextStyle(color: blue)),
                  TextSpan(
                    text:
                        "de 5PRO permite que el empaque libere gases internos sin comprometer el contenido, ideal para productos como café o granos recién tostados. Este pequeño componente evita la acumulación de presión, alarga la vida útil y mantiene la experiencia sensorial intacta. Un sistema discreto, automático y seguro, que convierte a la 5PRO en un empaque inteligente, pensado para productos que respiran.",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: videoBlurNotifier,
              builder: (context, isBlur, _) {
                return VideoFlutter(
                  src: 'assets/videos/smartbag/5pro/rotacion_5pro.webm',
                  blur: isBlur,
                  loop: false,
                  showControls: false,
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildMobile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Text.rich(
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: r.fs(1.7, 22), fontWeight: FontWeight.w600, color: Colors.black.withAlpha(160)),
        TextSpan(
          children: [
            TextSpan(text: "La precisión de una válvula. Integrada sin esfuerzo. "),
            TextSpan(text: "La válvula de desgasificación ", style: TextStyle(color: blue, fontWeight: FontWeight.w800)),
            TextSpan(
              text:
                  "de 5PRO permite que el empaque libere gases internos sin comprometer el contenido, ideal para productos como café o granos recién tostados. Este pequeño componente evita la acumulación de presión, alarga la vida útil y mantiene la experiencia sensorial intacta. Un sistema discreto, automático y seguro, que convierte a la 5PRO en un empaque inteligente, pensado para productos que respiran.",
            ),
          ],
        ),
      ),
    );
  }
}

//---------Fila de terminados, información.------------
class MoreInformation5PROSliver extends StatefulWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;

  const MoreInformation5PROSliver({super.key, required this.r, required this.blue, required this.isMobile});

  @override
  State<MoreInformation5PROSliver> createState() => _MoreInformation5PROSliverState();
}

class _MoreInformation5PROSliverState extends State<MoreInformation5PROSliver> {
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
    final List<Map<String, dynamic>> nuestra5pro = [
      {
        'isVideo': true,
        'video': 'assets/videos/smartbag/5pro/lamina.webm',
        'textSpans': [
          TextSpan(text: "Estructuras como ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "BOPP, PET, Metalizado y Transparente", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(
            text: ", cada una diseñada para un propósito específico: desde barreras de luz hasta permitir visibilidad del contenido. ",
            style: TextStyle(color: Colors.grey[600]),
          ),
          TextSpan(text: "Flexibilidad y protección", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: " en cada capa.", style: TextStyle(color: Colors.grey[600])),
        ],
      },
      {
        'isVideo': false,
        'image': 'img/smartbag/5pro/cardmin2.webp',
        'textSpans': [
          TextSpan(text: "Sistema de ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "válvula desgasificadora opcional", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: ", ideal para productos que liberan gases sin perder frescura. Perfecta para ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "café, granos y snacks gourmet", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: ".", style: TextStyle(color: Colors.grey[600])),
        ],
      },
      {
        'isVideo': false,
        'image': 'img/smartbag/5pro/cardmin3.webp',
        'textSpans': [
          TextSpan(text: "Ofrece un ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "cierre seguro y hermético", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: ", compatible con sistemas automáticos. ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "Mantiene la integridad", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: " del producto durante transporte y almacenamiento.", style: TextStyle(color: Colors.grey[600])),
        ],
      },
      {
        'isVideo': false,
        'image': 'img/smartbag/5pro/cardmin4.webp',
        'textSpans': [
          TextSpan(text: "Acabados ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "mateo o brillante", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: ": elige el ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "look & feel", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(
            text: " perfecto para tu marca, desde la elegancia minimalista hasta el alto impacto visual.",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      },
      {
        'isVideo': false,
        'image': 'img/smartbag/5pro/cardmin5.webp',
        'textSpans': [
          TextSpan(text: "Diseño con ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "ventanas opcionales", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: " que permiten ver el producto interior. ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "Transparente, con formas y tamaños personalizados", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: " para destacar tu contenido.", style: TextStyle(color: Colors.grey[600])),
        ],
      },
    ];

    return SliverToBoxAdapter(
      child: SizedBox(
        width: widget.r.wp(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: widget.r.wp(6)),
                child: Text(
                  "Es la era de ser un 5.",
                  style: TextStyle(fontSize: widget.r.fs(5, 50), fontWeight: FontWeight.bold, color: widget.blue),
                ),
              ),
            ),
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
                      bottom: 10,
                    ),
                    child: SizedBox(
                      width: widget.r.wp(60, max: 450),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: widget.r.wp(60, max: 450),
                            width: widget.r.wp(60, max: 450),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color.fromARGB(255, 227, 231, 241),
                              boxShadow: [
                                BoxShadow(color: Color.fromRGBO(60, 64, 67, 0.3), blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1)),
                                BoxShadow(color: Color.fromRGBO(60, 64, 67, 0.15), blurRadius: 3, spreadRadius: 1, offset: Offset(0, 1)),
                              ],
                            ),
                            child:
                                nuestra5pro[index]['isVideo']
                                    ? VideoFlutter(src: nuestra5pro[index]['video'], loop: false, retry: true, showControls: false, fit: BoxFit.cover)
                                    : ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(nuestra5pro[index]['image'])),
                          ),
                          const SizedBox(height: 26),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Text.rich(
                              textAlign: TextAlign.start,

                              TextSpan(
                                children: [
                                  TextSpan(
                                    style: TextStyle(fontSize: widget.r.fs(1.9, 24), fontWeight: FontWeight.w600, color: Colors.black.withAlpha(180)),
                                    children: List<TextSpan>.from(nuestra5pro[index]['textSpans']),
                                  ),
                                ],
                              ),
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
                        _scrollController.offset - (widget.r.wp(80)),
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
                        _scrollController.offset + (widget.r.wp(80)),
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

//---------Grandes soluciones, detalles 5PRO------------
class GreatSolutionsSliver extends StatelessWidget {
  const GreatSolutionsSliver({super.key, required this.r, required this.blue, required this.isMobile});
  final Responsive r;
  final bool isMobile;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ScrollAnimatedWrapper(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: 50),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: isMobile ? 10 : r.wp(6)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LottieBuilder.asset("assets/gifts/airplane.json", animate: true, height: 300),
                  const SizedBox(height: 30),
                  Text(
                    "Grandes soluciones, con detalles que marcan la diferencia.",
                    style: TextStyle(fontSize: (r.wp(100) * 0.1).clamp(30, 60), fontWeight: FontWeight.bold, height: 0, color: blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text.rich(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: (r.wp(100) * 0.03).clamp(16, 22),
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black.withAlpha(180),
                    ),
                    TextSpan(
                      children: [
                        TextSpan(text: "5PRO está diseñada para superar los estándares de empaque flexible, "),
                        TextSpan(text: "integrando soluciones ", style: TextStyle(color: blue)),
                        TextSpan(
                          text:
                              "como válvulas funcionales, terminados premium y estructuras de alta protección.\n\nCada detalle ha sido pensado para ",
                        ),
                        TextSpan(text: "combinar diseño, tecnología y eficiencia, sin comprometer la calidad. ", style: TextStyle(color: blue)),
                        TextSpan(
                          text:
                              "Gracias a su estructura multicapa, 5PRO mantiene el producto en condiciones óptimas, con opciones como acabado mate o brillante.\n\nTodo esto, pensado para adaptarse a diferentes industrias, formatos personalizados y exigencias del mercado actual. ",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: r.hp(5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//---------Videos para destacar la bolsa------------
class StandOutSliver extends StatelessWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;
  const StandOutSliver({super.key, required this.r, required this.blue, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 30 : 50, horizontal: r.wp(6)),
        child: isMobile ? _buildMobile() : _buildDesktop(),
      ),
    );
  }

  Column _buildDesktop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollAnimatedWrapper(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            height: r.wp(80, max: 600),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 231, 234, 244),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 6, spreadRadius: -1, offset: Offset(0, 4)),
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 4, spreadRadius: -1, offset: Offset(0, 2)),
                      ],
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: videoBlurNotifier,
                      builder: (context, isBlur, _) {
                        return VideoFlutter(
                          src: 'assets/videos/smartbag/5pro/loop.webm',
                          blur: isBlur,
                          loop: false,
                          showControls: false,
                          isPause: false,
                          retry: true,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: r.wp(6, max: 50)),
                Expanded(
                  child: _text(
                    "Empaca como un pro.",
                    "Lleva tus productos al siguiente nivel con 5PRO: una solución de empaque avanzada que combina válvulas funcionales, terminados premium y estructuras multicapa de alta protección. 5PRO se adapta a distintos formatos y permite una personalización total sin perder eficiencia ni calidad.",
                  ),
                ),
              ],
            ),
          ),
        ),
        ScrollAnimatedWrapper(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            height: r.wp(80, max: 600),
            child: Row(
              children: [
                Expanded(
                  child: _text(
                    "Diseñada para destacar. \nHecha para proteger.",
                    "5PRO no es solo una bolsa, es una declaración de calidad. Con acabados premium que elevan tu marca, y estructuras multicapa que resisten todo, 5PRO combina estética, tecnología y funcionalidad en un solo empaque. Ideal para quienes buscan impactar sin comprometer la protección.",
                  ),
                ),
                SizedBox(width: r.wp(6, max: 50)),

                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 231, 234, 244),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 6, spreadRadius: -1, offset: Offset(0, 4)),
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 4, spreadRadius: -1, offset: Offset(0, 2)),
                      ],
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: videoBlurNotifier,
                      builder: (context, isBlur, _) {
                        return VideoFlutter(
                          src: 'assets/videos/smartbag/5pro/5pro_destaca.webm',
                          blur: isBlur,
                          loop: false,
                          showControls: false,
                          isPause: false,
                          retry: true,
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
      ],
    );
  }

  Column _buildMobile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollAnimatedWrapper(
          child: Container(
            height: 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(255, 231, 234, 244),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 6, spreadRadius: -1, offset: Offset(0, 4)),
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 4, spreadRadius: -1, offset: Offset(0, 2)),
              ],
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: videoBlurNotifier,
              builder: (context, isBlur, _) {
                return VideoFlutter(
                  src: 'assets/videos/smartbag/5pro/loop.webm',
                  blur: isBlur,
                  loop: true,
                  showControls: false,
                  isPause: false,
                  retry: false,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        ScrollAnimatedWrapper(
          child: _text(
            "Empaca como un pro.",
            "Lleva tus productos al siguiente nivel con 5PRO: una solución de empaque avanzada que combina válvulas funcionales, terminados premium y estructuras multicapa de alta protección. 5PRO se adapta a distintos formatos y permite una personalización total sin perder eficiencia ni calidad.",
          ),
        ),
        SizedBox(height: 30),
        ScrollAnimatedWrapper(
          child: Container(
            height: 400,
            clipBehavior: Clip.hardEdge,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(255, 231, 234, 244),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 6, spreadRadius: -1, offset: Offset(0, 4)),
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 4, spreadRadius: -1, offset: Offset(0, 2)),
              ],
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: videoBlurNotifier,
              builder: (context, isBlur, _) {
                return VideoFlutter(
                  src: 'assets/videos/smartbag/5pro/5pro_destaca.webm',
                  blur: isBlur,
                  loop: true,
                  showControls: false,
                  isPause: false,
                  retry: false,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        ScrollAnimatedWrapper(
          child: _text(
            "Diseñada para destacar.",
            "5PRO no es solo una bolsa, es una declaración de calidad. Con acabados premium que elevan tu marca, y estructuras multicapa que resisten todo, 5PRO combina estética, tecnología y funcionalidad en un solo empaque. Ideal para quienes buscan impactar sin comprometer la protección.",
          ),
        ),
      ],
    );
  }

  Column _text(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.fs(2.9, 32))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(detail, textAlign: TextAlign.start, style: TextStyle(fontSize: r.fs(isMobile ? 1.9 : 1.5, 26))),
        ),
      ],
    );
  }
}

//---------Aun indeciso------------
class UndecidedSliver extends StatefulWidget {
  final Responsive r;
  final bool isMobile;
  const UndecidedSliver({super.key, required this.r, required this.isMobile});

  @override
  State<UndecidedSliver> createState() => _UndecidedSliverState();
}

class _UndecidedSliverState extends State<UndecidedSliver> {
  final ScrollController _scrollController = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = true;

  final items = const [
    (
      icon: CupertinoIcons.gift,
      title: "Empaque que trasciende",
      text: "No es solo un empaque, es una experiencia. Creamos conexiones desde el primer contacto visual hasta el último uso.",
    ),
    (
      icon: CupertinoIcons.shield,
      title: "Hecho para proteger lo esencial",
      text: "Tu producto conserva su aroma, sabor y forma gracias a materiales de alta ingeniería y precisión estructural.",
    ),
    (
      icon: CupertinoIcons.paintbrush,
      title: "Acabados que hablan por ti",
      text: "Estética sin límites: texturas, colores y formas que proyectan la esencia premium de tu marca.",
    ),
    (
      icon: CupertinoIcons.layers,
      title: "5PRO: Tecnología multicapa",
      text: "Hasta 5 selles de protección. Conservación avanzada, resistencia superior y una imagen inigualable.",
    ),
    (
      icon: CupertinoIcons.star_circle,
      title: "Diseño con propósito",
      text: "5PRO es elegancia en cada pliegue. Diseñada para marcas exigentes que valoran la estética tanto como la funcionalidad.",
    ),
  ];

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
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimatedWrapper(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.r.hp(8, max: 30), horizontal: widget.r.wp(6)),
              child: Text(
                "¿Aún indeciso?",
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: widget.r.fs(3, 40)),
              ),
            ),
          ),

          SizedBox(
            height: widget.r.hp(50, max: 400),

            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                items.length,
                (index) => _ItemIndeciso(
                  r: widget.r,
                  icon: items[index].icon,
                  title: items[index].title,
                  text: items[index].text,
                  isFirst: index == 0,
                  isLast: index == items.length - 1,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: widget.isMobile ? 30 : 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ArrowButton(
                  enabled: canScrollLeft,
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () {
                    _scrollController.animateTo(_scrollController.offset - 450, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                ),
                const SizedBox(width: 20),
                ArrowButton(
                  enabled: canScrollRight,
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () {
                    _scrollController.animateTo(_scrollController.offset + 450, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemIndeciso extends StatelessWidget {
  final Responsive r;
  final IconData icon;
  final String title, text;
  final bool isFirst, isLast;

  const _ItemIndeciso({required this.icon, required this.title, required this.text, required this.isFirst, required this.isLast, required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? r.wp(6) : 0, right: isLast ? r.wp(6) : 20, bottom: 50),
      child: Container(
        width: r.wp(80, max: 400),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 20),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: r.fs(2.2, 30))),
            const SizedBox(height: 8),
            Text(text, textAlign: TextAlign.justify, style: TextStyle(color: Colors.black87, fontSize: r.fs(1.9, 20))),
          ],
        ),
      ),
    );
  }
}

//---------Final de 5pro------------

class End5PROSliver extends StatelessWidget {
  const End5PROSliver({super.key, required this.blue, required this.route, required this.r});
  final Responsive r;
  final Color blue;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: r.wp(6)),
            width: r.wp(100),
            color: Colors.white,
            child: Column(
              children: [
                ScrollAnimatedWrapper(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(4, 60), color: Colors.black.withAlpha(200)),
                    TextSpan(children: [TextSpan(text: "Unete a la familia"), TextSpan(text: " 5PRO", style: TextStyle(color: blue))]),
                  ),
                ),
                SizedBox(height: 20),
                ScrollAnimatedWrapper(
                  child: SizedBox(
                    width: r.wp(100, max: 1200),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Una comunidad que transforma empaques en experiencias. Donde innovación, diseño y sostenibilidad se encuentran para elevar tu marca.",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: r.fs(2.4, 40)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ScrollAnimatedWrapper(child: OvalOrbitAnimation(blue: blue, screenWidth: r.wp(100))),
                ScrollAnimatedWrapper(
                  child: ElevatedButton(
                    onPressed: () {
                      navigateWithSlide(context, route);
                    },
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(blue), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("Armar mi 5PRO", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class OvalOrbitAnimation extends StatefulWidget {
  final Color blue;
  final double screenWidth;
  const OvalOrbitAnimation({super.key, required this.blue, required this.screenWidth});

  @override
  State<OvalOrbitAnimation> createState() => _OvalOrbitAnimationState();
}

class _OvalOrbitAnimationState extends State<OvalOrbitAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;

  //Imagen
  late AnimationController _controllerimg;
  late Animation<Offset> _animationimg;

  final int numLeaves = 2; // cantidad de elementos orbitando

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();

    //Imagen
    _controllerimg = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

    _animationimg = Tween<Offset>(
      begin: const Offset(0, 0.01),
      end: const Offset(0, -0.01),
    ).animate(CurvedAnimation(parent: _controllerimg, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerimg.dispose();
    super.dispose();
  }

  Offset calculatePosition(double angle, double a, double b) {
    final x = a * math.cos(angle);
    final y = b * math.sin(angle);
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final size = 300.0;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: 600,
        height: 600,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final List<Widget> behindBag = [];
            final List<Widget> inFrontBag = [];

            for (int i = 0; i < numLeaves; i++) {
              final angle = 2 * math.pi * (_controller.value + i / numLeaves);
              final position = calculatePosition(angle, 300, 50);
              final isBehind = position.dy < 0; // parte superior del óvalo
              final imagePaths = ["img/smartbag/5pro/earth.webp", "img/smartbag/5pro/saturn.webp"];

              final leaf = Transform.translate(
                offset: calculatePosition(2 * math.pi * (_controller.value + i / numLeaves), 300, 50),
                child: Transform.scale(
                  scale: (math.sin(2 * math.pi * (_controller.value + i / numLeaves)) + 1.5) / 2.5,
                  child: Opacity(opacity: 1.0, child: Image.asset(imagePaths[i % imagePaths.length], width: 80, height: 80)),
                ),
              );

              if (isBehind) {
                behindBag.add(leaf);
              } else {
                inFrontBag.add(leaf);
              }
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                // Línea punteada
                CustomPaint(
                  size: Size(size, size),
                  painter: DashedEllipsePainter(a: 300, b: 50, dashLength: 10, gapLength: 1, color: widget.blue.withAlpha(140)),
                ),

                // Íconos detrás de la bolsa
                ...behindBag,

                // Bolsa al centro
                // SizedBox(height: (screenWidth * 0.4).clamp(400, 700), child: Image.asset("img/smartbag/5pro/bags.webp", fit: BoxFit.cover)),
                SlideTransition(
                  position: _animationimg,
                  child: SizedBox(height: (screenWidth * 0.4).clamp(400, 700), child: Image.asset("img/smartbag/5pro/bags.webp", fit: BoxFit.cover)),
                ),

                CustomPaint(
                  size: Size(size, size),
                  painter: FrontDashedEllipsePainter(a: 300, b: 50, dashLength: 10, gapLength: 1, color: widget.blue.withAlpha(140)),
                ),
                // Íconos en frente de la bolsa
                ...inFrontBag,
              ],
            );
          },
        ),
      ),
    );
  }
}

// Painter para dibujar línea punteada elíptica
class DashedEllipsePainter extends CustomPainter {
  final double a; // radio horizontal
  final double b; // radio vertical
  final double dashLength;
  final double gapLength;
  final Color color;

  DashedEllipsePainter({required this.a, required this.b, required this.dashLength, required this.gapLength, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final totalLength = 2 * math.pi * math.sqrt((a * a + b * b) / 2); // aproximación de perímetro

    double t = 0;
    double drawnLength = 0;

    while (drawnLength < totalLength) {
      final p1 = Offset(a * math.cos(t), b * math.sin(t)) + center;
      final dt = 0.01;
      final nextT = t + dt;
      final p2 = Offset(a * math.cos(nextT), b * math.sin(nextT)) + center;

      if ((drawnLength ~/ (dashLength + gapLength)) % 2 == 0) {
        canvas.drawLine(p1, p2, paint);
      }

      drawnLength += (p2 - p1).distance;
      t = nextT;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter para dibujar solo la mitad frontal de una línea punteada elíptica
class FrontDashedEllipsePainter extends CustomPainter {
  final double a; // radio horizontal
  final double b; // radio vertical
  final double dashLength;
  final double gapLength;
  final Color color;

  FrontDashedEllipsePainter({required this.a, required this.b, required this.dashLength, required this.gapLength, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final totalLength = math.pi * math.sqrt((a * a + b * b) / 2); // solo media elipse

    double t = 45;
    double drawnLength = 0;

    while (drawnLength < totalLength) {
      final p1 = Offset(a * math.cos(t), b * math.sin(t)) + center;
      final dt = 0.01;
      final nextT = t + dt;
      final p2 = Offset(a * math.cos(nextT), b * math.sin(nextT)) + center;

      // Solo dibujar la parte frontal (cuando sin(t) >= 0)
      if (math.sin(t) >= 0 && ((drawnLength ~/ (dashLength + gapLength)) % 2 == 0)) {
        canvas.drawLine(p1, p2, paint);
      }

      drawnLength += (p2 - p1).distance;
      t = nextT;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
