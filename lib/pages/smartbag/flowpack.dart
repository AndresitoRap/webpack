import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class Flowpack extends StatelessWidget {
  const Flowpack({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 850;
    final blue = Theme.of(context).primaryColor;
    return CustomScrollView(
      slivers: [
        SliverStartFlowpack(screenHeight: screenHeight, screenWidth: screenWidth, blue: blue, isMobile: isMobile),
        SliverAboutFlowpack(screenWidth: screenWidth, blue: blue, isMobile: isMobile),
        SliverWithInfoFast(screenWidth: screenWidth),
        SliverWithCards(screenWidth: screenWidth, blue: blue, isMobile: isMobile),
        SliverWithModels(screenWidth: screenWidth, blue: blue),
        SliverWithMoreFlow(screenWidth: screenWidth, blue: blue, isMobile: isMobile),
        SliverWithComparacion(screenWidth: screenWidth, blue: blue),
        SliverFinalFlowpack(screenWidth: screenWidth, isMobile: isMobile, blue: blue),
      ],
    );
  }
}

//Sliver con Inicio
class SliverStartFlowpack extends StatefulWidget {
  const SliverStartFlowpack({super.key, required this.screenHeight, required this.screenWidth, required this.blue, required this.isMobile});

  final double screenHeight;
  final double screenWidth;
  final Color blue;
  final bool isMobile;

  @override
  State<SliverStartFlowpack> createState() => _SliverStartFlowpackState();
}

class _SliverStartFlowpackState extends State<SliverStartFlowpack> {
  bool isVideofinally = false;
  bool ishover = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: widget.isMobile ? 1 : 2), () {
      setState(() {
        isVideofinally = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.screenHeight,
            width: widget.screenWidth,

            child: Stack(
              children: [
                widget.isMobile
                    ? SizedBox(
                      height: widget.screenHeight,
                      width: widget.screenWidth,
                      child: Image.asset("img/smartbag/flowpack/inicio.webp", fit: BoxFit.cover),
                    )
                    : ValueListenableBuilder<bool>(
                      valueListenable: videoBlurNotifier,
                      builder: (context, isBlur, _) {
                        return VideoFlutter(
                          src: 'assets/videos/smartbag/flowpack/inicio.webm',
                          blur: isBlur,
                          loop: false,
                          showControls: false,
                          isPause: false,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 180),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      opacity: isVideofinally ? 1.0 : 0.0,
                      child: Text(
                        "FLOWPACK",
                        style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: (widget.screenWidth * 0.09).clamp(30, 60)),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  opacity: isVideofinally ? 1.0 : 0.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          ishover = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          ishover = false;
                        });
                      },
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {},
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ishover ? Colors.white : widget.blue,
                            border: ishover ? Border.all(color: widget.blue, width: 2) : Border.all(width: 2, color: Colors.transparent),
                          ),
                          child: Text(
                            "Armar mi flowpack",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: (widget.screenWidth * 0.06).clamp(20, 30),
                              color: ishover ? widget.blue : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Sliver con Flowpack es estilo
class SliverAboutFlowpack extends StatefulWidget {
  final double screenWidth;
  final Color blue;
  final bool isMobile;
  const SliverAboutFlowpack({super.key, required this.screenWidth, required this.blue, required this.isMobile});

  @override
  State<SliverAboutFlowpack> createState() => _SliverAboutFlowpackState();
}

class _SliverAboutFlowpackState extends State<SliverAboutFlowpack> {
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
                0.6 // más ancho en mobile
            : (widget.screenWidth * 0.8).clamp(0, 1000);

    final double cardHeight =
        widget.isMobile
            ? widget.screenWidth *
                0.8 // cuadrado en mobile
            : (widget.screenWidth * 0.5).clamp(0, 500);

    final List<Map<String, dynamic>> nuestraFlowpackSmartbag = [
      {"title": "Flowpack Smartbag:\ninnovación en cada detalle", "image": "img/smartbag/flowpack/cardLarge1.webp"},
      {"title": "Diseño elegante, opciones\navanzadas como válvula y Peel & Stick", "image": "img/smartbag/flowpack/cardLarge2.webp"},
      {"title": "Empaque ideal para destacar\ntu producto con estilo y eficiencia.", "image": "img/smartbag/flowpack/cardLarge3.webp"},
    ];
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        width: widget.screenWidth,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('flowpack-con-estilo'),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: widget.screenWidth * 0.06),
                child: Text(
                  "Flowpack es estilo.",
                  style: TextStyle(fontSize: (widget.screenWidth * 0.2).clamp(30, 50), fontWeight: FontWeight.bold, color: widget.blue),
                ),
              ),
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('scroll-floepack-con-esitlo'),

              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(nuestraFlowpackSmartbag.length, (index) {
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
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Color.fromRGBO(99, 99, 99, 0.2), blurRadius: 8, spreadRadius: 0, offset: Offset(0, 2))],

                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(image: AssetImage(nuestraFlowpackSmartbag[index]["image"]), fit: BoxFit.cover),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                nuestraFlowpackSmartbag[index]["title"],
                                style: TextStyle(
                                  fontSize: (widget.screenWidth * 0.04).clamp(0, 26),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('buttons-scroll'),
              child: Padding(
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

//Sliver con informaciónn rapida
class SliverWithInfoFast extends StatelessWidget {
  const SliverWithInfoFast({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: screenWidth * 0.06),
        color: Colors.white,
        width: screenWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('perfeccionadna-con-flplakc'),
              child: Text(
                "Perfeccionada con ingeniería de empaque de última generación, la nueva Flowpack Smartbag combina tecnología Peel & Stick y válvula inteligente para una experiencia práctica y sofisticada. Diseñada para preservar frescura, facilitar el consumo y destacar en cada detalle. Impulsada por innovación en sellado y control de flujo, con acabados mate o brillante que reflejan tu estilo. Un nuevo estándar en empaque flexible. Precisa. Elegante. Funcional.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.04).clamp(18, 26)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 100),
            ScrollAnimatedWrapper(
              visibilityKey: Key('foto-preferccionacod'),

              child: Container(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.transparent, Colors.transparent],
                        stops: [0.0, 0.8, 1.0], // más abrupto: blanco hasta 70%, luego se desvanece
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset("img/smartbag/flowpack/cruzado.webp"),
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

//Sliver con cards
class SliverWithCards extends StatefulWidget {
  final double screenWidth;
  final Color blue;
  final bool isMobile;
  const SliverWithCards({super.key, required this.screenWidth, required this.blue, required this.isMobile});

  @override
  State<SliverWithCards> createState() => _SliverWithCardsState();
}

class _SliverWithCardsState extends State<SliverWithCards> {
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
    final List<Map<String, dynamic>> nuestraFlowpackSmartbag = [
      {
        'image': 'img/smartbag/flowpack/shortCard1.webp',
        'textSpans': [
          TextSpan(text: "Flowpack Smartbag: ", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(
            text: "un diseño que no solo protege tu producto, sino que además impresiona por su estética y funcionalidad ",
            style: TextStyle(color: Colors.grey[600]),
          ),
          TextSpan(text: "en cada detalle de su estructura", style: TextStyle(color: widget.blue.withAlpha(180))),
        ],
      },
      {
        'image': 'img/smartbag/flowpack/shortCard2.webp',
        'textSpans': [
          TextSpan(text: "Estructuras multicapa de 3 y 4 láminas, ", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(
            text: "que mejoran significativamente la barrera contra agentes externos y maximizan el rendimiento del empaque",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      },
      {
        'image': 'img/smartbag/flowpack/shortCard3.webp',
        'textSpans': [
          TextSpan(text: "Sistemas como válvula desgasificadora y ", style: TextStyle(color: Colors.grey[600])),
          TextSpan(text: "tecnología Peel & Stick se integran ", style: TextStyle(color: widget.blue.withAlpha(180))),
          TextSpan(text: "para ofrecer una experiencia de uso superior y sin complicaciones", style: TextStyle(color: Colors.grey[600])),
        ],
      },
    ];
    final cardSize = (widget.screenWidth * 0.550).clamp(0, 550).toDouble();
    final paddingSide = widget.screenWidth * 0.06;
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        width: widget.screenWidth,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('scroll-cards-more-inof-flow'),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(nuestraFlowpackSmartbag.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? paddingSide : 0,
                        right: index == nuestraFlowpackSmartbag.length - 1 ? paddingSide : 20,
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
                              height: cardSize,
                              width: cardSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color.fromARGB(255, 227, 231, 241),
                                boxShadow: [
                                  BoxShadow(color: Color.fromRGBO(60, 64, 67, 0.3), blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1)),
                                  BoxShadow(color: Color.fromRGBO(60, 64, 67, 0.15), blurRadius: 3, spreadRadius: 1, offset: Offset(0, 1)),
                                ],
                              ),
                              child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(nuestraFlowpackSmartbag[index]['image'])),
                            ),
                            const SizedBox(height: 26),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: (widget.screenWidth * 0.03).clamp(12, 18),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withAlpha(180),
                                  ),
                                  children: List<TextSpan>.from(nuestraFlowpackSmartbag[index]['textSpans']),
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
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('buttons-cscorl--more-inf'),

              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}

//Sliver con foto modelo
class SliverWithModels extends StatefulWidget {
  const SliverWithModels({super.key, required this.screenWidth, required this.blue});

  final double screenWidth;
  final Color blue;

  @override
  State<SliverWithModels> createState() => _SliverWithModelsState();
}

class _SliverWithModelsState extends State<SliverWithModels> {
  final ScrollController _scrollColors = ScrollController();
  final bool _showLeftArrow = false;
  final bool _showRightArrow = true;
  String selectedColor = "Azul Holografica";

  void _scrollRight() {
    final newOffset = (_scrollColors.offset + 200).clamp(0.0, _scrollColors.position.maxScrollExtent);
    _scrollColors.animateTo(newOffset, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  void _scrollLeft() {
    final newOffset = (_scrollColors.offset - 200).clamp(0.0, _scrollColors.position.maxScrollExtent);
    _scrollColors.animateTo(newOffset, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> colors = [
      //{"name": "Azul Holografica", "color": const Color(0xE01261A1), "image": "img/ecobag/4pro.webp"},
      //{"name": "Metalizada Holografica", "color": const Color(0xFFC7C7C7), "image": "img/smartbag/flowpack/colorMetalizada.webp"},
      {"name": "Naranja Holografica", "color": const Color.fromARGB(255, 233, 111, 41), "image": "img/smartbag/flowpack/colorNaranja.webp"},
      {"name": "Blanco", "color": const Color.fromARGB(255, 210, 210, 210), "image": "img/smartbag/flowpack/colorBlanco.webp"},
      {"name": "Negro", "color": const Color.fromARGB(221, 70, 70, 70), "image": "img/smartbag/flowpack/ColorNegro.webp"},
      {"name": "Dorado", "color": const Color.fromARGB(255, 232, 204, 63), "image": "img/smartbag/flowpack/ColorDorado.webp"},
      {"name": "Naranja Lechosa", "color": const Color.fromARGB(255, 204, 110, 39), "image": "img/smartbag/flowpack/colorNaranjaLechosa.webp"},
    ];
    final selectedItem = colors.firstWhere((item) => item["name"] == selectedColor, orElse: () => colors.first);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('esitli-simple-flpakc'),

              child: Text(
                "Estilo simple",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.04).clamp(16, 30), color: widget.blue, height: 0.99),
              ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: Key('impacto-sofisticado'),

              child: ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [widget.blue, widget.blue.withAlpha(100)], // Cambia a los colores que desees
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                blendMode: BlendMode.srcIn,
                child: Text(
                  "Impacto sofisticado",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(40, 80), height: 0.99),
                ),
              ),
            ),
            SizedBox(height: 30),
            ScrollAnimatedWrapper(
              visibilityKey: Key('modelo,cambiaocloresflow'),

              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: double.infinity,
                  height: 800,
                  constraints: BoxConstraints(minHeight: 800),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Sombra desde abajo
                      Positioned(
                        bottom: -70,
                        left: 0,
                        right: 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [selectedItem["color"].withAlpha(50), const Color.fromARGB(0, 255, 255, 255)],
                            ),
                          ),
                        ),
                      ),

                      // Imagen bajada y cortada
                      widget.screenWidth <= 1000
                          ? Positioned(
                            bottom: -100,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                // Lista horizontal
                                SizedBox(
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: SingleChildScrollView(
                                          controller: _scrollColors,
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children:
                                                colors
                                                    .map(
                                                      (item) =>
                                                          _buildColorLabel(item["name"], item["color"], isSelected: selectedColor == item["name"]),
                                                    )
                                                    .toList(),
                                          ),
                                        ),
                                      ),
                                      // Flechas
                                      if (_showLeftArrow)
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.centerRight,
                                                end: Alignment.centerLeft,
                                                colors: [const Color.fromARGB(0, 255, 255, 255), Color.fromARGB(255, 241, 245, 255)],
                                              ),
                                            ),
                                            child: IconButton(icon: Icon(CupertinoIcons.chevron_left, color: widget.blue), onPressed: _scrollLeft),
                                          ),
                                        ),

                                      // Flecha derecha
                                      if (_showRightArrow)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [const Color.fromARGB(0, 255, 255, 255), Color.fromARGB(255, 241, 245, 255)],
                                              ),
                                            ),
                                            child: IconButton(icon: Icon(CupertinoIcons.chevron_right, color: widget.blue), onPressed: _scrollRight),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Imagen centrada
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  switchInCurve: Curves.easeInOut,
                                  switchOutCurve: Curves.easeInOut,
                                  transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child),
                                  child: SizedBox(
                                    key: ValueKey(selectedItem["image"]),
                                    height: 700,
                                    child: Image.asset(selectedItem["image"], fit: BoxFit.fitHeight),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Stack(
                            children: [
                              Positioned(
                                bottom: -100,
                                left: 200,
                                right: 0,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  switchInCurve: Curves.easeInOut,
                                  switchOutCurve: Curves.easeInOut,
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  child: Image.asset(selectedItem["image"], key: ValueKey(selectedItem["image"]), fit: BoxFit.fitHeight, height: 700),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 700,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                                    child: ListView(
                                      children:
                                          colors
                                              .map(
                                                (item) =>
                                                    _buildColorLabelColumn(item["name"], item["color"], isSelected: selectedColor == item["name"]),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                  SizedBox(width: 710),
                                ],
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                textAlign: TextAlign.center,
                "Estos son algunos colores.\nHay más variedades disponibles.",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorLabel(String text, Color color, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = text;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(color: isSelected ? color : Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: 40,
                decoration: BoxDecoration(color: isSelected ? color : Colors.transparent, borderRadius: BorderRadius.circular(1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorLabelColumn(String text, Color color, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = text;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Row(
            children: [
              Icon(Icons.circle, color: isSelected ? Colors.white : color, size: 16),
              const SizedBox(width: 10),
              Text(text, style: TextStyle(color: isSelected ? Colors.white : color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

//Sliver con mas flow aalto impacto
class SliverWithMoreFlow extends StatefulWidget {
  const SliverWithMoreFlow({super.key, required this.screenWidth, required this.blue, required this.isMobile});

  final double screenWidth;
  final Color blue;
  final bool isMobile;

  @override
  State<SliverWithMoreFlow> createState() => _SliverWithMoreFlowState();
}

class _SliverWithMoreFlowState extends State<SliverWithMoreFlow> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: widget.screenWidth * 0.06),
        child: Column(
          children: [
            Text.rich(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.07).clamp(20, 40)),
              TextSpan(children: [TextSpan(text: "Flow ", style: TextStyle(color: widget.blue)), TextSpan(text: "al más alto impacto")]),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: widget.isMobile ? 900 : 700,
              width: (widget.screenWidth * 0.8).clamp(0, 1200),
              child: ScrollAnimatedWrapper(
                visibilityKey: Key('flowalmasalto'),

                child:
                    widget.isMobile
                        ? Column(
                          children: [
                            containerFlow(
                              widget.blue,
                              imagen: "img/smartbag/flowpack/cortina.webp",
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Con aleta",
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(20, 22), color: Colors.black.withAlpha(100)),
                                    ),
                                    Text(
                                      "Algo más innovador",
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.07).clamp(24, 26), fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            containerFlow(
                              imagen: "img/smartbag/flowpack/splash.webp",
                              widget.blue,
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Respira",
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(20, 22), color: Colors.black.withAlpha(100)),
                                    ),
                                    Text(
                                      "Con toda seguridad",
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(24, 26), fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            containerFlow(
                              imagen: "img/smartbag/flowpack/perlas.webp",
                              widget.blue,
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Simple",
                                        style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(20, 22), color: Colors.black.withAlpha(100)),
                                      ),
                                      Text(
                                        "Pero con estilo",
                                        style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(24, 26), fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Row(
                          children: [
                            containerFlow(
                              imagen: "img/smartbag/flowpack/cortina.webp",
                              widget.blue,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Con aleta",
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(20, 22), color: Colors.black.withAlpha(100)),
                                    ),
                                    Text(
                                      "Algo más innovador",
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.07).clamp(24, 26), fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  containerFlow(
                                    imagen: "img/smartbag/flowpack/splash.webp",
                                    widget.blue,
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Respira",
                                            style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(20, 22), color: Colors.black.withAlpha(100)),
                                          ),
                                          Text(
                                            "Con toda seguridad",
                                            style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(24, 26), fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  containerFlow(
                                    imagen: "img/smartbag/flowpack/perlas.webp",
                                    widget.blue,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Simple",
                                            style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(20, 22), color: Colors.black.withAlpha(100)),
                                          ),
                                          Text(
                                            "Pero con estilo",
                                            style: TextStyle(fontSize: (widget.screenWidth * 0.05).clamp(24, 26), fontWeight: FontWeight.bold),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerFlow(Color blue, {required Widget child, required String imagen, Alignment alignment = Alignment.center}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: alignment,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[100],
            image: DecorationImage(image: AssetImage(imagen), fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(50, 50, 93, 0.25), blurRadius: 5, spreadRadius: -1, offset: Offset(0, 2)),
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 3, spreadRadius: -1, offset: Offset(0, 1)),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

//Sliver con comparacion
class SliverWithComparacion extends StatelessWidget {
  const SliverWithComparacion({super.key, required this.screenWidth, required this.blue});

  final double screenWidth;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    final double iconSize = 28;
    final double fontSize = (screenWidth * 0.035).clamp(16, 20);
    final double titleFontSize = (screenWidth * 0.05).clamp(16, 32);

    final characteristics = [
      {'icon': CupertinoIcons.layers, 'label': '3 y 4 láminas', 'flowpack': true, 'fourpro': true},
      {'icon': CupertinoIcons.wind, 'label': 'Integra válvula desgasificadora', 'flowpack': true, 'fourpro': true},
      {'icon': CupertinoIcons.rectangle_on_rectangle, 'label': 'Peel Stick', 'flowpack': true, 'fourpro': true},
      {'icon': CupertinoIcons.paintbrush, 'label': 'Acabados premium', 'flowpack': true, 'fourpro': true},
      {'icon': CupertinoIcons.slider_horizontal_3, 'label': 'Desde 70 g hasta 2500 g.', 'flowpack': true, 'fourpro': true},
      {'icon': CupertinoIcons.arrow_right_arrow_left, 'label': 'Aleta dorsal', 'flowpack': true, 'fourpro': false}, // <-- aquí está
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 24),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollAnimatedWrapper(
                visibilityKey: Key('sxclusive-flpck'),

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    textAlign: TextAlign.start,
                    "Exclusividad en su estilo.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: (screenWidth * 0.1).clamp(20, 40)),
                  ),
                ),
              ),
              SizedBox(height: 50),
              // Títulos y fotos
              ScrollAnimatedWrapper(
                visibilityKey: Key('foto-4pr-flowpk'),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset("img/smartbag/flowpack/flowpackBlancoNegro.webp", fit: BoxFit.contain),
                          const SizedBox(height: 12),
                          Text("Flowpack Smart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize, color: blue)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset("img/smartbag/flowpack/flowpackVs4proBlancoNegro.webp", fit: BoxFit.contain),
                          const SizedBox(height: 12),
                          Text(
                            "4PRO Smart",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize, color: Colors.black.withAlpha(200)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Separador
              ScrollAnimatedWrapper(
                visibilityKey: Key('separador'),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Divider(thickness: 2, color: Colors.grey[300])),
              ),

              const SizedBox(height: 16),

              // Lista de características comparadas
              for (var item in characteristics) ...[
                ScrollAnimatedWrapper(
                  visibilityKey: Key('items-rows-${item['label'] as String}'),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            if (item['flowpack'] as bool) Icon(item['icon'] as IconData, color: blue, size: iconSize) else SizedBox(height: iconSize),
                            const SizedBox(height: 8),
                            Text(item['label'] as String, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(item['icon'] as IconData, size: iconSize, color: Colors.black.withAlpha(200)),
                            const SizedBox(height: 8),
                            if (item['fourpro'] as bool)
                              Text(
                                item['label'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: fontSize, color: Colors.black.withAlpha(200)),
                              )
                            else
                              Text('-'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

//Sliver final

class SliverFinalFlowpack extends StatefulWidget {
  const SliverFinalFlowpack({super.key, required this.screenWidth, required this.isMobile, required this.blue});
  final bool isMobile;
  final double screenWidth;
  final Color blue;

  @override
  State<SliverFinalFlowpack> createState() => _SliverFinalFlowpackState();
}

class _SliverFinalFlowpackState extends State<SliverFinalFlowpack> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _secondaryController;

  late Animation<Offset> _positionAnim;
  late Animation<double> _rotationAnim;
  late Animation<double> _scaleAnim;

  late Animation<Offset> _slideAnim;

  bool _hasAnimated = false;

  //Nueva bolsa
  late AnimationController _newBagController;
  late Animation<Offset> _newBagSlide;
  late Animation<double> _newBagRotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _secondaryController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _positionAnim = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _rotationAnim = Tween<double>(begin: 0.5, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.4).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    // Segunda animación: izquierda y luego derecha
    _slideAnim = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween<Offset>(begin: Offset.zero, end: const Offset(-0.1, 0)).chain(CurveTween(curve: Curves.easeInOut)), weight: 50),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-0.1, 0),
          end: const Offset(1.5, 0), // se va a la derecha
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 50,
      ),
    ]).animate(_secondaryController);

    _newBagController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _newBagSlide = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _newBagController, curve: Curves.easeOutBack));

    _newBagRotation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.3, end: -0.2).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -0.2, end: 0.0).chain(CurveTween(curve: Curves.elasticOut)), weight: 50),
    ]).animate(_newBagController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _newBagController.dispose();

    super.dispose();
  }

  void _startAnimationIfVisible(double visibleFraction) {
    if (!_hasAnimated && visibleFraction > 0.5) {
      _hasAnimated = true;

      _controller.forward().then((_) async {
        await Future.delayed(const Duration(seconds: 1));
        await _secondaryController.forward();
        await Future.delayed(const Duration(milliseconds: 500));
        await _newBagController.forward(); // 🚀 Lanzamos la nueva bolsa
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ScrollAnimatedWrapper(
        visibilityKey: Key('scroll-final'),

        child: VisibilityDetector(
          key: const Key("flowpack-final-animation"),
          onVisibilityChanged: (info) {
            _startAnimationIfVisible(info.visibleFraction);
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 50),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: widget.screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: widget.isMobile ? 10 : 40),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: Colors.white),
                  child:
                      widget.isMobile
                          ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: (widget.screenWidth * 0.06).clamp(22, 40),
                                    color: Colors.black.withAlpha(200),
                                  ),
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "La opción ligera, versátil y económica para productos de "),
                                      TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.blue)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Elige Flowpack Smart",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: (widget.screenWidth * 0.03).clamp(18, 26), color: Colors.black),
                                      ),
                                      SizedBox(width: 5),

                                      Icon(CupertinoIcons.arrow_right, color: widget.blue),
                                    ],
                                  ),
                                ),
                              ),

                              Stack(
                                children: [
                                  // Primera bolsa (entrada y salida)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: AnimatedBuilder(
                                      animation: Listenable.merge([_controller, _secondaryController]),
                                      builder: (context, child) {
                                        Widget transformed = Transform.translate(
                                          offset: _positionAnim.value * 300,
                                          child: Transform.rotate(
                                            angle: _rotationAnim.value,
                                            child: Transform.scale(scale: _scaleAnim.value, child: child),
                                          ),
                                        );

                                        if (_secondaryController.status != AnimationStatus.dismissed) {
                                          transformed = Transform.translate(offset: _slideAnim.value * 300, child: transformed);
                                        }

                                        // Solo mostrar mientras no se haya activado la nueva bolsa
                                        return _newBagController.status == AnimationStatus.dismissed ? transformed : const SizedBox.shrink();
                                      },
                                      child: Image.asset("img/smartbag/flowpack/flowpack_blanco.webp"),
                                    ),
                                  ),

                                  // Segunda bolsa (la que aparece al final)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),

                                    child: AnimatedBuilder(
                                      animation: _newBagController,
                                      builder: (context, child) {
                                        if (_newBagController.status == AnimationStatus.dismissed && _secondaryController.isCompleted) {
                                          return const SizedBox.shrink();
                                        }

                                        return Transform.translate(
                                          offset: _newBagSlide.value * 300,
                                          child: Transform.rotate(angle: _newBagRotation.value, child: child),
                                        );
                                      },
                                      child: Image.asset("img/smartbag/flowpack.webp"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          : Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text.rich(
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: (widget.screenWidth * 0.06).clamp(22, 40),
                                          color: Colors.black.withAlpha(200),
                                        ),
                                        TextSpan(
                                          children: [
                                            TextSpan(text: "La opción ligera, versátil y económica para productos de "),
                                            TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.blue)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Elige Flowpack Smart",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: (widget.screenWidth * 0.03).clamp(18, 26), color: Colors.black),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(CupertinoIcons.arrow_right, color: widget.blue),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    // Primera bolsa (entrada y salida)
                                    AnimatedBuilder(
                                      animation: Listenable.merge([_controller, _secondaryController]),
                                      builder: (context, child) {
                                        Widget transformed = Transform.translate(
                                          offset: _positionAnim.value * 300,
                                          child: Transform.rotate(
                                            angle: _rotationAnim.value,
                                            child: Transform.scale(scale: _scaleAnim.value, child: child),
                                          ),
                                        );

                                        if (_secondaryController.status != AnimationStatus.dismissed) {
                                          transformed = Transform.translate(offset: _slideAnim.value * 300, child: transformed);
                                        }

                                        // Solo mostrar mientras no se haya activado la nueva bolsa
                                        return _newBagController.status == AnimationStatus.dismissed ? transformed : const SizedBox.shrink();
                                      },
                                      child: Image.asset("img/smartbag/flowpack/flowpack_blanco.webp"),
                                    ),

                                    // Segunda bolsa (la que aparece al final)
                                    AnimatedBuilder(
                                      animation: _newBagController,
                                      builder: (context, child) {
                                        if (_newBagController.status == AnimationStatus.dismissed && _secondaryController.isCompleted) {
                                          return const SizedBox.shrink();
                                        }

                                        return Transform.translate(
                                          offset: _newBagSlide.value * 300,
                                          child: Transform.rotate(angle: _newBagRotation.value, child: child),
                                        );
                                      },
                                      child: Image.asset("img/smartbag/flowpack.webp"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
