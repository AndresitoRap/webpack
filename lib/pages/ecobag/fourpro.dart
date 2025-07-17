import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/htmlvideo.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class FourProEco extends StatefulWidget {
  final double screenWidth;
  final String currentRoute;
  final Subcategorie subcategorie;
  final String section;
  const FourProEco({super.key, required this.screenWidth, required this.currentRoute, required this.subcategorie, required this.section});

  @override
  State<FourProEco> createState() => _FourProEcoState();
}

class _FourProEcoState extends State<FourProEco> with TickerProviderStateMixin {
  final String textLine1 = "4PRO";
  final String textLine2 = "EcoBag";
  bool _showImage = false;
  final ScrollController scrollControllerCards = ScrollController();

  final List<bool> visibleLettersLine1 = [];
  final List<bool> visibleLettersLine2 = [];

  final Duration delayBetweenLetters = const Duration(milliseconds: 100);

  //Scroll colores
  final ScrollController _scrollColors = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;
  String selectedColor = "Kraft Azul";

  //Cards
  final ScrollController _scrollController = ScrollController();
  bool scrollControllerLeft = false;
  bool scrollControllerRigth = true;
  void _handleScroll() {
    final position = scrollControllerCards.position;
    setState(() {
      scrollControllerLeft = position.pixels > 0;
      scrollControllerRigth = position.pixels < position.maxScrollExtent;
    });
  }

  double scrollProgress = 0.0; // va de 0.0 a 1.0 según el scroll
  final GlobalKey _videoKey = GlobalKey();

  final List<Map<String, dynamic>> colors = [
    {"name": "Kraft Azul", "color": const Color.fromARGB(225, 18, 97, 161), "image": "assets/img/ecobag/4pro.webp"},
    {"name": "Kraft Blanco", "color": const Color.fromARGB(255, 199, 199, 199), "image": "assets/img/ecobag/4pro.webp"},
    {"name": "Kraft Beige", "color": const Color.fromARGB(255, 211, 163, 96), "image": "assets/img/ecobag/4pro.webp"},
    {"name": "Kraft Natural", "color": const Color.fromARGB(255, 242, 183, 135), "image": "assets/img/ecobag/4pro/Kraft_natural.webp"},
    {"name": "Kraft Natural Negro", "color": Colors.black87, "image": "assets/img/ecobag/4pro/Kraft_negro.webp"},
    {"name": "Kraft Natural Rojo", "color": Colors.red, "image": "assets/img/ecobag/4pro/Kraft_rojo.webp"},
    {"name": "Kraft Verde Oscuro", "color": Colors.green, "image": "assets/img/ecobag/4pro/Kraft_verde.webp"},
    {"name": "Kraft Verde Manzana Biche", "color": Colors.lightGreen, "image": "assets/img/ecobag/4pro.webp"},
  ];

  void _updateArrowVisibility() {
    if (!_scrollColors.hasClients || !_scrollColors.position.hasContentDimensions) return;

    final offset = _scrollColors.offset;
    final maxScroll = _scrollColors.position.maxScrollExtent;

    setState(() {
      _showLeftArrow = offset > 10;
      _showRightArrow = offset < maxScroll - 10;
    });
  }

  void _scrollRight() {
    final newOffset = (_scrollColors.offset + 200).clamp(0.0, _scrollColors.position.maxScrollExtent);
    _scrollColors.animateTo(newOffset, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  void _scrollLeft() {
    final newOffset = (_scrollColors.offset - 200).clamp(0.0, _scrollColors.position.maxScrollExtent);
    _scrollColors.animateTo(newOffset, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() {
        _showImage = true;
      });
    });

    //Scroll colores
    _scrollColors.addListener(_updateArrowVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateArrowVisibility());

    // Listener de scroll principal
    _scrollController.addListener(_onScroll);
    scrollControllerCards.addListener(_handleScroll);
  }

