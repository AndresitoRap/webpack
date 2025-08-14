import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class Flowpack extends StatelessWidget {
  final Responsive r;
  final Subcategorie subcategorie;
  const Flowpack({super.key, required this.r, required this.subcategorie});

  @override
  Widget build(BuildContext context) {
    final isMobile = r.wp(100) < 850;
    final blue = Theme.of(context).primaryColor;
    final route = '${subcategorie.route}/crea-tu-empaque';

    return CustomScrollView(
      slivers: [
        SliverStartFlowpack(r: r, blue: blue, isMobile: isMobile, route: route),
        InformationFlowpackSliver(r: r, blue: blue, isMobile: isMobile),
        SliverWithInfoFast(r: r, blue: blue),
        CardsWithInformationSliver(r: r, blue: blue, isMobile: isMobile),
        ModelImagenSliver(r: r, blue: blue, isMobile: isMobile),
        ImagenSlivers(r: r, blue: blue, isMobile: isMobile),
        ComparisionSliver(r: r, blue: blue),
        FlowpackFinallySliver(r: r, isMobile: isMobile, blue: blue, route: route),
        SliverToBoxAdapter(child: const Footer()),
      ],
    );
  }
}

//---------Inicio de la pantalla en Flowpack------------
class SliverStartFlowpack extends StatefulWidget {
  const SliverStartFlowpack({super.key, required this.r, required this.blue, required this.isMobile, required this.route});
  final String route;
  final Responsive r;
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
            height: widget.r.hp(100),
            width: widget.r.wp(100),
            child: Stack(
              fit: StackFit.expand,
              children: [
                widget.isMobile
                    ? Image.asset("img/smartbag/flowpack/inicio.webp", fit: BoxFit.cover)
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
                      child: Text("FLOWPACK", style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: widget.r.fs(5, 60))),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  opacity: isVideofinally ? 1.0 : 0.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        navigateWithSlide(context, widget.route);
                      },
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
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
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
                              style: TextStyle(fontWeight: FontWeight.bold, color: ishover ? widget.blue : Colors.white),
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

//---------Información de la flowpack------------
class InformationFlowpackSliver extends StatefulWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;
  const InformationFlowpackSliver({super.key, required this.r, required this.blue, required this.isMobile});

  @override
  State<InformationFlowpackSliver> createState() => _InformationFlowpackSliverState();
}

class _InformationFlowpackSliverState extends State<InformationFlowpackSliver> {
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
      {"title": "Flowpack Smartbag:\ninnovación en cada detalle", "image": "img/smartbag/flowpack/cardLarge1.webp"},
      {"title": "Diseño elegante, opciones\navanzadas como válvula y Peel & Stick", "image": "img/smartbag/flowpack/cardLarge2.webp"},
      {"title": "Empaque ideal para destacar\ntu producto con estilo y eficiencia.", "image": "img/smartbag/flowpack/cardLarge3.webp"},
    ];
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        width: widget.r.wp(100),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: widget.r.wp(6)),
                child: Text("Flowpack es estilo.", style: TextStyle(fontSize: widget.r.fs(3.5, 50), fontWeight: FontWeight.bold, color: widget.blue)),
              ),
            ),

            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(nuestraFlowpackSmartbag.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? widget.r.wp(6) : 0, right: index == 4 ? widget.r.wp(6) : 20, bottom: 50),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: widget.r.hp(60, max: 700),
                        width: widget.r.wp(80, max: 1000),
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
                              style: TextStyle(fontSize: widget.r.fs(2, 26), fontWeight: FontWeight.bold, color: Colors.white),
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
                        _scrollController.offset - widget.r.wp(80),
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
                        _scrollController.offset + widget.r.wp(80),
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

//---------Información rápida------------
class SliverWithInfoFast extends StatelessWidget {
  const SliverWithInfoFast({super.key, required this.r, required this.blue});

