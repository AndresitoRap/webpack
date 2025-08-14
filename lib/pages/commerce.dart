import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/pages/ecobag/doypack.dart';
import 'package:webpack/pages/ecobag/fivepro.dart';
import 'package:webpack/pages/ecobag/flowpack.dart';
import 'package:webpack/pages/ecobag/fourpro.dart';
import 'package:webpack/pages/smartbag/flowpack.dart';
import 'package:webpack/pages/smartbag/doypack.dart';
import 'package:webpack/pages/smartbag/fivepro.dart';
import 'package:webpack/pages/smartbag/fourpro.dart';
import 'package:webpack/utils/buttonarrow.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/video.dart';

class Commerce extends StatefulWidget {
  final String section;
  final Subcategorie selectedSubcategorie;
  final GlobalKey videoKey = GlobalKey();
  Commerce({super.key, required this.section, required this.selectedSubcategorie});

  @override
  State<Commerce> createState() => _CommerceState();
}

class _CommerceState extends State<Commerce> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    final section = widget.section.toLowerCase();
    final categoryName = widget.selectedSubcategorie.category.name.toLowerCase();
    final Responsive r = Responsive.of(context);

    Widget content;

    if (categoryName == 'smartbag') {
      switch (section) {
        case '4pro':
          content = FourPro(currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section, r: r);
          break;

        case '5pro':
          content = FivePro(currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, r: r);
          break;

        case 'doypack':
          content = DoypackSmart(r: r, subcategorie: widget.selectedSubcategorie);
          break;

        case 'flowpack':
          content = Flowpack(r: r, subcategorie: widget.selectedSubcategorie);
          break;

        case 'cojin':
          content = Plantilla(
            img: "img/smartbag/cojin/inicio.webp",
            name: "Cojín",
            videoKey: widget.videoKey,
            r: r,
            subcategorie: widget.selectedSubcategorie,
          );
          break;

        case 'piramidal':
          content = Plantilla(
            img: "img/smartbag/piramide.webp",
            name: "Piramidal",
            videoKey: widget.videoKey,
            r: r,
            subcategorie: widget.selectedSubcategorie,
          );
          break;

        case 'standpack':
          content = Plantilla(
            img: "img/smartbag/standpack/inicio.webp",
            name: "StandPack",
            videoKey: widget.videoKey,
            r: r,
            subcategorie: widget.selectedSubcategorie,
          );
          break;

        default:
          content = const Center(child: Text('En construcción'));
          break;
      }
    } else {
      switch (section) {
        case '4pro':
          content = FourProEco(r: r, subcategorie: widget.selectedSubcategorie);
          break;

        case '5pro':
          content = FiveProEco();
          break;

        case 'doypack':
          content = DoypackEco(r: r, subcategorie: widget.selectedSubcategorie);
          break;

        case 'flowpack':
          content = FlowpackEco(r: r, subcategorie: widget.selectedSubcategorie);
          break;

        case 'cojin':
          content = Plantilla(
            img: "img/ecobag/cojin.webp",
            name: "Cojín",
            videoKey: widget.videoKey,
            r: r,
            subcategorie: widget.selectedSubcategorie,
          );
          break;

        case 'piramidal':
          content = Plantilla(
            img: "img/ecobag/Piramidal.webp",
            name: "Piramidal",
            videoKey: widget.videoKey,
            r: r,
            subcategorie: widget.selectedSubcategorie,
          );
          break;

        default:
          content = const Center(child: Text('En construcción'));
      }
    }

    return Scaffold(body: Stack(children: [content, Header()]));
  }
}

class Plantilla extends StatefulWidget {
  final Responsive r;
  final String img, name;
  final GlobalKey? videoKey;
  final Subcategorie subcategorie;

  const Plantilla({super.key, required this.img, required this.name, this.videoKey, required this.r, required this.subcategorie});

  @override
  State<Plantilla> createState() => _PlantillaState();
}

class _PlantillaState extends State<Plantilla> with TickerProviderStateMixin {
  //controlador scroll
  double scrollProgress = 0.0;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _videoKey = GlobalKey();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));

    _controller.forward().whenComplete(() {
      setState(() {});
    });
    _controller.forward().whenComplete(() {
      setState(() {});
    });

    _scrollController.addListener(() {
      final GlobalKey videoKey = widget.videoKey ?? _videoKey;
      final RenderBox? renderBox = videoKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;
        final visible = position.dy + renderBox.size.height > 0 && position.dy < screenHeight;
        if (visible) {
          // Nuevo cálculo más preciso: efecto solo cuando el video está centrado
          final double midScreen = screenHeight / 2;
          final double midVideo = position.dy + renderBox.size.height / 2;
          final double distance = (midVideo - midScreen).abs();
          final double maxDistance = screenHeight * 0.6;
          final double progress = (1.0 - (distance / maxDistance)).clamp(0.0, 1.0);
          setState(() {
            scrollProgress = progress;
          });
        } else {
          setState(() {
            scrollProgress = 0.0;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final color =
        (ModalRoute.of(context)?.settings.name?.toLowerCase() ?? "").contains('ecobag')
            ? Color.fromARGB(255, 75, 141, 44)
            : Theme.of(context).primaryColor;
    final isMobile = screenWidth < 850;
    final r = widget.r;
    final route = '${widget.subcategorie.route}/crea-tu-empaque';

    return Scaffold(
      backgroundColor: const Color(0xff1d1d1f),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          StartTemplateSliver(color: color, img: widget.img, name: widget.name, r: r),
          ScrollInfoSliver(screenWidth: screenWidth, isMobile: isMobile, color: color, r: r),
          VideoTemplateSliver(
            r: r,
            widget: widget,
            isMobile: isMobile,
            color: color,
            scrollProgress: scrollProgress,
            videoKey: widget.videoKey ?? _videoKey,
          ),
          ThisMomentSliver(r: r, color: color, isMobile: isMobile),
          ScrollWithMoreInfoSliver(r: r, widget: widget, color: color, isMobile: isMobile, route: route),

          DoubItSliver(r: r, isMobile: isMobile, widget: widget, color: color, route: route),
          if ((ModalRoute.of(context)?.settings.name?.toLowerCase() ?? "").contains('ecobag'))
            SliverWithCareUs(screenWidth: screenWidth, widget: widget),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(top: 50), child: Footer(isDark: true))),
        ],
      ),
    );
  }
}

