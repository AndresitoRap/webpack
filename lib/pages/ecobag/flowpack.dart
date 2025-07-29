import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class FlowpackEco extends StatelessWidget {
  const FlowpackEco({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 850;
    final green = Color.fromARGB(255, 75, 141, 44);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 255, 252),
      body: CustomScrollView(
        slivers: [
          SliverWithStartFlowPacEco(screenHeight: screenHeight, screenWidth: screenWidth, green: green),
          SliverWithTextFlowPackEco(screenWidth: screenWidth, green: green),
          SliverWithImage(green: green, isMobile: isMobile),
          SliverInfoEcoFlowpack(isMobile: isMobile, screenWidth: screenWidth),
          SliverWithMoreFlow(screenWidth: screenWidth, green: green, isMobile: isMobile),
          SliverWithComparacion(screenWidth: screenWidth, green: green),
          SliverWithCareUs(screenWidth: screenWidth),
          SliverFinalFlowpack(screenWidth: screenWidth, isMobile: isMobile, green: green),
        ],
      ),
    );
  }
}

//Inicio
class SliverWithStartFlowPacEco extends StatefulWidget {
  const SliverWithStartFlowPacEco({super.key, required this.screenHeight, required this.screenWidth, required this.green});

  final double screenHeight;
  final double screenWidth;
  final Color green;

  @override
  State<SliverWithStartFlowPacEco> createState() => _SliverWithStartFlowPacEcoState();
}

