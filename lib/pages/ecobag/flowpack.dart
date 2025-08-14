import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class FlowpackEco extends StatelessWidget {
  final Responsive r;
  final Subcategorie subcategorie;
  const FlowpackEco({super.key, required this.r, required this.subcategorie});

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF4B8D2C);
    final route = '${subcategorie.route}/crea-tu-empaque';
    final isMobile = r.wp(100) < 850;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 255, 252),
      body: CustomScrollView(
        slivers: [
          StartFlowpackSliver(r: r, green: green),
          TextEcoBagFlowpckSliver(r: r, green: green),
          ImageZoomFlowpackSliver(green: green, isMobile: isMobile),
          ScrollEcoFlowpackSliver(isMobile: isMobile, r: r),
          ImagenSlivers(r: r, green: green, isMobile: isMobile),
          ComparisionSliver(r: r, green: green),
          WeCareUsSliver(r: r, green: green, isMobile: isMobile),
          FlowpackFinallySliver(r: r, isMobile: isMobile, green: green, route: route),
          SliverToBoxAdapter(child: const Footer()),
        ],
      ),
    );
  }
}

//---------Inicio de Flowpack------------
class StartFlowpackSliver extends StatefulWidget {
  const StartFlowpackSliver({super.key, required this.r, required this.green});

  final Responsive r;
  final Color green;

  @override
  State<StartFlowpackSliver> createState() => _StartFlowpackSliverState();
}

class _StartFlowpackSliverState extends State<StartFlowpackSliver> with TickerProviderStateMixin {
  late AnimationController _textController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimationimg;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationimg;

  late AnimationController _centerController;
  late AnimationController _leftController;
  late AnimationController _rightController;

  late Animation<Offset> _leftImageSlide;
  late Animation<Offset> _rightImageSlide;

