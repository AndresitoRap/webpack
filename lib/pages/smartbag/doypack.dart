import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class DoypackSmart extends StatelessWidget {
  const DoypackSmart({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 850;
    final blue = Theme.of(context).primaryColor;

    return CustomScrollView(
      slivers: [
        SliverToStart(screenHeight: screenHeight, screenWidth: screenWidth, blue: blue),
        SliverInfoDoypack(screenWidth: screenWidth, isMobile: isMobile),
        SliverWithGramaje(isMobile: isMobile, screenWidth: screenWidth, blue: blue),
        SliverWithMoreInfoDoypack(screenWidth: screenWidth, blue: blue, isMobile: isMobile),
        SliverWithDeclaracionDeExcelencia(isMobile: isMobile, screenWidth: screenWidth, blue: blue),
        SliverWithVentanaInfo(blue: blue, screenWidth: screenWidth, isMobile: isMobile),
        SliverWithResumen(screenWidth: screenWidth, isMobile: isMobile, blue: blue),
        SliverToBoxAdapter(child: Footer()),
      ],
    );
  }
}

//Inicio de la doypack
class SliverToStart extends StatefulWidget {
  const SliverToStart({super.key, required this.screenHeight, required this.screenWidth, required this.blue});

  final double screenHeight;
  final double screenWidth;
  final Color blue;

  @override
  State<SliverToStart> createState() => _SliverToStartState();
}

class _SliverToStartState extends State<SliverToStart> with TickerProviderStateMixin {
  //Inicio
  final String text = "Doypack";
  late final List<AnimationController> _controllers = [];
  late final List<Animation<Offset>> _slideAnimations = [];
  late final List<Animation<double>> _fadeAnimations = [];

  //Video que cubre
  late final AnimationController _coverController;
  late final Animation<Offset> _coverSlide;

  //Texto arriba del video
  late final AnimationController _doypackController;
  late final Animation<double> _doypackFade;

  //Boton de abajo
  late final AnimationController _buttonController;
  late final Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    for (int i = 0; i < text.length; i++) {
      final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

      final slide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

      final fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

      _controllers.add(controller);
      _slideAnimations.add(slide);
      _fadeAnimations.add(fade);
    }

    // Cubierta gris que sube
    _coverController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _coverSlide = Tween<Offset>(
      begin: const Offset(0, 10),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _coverController, curve: Curves.fastEaseInToSlowEaseOut));

    _doypackController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _doypackFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _doypackController, curve: Curves.easeIn));

    _buttonController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _buttonFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      _controllers[i].forward();
    }

    // Espera un momento y luego lanza la cubierta
    await Future.delayed(const Duration(milliseconds: 600));
    _coverController.forward();

    await _coverController.forward();

    await Future.delayed(const Duration(milliseconds: 400)); // pequeño espacio
    _doypackController.forward();

    await _doypackController.forward();

    await Future.delayed(const Duration(milliseconds: 200)); // pequeño espacio
    _buttonController.forward();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _coverController.dispose();
    _doypackController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(),
        clipBehavior: Clip.antiAlias,
        height: widget.screenHeight + 25,
        width: widget.screenWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Texto animado
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(text.length, (index) {
                return SlideTransition(
                  position: _slideAnimations[index],
                  child: FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: Text(text[index], style: TextStyle(fontSize: (widget.screenWidth * 0.1).clamp(40, 70), fontWeight: FontWeight.bold)),
                  ),
                );
              }),
            ),
            //Texto después de video
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _doypackFade,
                child: Text(
                  textAlign: TextAlign.center,
                  "Doypack",
                  style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: (widget.screenWidth * 0.2).clamp(80, 120)),
                ),
              ),
            ),
            // Cubierta que sube y tapa el texto
            SlideTransition(
              position: _coverSlide,
              child: Container(height: widget.screenHeight + 25, width: widget.screenWidth, color: Colors.grey.withAlpha(100)),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _buttonFade,
                child: Column(
                  children: [
                    Text(
                      "Exclusiva para tí.",
                      style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: (widget.screenWidth * 0.06).clamp(20, 30)),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(widget.blue), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Crear mi doypack",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenHeight * 0.025).clamp(16, 22)),
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
    );
  }
}

//Sliver con la información
class SliverInfoDoypack extends StatefulWidget {
  const SliverInfoDoypack({super.key, required this.screenWidth, required this.isMobile});

  final double screenWidth;
  final bool isMobile;

