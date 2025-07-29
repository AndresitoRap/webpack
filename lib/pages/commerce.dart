import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/pages/ecobag/doypack.dart';
import 'package:webpack/pages/ecobag/fivepro.dart';
import 'package:webpack/pages/ecobag/flowpack.dart';
import 'package:webpack/pages/ecobag/fourpro.dart';
import 'package:webpack/pages/smartbag/flowpack.dart';
import 'package:webpack/pages/smartbag/doypack.dart';
import 'package:webpack/pages/smartbag/fivepro.dart';
import 'package:webpack/pages/smartbag/fourpro.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/video.dart';

class Commerce extends StatefulWidget {
  final String section;
  final Subcategorie selectedSubcategorie;
  const Commerce({super.key, required this.section, required this.selectedSubcategorie});

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
    final screenWidth = MediaQuery.of(context).size.width;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    final section = widget.section.toLowerCase();
    final categoryName = widget.selectedSubcategorie.category.name.toLowerCase();
    Widget content;

    if (categoryName == 'smartbag') {
      switch (section) {
        case '4pro':
          content = FourPro(screenWidth: screenWidth, currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);
          break;

        case '5pro':
          content = FivePro(currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);
          break;

        case 'doypack':
          content = DoypackSmart();
          break;

        case 'flowpack':
          content = Flowpack();
          break;

        case 'cojin':
          content = Plantilla(img: "assets/img/smartbag/cojin.webp", name: "Cojín");
          break;

        case 'piramidal':
          content = Plantilla(img: "assets/img/smartbag/piramide.webp", name: "Piramidal");
          break;

        case 'standpack':
          content = Plantilla(img: "assets/img/smartbag/standpack.webp", name: "StandPack");
          break;

        default:
          content = const Center(child: Text('En construcción'));
          break;
      }
    } else {
      switch (section) {
        case '4pro':
          content = FourProEco(
            screenWidth: screenWidth,
            currentRoute: currentRoute,
            subcategorie: widget.selectedSubcategorie,
            section: widget.section,
          );
          break;

        case '5pro':
          content = FiveProEco();
          break;

        case 'doypack':
          content = DoypackEco();
          break;

        case 'flowpack':
          content = FlowpackEco();
          break;

        case 'cojin':
          content = Plantilla(img: "assets/img/ecobag/cojin.webp", name: "Cojín");
          break;

        case 'piramidal':
          content = Plantilla(img: "assets/img/ecobag/Piramidal.webp", name: "Piramidal");
          break;

        default:
          content = const Center(child: Text('En construcción'));
      }
    }

    return Scaffold(body: Stack(children: [content, Header()]));
  }
}

class Plantilla extends StatefulWidget {
  final String img;
  final String name;
  const Plantilla({super.key, required this.img, required this.name});

  @override
  State<Plantilla> createState() => _PlantillaState();
}

class _PlantillaState extends State<Plantilla> with TickerProviderStateMixin {
  //controlador scroll
  double scrollProgress = 0.0;

  final ScrollController _scrollController = ScrollController();

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  //text
  late Animation<double> _textScaleAnimation;

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

    _controller.forward().whenComplete(() {
      setState(() {});
    });

    //Scroll
    _scrollController.addListener(() {
      final offset = _scrollController.offset.clamp(0, 200); // puedes ajustar el rango
      final progress = offset / 200;
      setState(() {
        scrollProgress = progress;
      });
    });