  @override
  void initState() {
    super.initState();

    _centerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _leftController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _rightController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _scaleAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(CurvedAnimation(parent: _centerController, curve: Curves.fastOutSlowIn));

    _fadeAnimationimg = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _centerController, curve: Curves.fastOutSlowIn));

    _slideAnimationimg = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _centerController, curve: Curves.fastOutSlowIn));

    _leftImageSlide = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: const Offset(-0.4, 0),
    ).animate(CurvedAnimation(parent: _leftController, curve: Curves.easeOut));

    _rightImageSlide = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: const Offset(0.4, 0),
    ).animate(CurvedAnimation(parent: _rightController, curve: Curves.easeOut));

    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _textController, curve: Curves.fastOutSlowIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.fastOutSlowIn));

    // Secuencia
    Future.delayed(const Duration(milliseconds: 400), () async {
      await _centerController.forward(); // 1. Central
      await Future.delayed(const Duration(milliseconds: 100));
      await _leftController.forward(); // 2. Izquierda
      await Future.delayed(const Duration(milliseconds: 100));
      await _rightController.forward(); // 3. Derecha
      await Future.delayed(const Duration(milliseconds: 100));
      _textController.forward(); // 4. Texto
    });
  }

  @override
  void dispose() {
    _centerController.dispose();
    _leftController.dispose();
    _rightController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50, top: 200),
        child: SizedBox(
          height: widget.r.hp(100),
          width: widget.r.wp(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("FLOWPACK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(4, 60), color: widget.green)),
              SizedBox(height: 50),

              /// TEXTO
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                    width: 1000,
                    child: Center(
                      child: Text(
                        "Flowpack EcoBag redefine cómo debe sentirse un empaque flexible, funcional, sostenible y visualmente impactante. Sin o con válvula desgasificadora integrada, ventana frontal y sistema Peel Stick, esta bolsa combina practicidad y diseño en cada detalle. Su estructura es precisa, su presentación limpia, y su apertura, simplemente intuitiva. Listo para destacar tu producto desde el primer vistazo.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: widget.r.fs(1.9, 26), color: Colors.black.withAlpha(200)),
                      ),
                    ),
                  ),
                ),
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  // Izquierda
                  SlideTransition(
                    position: _leftImageSlide,
                    child: Opacity(opacity: 0.6, child: Image.asset("img/ecobag/flowpack.webp", height: widget.r.hp(30))),
                  ),

                  // Derecha
                  SlideTransition(
                    position: _rightImageSlide,
                    child: Opacity(opacity: 0.6, child: Image.asset("img/ecobag/flowpack.webp", height: widget.r.hp(30))),
                  ),

                  // Central
                  SlideTransition(
                    position: _slideAnimationimg,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(opacity: _fadeAnimationimg, child: Image.asset("img/ecobag/flowpack.webp", height: widget.r.hp(45))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------Información de Ecobag Flow------------
class TextEcoBagFlowpckSliver extends StatelessWidget {
  const TextEcoBagFlowpckSliver({super.key, required this.r, required this.green});

  final Responsive r;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScrollAnimatedWrapper(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          "img/ecobag/doypack/o_with_flowers.webp",
                          fit: BoxFit.cover,
                          color: green,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text("Ecobag® Flowpack", style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: r.fs(3, 50))),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ScrollAnimatedWrapper(
                  visibilityKey: Key('flowpack-combina-proteccion'),

                  child: Text(
                    textAlign: TextAlign.center,
                    "Flowpack EcoBag combina protección, diseño y funcionalidad. Disponible en 3 o 4 láminas, con o sin ventana, se adapta a cada necesidad. Su sistema Peel Stick y la opción de válvula desgasificadora lo hacen ideal para productos que buscan destacar con una presentación impecable y práctica.",
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87, fontSize: r.fs(2, 26)),
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

//---------Bolsa con zoom------------
class ImageZoomFlowpackSliver extends StatefulWidget {
  final Color green;
  final bool isMobile;
  const ImageZoomFlowpackSliver({super.key, required this.green, required this.isMobile});

  @override
  State<ImageZoomFlowpackSliver> createState() => _ImageZoomFlowpackSliverState();
}

class _ImageZoomFlowpackSliverState extends State<ImageZoomFlowpackSliver> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  Offset _targetOffset = Offset.zero;
  Offset? _activeDot; // guarda cuál dot fue presionado
  bool _isZooming = false;
  int? selectedDot;
  late AnimationController _panelController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _panelController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _isZooming = false;
          _activeDot = null;
        });
      }
    });
  }

  void _zoomTo(Offset offset) {
    setState(() {
      _targetOffset = offset;
      _activeDot = offset;
      _isZooming = true;
    });
    _controller.forward(from: 0);
    _panelController.forward(); // 👈 mostrar panel
  }

  void _exitZoom() async {
    await _panelController.reverse();
    setState(() {
      selectedDot = null;
    });
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    _panelController.dispose();
    super.dispose();
  }

  Widget interactiveDot(Offset zoomOffset, int index) {
    final isActive = _isZooming && _activeDot == zoomOffset;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: !_isZooming || isActive ? 1.0 : 0.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDot = index;
          });
          if (isActive) {
            _exitZoom();
          } else {
            _zoomTo(zoomOffset);
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!isActive) const _PulseAnimation(),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: widget.green),
                    color: isActive ? widget.green.withAlpha(200) : null,
                  ),
                  child: isActive ? const Icon(Icons.close, size: 16, color: Colors.white) : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSlidingPanel(bool isMobile) {
    if (selectedDot == null) return const SizedBox();

    String title = "";
    String description = "";
    String img = 'img/smartbag/4pro/valvulas.webp';

    switch (selectedDot) {
      case 0:
        title = "Peel & Stick";
        description =
            "Ideal para abrir y cerrar el empaque múltiples veces sin perder hermeticidad. Perfecto para productos que requieren facilidad de acceso y conservación.";
        img = 'img/smartbag/4pro/valvulas.webp';
        break;
      case 1:
        title = "Válvula";
        description =
            "Permite la salida de gases sin permitir la entrada de aire, ideal para productos como café recién tostado. Mejora la conservación y frescura del contenido.";
        img = 'img/smartbag/4pro/valvulas.webp';
        break;
      case 2:
        title = "Ventana";
        description = "Una sección del empaque que permite ver el producto en su interior sin abrirlo. Añade valor visual y confianza al consumidor.";
        img = 'img/smartbag/4pro/valvulas.webp';
        break;
      default:
        title = "";
        description = "Una sección del empaque que permite ver el producto en su interior sin abrirlo. Añade valor visual y confianza al consumidor.";
        img = 'img/smartbag/4pro/valvulas.webp';
    }

    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Entra desde la izquierda
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _panelController, curve: Curves.easeInOut)),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: widget.isMobile ? 240 : 400,
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.green.withAlpha(100),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMobile
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: _exitZoom),
                        ],
                      )
                      : Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),

                  const SizedBox(height: 10),
                  SizedBox(width: widget.isMobile ? 200 : 400, height: widget.isMobile ? 200 : 400, child: Image.asset(img)),
                  Text(description, style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          ScrollAnimatedWrapper(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
                  final imgHeight = maxWidth * 1.6;

                  return SizedBox(
                    width: maxWidth,
                    height: imgHeight,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final scale = _scaleAnimation.value;
                        final dx = (_targetOffset.dx * maxWidth) * (scale - 1);
                        final dy = (_targetOffset.dy * imgHeight) * (scale - 1);

                        return ClipRect(
                          child: Transform(
                            transform:
                                Matrix4.identity()
                                  ..translate(-dx, -dy)
                                  ..scale(scale),
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: [
                                // PANEL DESLIZANTE
                                Image.asset("img/ecobag/flowpack.webp", fit: BoxFit.fitHeight, width: maxWidth, height: imgHeight),

                                // DOT 1
                                Positioned(left: maxWidth * 0.29, top: imgHeight * 0.20, child: interactiveDot(const Offset(0.29, 0.35), 0)),

                                // DOT 2
                                Positioned(left: maxWidth * 0.5 - 30, top: imgHeight * 0.40, child: interactiveDot(const Offset(0.5, 0.55), 1)),

                                // DOT 3
                                Positioned(left: maxWidth * 0.75 - 30, top: imgHeight * 0.75, child: interactiveDot(const Offset(0.75, 0.75), 2)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          buildSlidingPanel(widget.isMobile),
        ],
      ),
    );
  }
}

//Animación de la pulsación
class _PulseAnimation extends StatefulWidget {
  const _PulseAnimation();

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 2.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 0.7, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final green = Color.fromARGB(255, 75, 141, 44);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(shape: BoxShape.circle, color: green, border: Border.all(color: Colors.green, width: 2)),
            ),
          ),
        );
      },
    );
  }
}

