import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class FourProEco extends StatelessWidget {
  final Responsive r;
  final Subcategorie subcategorie;
  const FourProEco({super.key, required this.subcategorie, required this.r});

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF4B8D2C);
    final route = '${subcategorie.route}/crea-tu-empaque';
    final isMobile = r.wp(100) < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFFF8),
      body: CustomScrollView(
        slivers: [
          Intro4PROEcoSliver(r: r, route: route, green: green),
          NewFormToSeeSliver(r: r, green: green, isMobile: isMobile),
          BagChangeSliver(green: green, r: r),
          LayersExplainSliver(r: r, green: green, isMobile: isMobile),
          InformationPeelAndValveSliver(r: r, green: green),
          VideoSliver4PROEcoSliver(r: r),
          Scroll4EcoFunctionsSliver(r: r, green: green, isMobile: isMobile),
          WeCareUsSliver(r: r, isMobile: isMobile, green: green),
          SliverToBoxAdapter(child: SizedBox(width: r.wp(100), height: r.hp(90), child: LeafWithBagReveal(route: route))),
          SliverToBoxAdapter(child: const Footer()),
        ],
      ),
    );
  }
}

//---------Intro de 4PRO Ecobag------------
class Intro4PROEcoSliver extends StatefulWidget {
  final Responsive r;
  final String route;
  final Color green;

  const Intro4PROEcoSliver({super.key, required this.r, required this.route, required this.green});

  @override
  State<Intro4PROEcoSliver> createState() => _Intro4PROEcoSliverState();
}

class _Intro4PROEcoSliverState extends State<Intro4PROEcoSliver> {
  final String textLine1 = "4PRO";
  final String textLine2 = "EcoBag®";
  bool _showImage = false;
  final List<bool> visibleLettersLine1 = [];
  final List<bool> visibleLettersLine2 = [];

  final Duration delayBetweenLetters = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    _startAnimation();
    Future.delayed(const Duration(milliseconds: 1400), () {
      setState(() {
        _showImage = true;
      });
    });
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
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 45.0),
        child: SizedBox(
          height: widget.r.hp(100),
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
                      child: SizedBox(height: widget.r.hp(34, max: 500), child: Image.asset("img/ecobag/4pro/inicio.webp", fit: BoxFit.contain)),
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
                      textStyle: TextStyle(fontSize: widget.r.fs(6, 80), fontWeight: FontWeight.bold, color: Colors.black),
                    );
                  }),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(textLine2.length, (index) {
                    return AnimatedLetter(
                      char: textLine2[index],
                      visible: index < visibleLettersLine2.length,
                      key: ValueKey("line2-$index"),
                      textStyle: TextStyle(fontSize: widget.r.fs(6, 90), fontWeight: FontWeight.w300, color: widget.green),
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
                        navigateWithSlide(context, widget.route); // tu función personalizada
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
                              "Crear mi EcoBag® 4PRO",
                              textStyle: TextStyle(fontSize: 20),
                              colors: [widget.green, widget.green, Colors.white],
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
    );
  }
}

//---------Creación de EcoBag® 4PRO------------
class NewFormToSeeSliver extends StatelessWidget {
  const NewFormToSeeSliver({super.key, required this.r, required this.green, required this.isMobile});