//---------Inicio con el splash------------
class StartTemplateSliver extends StatefulWidget {
  final Responsive r;
  final Color color;
  final GlobalKey? videoKey;
  final String img, name;
  const StartTemplateSliver({super.key, required this.color, this.videoKey, required this.img, required this.name, required this.r});

  @override
  State<StartTemplateSliver> createState() => _StartTemplateSliverState();
}

class _StartTemplateSliverState extends State<StartTemplateSliver> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 6.0,
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)));

    _textScaleAnimation = Tween<double>(
      begin: 2.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: SizedBox(
          height: widget.r.hp(100),
          width: widget.r.wp(100),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder:
                    (_, __) => Opacity(
                      opacity: _opacityAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 92, 92, 92),
                            boxShadow: [BoxShadow(color: const Color.fromARGB(255, 92, 92, 92), blurRadius: 100, spreadRadius: 40)],
                          ),
                        ),
                      ),
                    ),
              ),
              // Contenido principal
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _textScaleAnimation,
                    builder:
                        (_, __) => Transform.scale(
                          scale: _textScaleAnimation.value,
                          child: Opacity(
                            opacity: 1.0 - _opacityAnimation.value,
                            child: Column(
                              children: [
                                Text(
                                  widget.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: widget.r.fs(10, 80),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(offset: Offset(0, -2), color: Colors.white.withAlpha(150), blurRadius: 6),
                                      Shadow(offset: Offset(0, 2), color: widget.color, blurRadius: 12),
                                    ],
                                  ),
                                ),
                                Text("Bajo pedido", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withAlpha(200), fontSize: 20)),
                              ],
                            ),
                          ),
                        ),
                  ),
                  AnimatedBuilder(
                    animation: _opacityAnimation,
                    builder:
                        (_, __) => Opacity(
                          opacity: 1.0 - _opacityAnimation.value,
                          child: Image.asset(widget.img, height: widget.r.hp(60, max: 600), fit: BoxFit.contain),
                        ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 1500),
                    opacity: 1.0 - _opacityAnimation.value,
                    child: Column(
                      children: [
                        Text(
                          "Diseños que destacan.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: widget.r.fs(1.9, 40)),
                        ),
                        SizedBox(height: widget.r.hp(2)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(children: _buildDescripcion(widget.name, widget.color)),
                            style: TextStyle(color: Colors.white.withAlpha(200), fontSize: widget.r.fs(1.3, 26)),
                          ),
                        ),
                      ],
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

  List<TextSpan> _buildDescripcion(String bolsa, Color color) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final tipo = route.contains("ecobag") ? "EcoBag®" : "SmartBag®";

    switch (bolsa.toLowerCase()) {
      case 'standpack':
        return [
          TextSpan(text: "La "),
          TextSpan(text: "StandPack ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "de la línea "),
          TextSpan(text: "$tipo ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "se destaca por su estructura autoportante que ofrece una "),
          TextSpan(text: "presencia imponente ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "en anaquel. Ideal para destacar tu producto en cualquier entorno."),
        ];

      case 'piramidal':
        return [
          TextSpan(text: "La "),
          TextSpan(text: "Piramidal ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "de la línea "),
          TextSpan(text: "$tipo ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "fusiona geometría moderna con funcionalidad. Su diseño "),
          TextSpan(text: "vanguardista ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "hace que tu empaque sea inolvidable."),
        ];

      case 'cojín':
        return [
          TextSpan(text: "El "),
          TextSpan(text: "Cojín ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "de la línea "),
          TextSpan(text: "$tipo ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "ofrece un formato tradicional optimizado. Es cómodo, versátil y "),
          TextSpan(text: "perfecto para automatización de empaque.", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ];

      default:
        return [
          TextSpan(text: "Este empaque especial de la línea "),
          TextSpan(text: "$tipo ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "fue diseñado para adaptarse a las necesidades modernas con estilo y rendimiento."),
        ];
    }
  }
}

//---------Información de el producto------------
class ScrollInfoSliver extends StatefulWidget {
  const ScrollInfoSliver({super.key, required this.screenWidth, required this.isMobile, required this.color, required this.r});
  final Color color;
  final Responsive r;
  final double screenWidth;
  final bool isMobile;

  @override
  State<ScrollInfoSliver> createState() => _ScrolInfolSliverState();
}

class _ScrolInfolSliverState extends State<ScrollInfoSliver> {
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
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final String tipoBolsa =
        route.contains('cojin')
            ? 'cojin'
            : route.contains('piramidal')
            ? 'piramidal'
            : route.contains('standpack')
            ? 'standpack'
            : '';

    final Map<String, Map<String, List<Map<String, String>>>> tarjetas = {
      'cojin': {
        'eco': [
          {'image': 'img/BLogo.webp', 'text': 'Cojín ecoamigable, 2 o 3 sellos, con terminación papel, varios tamaños.'},
          {'image': 'img/BLogo.webp', 'text': 'Versátil y resistente, ideal para alimentos y productos sólidos.'},
          {'image': 'img/BLogo.webp', 'text': 'Sostenible, con o sin ventana, en medidas y acabados premium.'},
        ],
        'smart': [
          {'image': 'img/smartbag/cojin/cardLarge1.webp', 'text': 'Cojín de alto desempeño, 2 o 3 sellos, mate o brillante.'},
          {'image': 'img/smartbag/cojin/cardLarge2.webp', 'text': 'Optimizado para conservación, con o sin ventana.'},
          {'image': 'img/smartbag/cojin/cardLarge3.webp', 'text': 'Premium, alta barrera, acabados y medidas exclusivas.'},
        ],
      },

      'piramidal': {
        'eco': [
          {'image': 'img/BLogo.webp', 'text': 'EcoBag® Piramidal, diseño estable y atractivo, ideal para exhibición en estanterías.'},
          {'image': 'img/BLogo.webp', 'text': 'Fabricada con materiales sostenibles, disponible con o sin ventana.'},
          {'image': 'img/BLogo.webp', 'text': 'Acabados en papel o mate, perfecta para productos gourmet y especiales.'},
        ],
        'smart': [
          {
            'image': 'img/smartbag/piramidal/CardLarge1.webp',
            'text': 'SmartBag® Piramidal de alto rendimiento, máxima protección y presentación premium.',
          },
          {
            'image': 'img/smartbag/piramidal/CardLarge2.webp',
            'text': 'Disponible en terminación mate o brillante, con barrera de alta conservación.',
          },
          {'image': 'img/smartbag/piramidal/CardLarge3.webp', 'text': 'Diseño exclusivo para destacar tu marca en tú negocio.'},
        ],
      },

      'standpack': {
        'smart': [
          {'image': 'img/smartbag/standpack/cardLarge1.webp', 'text': 'Sella el sabor. Conserva lo esencial.'},
          {'image': 'img/smartbag/standpack/cardLarge2.webp', 'text': 'Claridad total. El envase que deja ver la frescura.'},
          {'image': 'img/smartbag/standpack/cardLarge3.webp', 'text': 'Diseñado para proteger. Hecho para destacar.', 'down': 'Y'},
        ],
      },
    };
    final tarjetasMostrar = tarjetas[tipoBolsa]?[isEco ? 'eco' : 'smart'] ?? [];

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: widget.isMobile ? 40 : 20),
              child: Text(
                "Exclusividad de ${tipoBolsa.toUpperCase()}.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(30, 50), color: Colors.white),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(tarjetasMostrar.length, (index) {
                  final tarjeta = tarjetasMostrar[index];
                  return buildCard(
                    image: tarjeta['image']!,
                    text: tarjeta['text']!,
                    isFirst: index == 0,
                    isLast: index == tarjetasMostrar.length - 1,
                    down: tarjeta['down'] ?? '',
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ArrowButton(
                    enabled: canScrollLeft,
                    isDark: true,
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
                  ArrowButton(
                    enabled: canScrollRight,
                    isDark: true,
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
          ],
        ),
      ),
    );
  }

  Widget buildCard({required String image, required String text, required bool isFirst, required bool isLast, required String down}) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? widget.r.wp(6) : 0, right: isLast ? widget.r.wp(6) : 20),
      child: Container(
        width: widget.isMobile ? widget.r.wp(80) : widget.r.wp(60),
        height: widget.isMobile ? widget.r.wp(90) : widget.r.wp(40, max: 600),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(26), image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Align(
          alignment: down.isNotEmpty ? Alignment.bottomLeft : Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(widget.r.dp(3, max: 22)),
            child: Text(
              text,
              style: TextStyle(
                height: 1.2,
                color: Colors.white,
                fontSize: widget.r.fs(2, 24),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0), // desplazamiento en X y Y
                    blurRadius: 4, // difuminado de la sombra
                    color: Colors.black.withAlpha(200), // color y opacidad
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

//---------Video con la información del producto------------
class VideoTemplateSliver extends StatefulWidget {
  const VideoTemplateSliver({
    super.key,
    required this.widget,
    required this.isMobile,
    required this.color,
    required this.scrollProgress,
    required this.videoKey,
    required this.r,
  });

  final Plantilla widget;
  final Responsive r;
  final Color color;
  final bool isMobile;
  final double scrollProgress;
  final GlobalKey videoKey;

  @override
  State<VideoTemplateSliver> createState() => _VideoTemplateSliverState();
}

class _VideoTemplateSliverState extends State<VideoTemplateSliver> {
  final ValueNotifier<bool> showAnimation = ValueNotifier(false);

  @override
  void dispose() {
    showAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final String tipoBolsa =
        route.contains('cojin')
            ? 'cojin'
            : route.contains('piramidal')
            ? 'piramidal'
            : route.contains('standpack')
            ? 'standpack'
            : '';

    final Map<String, Map<String, List<Map<String, String>>>> videos = {
      'cojin': {
        'eco': [
          {'Video': 'assets/videos/smartbag/smart1.webm'},
        ],
        'smart': [
          {'Video': 'assets/videos/smartbag/cojin/video.webm'},
        ],
      },
      'piramidal': {
        'eco': [
          {'Video': 'assets/videos/smartbag/smart1.webm'},
        ],
        'smart': [
          {'Video': 'assets/videos/smartbag/smart1.webm'},
        ],
      },
      'standpack': {
        'smart': [
          {'Video': 'assets/videos/smartbag/standpack/video.webm'},
        ],
      },
    };

    // Selección del video
    final String videoSrc = videos[tipoBolsa]?[isEco ? 'eco' : 'smart']?.first['Video'] ?? '';

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Text(
                textAlign: TextAlign.center,
                "Unete a la familia.",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.15).clamp(30, 60)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

              child: Text(
                textAlign: TextAlign.center,
                "Sé ${widget.widget.name}.",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.15).clamp(30, 60)),
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: widget.r.wp(80, max: 1000),
              child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withAlpha(200), fontSize: widget.r.fs(2, 26)),
                TextSpan(children: buildDescripcion(widget.widget.name, widget.color)),
              ),
            ),
            //Container que se reduce un poquito al hacer scroll
            Center(
              child: Builder(
                builder: (context) {
                  final borderRadius = BorderRadius.circular(30 * widget.scrollProgress);
                  final pdh = widget.r.wp(4) * widget.scrollProgress;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: pdh),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: SizedBox(
                        key: widget.videoKey,
                        width: double.infinity,
                        height: min(screenHeight * 0.8, 1100),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return VideoFlutter(src: videoSrc, blur: isBlur, loop: true, showControls: true, fit: BoxFit.cover);
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
            const SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
              child:
                  widget.isMobile
                      ? Column(
                        children: [
                          Text.rich(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withAlpha(180),
                              fontSize: (screenWidth * 0.03).clamp(18, 26),
                              height: 0.99,
                            ),
                            TextSpan(children: buildDescriptiondownvideo1(widget.widget.name, widget.color)),
                          ),
                          SizedBox(height: 50),
                          Text.rich(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withAlpha(180),
                              fontSize: (screenWidth * 0.03).clamp(18, 26),
                              height: 0.99,
                            ),
                            TextSpan(children: buildDescriptiondownvideo2(widget.widget.name, widget.color)),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text.rich(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withAlpha(180),
                                fontSize: (screenWidth * 0.03).clamp(18, 24),
                                height: 0.99,
                              ),
                              TextSpan(children: buildDescriptiondownvideo1(widget.widget.name, widget.color)),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.1),
                          Expanded(
                            child: Text.rich(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withAlpha(180),
                                fontSize: (screenWidth * 0.03).clamp(18, 24),
                                height: 0.99,
                              ),
                              TextSpan(children: buildDescriptiondownvideo2(widget.widget.name, widget.color)),
                            ),
                          ),
                        ],
                      ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  List<TextSpan> buildDescripcion(String bolsa, Color color) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final tipo = isEco ? "EcoBag®" : "SmartBag®";

    switch (bolsa.toLowerCase()) {
      case 'standpack':
        return [
          TextSpan(text: "La "),
          TextSpan(text: "StandPack ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "de la línea "),
          TextSpan(text: tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: " combina una estructura autoportante con cierre hermético y base con fuelle, garantizando "),
          TextSpan(text: "gran capacidad, estabilidad y frescura", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: ". Ideal para exhibir y proteger tu producto en ambiente retail."),
        ];

      case 'piramidal':
        return [
          TextSpan(text: "La "),
          TextSpan(text: "Piramidal ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "de la línea "),
          TextSpan(text: tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: " presenta una forma triangular única con cuatro caras personalizables, brindando "),
          TextSpan(text: "impacto visual, innovación y gran capacidad interna", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: ". Una presentación poco convencional que destaca tu producto."),
        ];

      case 'cojín':
        return [
          TextSpan(text: "El "),
          TextSpan(text: "Cojín ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "de la línea "),
          TextSpan(text: tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: " es un empaque tradicional tipo sachet, perfecto para porciones pequeñas o demostraciones. Ofrece "),
          TextSpan(
            text: "practicidad, personalización completa y óptimo ajuste para automatización",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "."),
        ];

      default:
        return [
          TextSpan(text: "Este empaque de la línea "),
          TextSpan(text: tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: " ha sido diseñado utilizando materiales de alta barrera contra oxígeno, luz y humedad, asegurando "),
          TextSpan(
            text: "protección prolongada, frescura y calidad ideal para exportación",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "."),
        ];
    }
  }

  List<TextSpan> buildDescriptiondownvideo1(String bolsa, Color color) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final tipo = isEco ? "EcoBag®" : "SmartBag®";

    switch (bolsa.toLowerCase()) {
      case 'standpack':
        return [
          TextSpan(text: "SmartBag® Standpack ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                "está diseñada para destacar tu producto desde el primer vistazo. Con una base estable que permite que se mantenga de pie, tecnología de barrera que ",
          ),
          TextSpan(text: "conserva la frescura ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                "y un diseño personalizable que se adapta a tu marca, es ideal para alimentos como frutas frescas, pollo marinado y productos listos para preparar.",
          ),
        ];

      case 'piramidal':
        return [
          TextSpan(text: "Piramidal $tipo", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                "combina diseño innovador con eficiencia estructural para ofrecer una presentación única que capta miradas. Perfecto para exhibición gourmet, este empaque aporta ",
          ),
          TextSpan(text: "elegancia, estabilidad y diferenciación.", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ];

      case 'cojín':
        return [
          TextSpan(text: "Clásico, confiable y adaptable. El empaque tipo "),
          TextSpan(text: "Cojín $tipo es ideal ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: "para líneas de alta producción que requieren eficiencia sin sacrificar calidad."),
        ];

      default:
        return [
          TextSpan(text: "Este empaque de la línea "),
          TextSpan(text: tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: " ha sido diseñado utilizando materiales de alta barrera contra oxígeno, luz y humedad, asegurando "),
          TextSpan(
            text: "protección prolongada, frescura y calidad ideal para exportación",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "."),
        ];
    }
  }

  List<TextSpan> buildDescriptiondownvideo2(String bolsa, Color color) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final tipo = isEco ? "EcoBag®" : "SmartBag®";

    switch (bolsa.toLowerCase()) {
      case 'standpack':
        return [
          TextSpan(text: "Disfruta de una "),
          TextSpan(text: "experiencia visual y funcional ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(
            text:
                "que combina practicidad, resistencia y presentación premium. Ya sea en refrigeradores o estanterías, tu producto siempre se verá bien.",
          ),
        ];

      case 'piramidal':
        return [
          TextSpan(text: "Su "),
          TextSpan(text: "forma tridimensional  ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(
            text: "mejora la experiencia del consumidor y comunica exclusividad. Disponible con acabados de alto impacto, impresión full color y ",
          ),
          TextSpan(text: "materiales sostenibles.", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ];

      case 'cojín':
        return [
          if (tipo == "EcoBag®") ...[
            TextSpan(text: "Fabricado con materiales reciclables o compostables, este "),
            TextSpan(text: "EcoBag tipo Cojín ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            TextSpan(text: "combina funcionalidad y conciencia ambiental en un diseño práctico y moderno."),
          ],

          if (tipo == "SmartBag®") ...[
            TextSpan(text: "Diseñado para el rendimiento, este "),
            TextSpan(text: "SmartBag tipo Cojín ", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            TextSpan(text: "ofrece tecnología avanzada, ideal para productos que requieren máxima protección y presencia visual."),
          ],
        ];

      default:
        return [
          TextSpan(text: "Este empaque de la línea "),
          TextSpan(text: tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          TextSpan(text: " ha sido diseñado utilizando materiales de alta barrera contra oxígeno, luz y humedad, asegurando "),
          TextSpan(
            text: "protección prolongada, frescura y calidad ideal para exportación.",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "."),
        ];
    }
  }
}

//---------Sección "Se único y destaca"------------
class ThisMomentSliver extends StatelessWidget {
  final Responsive r;
  final Color color;
  final bool isMobile;
  const ThisMomentSliver({super.key, required this.color, required this.r, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final String tipoBolsa =
        route.contains('cojin')
            ? 'cojin'
            : route.contains('piramidal')
            ? 'piramidal'
            : route.contains('standpack')
            ? 'standpack'
            : '';

    final Map<String, Map<String, List<Map<String, String>>>> img = {
      'cojin': {
        'eco': [
          {'Img': 'img/BIsotipo.webp'},
        ],
        'smart': [
          {'Img': 'img/smartbag/cojin/Big.webp'},
        ],
      },
      'piramidal': {
        'eco': [
          {'Img': 'img/BIsotipo.webp'},
        ],
        'smart': [
          {'Img': 'img/smartbag/piramidal/BIG.webp'},
        ],
      },
      'standpack': {
        'smart': [
          {'Img': 'img/smartbag/standpack/big.webp'},
        ],
      },
    };
    final String imgsrc = img[tipoBolsa]?[isEco ? 'eco' : 'smart']?.first['Img'] ?? '';
    final bool isCojinSmartbag = tipoBolsa == 'cojin' && !isEco; // porque 'smart' es cuando isEco es false

    final double imageHeight = isMobile ? (isCojinSmartbag ? 900 : 300) : (isCojinSmartbag ? 1200 : 500);

    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Texto gris claro
            Text('Es el momento.', style: TextStyle(color: Colors.grey.shade500, fontSize: r.fs(3, 80), fontWeight: FontWeight.bold)),
            // Texto con glow
            Text(
              textAlign: TextAlign.center,
              'Sé único y destaca.',
              style: TextStyle(
                fontSize: r.fs(6, 90),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.white.withAlpha(200), blurRadius: 50, offset: Offset(0, 5)),
                  Shadow(color: color, blurRadius: 20, offset: Offset(0, 5)),
                ],
              ),
            ),
            SizedBox(
              height: imageHeight,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: imageHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, color]),
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.bottomCenter, child: Image.asset(imgsrc, height: imageHeight, fit: BoxFit.cover)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------Sección con más información------------
class ScrollWithMoreInfoSliver extends StatefulWidget {
  const ScrollWithMoreInfoSliver({
    super.key,
    required this.r,
    required this.widget,
    required this.color,
    required this.isMobile,
    required this.route,
  });

  final Responsive r;
  final Plantilla widget;
  final Color color;
  final bool isMobile;
  final String route;

  @override
  State<ScrollWithMoreInfoSliver> createState() => _ScrollWithMoreInfoSliverState();
}

class _ScrollWithMoreInfoSliverState extends State<ScrollWithMoreInfoSliver> {
  bool isHoverText = false;

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
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final String tipoBolsa =
        route.contains('cojin')
            ? 'cojín'
            : route.contains('piramidal')
            ? 'piramidal'
            : route.contains('standpack')
            ? 'standpack'
            : '';

    final String tipoLinea =
        route.contains('ecobag')
            ? 'EcoBag®'
            : route.contains('smartbag')
            ? 'SmartBag®'
            : '';

    final Map<String, Map<String, List<Map<String, String>>>> tarjetas = {
      'cojín': {
        'eco': [
          {
            'image': 'img/smartbag/discover1.webp',
            'text':
                'Bolsa tipo cojín fabricada con materiales ecoamigables. Disponible en 2 sellos o 3 sellos, con acabado mate o brillante, en varios tamaños.',
          },
          {
            'image': 'img/smartbag/discover1.webp',
            'text':
                'Diseño versátil y resistente, ideal para alimentos y productos sólidos. Opciones de impresión personalizadas y variedad de gramajes.',
          },
          {
            'image': 'img/smartbag/discover1.webp',
            'text': 'Opción sostenible para empaque de alta calidad. Disponible en diferentes medidas, con o sin ventana, y terminados premium.',
          },
        ],
        'smart': [
          {
            'image': 'img/smartbag/cojin/cardShort1.webp',
            'text':
                'Bolsa tipo cojín de alto desempeño, con opción de 2 o 3 sellos. Acabado mate o brillante y variedad de tamaños para diferentes usos.',
          },
          {
            'image': 'img/smartbag/cojin/cardShort2.webp',
            'text':
                'Diseño optimizado para conservación de producto. Soporta impresión de alta definición y ofrece versiones con ventana o sin ventana.',
          },
          {
            'image': 'img/smartbag/cojin/cardShort3.webp',
            'text': 'Opción premium en presentación cojín, con materiales de alta barrera, múltiples acabados y medidas personalizables.',
          },
        ],
      },
      'piramidal': {
        'eco': [
          {
            'image': 'img/smartbag/discover1.webp',
            'text':
                'Diseño ecológico y moderno que optimiza el uso de materiales, reduciendo el consumo de plástico al usar papel kraft - blanco sin comprometer la protección del producto.',
          },
          {
            'image': 'img/smartbag/discover1.webp',
            'text':
                'Perfecta para presentaciones gourmet, productos orgánicos y marcas que buscan transmitir un mensaje de responsabilidad ambiental.',
          },
          {
            'image': 'img/smartbag/discover1.webp',
            'text': 'Fabricada con materiales 100% eco amigables, ofreciendo resistencia, frescura prolongada y una huella de carbono reducida.',
          },
        ],
        'smart': [
          {
            'image': 'img/smartbag/piramidal/CardShort1.webp',
            'text':
                'Formato innovador y llamativo que destaca en estanterías, generando un alto impacto visual y aumentando la recordación de marca.',
          },
          {
            'image': 'img/smartbag/piramidal/CardShort2.webp',
            'text': 'Ideal para snacks, infusiones, café y productos de alta rotación, combinando practicidad de uso con una estética premium.',
          },
          {
            'image': 'img/smartbag/piramidal/CardShort3.webp',
            'text':
                'Diseño ergonómico con sellado hermético y estructura estable que garantiza una conservación óptima y mayor durabilidad del contenido.',
          },
        ],
      },

      'standpack': {
        'smart': [
          {
            'image': 'img/smartbag/standpack/cardShort1.webp',
            'text': 'Frescura que inspira confianza. Ideal para conservar la jugosidad y el sabor auténtico del pollo, como recién salido del horno.',
          },
          {
            'image': 'img/smartbag/standpack/cardShort2.webp',
            'text': 'El sabor de la naturaleza, preservado. Diseñado para mantener frutas y verduras tan frescas como el primer día.',
          },
          {
            'image': 'img/smartbag/standpack/cardShort3.webp',
            'text': 'Un solo envase, infinitas posibilidades. Perfecto para carnes, snacks o alimentos listos para disfrutar.',
          },
        ],
      },
    };
    final tarjetasMostrar = tarjetas[tipoBolsa]?[isEco ? 'eco' : 'smart'] ?? [];

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: widget.r.wp(100),
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.r.wp(8)),
                  child: SizedBox(
                    width: 1000,
                    child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: widget.r.fs(1.3, 24)),
                        children: [
                          if (tipoBolsa == 'cojín' && tipoLinea == 'EcoBag®') ...[
                            const TextSpan(text: "Clásico, confiable y sostenible. El empaque tipo "),
                            TextSpan(text: "Cojín EcoBag® ", style: TextStyle(color: widget.color)),
                            const TextSpan(
                              text:
                                  "integra eficiencia productiva con conciencia ambiental. Su diseño simple optimiza la cadena de envasado, mientras sus materiales sustentables hacen la diferencia en cada etapa del ciclo de vida del producto.",
                            ),
                          ] else if (tipoBolsa == 'cojín' && tipoLinea == 'SmartBag®') ...[
                            const TextSpan(text: "Diseñado para la precisión. El empaque tipo "),
                            TextSpan(text: "Cojín SmartBag® ", style: TextStyle(color: widget.color)),
                            const TextSpan(
                              text:
                                  "es la evolución del formato tradicional, integrando soluciones inteligentes para líneas de alta velocidad, trazabilidad automatizada y máxima eficiencia sin comprometer la calidad del producto final.",
                            ),
                          ] else if (tipoBolsa == 'piramidal' && tipoLinea == 'EcoBag®') ...[
                            const TextSpan(text: "Forma única, impacto sustentable. El "),
                            TextSpan(text: "Piramidal EcoBag® ", style: TextStyle(color: widget.color)),
                            const TextSpan(
                              text:
                                  "proporciona una estética distintiva en el punto de venta, combinando elegancia visual con materiales ecoamigables. Ideal para marcas que buscan diferenciarse mientras cuidan el planeta.",
                            ),
                          ] else if (tipoBolsa == 'piramidal' && tipoLinea == 'SmartBag®') ...[
                            const TextSpan(text: "Innovación desde cada ángulo. El "),
                            TextSpan(text: "Piramidal SmartBag® ", style: TextStyle(color: widget.color)),
                            const TextSpan(
                              text:
                                  "transforma la experiencia del empaque con una silueta moderna, capacidad optimizada y compatibilidad con cierres inteligentes. Diseñado para destacar tanto en el anaquel como en la línea de producción.",
                            ),
                          ] else if (tipoBolsa == 'standpack' && tipoLinea == 'EcoBag®') ...[
                            const TextSpan(text: "Sustentabilidad sin compromisos. El "),
                            TextSpan(text: "StandPack EcoBag® ", style: TextStyle(color: widget.color)),
                            const TextSpan(
                              text:
                                  "es funcional, reutilizable y ecológico. Su base expandible asegura estabilidad, mientras que sus materiales reciclables reflejan un compromiso real con el entorno.",
                            ),
                          ] else if (tipoBolsa == 'standpack' && tipoLinea == 'SmartBag®') ...[
                            const TextSpan(text: "Versatilidad con propósito. El "),
                            TextSpan(text: "StandPack SmartBag® ", style: TextStyle(color: widget.color)),
                            const TextSpan(
                              text:
                                  "eleva el empaque flexible con opciones avanzadas de cierre, compatibilidad con válvulas, impresión inteligente y estructura pensada para la experiencia del usuario moderno.",
                            ),
                          ] else ...[
                            const TextSpan(text: "Descubre el empaque ideal para tu producto."),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.r.wp(8), vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      navigateWithSlide(context, widget.route);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) {
                        setState(() {
                          isHoverText = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHoverText = false;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.left,
                            "Crear mi ${widget.widget.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.color,
                              fontSize: widget.r.fs(1.2, 20),
                              decoration: isHoverText ? TextDecoration.underline : TextDecoration.none,
                              decorationColor: widget.color,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(CupertinoIcons.arrow_right, color: widget.color, size: 24),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                //Scroll
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    children: List.generate(tarjetasMostrar.length, (index) {
                      final tarjeta = tarjetasMostrar[index];
                      return buildCard(
                        isMobile: widget.isMobile,
                        image: tarjeta['image']!,
                        text: tarjeta['text']!,
                        isFirst: index == 0,
                        isLast: index == tarjetasMostrar.length - 1,
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ArrowButton(
                        enabled: canScrollLeft,
                        isDark: true,
                        icon: CupertinoIcons.chevron_left,
                        onTap: () {
                          _scrollController.animateTo(
                            _scrollController.offset - (widget.r.wp(60)),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),

                      const SizedBox(width: 20),
                      ArrowButton(
                        isDark: true,

                        enabled: canScrollRight,
                        icon: CupertinoIcons.chevron_right,
                        onTap: () {
                          _scrollController.animateTo(
                            _scrollController.offset + (widget.r.wp(60)),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              // evita interacciones
              child: Container(
                height: 300, // altura del degradado
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Color(0xff1d1d1f)]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({required bool isMobile, required String image, text, required bool isFirst, required bool isLast}) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? widget.r.wp(6) : 0, right: isLast ? widget.r.wp(6) : 20),
      child: SizedBox(
        width: widget.r.wp(70, max: 500),
        height: widget.r.wp(70, max: 500) + 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.r.wp(70, max: 500),
              height: widget.r.wp(70, max: 500),
              padding: const EdgeInsets.only(top: 22, left: 22),
              margin: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(26), image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
            ),
            Text(text, style: TextStyle(height: 1.2, color: Colors.white, fontSize: widget.r.fs(1.4, 20), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

//---------Sección final------------

class DoubItSliver extends StatelessWidget {
  const DoubItSliver({super.key, required this.r, required this.isMobile, required this.widget, required this.color, required this.route});

  final Responsive r;
  final bool isMobile;
  final Plantilla widget;
  final Color color;
  final String route;

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> getLoDudasData(String name) {
      final isSmart = name.contains("SmartBag");

      return {
        'standpack': {
          'text': TextSpan(
            children: [
              TextSpan(text: "Funcionalidad y elegancia se unen con "),
              TextSpan(text: "${isSmart ? 'SmartBag' : 'EcoBag'} Standpack. ", style: TextStyle(color: color)),
              TextSpan(text: "Perfecto para destacar en anaquel y proteger tu producto."),
            ],
          ),
          'image': "img/smartbag/standpack/end.webp",
        },
        'piramidal': {
          'text': TextSpan(
            children: [
              TextSpan(text: "Innovación con forma. "),
              TextSpan(text: "${isSmart ? 'SmartBag' : 'EcoBag'} Piramidal. ", style: TextStyle(color: color)),
              TextSpan(text: "Ideal para tés y productos gourmet que buscan una experiencia única."),
            ],
          ),
          'image': isSmart ? "img/BLogo.webp" : "img/smartbag/piramidal/end.webp",
        },
        'cojín': {
          'text': TextSpan(
            children: [
              TextSpan(text: "Clásico, confiable y adaptable. "),
              TextSpan(text: "${isSmart ? 'SmartBag' : 'EcoBag'} Cojín. ", style: TextStyle(color: color)),
              TextSpan(text: "Para líneas de alta producción con eficiencia y calidad."),
            ],
          ),
          'image': isSmart ? "img/BLogo.webp" : "img/smartbag/cojin/end.webp",
        },
      };
    }

    final String tipo =
        widget.name.toLowerCase().contains('stand')
            ? 'standpack'
            : widget.name.toLowerCase().contains('piram')
            ? 'piramidal'
            : 'cojín';

    final datos = getLoDudasData(widget.name)[tipo]!;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: r.wp(6)),
        child: Column(
          children: [
            Container(
              width: 1200,
              padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: 50),
              decoration: BoxDecoration(
                image: !isMobile ? DecorationImage(image: AssetImage(datos['image']), alignment: Alignment.bottomRight) : null,
                color: Colors.black,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child:
                    isMobile
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: r.wp(6), right: r.wp(6), top: 50),
                              child: Text(
                                "Lo dudas?",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500, fontSize: r.fs(1.9, 22)),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                              child: Text(
                                "Es la ${widget.name} que esperabas!",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: r.fs(3, 32)),
                              ),
                            ),
                            SizedBox(height: 20),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                              child: Text.rich(
                                datos['text'],
                                style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: r.fs(1.4, 18)),
                              ),
                            ),
                            SizedBox(height: 20),

                            _button(context, isMobile),
                            Image.asset(datos['image']),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lo dudas?",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade500, fontSize: r.fs(1.2, 26)),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Es la ${widget.name} que esperabas!",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: r.fs(2, 32)),
                                  ),
                                  SizedBox(height: 20),
                                  Text.rich(
                                    datos['text'],
                                    style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: r.fs(1, 18)),
                                  ),
                                  SizedBox(height: 20),

                                  _button(context, isMobile),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox(height: 500)),
                          ],
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _button(BuildContext context, bool isMobile) => Padding(
    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 0, vertical: 8),
    child: ElevatedButton(
      onPressed: () {
        navigateWithSlide(context, route);
      },
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color), foregroundColor: WidgetStatePropertyAll(Colors.white)),
      child: Text("Cotizar"),
    ),
  );
}

//Sliver nos importa
class SliverWithCareUs extends StatelessWidget {
  const SliverWithCareUs({super.key, required this.screenWidth, required this.widget});

  final Plantilla widget;
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
                Text(
                  "Te importa. Nos importa.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44), fontSize: min(screenWidth * 0.06, 70)),
                ),

                SizedBox(height: screenWidth >= 1000 ? 50 : 100),
                Text(
                  textAlign: TextAlign.center,
                  "Desde empaques como ${widget.name} Ecobag®, diseñados para proteger tu producto y destacar tu marca, hasta soluciones como Ecobag®, que combinan funcionalidad con conciencia ambiental. Usamos materiales reciclables, desarrollamos opciones versátiles como válvulas y cierres herméticos, y te ofrecemos formatos pensados para cada necesidad, siempre con una visión sustentable. Porque cada detalle cuenta cuando quieres hacer las cosas bien.",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, fontSize: min(screenWidth * 0.026, 25), height: 0),
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
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: min(screenw * 0.03, 24)),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: min(screenw * 0.025, 22), color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
