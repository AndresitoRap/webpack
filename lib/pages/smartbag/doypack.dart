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

class DoypackSmart extends StatelessWidget {
  final Responsive r;
  final Subcategorie subcategorie;
  const DoypackSmart({super.key, required this.r, required this.subcategorie});

  @override
  Widget build(BuildContext context) {
    final isMobile = r.wp(100) < 850;
    final blue = Theme.of(context).primaryColor;
    final route = '${subcategorie.route}/crea-tu-empaque';

    return CustomScrollView(
      slivers: [
        IntroDoypackSliver(r: r, blue: blue, isMobile: isMobile, route: route),
        InformationDoypackSliver(r: r, isMobile: isMobile),
        WeightSliver(isMobile: isMobile, r: r, blue: blue),
        ZipperAndValveSliver(r: r, blue: blue, isMobile: isMobile),
        DeclarationOfExcellenceSliver(isMobile: isMobile, r: r, blue: blue),
        InformationWindowSliver(blue: blue, r: r, isMobile: isMobile),
        SummarySliver(r: r, isMobile: isMobile, blue: blue, route: route),
        SliverToBoxAdapter(child: Footer()),
      ],
    );
  }
}

//---------Inicio de Doypack------------
class IntroDoypackSliver extends StatefulWidget {
  const IntroDoypackSliver({super.key, required this.r, required this.blue, required this.isMobile, required this.route});
  final Responsive r;
  final Color blue;
  final bool isMobile;
  final String route;

  @override
  State<IntroDoypackSliver> createState() => _IntroDoypackSliverState();
}

class _IntroDoypackSliverState extends State<IntroDoypackSliver> with TickerProviderStateMixin {
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