  final Responsive r;
  final Color green;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: 40),
        width: r.wp(100, max: 1700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Text(
                "Nueva forma de ver\nla sustentabilidad",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: r.fs(4, 60), height: 1.2),
              ),
            ),
            SizedBox(height: 30),
            ScrollAnimatedWrapper(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: r.wp(100, max: 700),
                  child: Text.rich(
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black54, fontSize: r.fs(2, 25), height: 1.4),
                    TextSpan(
                      children: [
                        TextSpan(text: "EcoBag® 4PRO ", style: TextStyle(color: green)),
                        TextSpan(text: "nació de la necesidad de redefinir el empaque sostenible. Su diseño integra "),
                        TextSpan(text: "materiales responsables con el medio ambiente ", style: TextStyle(color: green)),
                        TextSpan(
                          text:
                              "y un enfoque funcional que no sacrifica estilo ni eficiencia. Estructura reforzada, resistencia superior y acabado elegante, es ideal para marcas que buscan destacar y, al mismo tiempo, ",
                        ),
                        TextSpan(text: "reducir su huella ecológica.", style: TextStyle(color: green)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: isMobile ? 50 : 100),
            ScrollAnimatedWrapper(
              child: Container(
                height: 600,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromARGB(255, 242, 248, 240)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      style: TextStyle(fontSize: r.fs(2, 24)),
                      TextSpan(
                        children: [
                          TextSpan(text: "Resistencia con estilo. EcoBag® 4PRO ", style: TextStyle(fontWeight: FontWeight.bold, color: green)),
                          TextSpan(
                            text:
                                "está disponible en una gama de colores vibrantes y naturales que reflejan el compromiso con la sostenibilidad y el diseño contemporáneo.",
                          ),
                        ],
                      ),
                    ),
                    isMobile
                        ? Expanded(child: Image.asset("img/ecobag/4pro/Bags.webp", fit: BoxFit.contain))
                        : Expanded(
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: videoBlurNotifier,
                                builder: (context, isBlur, _) {
                                  return VideoFlutter(
                                    src: 'assets/videos/ecobag/4pro/videoBolsas.webm',
                                    loop: false,
                                    isPause: false,
                                    fit: BoxFit.contain,
                                    blur: isBlur,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Nota: Los colores mostrados en la imagen son solo una referencia. Contamos con una amplia variedad de colores disponibles para personalizar tu empaque según tu marca y necesidades.",
                        style: TextStyle(color: green.withAlpha(150), fontSize: 12),
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

//---------Bolsa cambiante------------
class BagChangeSliver extends StatefulWidget {
  const BagChangeSliver({super.key, required this.green, required this.r});

  final Color green;
  final Responsive r;

  @override
  State<BagChangeSliver> createState() => _BagChangeSliverState();
}

class _BagChangeSliverState extends State<BagChangeSliver> {
  final ScrollController _scrollColors = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;
  String selectedColor = "Kraft Blanco";

  final List<Map<String, dynamic>> colors = [
    // {"name": "Kraft Azul", "color": const Color.fromARGB(225, 18, 97, 161), "image": "img/ecobag/4pro.webp"},
    {"name": "Kraft Blanco", "color": const Color(0xFFC7C7C7), "image": "img/ecobag/4pro/Kraft_Blanco.webp"},
    // {"name": "Kraft Beige", "color": const Color.fromARGB(255, 211, 163, 96), "image": "img/ecobag/4pro.webp"},
    {"name": "Kraft Natural", "color": const Color(0xFFF2B787), "image": "img/ecobag/4pro/inicio.webp"},
    {"name": "Kraft Barroco Natural", "color": const Color(0xFFCB986E), "image": "img/ecobag/4pro/barroco_Natural.webp"},
    {"name": "Kraft Natural Negro", "color": Colors.black87, "image": "img/ecobag/4pro/Kraft_negro.webp"},
    {"name": "Kraft Natural Rojo", "color": Colors.red, "image": "img/ecobag/4pro/Kraft_rojo.webp"},
    {"name": "Kraft Grano Café", "color": Colors.brown, "image": "img/ecobag/4pro/grano_cafe.webp"},
    {"name": "Kraft Verde Oliva", "color": Colors.green, "image": "img/ecobag/4pro/Kraft_verde.webp"},
    //{"name": "Kraft Verde Manzana Biche", "color": Colors.lightGreen, "image": "img/ecobag/4pro.webp"},
  ];

  @override
  void initState() {
    super.initState();

    //Scroll colores
    _scrollColors.addListener(_updateArrowVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateArrowVisibility());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Aquí es seguro usar context para precargar
    for (var item in colors) {
      precacheImage(AssetImage(item["image"]), context);
    }
  }

  @override
  void dispose() {
    _scrollColors.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final selectedItem = colors.firstWhere((item) => item["name"] == selectedColor, orElse: () => colors.first);

    return SliverToBoxAdapter(
      child: Column(
        children: [
          ScrollAnimatedWrapper(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
              child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: widget.r.fs(5, 60), height: 0),
                TextSpan(
                  children: [TextSpan(text: "PackVision.\n", style: TextStyle(color: widget.green)), TextSpan(text: "Conecta con lo esencial.")],
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 24),
            width: 1000,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "Más que tecnología, es una forma de repensar el empaque. Con Ecobag® 4PRO, visualizas cada detalle con intención: desde el material hasta el impacto ambiental. Explora opciones sostenibles, adapta tu diseño a lo que el planeta necesita y toma decisiones que marcan la diferencia. Rápido, simple y responsable.",
                style: TextStyle(fontSize: widget.r.fs(2, 24), color: Colors.black87),
              ),
            ),
          ),
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
                  widget.r.wp(100) <= 1000
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
                                                  (item) => _buildColorLabel(item["name"], item["color"], isSelected: selectedColor == item["name"]),
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
                      : ScrollAnimatedWrapper(
                        child: Stack(
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
                      ),
                ],
              ),
            ),
          ),
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

//---------Información acerca de la 4PRO Ecobag------------
class LayersExplainSliver extends StatelessWidget {
  final Responsive r;
  final Color green;
  final bool isMobile;
  const LayersExplainSliver({super.key, required this.r, required this.green, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(6, max: 40)),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(5, 60), height: 0.9),
                  TextSpan(
                    children: [TextSpan(text: "4PRO EcoBag®", style: TextStyle(color: green)), TextSpan(text: "\nProtege. Impacta. Transforma.")],
                  ),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(4, max: 40)),
                child: Text.rich(
                  style: TextStyle(fontSize: r.fs(2, 24), fontWeight: FontWeight.w300),
                  TextSpan(
                    children: [
                      TextSpan(text: "Disponible en versiones de "),
                      TextSpan(text: "3 y 4 láminas ", style: TextStyle(color: green, fontWeight: FontWeight.bold)),
                      TextSpan(text: "para adaptarse a tus necesidades de protección, frescura y sostenibilidad."),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: r.wp(6)), child: isMobile ? _buildPhone() : _buildDesktop()),
          ],
        ),
      ),
    );
  }

  Container _buildDesktop() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: 1200,
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text.rich(
                    style: TextStyle(fontSize: r.fs(1.8, 24), fontWeight: FontWeight.w300),
                    TextSpan(
                      children: [
                        TextSpan(text: "Las bolsas Ecobag 4PRO están compuestas por 3 láminas que trabajan juntas para mantener "),
                        TextSpan(text: "la frescura y resistencia en cada empaque. ", style: TextStyle(color: green, fontWeight: FontWeight.bold)),
                        TextSpan(text: "Esta estructura optimiza el rendimiento sin sacrificar flexibilidad ni sostenibilidad."),
                      ],
                    ),
                  ),
                  SizedBox(height: r.hp(4, max: 60)),
                  Text.rich(
                    style: TextStyle(fontSize: r.fs(1.8, 24), fontWeight: FontWeight.w300),
                    TextSpan(
                      children: [
                        TextSpan(text: "Cuando tu diseño requiere una ventana frontal, "),
                        TextSpan(
                          text: "se añade una cuarta lámina que protege sin comprometer la visibilidad del producto. ",
                          style: TextStyle(color: green, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " La capa adicional mantiene la integridad del empaque mientras ofrece una experiencia visual única."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 2, child: Image.asset("img/ecobag/4pro/twoBags.webp", fit: BoxFit.fitWidth, height: 600)),
          ],
        ),
      ),
    );
  }

  Column _buildPhone() {
    return Column(
      children: [
        ScrollAnimatedWrapper(
          child: Text.rich(
            style: TextStyle(fontSize: r.fs(2, 24), fontWeight: FontWeight.w300),
            TextSpan(
              children: [
                TextSpan(text: "Las bolsas Ecobag 4PRO están compuestas por 3 láminas que trabajan juntas para mantener "),
                TextSpan(text: "la frescura y resistencia en cada empaque. ", style: TextStyle(color: green, fontWeight: FontWeight.bold)),
                TextSpan(text: "Esta estructura optimiza el rendimiento sin sacrificar flexibilidad ni sostenibilidad."),
              ],
            ),
          ),
        ),

        ScrollAnimatedWrapper(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.asset("img/ecobag/4pro/Kraft_negro.webp", height: 600, fit: BoxFit.fitHeight),
          ),
        ),

        ScrollAnimatedWrapper(
          child: Text.rich(
            style: TextStyle(fontSize: r.fs(2, 24), fontWeight: FontWeight.w300),
            TextSpan(
              children: [
                TextSpan(text: "Cuando tu diseño requiere una ventana frontal, "),
                TextSpan(
                  text: "se añade una cuarta lámina que protege sin comprometer la visibilidad del producto. ",
                  style: TextStyle(color: green, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: " La capa adicional mantiene la integridad del empaque mientras ofrece una experiencia visual única."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//---------Información acerca del peel y la válvula------------
class InformationPeelAndValveSliver extends StatelessWidget {
  final Responsive r;
  final Color green;
  const InformationPeelAndValveSliver({super.key, required this.r, required this.green});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: r.hp(16, max: 120)),
        child: SizedBox(
          width: r.wp(100, max: 1720),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "Con sistema de cierre.",
                  style: TextStyle(fontSize: r.fs(5, 55), color: green, fontWeight: FontWeight.bold, height: 0),
                ),
                SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.start,
                  "Preserva la frescura con válvula y Peel & Stick sin complicaciones.",
                  style: TextStyle(fontSize: r.fs(3.2, 40), fontWeight: FontWeight.bold, height: 0),
                ),
                SizedBox(height: 30),
                Text(
                  "La EcoBag® 4PRO con sistema de válvula y sello Peel & Stick ofrece una solución versátil y práctica para preservar la frescura de tus productos. Su diseño multicapa permite una conservación prolongada, mientras que la válvula garantiza una liberación controlada de gases. El cierre Peel & Stick aporta facilidad de uso y reutilización sin comprometer el sellado. Todo en un empaque sostenible, inteligente y visualmente impactante.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: r.fs(2.1, 24), fontWeight: FontWeight.w500, height: 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//---------Video------------
class VideoSliver4PROEcoSliver extends StatelessWidget {
  final Responsive r;
  const VideoSliver4PROEcoSliver({super.key, required this.r});

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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: pdh),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: SizedBox(
                width: double.infinity,
                height: r.hp(80, max: 1100),
                child: VideoFlutter(src: 'assets/videos/ecobag/4pro/animacion.webm', blur: false, loop: true, showControls: true, fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }
}

//---------Scroll 4 funciones, 4pro Ecobag------------
class Scroll4EcoFunctionsSliver extends StatefulWidget {
  const Scroll4EcoFunctionsSliver({super.key, required this.r, required this.green, required this.isMobile});

  final bool isMobile;
  final Responsive r;
  final Color green;

  @override
  State<Scroll4EcoFunctionsSliver> createState() => _Scroll4EcoFunctionsSliverState();
}

class _Scroll4EcoFunctionsSliverState extends State<Scroll4EcoFunctionsSliver> {
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
    final List<dynamic> localCards = [
      {"title": "4PRO Ecobag® está\ndiseñada pensando en el planeta. ", "image": "img/ecobag/4pro/cardLarge1.webp"},
      {"title": "Tu producto merece verse\ny mantenerse\nimpecable.", "image": "img/ecobag/4pro/cardLarge2.webp"},
      {
        "title": "Cierre hermético, zipper,\nválvula desgasificadora.Todo para que\ntu producto luzca profesional.",
        "image": "img/ecobag/4pro/cardLarge3.webp",
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: widget.r.wp(100),
        padding: EdgeInsets.only(bottom: widget.r.dp(7), top: widget.r.hp(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Text("4 Funciones, 4PRO.", style: TextStyle(fontWeight: FontWeight.bold, color: widget.green, fontSize: widget.r.fs(2.6, 60))),
              ),
            ),
            SizedBox(height: widget.r.hp(3)),
            SingleChildScrollView(
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
                      height: widget.r.hp(widget.isMobile ? 40 : 60, max: 600),
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