  final Responsive r;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: r.wp(6)),
        color: Colors.white,
        width: r.wp(100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScrollAnimatedWrapper(
              child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(2, 26)),
                TextSpan(
                  children: [
                    TextSpan(text: "Perfeccionada con ingeniería de empaque de última generación, la nueva "),
                    TextSpan(text: "Flowpack SmartBag® ", style: TextStyle(color: blue)),
                    TextSpan(text: "combina tecnología Peel & Stick y válvula inteligente para una "),
                    TextSpan(text: "experiencia práctica y sofisticada.\n\n", style: TextStyle(color: blue)),
                    TextSpan(
                      text:
                          "Diseñada para preservar frescura, facilitar el consumo y destacar en cada detalle. Impulsada por innovación en sellado y control de flujo,",
                    ),
                    TextSpan(text: "con acabados mate o brillante que reflejan tu estilo. ", style: TextStyle(color: blue)),
                    TextSpan(text: "Un nuevo estándar en empaque flexible. Precisa. Elegante. Funcional."),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
            ScrollAnimatedWrapper(
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

//---------Información con imagenes en cards------------
class CardsWithInformationSliver extends StatefulWidget {
  final Responsive r;
  final Color blue;
  final bool isMobile;
  const CardsWithInformationSliver({super.key, required this.r, required this.blue, required this.isMobile});

  @override
  State<CardsWithInformationSliver> createState() => _CardsWithInformationSliverState();
}

class _CardsWithInformationSliverState extends State<CardsWithInformationSliver> {
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

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(top: widget.isMobile ? 70 : 30),
        width: widget.r.wp(100),
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
                        left: index == 0 ? widget.r.wp(6) : 0,
                        right: index == nuestraFlowpackSmartbag.length - 1 ? widget.r.wp(6) : 20,
                        bottom: 50,
                      ),
                      child: SizedBox(
                        width: widget.r.wp(50, max: 500),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: widget.r.wp(50, max: 500),
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
                              child: Text.rich(
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: widget.r.fs(1.9, 22), fontWeight: FontWeight.w600, color: Colors.black.withAlpha(180)),
                                TextSpan(children: List<TextSpan>.from(nuestraFlowpackSmartbag[index]['textSpans'])),
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
                        _scrollController.offset - widget.r.wp(60),
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
                        _scrollController.offset + widget.r.wp(60),
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

//---------Imagen con colores------------
class ModelImagenSliver extends StatefulWidget {
  const ModelImagenSliver({super.key, required this.r, required this.blue, required this.isMobile});

  final Responsive r;
  final Color blue;
  final bool isMobile;

  @override
  State<ModelImagenSliver> createState() => _ModelImagenSliverState();
}

class _ModelImagenSliverState extends State<ModelImagenSliver> {
  late ScrollController _scrollColors;
  bool _showLeftArrow = false;
  bool _showRightArrow = false;
  String selectedColor = "Naranja Holografica";

  @override
  void initState() {
    super.initState();
    _scrollColors = ScrollController();

    _scrollColors.addListener(() {
      final maxScroll = _scrollColors.position.maxScrollExtent;
      final current = _scrollColors.offset;

      setState(() {
        _showLeftArrow = current > 0;
        _showRightArrow = current < maxScroll;
      });
    });

    // Detectar estado inicial después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollColors.hasClients) {
        final maxScroll = _scrollColors.position.maxScrollExtent;
        setState(() {
          _showRightArrow = maxScroll > 0;
        });
      }
    });
  }

  void _scrollLeft() {
    _scrollColors.animateTo(
      (_scrollColors.offset - 100).clamp(0, _scrollColors.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollColors.animateTo(
      (_scrollColors.offset + 100).clamp(0, _scrollColors.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
              child: Text(
                "Estilo simple",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(1.8, 30), color: widget.blue, height: 0.99),
              ),
            ),
            ScrollAnimatedWrapper(
              child: ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [widget.blue, widget.blue.withAlpha(100)], // Cambia a los colores que desees
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                blendMode: BlendMode.srcIn,
                child: Text("Impacto sofisticado", style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(4, 80), height: 0.99)),
              ),
            ),
            SizedBox(height: 30),
            ClipRRect(
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
                    widget.r.wp(100) < 1000 ? _buildPhone(colors, selectedItem) : _buildDesktop(selectedItem, colors),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                textAlign: TextAlign.center,
                "Algunos de nuestros colores disponibles, existen más.",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildDesktop(Map<String, dynamic> selectedItem, List<Map<String, dynamic>> colors) {
    return Stack(
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
                    colors.map((item) => _buildColorLabelColumn(item["name"], item["color"], isSelected: selectedColor == item["name"])).toList(),
              ),
            ),
            SizedBox(width: 710),
          ],
        ),
      ],
    );
  }

  Positioned _buildPhone(List<Map<String, dynamic>> colors, Map<String, dynamic> selectedItem) {
    return Positioned(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          colors.map((item) => _buildColorLabel(item["name"], item["color"], isSelected: selectedColor == item["name"])).toList(),
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
            child: SizedBox(key: ValueKey(selectedItem["image"]), height: 700, child: Image.asset(selectedItem["image"], fit: BoxFit.fitHeight)),
          ),
        ],
      ),
    );
  }

  Widget _buildColorLabel(String text, Color color, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = text;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(color: isSelected ? color : Colors.grey, fontWeight: FontWeight.bold, fontSize: widget.r.fs(1.8, 22))),
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = text;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,

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

//---------Imagenes------------
class ImagenSlivers extends StatelessWidget {
  const ImagenSlivers({super.key, required this.r, required this.blue, required this.isMobile});