    _controller.forward().whenComplete(() {
      setState(() {});
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
    final screenHeight = MediaQuery.of(context).size.height;
    final color =
        (ModalRoute.of(context)?.settings.name?.toLowerCase() ?? "").contains('ecobag')
            ? Color.fromARGB(255, 75, 141, 44)
            : Theme.of(context).primaryColor;
    final isMobile = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xff1d1d1f),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Imagen con opacidad sincronizada con la explosión
                  // Texto "Bolsa" que aparece y se achica
                  Positioned(
                    top: 200,
                    child: AnimatedBuilder(
                      animation: _textScaleAnimation,
                      builder: (_, __) {
                        return Transform.scale(
                          scale: _textScaleAnimation.value,
                          child: Opacity(
                            opacity: 1.0 - _opacityAnimation.value,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: (screenWidth * 0.2).clamp(20, 80),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, -2), // sombra arriba blanca
                                        color: Colors.white.withOpacity(0.5),
                                        blurRadius: 6,
                                      ),
                                      Shadow(
                                        offset: Offset(0, 2), // sombra abajo con color
                                        color: color,
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                Text("Bajo pedido", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    child: AnimatedBuilder(
                      animation: _opacityAnimation,
                      builder: (_, __) {
                        return Opacity(
                          opacity: 1.0 - _opacityAnimation.value,
                          child: Image.asset(widget.img, width: (screenWidth * 0.8).clamp(900, 1200)),
                        );
                      },
                    ),
                  ),

                  // Efecto de explosión central
                  Positioned(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, __) {
                        return Opacity(
                          opacity: _opacityAnimation.value,
                          child: Center(
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
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1500),
                      opacity: 1.0 - _opacityAnimation.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),

                        child: Container(
                          width: (screenWidth).clamp(400, 1100),
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: screenWidth * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Diseños que destacan.",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: (screenWidth * 0.1).clamp(22, 40)),
                              ),
                              SizedBox(height: 50),
                              Text.rich(
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white.withAlpha(200), fontSize: (screenWidth * 0.03).clamp(16, 26)),
                                TextSpan(children: _buildDescripcion(widget.name, color)),
                              ),

                              Text(
                                textAlign: TextAlign.center,
                                "   ",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: (screenWidth * 0.06).clamp(20, 50)),
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
          SliverInfoPlantilla(screenWidth: screenWidth, isMobile: isMobile, color: color),
          SliverWithOtherThingPlantilla(
            widget: widget,
            screenWidth: screenWidth,
            isMobile: isMobile,
            color: color,
            scrollProgress: scrollProgress, // <- AQUÍ SÍ PASA EL VALOR
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildDescripcion(String bolsa, Color color) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final tipo = isEco ? "EcoBag" : "SmartBag";

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

//Sliver con información
class SliverInfoPlantilla extends StatefulWidget {
  const SliverInfoPlantilla({super.key, required this.screenWidth, required this.isMobile, required this.color});
  final Color color;
  final double screenWidth;
  final bool isMobile;

  @override
  State<SliverInfoPlantilla> createState() => _SliverInfoPlantillaState();
}

class _SliverInfoPlantillaState extends State<SliverInfoPlantilla> {
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
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'EcoBag® Cojín 1...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'EcoBag® Cojín 2...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'EcoBag® Cojín 3...'},
        ],
        'smart': [
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® Cojín 1...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® Cojín 2...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® Cojín 3...'},
        ],
      },
      'piramidal': {
        'eco': [
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'EcoBag® Piramidal 1...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'EcoBag® Piramidal 2...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'EcoBag® Piramidal 3...'},
        ],
        'smart': [
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® Piramidal 1...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® Piramidal 2...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® Piramidal 3...'},
        ],
      },
      'standpack': {
        'smart': [
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® StandPack 1...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® StandPack 2...'},
          {'image': 'assets/img/smartbag/discover1.webp', 'text': 'SmartBag® StandPack 3...'},
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
              padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.06, vertical: 10),
              child: Text(
                "Exclusividad de ${tipoBolsa.toUpperCase()}.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (widget.screenWidth * 0.09).clamp(30, 50), color: widget.color),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(tarjetasMostrar.length, (index) {
                  final tarjeta = tarjetasMostrar[index];
                  return buildCard(
                    screenWidth: widget.screenWidth,
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
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required double screenWidth,
    required bool isMobile,
    required String image,
    required String text,
    required bool isFirst,
    required bool isLast,
  }) {
    final double horizontalPadding = screenWidth * 0.06;
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? horizontalPadding : 0, right: isLast ? horizontalPadding : 20),
      child: Container(
        width: isMobile ? 400 : (screenWidth * 0.6).clamp(650, 1200),
        height: isMobile ? 500 : (screenWidth * 0.1).clamp(500, 900),
        padding: const EdgeInsets.only(top: 22, left: 22),
        margin: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(26), image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.02, top: screenWidth * 0.01),
            child: Text(
              text,
              style: TextStyle(height: 1.2, color: Colors.white, fontSize: (screenWidth * 0.04).clamp(16, 24), fontWeight: FontWeight.bold),
            ),
          ),
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
      icon: Icon(icon, color: enabled ? Colors.white : Colors.white.withAlpha(150)),
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(enabled ? Color(0xff393839) : Color(0xff393839).withAlpha(180))),
    );
  }
}

//Sliver con mas información
class SliverWithOtherThingPlantilla extends StatefulWidget {
  const SliverWithOtherThingPlantilla({
    super.key,
    required this.widget,
    required this.screenWidth,
    required this.isMobile,
    required this.color,
    required this.scrollProgress,
  });

  final Plantilla widget;
  final Color color;
  final double screenWidth;
  final bool isMobile;
  final double scrollProgress;

  @override
  State<SliverWithOtherThingPlantilla> createState() => _SliverWithOtherThingPlantillaState();
}

class _SliverWithOtherThingPlantillaState extends State<SliverWithOtherThingPlantilla> {
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

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Text(
              "Unete a la familia.",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.15).clamp(30, 60)),
            ),
            Text(
              "Sé ${widget.widget.name}.",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.15).clamp(30, 60)),
            ),
            SizedBox(height: widget.isMobile ? 100 : 60),
            SizedBox(
              width: screenWidth.clamp(500, 1200),
              child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withAlpha(200), fontSize: (screenWidth * 0.03).clamp(16, 26)),
                TextSpan(children: buildDescripcion(widget.widget.name, widget.color)),
              ),
            ),
            //Container que se reduce un poquito al hacer scroll
            Center(
              child: VisibilityDetector(
                key: Key('video-section'),
                onVisibilityChanged: (info) {
                  double visibleFraction = info.visibleFraction;

                  // Si ya está visible al 40% o más, activamos
                  if (visibleFraction > 0.4 && !showAnimation.value) {
                    showAnimation.value = true;
                  }
                },
                child: Builder(
                  builder: (context) {
                    final borderRadius = BorderRadius.circular(30 * widget.scrollProgress);
                    final horizontalPadding = screenWidth * 0.055 * widget.scrollProgress;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
                      child: ClipRRect(
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
                                  return VideoFlutter(
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
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> buildDescripcion(String bolsa, Color color) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final isEco = route.contains("ecobag");
    final tipo = isEco ? "EcoBag" : "SmartBag";

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
}