  @override
  State<SliverInfoDoypack> createState() => _SliverInfoDoypackState();
}

class _SliverInfoDoypackState extends State<SliverInfoDoypack> {
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
    final List<dynamic> nuestraDoypack = [
      {"title": "Smartbag® Doypack:\npresentación moderna\ny profesional.", "image": "assets/img/home/eco.webp"},
      {"title": "Diseñada para destacar\ntu producto en estantería,\ny proteger su contenido.", "image": "assets/img/home/eco.webp"},
      {"title": "Zipper resellable,\nválvula desgasificadora\ny múltiples capacidades\npara cada necesidad.", "image": "assets/img/home/eco.webp"},
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('sello-perfecto-doypack'),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06),
                child: Text(
                  "Sello perfecto. Estilo Doypack.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(30, 50)),
                ),
              ),
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('Scroll-doypack'),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: List.generate(nuestraDoypack.length, (int index) {
                    final card = nuestraDoypack[index];
                    final double horizontalPadding = widget.screenWidth * 0.06;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? horizontalPadding : 0,
                        right: index == nuestraDoypack.length - 1 ? horizontalPadding : 20,
                      ),
                      child: Container(
                        width: widget.isMobile ? 450 : (widget.screenWidth * 0.6).clamp(650, 1200),
                        height: widget.isMobile ? 700 : (widget.screenWidth * 0.1).clamp(500, 900),
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
                                      Padding(
                                        padding: EdgeInsets.only(left: widget.screenWidth * 0.02, top: widget.screenWidth * 0.01),
                                        child: Text(
                                          card['title'],
                                          style: TextStyle(
                                            height: 0,
                                            color: card['colorText'] ?? Colors.white,
                                            fontSize: (widget.screenWidth * 0.04).clamp(16, 24),
                                            fontWeight: FontWeight.bold,
                                          ),
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

//Clase de botones
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

//Sliver con los gramajes
class SliverWithGramaje extends StatefulWidget {
  const SliverWithGramaje({super.key, required this.isMobile, required this.screenWidth, required this.blue});

  final bool isMobile;
  final double screenWidth;
  final Color blue;

  @override
  State<SliverWithGramaje> createState() => _SliverWithGramajeState();
}

class _SliverWithGramajeState extends State<SliverWithGramaje> {
  int selectedIndex = 0;
  final List<String> options = ["500Gr", "2500Gr"];
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 100 : 150, horizontal: widget.screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('varios-tamaños-doypack'),
              child: Text(
                "Varios tamaños.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.08).clamp(50, 80)),
                textAlign: TextAlign.center,
              ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: Key('Capacidades-increibles'),
              child: Text(
                "Capacidades increbiles.",
                style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: (widget.screenWidth * 0.08).clamp(50, 80)),
                textAlign: TextAlign.center,
              ),
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('video-imagen-tamano'),
              child:
                  widget.isMobile
                      ? Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 50),
                                width: (widget.screenWidth * 0.6).clamp(0, 800),
                                height: (widget.screenWidth * 0.6).clamp(0, 800),
                                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
                                child: Center(child: Text("Foto")),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 50),
                                width: (widget.screenWidth * 0.6).clamp(0, 800),
                                height: (widget.screenWidth * 0.6).clamp(0, 800),
                                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
                                child: Center(child: Text("Foto")),
                              ),
                            ],
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50),
                            width: (widget.screenWidth * 0.6).clamp(0, 800),
                            height: (widget.screenWidth * 0.6).clamp(0, 800),
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
                            child: Center(child: Text("Video")),
                          ),
                          Container(
                            height: 40,
                            width: 250,
                            margin: EdgeInsets.symmetric(vertical: 50),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.grey.shade300),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
                                  child: Container(
                                    width: 125,
                                    height: 40,
                                    decoration: BoxDecoration(color: widget.blue, borderRadius: BorderRadius.circular(30)),
                                  ),
                                ),
                                Row(
                                  children: List.generate(options.length, (index) {
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        child: Center(
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Text(
                                              options[index],
                                              style: TextStyle(
                                                color: selectedIndex == index ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: Key('dispnible-en-gramajes-doypack'),
              child: SizedBox(
                width: 1000,
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withAlpha(190),
                    fontSize: (widget.screenWidth * 0.04).clamp(20, 28),
                  ),
                  TextSpan(
                    children: [
                      TextSpan(text: "Disponible en "),
                      TextSpan(text: "125, 250, 500, 1000 y 2500 gramos, ", style: TextStyle(color: widget.blue)),
                      TextSpan(
                        text:
                            "el empaque Doypack se adapta perfectamente a lo que necesites. Con acabados mate o brillante, cada presentación ofrece una experiencia visual impecable y funcional, pensada para destacar tu producto con estilo.",
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

//Sliver con las bolsas subiendo
class SliverWithMoreInfoDoypack extends StatefulWidget {
  const SliverWithMoreInfoDoypack({super.key, required this.screenWidth, required this.blue, required this.isMobile});

  final double screenWidth;
  final Color blue;
  final bool isMobile;

  @override
  State<SliverWithMoreInfoDoypack> createState() => _SliverWithMoreInfoDoypackState();
}

class _SliverWithMoreInfoDoypackState extends State<SliverWithMoreInfoDoypack> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller3;

  late Animation<Offset> _offset;
  late Animation<double> _rotation;

  late Animation<Offset> _offset3;
  late Animation<double> _rotation3;

  bool _hasAnimated = false;
  bool _hasAnimated3 = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _offset = Tween<Offset>(
      begin: const Offset(0.3, 1.0), // desde abajo derecha
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _rotation = Tween<double>(
      begin: 0.20, // más rotado al inicio (en sentido reloj)
      end: -0.12, // termina ligeramente inclinado hacia arriba derecha
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Inicia con delay (después de estar en el viewport)
    Future.delayed(const Duration(milliseconds: 400), () {});

    _controller3 = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _offset3 = Tween<Offset>(
      begin: const Offset(-0.9, 1.0), // desde abajo derecha
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller3, curve: Curves.easeOutCubic));

    _rotation3 = Tween<double>(
      begin: 0.40, // más rotado al inicio (en sentido reloj)
      end: 0.16, // termina ligeramente inclinado hacia arriba derecha
    ).animate(CurvedAnimation(parent: _controller3, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScrollAnimatedWrapper(
            visibilityKey: Key('smartbag-doypack-blue'),
            child: Text(
              textAlign: TextAlign.center,
              "SmartBag® Doypack.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(28, 60), color: widget.blue),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('elegante-funcional-doypoack'),
            child: Text(
              textAlign: TextAlign.center,
              "Elegante, funcional, versátil.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(28, 60)),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('con-una-estrucutra-doypack'),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 10),
              child: SizedBox(
                width: 1000,
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withAlpha(200),
                    fontSize: (widget.screenWidth * 0.04).clamp(18, 22),
                  ),

                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Con una estructura de 132 g/m², disponible en acabados mate o brillante, y capacidades desde 125 g hasta 2.5 kg, ofrece la ",
                      ),
                      TextSpan(text: "combinación perfecta entre resistencia, estética y funcionalidad. ", style: TextStyle(color: widget.blue)),
                      TextSpan(
                        text:
                            "Incluye opciones como válvula desgasificadora y zipper hermético, para que tu producto se conserve impecable y proyecte una imagen verdaderamente profesional.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          widget.isMobile
              ? ScrollAnimatedWrapper(
                visibilityKey: Key('el-cierre-que-tranf'),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 100),
                  child: Column(
                    children: [
                      Image.asset(height: 400, "assets/img/smartbag/doypack.webp", fit: BoxFit.contain),
                      const SizedBox(height: 24),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: (widget.screenWidth * 0.022).clamp(20, 22),
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(text: "El cierre que transforma la experiencia.\n", style: TextStyle(fontWeight: FontWeight.w800)),
                            TextSpan(text: "El "),
                            TextSpan(text: "zipper hermético", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " de la "),
                            TextSpan(text: "Smartbag Doypack", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " redefine la manera en que se conserva y presenta tu producto. Abre y cierra con facilidad, "),
                            TextSpan(
                              text: "manteniendo la frescura intacta una y otra vez.\n\n",
                              style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                            ),
                            TextSpan(text: "Diseñado para ser "),
                            TextSpan(text: "práctico, confiable", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " y "),
                            TextSpan(text: "visualmente limpio", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: ", eleva la experiencia del usuario y proyecta una "),
                            TextSpan(text: "imagen profesional", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " desde el primer contacto."),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Image.asset(height: 400, "assets/img/smartbag/doypack.webp", fit: BoxFit.contain),
                      const SizedBox(height: 24),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: (widget.screenWidth * 0.022).clamp(20, 22),
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(text: "Tecnología que respira contigo.\n", style: TextStyle(fontWeight: FontWeight.w800)),
                            TextSpan(text: "La "),
                            TextSpan(text: "válvula desgasificadora", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " permite la "),
                            TextSpan(text: "liberación controlada de gases", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " sin dejar entrar oxígeno, "),
                            TextSpan(
                              text: "preservando la frescura del producto.",
                              style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                            ),
                            TextSpan(text: " Ideal para productos como café.\n\n"),
                            TextSpan(text: "Además, su "),
                            TextSpan(text: "diseño discreto", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " mantiene la "),
                            TextSpan(text: "estética limpia", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                            TextSpan(text: " del empaque."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : ScrollAnimatedWrapper(
                visibilityKey: Key('el-cierre-que-tranf2'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      VisibilityDetector(
                        key: const Key('smartbag-animation'),
                        onVisibilityChanged: (info) {
                          final visiblePercentage = info.visibleFraction;
                          if (!_hasAnimated && visiblePercentage >= 0.4) {
                            _hasAnimated = true;
                            Future.delayed(const Duration(milliseconds: 300), () {
                              if (mounted) _controller.forward();
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.08),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Imagen con animación
                                Expanded(
                                  flex: 5,
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(_offset.value.dx * 100, _offset.value.dy * 100),
                                        child: Transform.rotate(
                                          angle: _rotation.value,
                                          alignment: Alignment.topCenter, // Punto central superior como eje de giro
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Image.asset("assets/img/smartbag/doypack.webp", fit: BoxFit.contain),
                                  ),
                                ),

                                const SizedBox(width: 40),

                                // Texto con animación también (opcional)
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Zipper inteligente",
                                          style: TextStyle(
                                            fontSize: (widget.screenWidth * 0.03).clamp(22, 28),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: (widget.screenWidth * 0.022).clamp(16, 20),
                                              fontWeight: FontWeight.w400,
                                              height: 1.6,
                                              color: Colors.black87,
                                            ),
                                            children: [
                                              TextSpan(text: "El cierre que transforma la experiencia.\n\n"),
                                              TextSpan(text: "El "),
                                              TextSpan(text: "zipper hermético", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                                              TextSpan(text: " de la "),
                                              TextSpan(text: "Smartbag Doypack", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                                              TextSpan(
                                                text: " redefine la manera en que se conserva y presenta tu producto. Abre y cierra con facilidad, ",
                                              ),
                                              TextSpan(
                                                text: "manteniendo la frescura intacta una y otra vez.\n\n",
                                                style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                                              ),
                                              TextSpan(text: "Diseñado para ser "),
                                              TextSpan(
                                                text: "práctico, confiable",
                                                style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                                              ),
                                              TextSpan(text: " y "),
                                              TextSpan(text: "visualmente limpio", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                                              TextSpan(text: ", eleva la experiencia del usuario y proyecta una "),
                                              TextSpan(text: "imagen profesional", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                                              TextSpan(text: " desde el primer contacto."),
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
                        ),
                      ),

                      VisibilityDetector(
                        key: const Key('third-bag'),
                        onVisibilityChanged: (info) {
                          final visiblePercentage = info.visibleFraction;
                          if (!_hasAnimated3 && visiblePercentage >= 0.4) {
                            _hasAnimated3 = true;
                            Future.delayed(const Duration(milliseconds: 300), () {
                              if (mounted) _controller3.forward();
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.08),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Válvula inteligente",
                                          style: TextStyle(
                                            fontSize: (widget.screenWidth * 0.03).clamp(22, 28),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: (widget.screenWidth * 0.022).clamp(16, 20),
                                              fontWeight: FontWeight.w400,
                                              height: 1.6,
                                              color: Colors.black87,
                                            ),
                                            children: [
                                              TextSpan(text: "Tecnología que respira contigo.\n\n"),
                                              TextSpan(text: "La "),
                                              TextSpan(
                                                text: "válvula desgasificadora",
                                                style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                                              ),
                                              TextSpan(text: " permite la "),
                                              TextSpan(
                                                text: "liberación controlada de gases",
                                                style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                                              ),
                                              TextSpan(text: " sin dejar entrar oxígeno, "),
                                              TextSpan(
                                                text: "preservando la frescura del producto.",
                                                style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500),
                                              ),
                                              TextSpan(text: " Ideal para productos como café.\n\n"),
                                              TextSpan(text: "Además, su "),
                                              TextSpan(text: "diseño discreto", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                                              TextSpan(text: " mantiene la "),
                                              TextSpan(text: "estética limpia", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                                              TextSpan(text: " del empaque."),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),

                                // Imagen con animación
                                Expanded(
                                  flex: 5,
                                  child: AnimatedBuilder(
                                    animation: _controller3,
                                    builder: (_, child) {
                                      return Transform.translate(
                                        offset: Offset(_offset3.value.dx * 100, _offset3.value.dy * 100),
                                        child: Transform.rotate(
                                          angle: _rotation3.value,
                                          alignment: Alignment.topCenter, // Punto central superior como eje de giro
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Image.asset("assets/img/smartbag/doypack.webp", fit: BoxFit.contain),
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
              ),
        ],
      ),
    );
  }
}

//Sliver con declaración de excelencia
class SliverWithDeclaracionDeExcelencia extends StatelessWidget {
  const SliverWithDeclaracionDeExcelencia({super.key, required this.isMobile, required this.screenWidth, required this.blue});

  final bool isMobile;
  final double screenWidth;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 150),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            width: 1200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,

              boxShadow: [
                BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.25), blurRadius: 8, spreadRadius: -2, offset: Offset(0, 4)),
                BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.08), blurRadius: 0, spreadRadius: 1, offset: Offset(0, 0)),
              ],
            ),
            child: ScrollAnimatedWrapper(
              visibilityKey: Key('declaracion-de-excelencia-doyopack'),
              child:
                  isMobile
                      ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(height: 80, "assets/img/BIsotipo.webp", fit: BoxFit.contain),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: (screenWidth * 0.1).clamp(20, 50)),
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withAlpha(150),
                                  height: 1.2,
                                  fontSize: (screenWidth * 0.05).clamp(16, 20),
                                ),
                                children: [
                                  TextSpan(text: "PackVision Smartbag Doypack convierte cada empaque en una "),
                                  TextSpan(
                                    text: "declaración de excelencia. ",
                                    style: TextStyle(color: blue.withAlpha(200), fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        "Disponible en acabados mate, brillante o metalizado. Zipper hermético y válvula desgasificadora integrados para preservar frescura y calidad. Diseño funcional con materiales premium que protegen y elevan tu producto.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Expanded(child: Padding(padding: const EdgeInsets.all(50), child: Image.asset("assets/img/BIsotipo.webp"))),
                          Expanded(
                            flex: 2,

                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 100),
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withAlpha(150),
                                    height: 1.2,
                                    fontSize: (screenWidth * 0.05).clamp(16, 20),
                                  ),
                                  children: [
                                    TextSpan(text: "PackVision Smartbag Doypack convierte cada empaque en una "),
                                    TextSpan(
                                      text: "declaración de excelencia. ",
                                      style: TextStyle(color: blue.withAlpha(200), fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          "Disponible en acabados mate, brillante o metalizado. Zipper hermético y válvula desgasificadora integrados para preservar frescura y calidad. Diseño funcional con materiales premium que protegen y elevan tu producto.",
                                    ),
                                  ],
                                ),
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

//Sliver con la información de ventana
class SliverWithVentanaInfo extends StatelessWidget {
  const SliverWithVentanaInfo({super.key, required this.blue, required this.screenWidth, required this.isMobile});

  final Color blue;
  final double screenWidth;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('Ventana-doypack'),
              child: Text(
                "Ventana",
                style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: (screenWidth * 0.1).clamp(40, 70), height: 0.8),
              ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: Key('Revela-tu-escencia-doyapck'),
              child: Text(
                textAlign: TextAlign.center,
                "Revela tu esencia.\nY todo lo demás.",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: (screenWidth * 0.1).clamp(40, 65), height: 0.95),
              ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: Key('foto-video-revela-0tu-sad'),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 50),
                height: 800,
                width: screenWidth,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey),
                child: Center(child: Text(isMobile ? "Foto" : "Video")),
              ),
            ),
            Container(
              width: 1000,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: ScrollAnimatedWrapper(
                visibilityKey: Key('Visibivilidad-interna-mas-icono'),
                child:
                    isMobile
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove_red_eye_outlined, size: 40),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text.rich(
                                      style: TextStyle(fontSize: 18),
                                      TextSpan(
                                        children: [
                                          TextSpan(text: "Visibilidad interna ", style: TextStyle(fontWeight: FontWeight.w800)),
                                          TextSpan(
                                            text: "Tu producto a la vista, tal como es.",
                                            style: TextStyle(color: Colors.black.withAlpha(200)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_cafe_rounded, size: 40),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text.rich(
                                      style: TextStyle(fontSize: 18),
                                      TextSpan(
                                        children: [
                                          TextSpan(text: "Ventana que enamora ", style: TextStyle(fontWeight: FontWeight.w800)),
                                          TextSpan(
                                            text: "Ideal para granos de café y más, muestra lo mejor desde el empaque.",
                                            style: TextStyle(color: Colors.black.withAlpha(200)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

                              child: Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Diseñado para destacar tu producto desde el primer vistazo. ",
                                      style: TextStyle(color: blue, fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          "Su ventana transparente revela el interior con elegancia, mientras que su estructura Doypack lo mantiene fresco y protegido. Ideal para cautivar, informar y conectar con tus clientes al instante.",
                                    ),
                                  ],
                                ),
                                style: TextStyle(fontSize: 18, height: 1.5),
                              ),
                            ),
                          ],
                        )
                        : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Columna de características con íconos
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Primer ítem
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.remove_red_eye_outlined, size: 40),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Visibilidad interna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 4),
                                            Text("Tu producto a la vista, tal como es.", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  // Segundo ítem
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.local_cafe_rounded, size: 40),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Ventana que enamora", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 4),
                                            Text(
                                              "Ideal para granos de café y más, muestra lo mejor desde el empaque.",
                                              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 60),

                            // Texto descriptivo
                            Expanded(
                              flex: 1,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Diseñado para destacar tu producto desde el primer vistazo. ",
                                      style: TextStyle(color: blue, fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          "Su ventana transparente revela el interior con elegancia, mientras que su estructura Doypack lo mantiene fresco y protegido. Ideal para cautivar, informar y conectar con tus clientes al instante.",
                                    ),
                                  ],
                                ),
                                style: TextStyle(fontSize: 18, height: 1.5),
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

//Sliver con el resumen y final
class SliverWithResumen extends StatefulWidget {
  const SliverWithResumen({super.key, required this.screenWidth, required this.isMobile, required this.blue});

  final double screenWidth;
  final bool isMobile;
  final Color blue;

  @override
  State<SliverWithResumen> createState() => _SliverWithResumenState();
}

class _SliverWithResumenState extends State<SliverWithResumen> {
  bool isHoverBuy = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: widget.screenWidth,
            padding:
                widget.isMobile
                    ? EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 100)
                    : EdgeInsets.only(
                      left: (widget.screenWidth * 0.2).clamp(30, widget.screenWidth),
                      right: (widget.screenWidth * 0.4),
                      top: 100,
                      bottom: 100,
                    ),
            child: SizedBox(
              width: 700,
              child: ScrollAnimatedWrapper(
                visibilityKey: Key('todo=en-uno.ventana'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Menos dudas.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.1).clamp(30, 60))),
                    Text(
                      "Más visibilidad.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.1).clamp(30, 60), color: widget.blue),
                    ),
                    Text.rich(
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: (widget.screenWidth * 0.07).clamp(20, 25)),
                      TextSpan(
                        children: [
                          TextSpan(text: "Todo en uno. Ventana ", style: TextStyle(color: widget.blue)),
                          TextSpan(text: "que muestra "),
                          TextSpan(text: "válvula ", style: TextStyle(color: widget.blue)),
                          TextSpan(text: "que respira "),
                          TextSpan(text: "zipper ", style: TextStyle(color: widget.blue)),
                          TextSpan(text: "que conserva. "),
                          TextSpan(text: "SmartBag combina funcionalidad y elegancia para elevar tu producto. El empaque que lo tiene todo. "),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => isHoverBuy = true),
                        onExit: (_) => setState(() => isHoverBuy = false),
                        child: GestureDetector(
                          onTap: () {
                            // Acción al hacer click
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ir a crear mi doypack",
                                style: TextStyle(
                                  color: widget.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: (widget.screenWidth * 0.05).clamp(20, 28),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                height: 3,
                                width: isHoverBuy ? (widget.screenWidth * 0.05).clamp(20, 20) * 15 : 0, // ajusta largo aquí
                                color: widget.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('foto-video-todo-en-una-venandas'),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    Container(
                      width: widget.screenWidth,
                      height: 600,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Text(widget.isMobile ? "Foto" : "Video"),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ScrollAnimatedWrapper(
            visibilityKey: Key('crear-mi-4por'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(widget.blue), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Text("Crear mi 4pro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.06).clamp(18, 24))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