    _buttonController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _buttonFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      _controllers[i].forward();
    }

    // Espera un momento y luego lanza la cubierta
    await Future.delayed(const Duration(milliseconds: 200));
    _coverController.forward();

    await _coverController.forward();

    await Future.delayed(const Duration(milliseconds: 200)); // pequeño espacio
    _doypackController.forward();

    await _doypackController.forward();

    await Future.delayed(const Duration(milliseconds: 400)); // pequeño espacio
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
        height: widget.r.hp(100),
        width: widget.r.wp(100),
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
                    child: Text(text[index], style: TextStyle(fontSize: widget.r.fs(4, 70), fontWeight: FontWeight.bold)),
                  ),
                );
              }),
            ),
            //Texto después de video
            Positioned(
              bottom: widget.r.hp(2),
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _buttonFade,
                child: Column(
                  children: [
                    Text("Exclusiva para tí.", style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: widget.r.fs(2, 30))),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        navigateWithSlide(context, widget.route);
                      },
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(widget.blue), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("Crear mi doypack", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Cubierta que sube y tapa el texto
            SlideTransition(
              position: _coverSlide,
              child: SizedBox(
                height: widget.r.hp(100),
                width: widget.r.wp(100),
                child:
                    widget.isMobile
                        ? Image.asset("img/smartbag/doypack/inicio.webp")
                        : ValueListenableBuilder<bool>(
                          valueListenable: videoBlurNotifier,
                          builder: (context, isBlur, _) {
                            return VideoFlutter(
                              src: 'assets/videos/smartbag/doypack/inicio_doypack.webm',
                              blur: isBlur,
                              loop: false,
                              showControls: false,
                              isPause: false,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------Información acerca de la doypack------------
class InformationDoypackSliver extends StatefulWidget {
  const InformationDoypackSliver({super.key, required this.r, required this.isMobile});

  final Responsive r;
  final bool isMobile;

  @override
  State<InformationDoypackSliver> createState() => _InformationDoypackSliverState();
}

class _InformationDoypackSliverState extends State<InformationDoypackSliver> {
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
    final List<Map<String, dynamic>> nuestraDoypack = [
      {
        "title": "Smartbag® Doypack:\npresentación moderna\ny profesional.",
        "image": "img/smartbag/doypack/cardLarge1.webp",
        "isVideo": false,
        "video": "",
      },
      {
        "title": "Diseñada para destacar\ntu producto en estantería,\ny proteger su contenido.",
        "image": "",
        "isVideo": true,
        "video": "assets/videos/smartbag/doypack/VideoCard.webm",
      },
      {
        "title": "Zipper resellable,\nválvula desgasificadora\ny múltiples capacidades\npara cada necesidad.",
        "image": "img/smartbag/doypack/cardLarge2.webp",
        "isVideo": false,
        "video": "",
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Text("Sello perfecto. Estilo Doypack.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(3, 50))),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(nuestraDoypack.length, (int index) {
                  final card = nuestraDoypack[index];
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? widget.r.wp(6) : 0, right: index == nuestraDoypack.length - 1 ? widget.r.wp(6) : 20),
                    child: Container(
                      width: widget.r.wp(80, max: 1000),
                      height: widget.r.wp(60, max: 500),
                      margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      child: Stack(
                        children: [
                          if (!card['isVideo'])
                            Positioned.fill(
                              child: ClipRRect(borderRadius: BorderRadius.circular(26), child: Image.asset(card['image'], fit: BoxFit.cover)),
                            ),
                          if (card['isVideo'])
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: VideoFlutter(
                                  src: card['video'],
                                  loop: false,
                                  autoplay: true,
                                  isPause: false,
                                  retry: true,
                                  showControls: false,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(top: 22, left: 22),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: widget.r.dp(1, max: 20), top: widget.r.dp(1, max: 20)),
                                        child: Text(
                                          card['title'],
                                          style: TextStyle(
                                            height: 0,
                                            color: card['colorText'] ?? Colors.white,
                                            fontSize: widget.r.fs(1.8, 22),
                                            fontWeight: FontWeight.bold,
                                            shadows: [Shadow(offset: Offset(0, 0), blurRadius: 6, color: Colors.black.withAlpha(130))],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 1, child: SizedBox(width: 100)),
                              ],
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

//---------Video, imagen con la demostracion del tamaño------------
class WeightSliver extends StatefulWidget {
  const WeightSliver({super.key, required this.isMobile, required this.r, required this.blue});

  final bool isMobile;
  final Responsive r;
  final Color blue;

  @override
  State<WeightSliver> createState() => _WeightSliverState();
}

class _WeightSliverState extends State<WeightSliver> {
  int selectedIndex = 0;
  final List<Map<String, String>> options = [
    {"text": "500Gr", "video": "assets/videos/smartbag/doypack/rotacion1.webm"},
    {"text": "2500Gr", "video": "assets/videos/smartbag/doypack/rotacion2.webm"},
  ];

  late List<GlobalKey<VideoFlutterState>> _videoKeys;

  @override
  void initState() {
    super.initState();
    _videoKeys = List.generate(options.length, (_) => GlobalKey<VideoFlutterState>());
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.r.hp(1, max: 30), horizontal: widget.r.wp(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScrollAnimatedWrapper(
              child: Text(
                "Varios tamaños.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(5, 80)),
                textAlign: TextAlign.center,
              ),
            ),
            ScrollAnimatedWrapper(
              child: Text(
                "Capacidades increbiles.",
                style: TextStyle(fontWeight: FontWeight.bold, color: widget.blue, fontSize: widget.r.fs(5, 80)),
                textAlign: TextAlign.center,
              ),
            ),
            ScrollAnimatedWrapper(visibilityKey: Key('video-imagen-tamano'), child: widget.isMobile ? _buildMobile() : _buildDesktop()),
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 60 : 100),
                child: SizedBox(
                  width: widget.r.wp(100, max: 1000),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black.withAlpha(190), fontSize: widget.r.fs(2, 26)),
                    TextSpan(
                      children: [
                        TextSpan(text: "Disponible en "),
                        TextSpan(text: "125, 250, 500, 1000 y 2500 gramos, ", style: TextStyle(color: widget.blue, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              "el empaque Doypack se adapta perfectamente a lo que necesites. Con acabados mate o brillante, cada presentación ofrece una experiencia visual impecable y funcional, pensada para destacar tu producto con estilo.",
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
    );
  }

  Column _buildDesktop() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: widget.r.wp(60, max: 800),
          height: widget.r.wp(60, max: 800),
          child: Stack(
            children: List.generate(options.length, (index) {
              return Visibility(
                visible: selectedIndex == index,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: VideoFlutter(
                    key: _videoKeys[index],
                    src: options[index]['video']!,
                    loop: false,
                    autoplay: true,
                    delay: Duration.zero,
                    isPause: false,
                    showControls: false,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ),
        Container(
          height: 40,
          width: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.grey.shade300),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastLinearToSlowEaseIn,
                alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(width: 125, height: 40, decoration: BoxDecoration(color: widget.blue, borderRadius: BorderRadius.circular(30))),
              ),
              Row(
                children: List.generate(options.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final previousIndex = selectedIndex;

                        setState(() {
                          selectedIndex = index;
                        });

                        // Reinicia el video anterior en segundo plano
                        final prevVideo = _videoKeys[previousIndex].currentState;
                        if (prevVideo != null) {
                          prevVideo.pause();
                          prevVideo.seekToStart();
                        }

                        // Espera y luego reproduce el nuevo
                        Future.delayed(Duration(milliseconds: 20), () {
                          final newVideo = _videoKeys[index].currentState;
                          if (newVideo != null) {
                            newVideo.play();
                          }
                        });
                      },
                      child: Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            options[index]['text']!,
                            style: TextStyle(color: selectedIndex == index ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
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
    );
  }

  Padding _buildMobile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.r.hp(2, max: 30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: widget.r.wp(60, max: 300),
              height: widget.r.wp(60, max: 800),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/smartbag/doypack/twobags1.webp"))),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: widget.r.wp(60, max: 300),
              height: widget.r.wp(60, max: 800),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/smartbag/doypack/twobags2.webp"))),
            ),
          ),
        ],
      ),
    );
  }
}

//---------Información de la estructura------------
class ZipperAndValveSliver extends StatefulWidget {
  const ZipperAndValveSliver({super.key, required this.r, required this.blue, required this.isMobile});

  final Responsive r;
  final Color blue;
  final bool isMobile;

  @override
  State<ZipperAndValveSliver> createState() => _ZipperAndValveSliverState();
}

class _ZipperAndValveSliverState extends State<ZipperAndValveSliver> with TickerProviderStateMixin {
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
      begin: const Offset(0.9, 1.0), // inicia desde la derecha
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller3, curve: Curves.easeOutCubic));

    _rotation3 = Tween<double>(
      begin: 0.40, // rotación hacia la derecha
      end: 0.16,
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.r.hp(2, max: 20)),
              child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(4, 60)),
                TextSpan(
                  children: [
                    TextSpan(text: "SmartBag® Doypack.\n", style: TextStyle(color: widget.blue)),
                    TextSpan(text: "Elegante, funcional, versátil."),
                  ],
                ),
              ),
            ),
          ),

          ScrollAnimatedWrapper(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 10),
              child: SizedBox(
                width: 1000,
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black.withAlpha(200), fontSize: widget.r.fs(1.9, 22)),
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Con una estructura de 132 g/m², disponible en acabados mate o brillante, y capacidades desde 125 g hasta 2.5 kg, ofrece la ",
                      ),
                      TextSpan(text: "combinación perfecta entre resistencia, estética y funcionalidad.\n\n", style: TextStyle(color: widget.blue)),
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
          ScrollAnimatedWrapper(child: widget.isMobile ? _buildPhone() : _buildDesktop(context)),
        ],
      ),
    );
  }

  Padding _buildDesktop(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
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
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(8)),
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
                            child: Transform.rotate(angle: _rotation.value, alignment: Alignment.topCenter, child: child),
                          );
                        },
                        child: Image.asset("img/smartbag/doypack/aloneBag2.webp", fit: BoxFit.contain),
                      ),
                    ),

                    const SizedBox(width: 40),

                    // Texto con animación también (opcional)
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Zipper inteligente.",
                              style: TextStyle(fontSize: widget.r.fs(2, 28), fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 24),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: widget.r.fs(1.9, 20), fontWeight: FontWeight.w400, height: 1.6, color: Colors.black87),
                                children: [
                                  TextSpan(text: "El cierre que transforma la experiencia.\n\n"),
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
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(8)),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Válvula inteligente.",
                              style: TextStyle(fontSize: widget.r.fs(2, 28), fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 24),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: widget.r.fs(1.9, 20), fontWeight: FontWeight.w400, height: 1.6, color: Colors.black87),
                                children: [
                                  TextSpan(text: "Tecnología que respira contigo.\n\n"),
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
                        child: Image.asset("img/smartbag/doypack/aloneBag.webp", fit: BoxFit.contain),
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

  Padding _buildPhone() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 10),
      child: Column(
        children: [
          Image.asset(height: 400, "img/smartbag/doypack/aloneBag.webp", fit: BoxFit.contain),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: widget.r.fs(1.8, 22), fontWeight: FontWeight.w400, height: 1.6, color: Colors.black87),
              children: [
                TextSpan(
                  text: "El cierre que transforma la experiencia.\n",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: widget.r.fs(2.2, 26)),
                ),
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
          const SizedBox(height: 24),
          Image.asset(height: 400, "img/smartbag/doypack/aloneBag2.webp", fit: BoxFit.contain),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: widget.r.fs(1.8, 22), fontWeight: FontWeight.w400, height: 1.6, color: Colors.black87),
              children: [
                TextSpan(text: "Tecnología que respira contigo.\n", style: TextStyle(fontWeight: FontWeight.w800, fontSize: widget.r.fs(2.2, 26))),
                TextSpan(text: "La "),
                TextSpan(text: "válvula desgasificadora", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                TextSpan(text: " permite la "),
                TextSpan(text: "liberación controlada de gases", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
                TextSpan(text: " sin dejar entrar oxígeno, "),
                TextSpan(text: "preservando la frescura del producto.", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w500)),
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
    );
  }
}