//---------Información en scroll con la flowpack------------
class ScrollEcoFlowpackSliver extends StatefulWidget {
  const ScrollEcoFlowpackSliver({super.key, required this.r, required this.isMobile});

  final Responsive r;
  final bool isMobile;

  @override
  State<ScrollEcoFlowpackSliver> createState() => ScrollEcoFlowpackSliverState();
}

class ScrollEcoFlowpackSliverState extends State<ScrollEcoFlowpackSliver> {
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
    final List<dynamic> nuestroFlowpack = [
      {"title": "EcoBag® Flowpack:\nversatilidad para\nproductos sellados.", "image": "img/smartbag/5pro/cardLarge3.webp"},
      {"title": "Ideal para snacks,\npolvos, golosinas y más.\nProtección y frescura asegurada.", "image": "img/smartbag/5pro/cardLarge3.webp"},
      {"title": "Sellado hermético,\nexcelente presentación\ny eficiencia en empaque.", "image": "img/smartbag/5pro/cardLarge3.webp"},
      {"title": "Adaptable a líneas automáticas\nde empaque y alta rotación.", "image": "img/smartbag/5pro/cardLarge3.webp"},
    ];

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollAnimatedWrapper(
              visibilityKey: Key('presentacion-moderna-flowpack'),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                child: Text("Presentación moderna.\nEstilo flowpack", style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(3, 50))),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(nuestroFlowpack.length, (int index) {
                  final card = nuestroFlowpack[index];
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? widget.r.wp(6) : 0, right: index == nuestroFlowpack.length - 1 ? widget.r.wp(6) : 20),
                    child: Container(
                      height: widget.r.hp(60, max: 700),
                      width: widget.r.wp(80, max: 1000),
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
                                      padding: EdgeInsets.only(left: widget.r.dp(1, max: 20), top: widget.r.dp(1, max: 20)),
                                      child: Text(
                                        card['title'],
                                        style: TextStyle(
                                          height: 0,
                                          color: card['colorText'] ?? Colors.white,
                                          fontSize: widget.r.fs(2, 24),
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

//---------Imagenes con breve información------------
class ImagenSlivers extends StatelessWidget {
  const ImagenSlivers({super.key, required this.r, required this.green, required this.isMobile});

  final Responsive r;
  final Color green;
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
              TextSpan(children: [TextSpan(text: "Flow ", style: TextStyle(color: green)), TextSpan(text: "al más alto impacto")]),
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
          green,
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
                green,
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
                green,
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
          green,
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
          green,
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
          green,
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

  Widget containerFlow(Color green, {required Widget child, required String imagen, Alignment alignment = Alignment.center}) {
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
  const ComparisionSliver({super.key, required this.r, required this.green});

  final Responsive r;
  final Color green;

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
                    style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: r.fs(4, 40)),
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
                          Text("Flowpack Eco", style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize, color: green)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset("img/smartbag/flowpack/flowpackVs4proBlancoNegro.webp", fit: BoxFit.contain),
                          const SizedBox(height: 12),
                          Text(
                            "4PRO Eco",
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
                            if (item['flowpack'] as bool)
                              Icon(item['icon'] as IconData, color: green, size: iconSize)
                            else
                              SizedBox(height: iconSize),
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

//---------Final de Flowpack EcoBag®------------
class FlowpackFinallySliver extends StatefulWidget {
  const FlowpackFinallySliver({super.key, required this.r, required this.isMobile, required this.green, required this.route});
  final bool isMobile;
  final Responsive r;
  final Color green;
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
                      TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.green)),
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
                      Icon(CupertinoIcons.arrow_right, color: widget.green),
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
                TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.green)),
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

                Icon(CupertinoIcons.arrow_right, color: widget.green),
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