  void _onScroll() {
    // RenderBox del widget
    final box = _videoKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Distancia desde el widget hasta la parte superior visible
    final widgetTop = box.localToGlobal(Offset.zero).dy;
    final viewportHeight = MediaQuery.of(context).size.height;

    // Queremos que la animación empiece cuando el widget
    // entra en los primeros 200 px del viewport
    final raw = (viewportHeight - widgetTop).clamp(0, 200);
    final progress = raw / 200;
    setState(() {
      scrollProgress = progress;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Aquí es seguro usar context para precargar
    for (var item in colors) {
      precacheImage(AssetImage(item["image"]), context);
    }
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < textLine1.length; i++) {
      await Future.delayed(delayBetweenLetters);
      setState(() {
        visibleLettersLine1.add(true);
      });
    }

    await Future.delayed(const Duration(milliseconds: 300)); // pequeño delay entre líneas

    for (int i = 0; i < textLine2.length; i++) {
      await Future.delayed(delayBetweenLetters);
      setState(() {
        visibleLettersLine2.add(true);
      });
    }
  }

  @override
  void dispose() {
    _scrollColors.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = widget.screenWidth;
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedItem = colors.firstWhere((item) => item["name"] == selectedColor, orElse: () => colors.first);

    final List<dynamic> localCards = [
      {"title": "4PRO Ecobag® está\ndiseñada pensando en el planeta. ", "image": "assets/img/home/eco.webp"},
      {"title": "Tu producto merece verse\ny mantenerse\nimpecable.", "image": "assets/img/home/eco.webp"},
      {
        "title": "Cierre hermético, zipper,\nválvula desgasificadora.Todo para que\ntu producto luzca profesional.",
        "image": "assets/img/home/eco.webp",
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 255, 252),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight,
              child: SizedBox(
                height: screenHeight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _showImage ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        child: AnimatedScale(
                          scale: _showImage ? 1.0 : 1.3,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOutBack,
                          child: AnimatedSlide(
                            offset: _showImage ? Offset(0, 0) : Offset(0, 0.1),
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeOut,
                            child: SizedBox(height: 500, width: 500, child: Image.asset("assets/img/ecobag/4pro.webp", fit: BoxFit.cover)),
                          ),
                        ),
                      ),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(textLine1.length, (index) {
                          return AnimatedLetter(
                            char: textLine1[index],
                            visible: index < visibleLettersLine1.length,
                            key: ValueKey("line1-$index"),
                            textStyle: TextStyle(fontSize: min(screenWidth * 0.1, 130), fontWeight: FontWeight.bold, color: Colors.black),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(textLine2.length, (index) {
                          return AnimatedLetter(
                            char: textLine2[index],
                            visible: index < visibleLettersLine2.length,
                            key: ValueKey("line2-$index"),
                            textStyle: TextStyle(
                              fontSize: min(screenWidth * 0.1, 90),
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 75, 141, 44),
                            ),
                          );
                        }),
                      ),
                      AnimatedOpacity(
                        opacity: _showImage ? 1.0 : 0.0,
                        duration: const Duration(seconds: 2), // duración del fade in
                        curve: Curves.easeInOut,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              final route = '${widget.subcategorie.route}/crea-tu-empaque';
                              // print(route);
                              navigateWithSlide(context, route); // tu función personalizada
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white),
                              overlayColor: WidgetStatePropertyAll(Color.fromARGB(255, 222, 240, 213)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedTextKit(
                                repeatForever: false,
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    "Crear mi Ecobag® 4PRO",
                                    textStyle: TextStyle(fontSize: 20),
                                    colors: [Color.fromARGB(255, 75, 141, 44), Color.fromARGB(255, 75, 141, 44), Colors.white],
                                    speed: Duration(milliseconds: 500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 40),
              width: min(screenWidth, 1720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('nuevaforma-text'),

                    child: Text(
                      "Nueva forma de ver\nla sustentabilidad",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 75, 141, 44),
                        fontSize: min(screenWidth * 0.08, 70),
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('ecobag4pronacio-text'),

                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: min(screenWidth, 700),
                        child: Text(
                          "Ecobag® 4PRO nació de la necesidad de redefinir el empaque sostenible. Su diseño integra materiales responsables con el medio ambiente y un enfoque funcional que no sacrifica estilo ni eficiencia. Estructura reforzada, resistencia superior y acabado elegante, es ideal para marcas que buscan destacar y, al mismo tiempo, reducir su huella ecológica.",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black54, fontSize: min(screenWidth * 0.032, 25), height: 1.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key('resistenciaconestilo-text'),

                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 800,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(255, 242, 248, 240)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            style: TextStyle(fontSize: min(screenWidth * 0.032, 23)),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Resistencia con estilo. Ecobag® 4PRO ",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44)),
                                ),
                                TextSpan(
                                  text:
                                      "está disponible en una gama de colores vibrantes y naturales que reflejan el compromiso con la sostenibilidad y el diseño contemporáneo.",
                                ),
                              ],
                            ),
                          ),
                          if (screenWidth >= 990) SizedBox(height: 100),
                          Expanded(child: Center(child: Image.asset("assets/img/ecobag/4pro/Bags.png", fit: BoxFit.contain))),
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Nota: Los colores mostrados en la imagen son solo una referencia. Contamos con una amplia variedad de colores disponibles para personalizar tu empaque según tu marca y necesidades.",
                              style: TextStyle(color: Color.fromARGB(255, 75, 141, 44).withAlpha(150), fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenWidth >= 800 ? 200 : 50),

            ScrollAnimatedWrapper(
              visibilityKey: Key('Packvision-conecta'),
              child: Column(
                children: [
                  Text(
                    "PackVision®",
                    style: TextStyle(
                      color: Color.fromARGB(255, 75, 141, 44),
                      fontWeight: FontWeight.bold,
                      fontSize: min(screenWidth * 0.08, 60),
                      height: 0,
                    ),
                  ),
                  Text(
                    "Conecta con lo esencial.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: min(screenWidth * 0.08, 60), height: 0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    width: 1000,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Más que tecnología, es una forma de repensar el empaque. Con Ecobag® 4PRO, visualizas cada detalle con intención: desde el material hasta el impacto ambiental. Explora opciones sostenibles, adapta tu diseño a lo que el planeta necesita y toma decisiones que marcan la diferencia. Rápido, simple y responsable.",
                        style: TextStyle(fontSize: min(screenWidth * 0.025, 23), color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: double.infinity,
                height: 800,
                constraints: BoxConstraints(minHeight: 800),
                child: ScrollAnimatedWrapper(
                  visibilityKey: Key("Change-bag"),
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
                      screenWidth <= 1000
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
                                                colors: [Colors.white60, Colors.white],
                                              ),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(CupertinoIcons.chevron_left, color: Color(0xFF4B8D2C)),
                                              onPressed: _scrollLeft,
                                            ),
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
                                                colors: [Colors.white60, Colors.white],
                                              ),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(CupertinoIcons.chevron_right, color: Color(0xFF4B8D2C)),
                                              onPressed: _scrollRight,
                                            ),
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
                                  duration: const Duration(milliseconds: 400), // ⏱️ velocidad del fade
                                  switchInCurve: Curves.easeInOut, // suavizado
                                  switchOutCurve: Curves.easeInOut,
                                  transitionBuilder: (Widget child, Animation<double> anim) => FadeTransition(opacity: anim, child: child),
                                  child: SizedBox(
                                    height: 800,
                                    child: Image.asset(selectedItem["image"], key: ValueKey(selectedItem["image"]), fit: BoxFit.fitHeight),
                                  ),
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

            SizedBox(height: screenWidth >= 800 ? 200 : 50),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Protege-imapacta"),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.06, 60), height: 0.9),
                        TextSpan(
                          children: [
                            TextSpan(text: "4PRO Ecobag®", style: TextStyle(color: Color.fromARGB(255, 75, 141, 44))),
                            TextSpan(text: "\nProtege. Impacta. Transforma."),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Disponible-en"),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth <= 1000 ? 50 : 100),
                      child: Text.rich(
                        style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                        TextSpan(
                          children: [
                            TextSpan(text: "Disponible en versiones de "),
                            TextSpan(text: "3 y 4 láminas ", style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold)),
                            TextSpan(text: "para adaptarse a tus necesidades de protección, frescura y sostenibilidad."),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ScrollAnimatedWrapper(
                    visibilityKey: Key("Info-disponible"),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child:
                          screenWidth <= 1000
                              ? Column(
                                children: [
                                  Text.rich(
                                    style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                    TextSpan(
                                      children: [
                                        TextSpan(text: "Las bolsas Ecobag 4PRO están compuestas por 3 láminas que trabajan juntas para mantener "),
                                        TextSpan(
                                          text: "la frescura y resistencia en cada empaque. ",
                                          style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: "Esta estructura optimiza el rendimiento sin sacrificar flexibilidad ni sostenibilidad."),
                                      ],
                                    ),
                                  ),
                                  Image.asset("assets/img/ecobag/4pro/Kraft_negro.webp", height: 600, fit: BoxFit.fitHeight),
                                  Text.rich(
                                    style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                    TextSpan(
                                      children: [
                                        TextSpan(text: "Cuando tu diseño requiere una ventana frontal, "),
                                        TextSpan(
                                          text: "se añade una cuarta lámina que protege sin comprometer la visibilidad del producto. ",
                                          style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: " La capa adicional mantiene la integridad del empaque mientras ofrece una experiencia visual única.",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              : SizedBox(
                                width: 1200,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Text.rich(
                                              style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Las bolsas Ecobag 4PRO están compuestas por 3 láminas que trabajan juntas para mantener ",
                                                  ),
                                                  TextSpan(
                                                    text: "la frescura y resistencia en cada empaque. ",
                                                    style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(
                                                    text: "Esta estructura optimiza el rendimiento sin sacrificar flexibilidad ni sostenibilidad.",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: screenWidth <= 1000 ? 50 : 100),
                                            Text.rich(
                                              style: TextStyle(fontSize: min(screenWidth * 0.025, 23), fontWeight: FontWeight.w300),
                                              TextSpan(
                                                children: [
                                                  TextSpan(text: "Cuando tu diseño requiere una ventana frontal, "),
                                                  TextSpan(
                                                    text: "se añade una cuarta lámina que protege sin comprometer la visibilidad del producto. ",
                                                    style: TextStyle(color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        " La capa adicional mantiene la integridad del empaque mientras ofrece una experiencia visual única.",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Image.asset("assets/img/ecobag/4pro/Kraft_negro.webp", fit: BoxFit.fitHeight, height: 600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth <= 1000 ? 50 : 150),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: SizedBox(
                width: min(screenWidth, 1720),
                child: Center(
                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key("Peel-valv-sistemas"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          "Con sistema de cierre.",
                          style: TextStyle(
                            fontSize: min(screenWidth * 0.06, 50),
                            color: Color.fromARGB(255, 75, 141, 44),
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          textAlign: TextAlign.start,
                          "Preserva la frescura con válvula y\nPeel & Stick sin complicaciones.",
                          style: TextStyle(fontSize: min(screenWidth * 0.06, 50), fontWeight: FontWeight.bold, height: 0),
                        ),
                        SizedBox(height: 30),

                        Text(
                          "La Ecobag 4PRO con sistema de válvula y sello Peel & Stick ofrece una solución versátil y práctica para preservar la frescura de tus productos. Su diseño multicapa permite una conservación prolongada, mientras que la válvula garantiza una liberación controlada de gases. El cierre Peel & Stick aporta facilidad de uso y reutilización sin comprometer el sellado. Todo en un empaque sostenible, inteligente y visualmente impactante.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: min(screenWidth * 0.03, 25), fontWeight: FontWeight.w500, height: 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight <= 1000 ? 50 : 100),
            ScrollAnimatedWrapper(
              visibilityKey: Key("Video-ecobag-ps-vlv"),
              child: TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                tween: Tween<double>(begin: 0.0, end: scrollProgress),
                builder: (context, scrollProgress, child) {
                  final borderRadius = BorderRadius.circular(30 * scrollProgress);
                  final horizontalPadding = screenWidth * 0.055 * scrollProgress;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
                    child: ClipRRect(
                      key: _videoKey,
                      borderRadius: borderRadius,
                      child: SizedBox(
                        width: double.infinity,
                        height: min(screenHeight * 0.8, 1100),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return HtmlBackgroundVideo(
                                  src: 'assets/assets/videos/smartbag/SmartbagInicio.webm',
                                  blur: isBlur,
                                  loop: true,
                                  showControls: true,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight <= 1000 ? 50 : 100),

            ScrollAnimatedWrapper(
              visibilityKey: Key('4funciones'),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.03),
                child: Row(
                  children: [
                    Text(
                      "4 Funciones, 4PRO",
                      style: TextStyle(fontSize: min(screenWidth * 0.03, 60), color: Color.fromARGB(255, 75, 141, 44), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            //Discover local
            ScrollAnimatedWrapper(
              visibilityKey: Key('4funciones-cards'),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollControllerCards,
                child: Row(
                  children: List.generate(localCards.length, (int index) {
                    final card = localCards[index];
                    final double horizontalPadding = screenWidth * 0.06;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? horizontalPadding : 0,
                        right: index == localCards.length - 1 ? horizontalPadding : 20,
                      ),
                      child: Container(
                        width: min(screenWidth * 0.8, 1000),
                        height: min(screenWidth * 0.6, 500),
                        padding: EdgeInsets.only(top: 22, left: 22),
                        margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          image: DecorationImage(image: AssetImage(card['image']), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        card['title'],
                                        style: TextStyle(
                                          height: 0,
                                          color: Colors.white,
                                          fontSize: min(screenWidth * 0.03, 25),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 1, child: SizedBox(width: 100)),
                              ],
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
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Botón izquierdo
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(scrollControllerLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                    ),
                    onPressed:
                        scrollControllerLeft
                            ? () {
                              scrollControllerCards.animateTo(
                                scrollControllerCards.offset - 1000,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            }
                            : null,
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(scrollControllerRigth ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                    ),
                    onPressed:
                        scrollControllerRigth
                            ? () {
                              scrollControllerCards.animateTo(
                                scrollControllerCards.offset + 1000,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            }
                            : null,
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth <= 1000 ? 50 : 100),
            SizedBox(
              width: min(screenWidth, 1600),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.06, horizontal: screenWidth * 0.06),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key('nos-importa'),
                    child: Column(
                      children: [
                        Text(
                          "Te importa. Nos importa.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 75, 141, 44),
                            fontSize: min(screenWidth * 0.06, 70),
                          ),
                        ),
                        SizedBox(height: screenWidth >= 1000 ? 50 : 100),
                        Text(
                          textAlign: TextAlign.center,
                          "Desde empaques como 4PRO®, diseñados para proteger tu producto y destacar tu marca, hasta soluciones como Ecobag, que combinan funcionalidad con conciencia ambiental. Usamos materiales reciclables, desarrollamos opciones versátiles como válvulas y cierres herméticos, y te ofrecemos formatos pensados para cada necesidad, siempre con una visión sustentable. Porque cada detalle cuenta cuando quieres hacer las cosas bien.",
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
                                          "Usamos materiales reciclables y procesos responsables en toda la línea 4PRO® y Ecobag.",
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
                                            child: _buildBenefitBox(icon: item.$1, title: item.$2, description: item.$3),
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
                                          "Usamos materiales reciclables y procesos responsables en toda la línea 4PRO® y Ecobag.",
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
                                          child: _buildBenefitBox(icon: item.$1, title: item.$2, description: item.$3),
                                        ),
                                    ],
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Expanded(child: LeafWithBagReveal(currentRoute: widget.currentRoute, subcategorie: widget.subcategorie, section: widget.section)),
              ],
            ),

            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitBox({required IconData icon, required String title, required String description}) {
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