//---------Declaración de Excelencia------------
class DeclarationOfExcellenceSliver extends StatelessWidget {
  const DeclarationOfExcellenceSliver({super.key, required this.isMobile, required this.r, required this.blue});

  final bool isMobile;
  final Responsive r;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: r.wp(6), right: r.wp(6), top: isMobile ? 50 : 100, bottom: isMobile ? 50 : 150),
        child: Center(
          child: ScrollAnimatedWrapper(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 20, vertical: 50),
              width: 1200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.163), blurRadius: 8, spreadRadius: -2, offset: Offset(0, 4)),
                  BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.04), blurRadius: 0, spreadRadius: 1, offset: Offset(0, 0)),
                ],
              ),
              child: isMobile ? _buildMobile() : _buildDesktop(),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildDesktop() {
    return Row(
      children: [
        Expanded(child: Padding(padding: const EdgeInsets.all(50), child: Image.asset("img/BImagotipo.webp"))),
        Expanded(
          flex: 2,

          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 100),
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withAlpha(150), height: 1.2, fontSize: r.fs(1.8, 20)),
                children: [
                  TextSpan(text: "PackVision Smartbag Doypack convierte cada empaque en una "),
                  TextSpan(text: "declaración de excelencia. ", style: TextStyle(color: blue.withAlpha(200), fontWeight: FontWeight.bold)),
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
    );
  }

  Column _buildMobile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: const EdgeInsets.all(16), child: Image.asset(height: 200, "img/BImagotipo.webp", fit: BoxFit.contain)),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black.withAlpha(150), height: 1.2, fontSize: r.fs(1.8, 20)),
              children: [
                TextSpan(text: "PackVision Smartbag Doypack convierte cada empaque en una "),
                TextSpan(text: "declaración de excelencia. ", style: TextStyle(color: blue.withAlpha(200), fontWeight: FontWeight.bold)),
                TextSpan(
                  text:
                      "Disponible en acabados mate, brillante o metalizado.\n\nZipper hermético y válvula desgasificadora integrados para preservar frescura y calidad. Diseño funcional con materiales premium que protegen y elevan tu producto.",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//---------Declaración información de la ventana------------
class InformationWindowSliver extends StatelessWidget {
  const InformationWindowSliver({super.key, required this.blue, required this.r, required this.isMobile});

  final Color blue;
  final Responsive r;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            ScrollAnimatedWrapper(child: Text("Ventana", style: TextStyle(fontWeight: FontWeight.bold, color: blue, fontSize: r.fs(5, 70)))),
            SizedBox(height: 10),
            ScrollAnimatedWrapper(
              child: Text(
                textAlign: TextAlign.center,
                "Revela tu esencia.\nY todo lo demás.",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: r.fs(4, 60), height: 0.98),
              ),
            ),
            ScrollAnimatedWrapper(
              child:
                  isMobile
                      ? Padding(
                        padding: EdgeInsets.symmetric(vertical: r.hp(10, max: 50)),
                        child: Image.asset("img/smartbag/doypack/3ventanas.webp", fit: BoxFit.cover, width: r.wp(100)),
                      )
                      : SizedBox(
                        height: r.hp(90, max: 800),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: videoBlurNotifier,
                          builder: (context, isBlur, _) {
                            return VideoFlutter(
                              src: 'assets/videos/smartbag/doypack/Tresventanas.webm',
                              blur: isBlur,
                              loop: false,
                              showControls: false,
                              isPause: false,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
              child: SizedBox(width: r.wp(100, max: 1000), child: ScrollAnimatedWrapper(child: isMobile ? _buildPhone() : _buildDesktop())),
            ),
            if (isMobile)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
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
                  style: TextStyle(fontSize: r.fs(2, 30), height: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Padding _buildDesktop() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.wp(6)),

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
          ),

          SizedBox(width: 60),
        ],
      ),
    );
  }

  Padding _buildPhone() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.hp(7, max: 20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLetterPhone("Visibilidad interna ", "Tu producto a la vista, tal como es.", Icons.remove_red_eye_outlined),
          SizedBox(height: 40),
          _buildLetterPhone("Ventana que enamora ", "Ideal para granos de café y más, muestra lo mejor desde el empaque.", Icons.coffee),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Row _buildLetterPhone(String title, String label, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40),
        SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            style: TextStyle(fontSize: r.fs(1.9, 22)),
            TextSpan(
              children: [
                TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(text: label, style: TextStyle(color: Colors.black.withAlpha(200))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//---------Final de doypack------------
class SummarySliver extends StatelessWidget {
  const SummarySliver({super.key, required this.r, required this.isMobile, required this.blue, required this.route});

  final Responsive r;
  final bool isMobile;
  final Color blue;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: r.wp(100),
            padding:
                isMobile
                    ? EdgeInsets.symmetric(horizontal: r.wp(6), vertical: 100)
                    : EdgeInsets.only(left: r.wp(20), right: r.wp(40), top: 100, bottom: 100),
            child: SizedBox(
              width: 700,
              child: ScrollAnimatedWrapper(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(4.2, 60)),
                      TextSpan(children: [TextSpan(text: "Menos dudas.\n"), TextSpan(text: "Más visibilidad.", style: TextStyle(color: blue))]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text.rich(
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: r.fs(2, 26)),
                        TextSpan(
                          children: [
                            TextSpan(text: "Todo en uno. Ventana ", style: TextStyle(color: blue)),
                            TextSpan(text: "que muestra "),
                            TextSpan(text: "válvula ", style: TextStyle(color: blue)),
                            TextSpan(text: "que respira "),
                            TextSpan(text: "zipper ", style: TextStyle(color: blue)),
                            TextSpan(text: "que conserva. "),
                            TextSpan(text: "SmartBag combina funcionalidad y elegancia para elevar tu producto. El empaque que lo tiene todo. "),
                          ],
                        ),
                      ),
                    ),
                    _ButtonHover(blue: blue, r: r, route: route),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: isMobile ? 0 : 20),
              child: SizedBox(
                width: r.wp(100),
                height: 600,

                child:
                    isMobile
                        ? Image.asset("img/smartbag/doypack/cardsloop.webp", fit: BoxFit.cover)
                        : ValueListenableBuilder<bool>(
                          valueListenable: videoBlurNotifier,
                          builder: (context, isBlur, _) {
                            return VideoFlutter(
                              src: 'assets/videos/smartbag/doypack/loop.webm',
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
          ),

          ScrollAnimatedWrapper(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(blue), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () {
                  navigateWithSlide(context, route);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Text("Crear mi DoyPack", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonHover extends StatefulWidget {
  final Color blue;
  final Responsive r;
  final String route;
  const _ButtonHover({required this.blue, required this.r, required this.route});

  @override
  State<_ButtonHover> createState() => __ButtonHoverState();
}

class __ButtonHoverState extends State<_ButtonHover> {
  bool isHoverBuy = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          navigateWithSlide(context, widget.route);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHoverBuy = true),
          onExit: (_) => setState(() => isHoverBuy = false),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ir a crear mi doypack", style: TextStyle(color: widget.blue, fontWeight: FontWeight.w600, fontSize: widget.r.fs(1.8, 24))),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                height: 3,
                width: isHoverBuy ? widget.r.wp(5) * 15 : 0,
                color: widget.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