  final Responsive r;
  final Color blue;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100, top: 20, left: r.wp(6), right: r.wp(6)),
        child: Column(
          children: [
            Text.rich(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(3, 40)),
              TextSpan(children: [TextSpan(text: "Flow ", style: TextStyle(color: blue)), TextSpan(text: "al más alto impacto")]),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: isMobile ? 900 : 700,
              width: r.wp(100, max: 1200),
              child: ScrollAnimatedWrapper(child: isMobile ? _buildMobile() : _buildDesktop()),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildDesktop() {
    return Row(
      children: [
        containerFlow(
          imagen: "img/smartbag/flowpack/cortina.webp",
          blue,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Con aleta", style: TextStyle(fontSize: r.fs(1.9, 22), color: Colors.black.withAlpha(100))),
                Text("Algo más innovador", style: TextStyle(fontSize: r.fs(2.1, 27), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              containerFlow(
                imagen: "img/smartbag/flowpack/splash.webp",
                blue,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Respira", style: TextStyle(fontSize: r.fs(1.9, 22), color: Colors.black.withAlpha(100))),
                      Text("Con toda seguridad", style: TextStyle(fontSize: r.fs(2.1, 27), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              containerFlow(
                imagen: "img/smartbag/flowpack/perlas.webp",
                blue,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Simple", style: TextStyle(fontSize: r.fs(1.9, 22), color: Colors.black.withAlpha(100))),
                      Text("Pero con estilo", style: TextStyle(fontSize: r.fs(2.1, 27), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildMobile() {
    return Column(
      children: [
        containerFlow(
          blue,
          imagen: "img/smartbag/flowpack/cortina.webp",
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Con aleta", style: TextStyle(fontSize: r.fs(1.9, 22), color: Colors.black.withAlpha(100))),
                Text("Algo más innovador", style: TextStyle(fontSize: r.fs(2.1, 27), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        containerFlow(
          imagen: "img/smartbag/flowpack/splash.webp",
          blue,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Respira", style: TextStyle(fontSize: r.fs(1.9, 22), color: Colors.black.withAlpha(100))),
                Text("Con toda seguridad", style: TextStyle(fontSize: r.fs(2.1, 27), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        containerFlow(
          imagen: "img/smartbag/flowpack/perlas.webp",
          blue,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Simple",
                    style: TextStyle(
                      fontSize: r.fs(1.9, 22),
                      color: Colors.white,
                      shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(180))],
                    ),
                  ),
                  Text(
                    "Pero con estilo",
                    style: TextStyle(
                      fontSize: r.fs(2.1, 27),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(180))],
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

//---------Comparación de la flowpack y 4pro------------
class ComparisionSliver extends StatelessWidget {
  const ComparisionSliver({super.key, required this.r, required this.blue});

  final Responsive r;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    final double iconSize = 28;
    final double fontSize = (r.wp(100) * 0.035).clamp(16, 20);
    final double titleFontSize = (r.wp(100) * 0.05).clamp(16, 32);

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
        padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: 24),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollAnimatedWrapper(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    textAlign: TextAlign.start,
                    "Exclusividad en su estilo.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.fs(4, 40)),
                  ),
                ),
              ),
              SizedBox(height: 50),
              // Títulos y fotos
              ScrollAnimatedWrapper(
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

//---------Final de Flowpack SmartBag®------------
class FlowpackFinallySliver extends StatefulWidget {
  const FlowpackFinallySliver({super.key, required this.r, required this.isMobile, required this.blue, required this.route});
  final bool isMobile;
  final Responsive r;
  final Color blue;
  final String route;
  @override
  State<FlowpackFinallySliver> createState() => _FlowpackFinallySliverState();
}

class _FlowpackFinallySliverState extends State<FlowpackFinallySliver> with TickerProviderStateMixin {
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
          end: const Offset(5, 0), // se va a la derecha
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 50,
      ),
    ]).animate(_secondaryController);

    _newBagController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _newBagSlide = Tween<Offset>(
      begin: const Offset(5, 0),
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
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 50),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: widget.r.wp(100),
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: widget.isMobile ? 10 : 40),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: Colors.white),
                  child: widget.isMobile ? _buildMobile() : _buildDesktop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildDesktop() {
    return Row(
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
                    fontSize: (widget.r.wp(100) * 0.06).clamp(22, 40),
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
              GestureDetector(
                onTap: () {
                  navigateWithSlide(context, widget.route);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Crea tú Flowpack",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: (widget.r.wp(100) * 0.03).clamp(18, 26), color: Colors.black),
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
                    child: Transform.rotate(angle: _rotationAnim.value, child: Transform.scale(scale: _scaleAnim.value, child: child)),
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

                  return Transform.translate(offset: _newBagSlide.value * 300, child: Transform.rotate(angle: _newBagRotation.value, child: child));
                },
                child: Image.asset("img/smartbag/flowpack.webp"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildMobile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text.rich(
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.r.wp(100) * 0.06).clamp(22, 40), color: Colors.black.withAlpha(200)),
            TextSpan(
              children: [
                TextSpan(text: "La opción ligera, versátil y económica para productos de "),
                TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.blue)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            navigateWithSlide(context, widget.route);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Elige Flowpack Smart",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: (widget.r.wp(100) * 0.03).clamp(18, 26), color: Colors.black),
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
                    child: Transform.rotate(angle: _rotationAnim.value, child: Transform.scale(scale: _scaleAnim.value, child: child)),
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

                  return Transform.translate(offset: _newBagSlide.value * 300, child: Transform.rotate(angle: _newBagRotation.value, child: child));
                },
                child: Image.asset("img/smartbag/flowpack.webp"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