class _SliverWithStartFlowPacEcoState extends State<SliverWithStartFlowPacEco> with TickerProviderStateMixin {
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
          height: widget.screenHeight,
          width: widget.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "FLOWPACK",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.2).clamp(30, 60), color: widget.green),
              ),
              SizedBox(height: 50),

              /// TEXTO
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06),
                    width: 1000,
                    child: Center(
                      child: Text(
                        "Flowpack EcoBag redefine cómo debe sentirse un empaque flexible, funcional, sostenible y visualmente impactante. Sin o con válvula desgasificadora integrada, ventana frontal y sistema Peel Stick, esta bolsa combina practicidad y diseño en cada detalle. Su estructura es precisa, su presentación limpia, y su apertura, simplemente intuitiva. Listo para destacar tu producto desde el primer vistazo.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: (widget.screenWidth * 0.07).clamp(16, 26), color: Colors.black.withAlpha(200)),
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
                    child: Opacity(opacity: 0.6, child: Image.asset("assets/img/ecobag/flowpack.webp", height: widget.screenHeight * 0.3)),
                  ),

                  // Derecha
                  SlideTransition(
                    position: _rightImageSlide,
                    child: Opacity(opacity: 0.6, child: Image.asset("assets/img/ecobag/flowpack.webp", height: widget.screenHeight * 0.3)),
                  ),

                  // Central
                  SlideTransition(
                    position: _slideAnimationimg,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimationimg,
                        child: Image.asset("assets/img/ecobag/flowpack.webp", height: widget.screenHeight * 0.45),
                      ),
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

//Sliver con texto
class SliverWithTextFlowPackEco extends StatelessWidget {
  const SliverWithTextFlowPackEco({super.key, required this.screenWidth, required this.green});

  final double screenWidth;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScrollAnimatedWrapper(
                  visibilityKey: Key('ecobag-flowpack'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          "assets/img/ecobag/doypack/o_with_flowers.png",
                          fit: BoxFit.cover,
                          color: green,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Ecobag® Flowpack",
                        style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: (screenWidth * 0.08).clamp(20, 50)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ScrollAnimatedWrapper(
                  visibilityKey: Key('flowpack-combina-proteccion'),

                  child: Text(
                    textAlign: TextAlign.center,
                    "Flowpack EcoBag combina protección, diseño y funcionalidad. Disponible en 3 o 4 láminas, con o sin ventana, se adapta a cada necesidad. Su sistema Peel Stick y la opción de válvula desgasificadora lo hacen ideal para productos que buscan destacar con una presentación impecable y práctica.",
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87, fontSize: (screenWidth * 0.04).clamp(20, 24)),
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

//Sliver con la imagen

class SliverWithImage extends StatefulWidget {
  final Color green;
  final bool isMobile;
  const SliverWithImage({super.key, required this.green, required this.isMobile});

  @override
  State<SliverWithImage> createState() => _SliverWithImageState();
}

class _SliverWithImageState extends State<SliverWithImage> with TickerProviderStateMixin {
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

  Widget buildSlidingPanel() {
    if (selectedDot == null) return const SizedBox();

    String title = "";
    String description = "";
    String img = 'assets/img/smartbag/4pro/valvulas.webp';

    switch (selectedDot) {
      case 0:
        title = "Peel & Stick";
        description =
            "Ideal para abrir y cerrar el empaque múltiples veces sin perder hermeticidad. Perfecto para productos que requieren facilidad de acceso y conservación.";
        img = 'assets/img/smartbag/4pro/valvulas.webp';
        break;
      case 1:
        title = "Válvula";
        description =
            "Permite la salida de gases sin permitir la entrada de aire, ideal para productos como café recién tostado. Mejora la conservación y frescura del contenido.";
        img = 'assets/img/smartbag/4pro/valvulas.webp';
        break;
      case 2:
        title = "Ventana";
        description = "Una sección del empaque que permite ver el producto en su interior sin abrirlo. Añade valor visual y confianza al consumidor.";
        img = 'assets/img/smartbag/4pro/valvulas.webp';
        break;
      default:
        title = "";
        description = "Una sección del empaque que permite ver el producto en su interior sin abrirlo. Añade valor visual y confianza al consumidor.";
        img = 'assets/img/smartbag/4pro/valvulas.webp';
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
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
            visibilityKey: Key('ecobag-flowpack-zoom-bag'),

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
                                Image.asset("assets/img/ecobag/flowpack.webp", fit: BoxFit.fitHeight, width: maxWidth, height: imgHeight),

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
          buildSlidingPanel(),
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

//Sliver con informacion
class SliverInfoEcoFlowpack extends StatefulWidget {
  const SliverInfoEcoFlowpack({super.key, required this.screenWidth, required this.isMobile});

  final double screenWidth;
  final bool isMobile;

  @override
  State<SliverInfoEcoFlowpack> createState() => _SliverInfoEcoFlowpackState();
}

class _SliverInfoEcoFlowpackState extends State<SliverInfoEcoFlowpack> {
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
      {"title": "EcoBag® Flowpack:\nversatilidad para\nproductos sellados.", "image": "assets/img/smartbag/5pro/cardLarge3.webp"},
      {
        "title": "Ideal para snacks,\npolvos, golosinas y más.\nProtección y frescura asegurada.",
        "image": "assets/img/smartbag/5pro/cardLarge3.webp",
      },
      {"title": "Sellado hermético,\nexcelente presentación\ny eficiencia en empaque.", "image": "assets/img/smartbag/5pro/cardLarge3.webp"},
      {"title": "Adaptable a líneas automáticas\nde empaque y alta rotación.", "image": "assets/img/smartbag/5pro/cardLarge3.webp"},
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
                padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06),
                child: Text(
                  "Presentación moderna. Estilo flowpack",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(30, 50)),
                ),
              ),
            ),

            ScrollAnimatedWrapper(
              visibilityKey: Key('scroll-flowpack'),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: List.generate(nuestroFlowpack.length, (int index) {
                    final card = nuestroFlowpack[index];
                    final double horizontalPadding = widget.screenWidth * 0.06;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? horizontalPadding : 0,
                        right: index == nuestroFlowpack.length - 1 ? horizontalPadding : 20,
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
              visibilityKey: Key('scroll-buttons-flowpack'),
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

//Sliver con mas flow aalto impacto
class SliverWithMoreFlow extends StatefulWidget {
  const SliverWithMoreFlow({super.key, required this.screenWidth, required this.green, required this.isMobile});

  final double screenWidth;
  final Color green;
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
            ScrollAnimatedWrapper(
              visibilityKey: Key('flow-al-mas-alto-impacto'),
              child: Text.rich(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.07).clamp(20, 40)),
                TextSpan(children: [TextSpan(text: "Flow ", style: TextStyle(color: widget.green)), TextSpan(text: "al más alto impacto")]),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: widget.isMobile ? 900 : 700,
              width: (widget.screenWidth * 0.8).clamp(0, 1200),
              child: ScrollAnimatedWrapper(
                visibilityKey: Key('con-aleta-y-otras'),

                child:
                    widget.isMobile
                        ? Column(
                          children: [
                            containerFlow(
                              widget.green,
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
                              widget.green,
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
                              widget.green,
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                          ],
                        )
                        : Row(
                          children: [
                            containerFlow(
                              widget.green,
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
                                    widget.green,
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
                                    widget.green,
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

  Widget containerFlow(Color green, {required Widget child, Alignment alignment = Alignment.center}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: alignment,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
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
  const SliverWithComparacion({super.key, required this.screenWidth, required this.green});

  final double screenWidth;
  final Color green;

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
                visibilityKey: Key('exclusividad-a-su-estilo'),

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    textAlign: TextAlign.start,
                    "Exclusividad en su estilo.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: (screenWidth * 0.1).clamp(20, 40)),
                  ),
                ),
              ),

              SizedBox(height: 50),
              // Títulos y fotos
              ScrollAnimatedWrapper(
                visibilityKey: Key('flowpackeco-4pro'),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset("assets/img/smartbag/flowpack.webp", fit: BoxFit.contain),
                          const SizedBox(height: 12),
                          Text("Flowpack Eco", style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize, color: green)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset("assets/img/smartbag/4pro.webp", fit: BoxFit.contain),
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
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Divider(thickness: 2, color: Colors.grey[300])),

              const SizedBox(height: 16),

              // Lista de características comparadas
              for (var item in characteristics) ...[
                ScrollAnimatedWrapper(
                  visibilityKey: Key('item-comparacion${item['label']}'),

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

//Te importa, nos importa
class SliverWithCareUs extends StatelessWidget {
  const SliverWithCareUs({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: min(screenWidth, 1600),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.06, horizontal: screenWidth * 0.06),
            child: Column(
              children: [
                ScrollAnimatedWrapper(
                  visibilityKey: Key('te-importa-nos-importa'),

                  child: Text(
                    "Te importa. Nos importa.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44), fontSize: min(screenWidth * 0.06, 70)),
                  ),
                ),

                SizedBox(height: screenWidth >= 1000 ? 50 : 100),
                ScrollAnimatedWrapper(
                  visibilityKey: Key('desde-empaques-cono-flowpack'),

                  child: Text(
                    textAlign: TextAlign.center,
                    "Desde empaques como Flowpac Ecobag®, diseñados para proteger tu producto y destacar tu marca, hasta soluciones como Ecobag®, que combinan funcionalidad con conciencia ambiental. Usamos materiales reciclables, desarrollamos opciones versátiles como válvulas y cierres herméticos, y te ofrecemos formatos pensados para cada necesidad, siempre con una visión sustentable. Porque cada detalle cuenta cuando quieres hacer las cosas bien.",
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87, fontSize: min(screenWidth * 0.026, 25), height: 0),
                  ),
                ),

                SizedBox(height: screenWidth >= 1000 ? 50 : 100),

                SizedBox(
                  width: min(screenWidth, 1600),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key('items-con-empaque'),

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
                                    "Usamos materiales reciclables y procesos responsables en toda la línea 5PRO y Ecobag®.",
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
                                      child: _buildBenefitBox(icon: item.$1, title: item.$2, description: item.$3, context: context),
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
                                    "Usamos materiales reciclables y procesos responsables en toda la línea 4PRO y Ecobag®.",
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
                                    child: _buildBenefitBox(icon: item.$1, title: item.$2, description: item.$3, context: context),
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
    );
  }

  Widget _buildBenefitBox({required IconData icon, required String title, required String description, required BuildContext context}) {
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
}

//Sliver final

class SliverFinalFlowpack extends StatefulWidget {
  const SliverFinalFlowpack({super.key, required this.screenWidth, required this.isMobile, required this.green});
  final bool isMobile;
  final double screenWidth;
  final Color green;

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
                                    TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.green)),
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
                                      "Elige Flowpack Eco",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: (widget.screenWidth * 0.03).clamp(18, 26), color: Colors.black),
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
                                    child: Image.asset("assets/img/smartbag/flowpack/flowpack_blanco.webp"),
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
                                    child: Image.asset("assets/img/smartbag/flowpack.webp"),
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
                                          TextSpan(text: "alto rendimiento.", style: TextStyle(color: widget.green)),
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
                                            "Elige Flowpack Eco",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: (widget.screenWidth * 0.03).clamp(18, 26), color: Colors.black),
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
                                    child: Image.asset("assets/img/smartbag/flowpack/flowpack_blanco.webp"),
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
                                    child: Image.asset("assets/img/smartbag/flowpack.webp"),
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
    );
  }
}
