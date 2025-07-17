import 'dart:ui' as ui;
import 'dart:ui_web';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:webpack/main.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 850;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              //Video de inicio
              SliverStart(screenWidth: screenWidth, screenHeight: screenHeight),
              //Empaques con conciencia
              SliverEmpaquesConConciencia(),
              //El futuro esta en un empaque
              SliverElFuturo(screenWidth: screenWidth),
              //Porque packvision
              SliverPorquePackvision(screenWidth: screenWidth),
              //Video/Foto SmartBag y Ecobag
              SliverSmartAndEco(screenWidth: screenWidth, isMobile: isMobile),
              //Productos
              SliverProducts(screenWidth: screenWidth),
              //Servicios
              SliverCarrouselServices(),
              //Sedes
              SliverHeadquarters(),
              SliverToBoxAdapter(child: Footer()),
            ],
          ),
          //Header
          Header(),
        ],
      ),
    );
  }
}

//Inicio con video
class SliverStart extends StatefulWidget {
  const SliverStart({super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  @override
  State<SliverStart> createState() => _SliverStartState();
}

class _SliverStartState extends State<SliverStart> {
  bool _videoEnded = false;

  @override
  void initState() {
    super.initState();

    // Opción 1 (esperar duración estimada)
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _videoEnded = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: widget.screenWidth,
        height: widget.screenHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // video
            ValueListenableBuilder<bool>(
              valueListenable: videoBlurNotifier,
              builder: (context, isBlur, _) {
                return VideoFlutter(
                  src: 'assets/assets/videos/paint.webm',
                  blur: isBlur,
                  loop: false,
                  onEnded: () => setState(() => _videoEnded = true),
                );
              },
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: _videoEnded ? 1.0 : 0.0,
              child: Container(
                color: Colors.white60,
                alignment: Alignment.center,
                child: Image.asset('assets/img/home/packvision.webp', width: widget.screenWidth * 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Clase para las cards "Empaques con conciencia"
class CardPackWithConscience {
  final String title;
  final String description;
  final String image;

  CardPackWithConscience({required this.title, required this.description, required this.image});
}

//Lista de empaques con conciencia
final List<CardPackWithConscience> cardPWC = [
  CardPackWithConscience(
    title: "Asesoría",
    description:
        "Ofrecemos asesoría personalizada y especializada para cada etapa de tu proyecto. Nuestro equipo de expertos te acompaña desde la conceptualización hasta la implementación, brindándote soluciones a medida, soporte constante y recomendaciones estratégicas para que tomes las mejores decisiones y logres tus objetivos con éxito.",
    image: "assets/img/home/asesoria.webp",
  ),
  CardPackWithConscience(
    title: "Calidad",
    description:
        "Nos comprometemos con los más altos estándares de calidad en cada detalle de nuestros productos y servicios. Cada proceso es cuidadosamente supervisado y controlado para garantizar resultados consistentes, duraderos y a la altura de tus expectativas, porque sabemos que la excelencia marca la diferencia.",
    image: "assets/img/home/calidad.webp",
  ),
  CardPackWithConscience(
    title: "Cumplimiento",
    description:
        "Sabemos lo importante que es el tiempo para ti y tu negocio, por eso garantizamos cumplimiento puntual en cada entrega. Nuestro compromiso es brindarte confianza y seguridad a través de una planificación eficiente, tiempos claros y un seguimiento riguroso que asegure el respeto por los plazos acordados.",
    image: "assets/img/home/cumplimiento.webp",
  ),
  CardPackWithConscience(
    title: "Servicios",
    description:
        "Contamos con un portafolio de servicios integrales diseñados para impulsar tu negocio. Desde consultoría técnica y desarrollo de soluciones hasta soporte postventa, trabajamos contigo para ofrecerte un acompañamiento completo, adaptado a tus necesidades y enfocado en el crecimiento sostenible de tus proyectos.",
    image: "assets/img/home/servicios.webp",
  ),
];

//Seccion "Empaques con conciencia"
class SliverEmpaquesConConciencia extends StatefulWidget {
  const SliverEmpaquesConConciencia({super.key});

  @override
  State<SliverEmpaquesConConciencia> createState() => _SliverEmpaquesConConcienciaState();
}

class _SliverEmpaquesConConcienciaState extends State<SliverEmpaquesConConciencia> with TickerProviderStateMixin {
  int? _expandedIndex;
  late AnimationController _textAnimationController;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _textFadeAnimation = CurvedAnimation(parent: _textAnimationController, curve: Curves.easeInOut);
    _textSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(_textFadeAnimation);
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    return SliverToBoxAdapter(
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: 150),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).colorScheme.tertiary, Theme.of(context).primaryColor],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: ScrollAnimatedWrapper(
                visibilityKey: const Key('empaques_con_conciencia_title'),
                child: Text(
                  "Empaques con conciencia.",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.05).clamp(25, 45)),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              visibilityKey: const Key('empaques_con_conciencia_cards'),
              child: isMobile ? _buildMobileCards(screenWidth) : _buildDesktopCards(screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileCards(double screenWidth) {
    return Column(
      children: List.generate(cardPWC.length, (index) {
        final card = cardPWC[index];
        final isExpanded = _expandedIndex == index;
        return GestureDetector(
          onTap: () {
            if (isExpanded) {
              _textAnimationController.reverse().then((_) {
                if (mounted) setState(() => _expandedIndex = null);
              });
            } else {
              setState(() {
                _expandedIndex = index;
                _textAnimationController.forward(from: 0);
              });
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: double.infinity,
            height: isExpanded ? screenWidth * 0.95 : screenWidth * 0.6,
            margin: const EdgeInsets.only(bottom: 12),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(child: Image.asset(card.image, fit: BoxFit.cover)),
                Positioned(
                  top: 16,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(230),
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    child: Text(card.title, style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),

                if (isExpanded)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.12, 0.3],
                            colors: [Color.fromARGB(0, 255, 255, 255), Colors.white70, Colors.white],
                          ),
                        ),
                        child: SlideTransition(
                          position: _textSlideAnimation,
                          child: Text(
                            card.description,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _AnimatedExpandCollapseIcon(
                    isExpanded: isExpanded,
                    iconSize: 30,
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _textAnimationController.reverse().then((_) {
                            if (mounted) setState(() => _expandedIndex = null);
                          });
                        } else {
                          _expandedIndex = index;
                          _textAnimationController.forward(from: 0);
                        }
                      });
                    },
                    primaryColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDesktopCards(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.05),
      child: SizedBox(
        height: screenWidth * 0.3,
        child: Stack(
          children: List.generate(cardPWC.length, (index) {
            final card = cardPWC[index];
            final isExpanded = _expandedIndex == index;
            double leftPosition =
                _expandedIndex == null
                    ? index * (screenWidth * 0.21 + screenWidth * 0.012)
                    : isExpanded
                    ? 0
                    : screenWidth * 0.5 + screenWidth * 0.02 + (index - 1) * 20.0;

            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: leftPosition,
              child: AnimatedPositionedCard(
                index: index,
                isAnotherExpanded: _expandedIndex != null && _expandedIndex != index,
                isExpanded: isExpanded,
                screenWidth: screenWidth,
                card: card,
                onExpand: () {
                  setState(() {
                    _expandedIndex = index;
                    _textAnimationController.forward(from: 0);
                  });
                },
                onCollapse: () {
                  setState(() {
                    _textAnimationController.reverse();
                    _expandedIndex = null;
                  });
                },
                textFadeAnimation: _textFadeAnimation,
                textSlideAnimation: _textSlideAnimation,
              ),
            );
          }),
        ),
      ),
    );
  }
}

//Seccion del futuro esta en un empaque
class SliverElFuturo extends StatelessWidget {
  const SliverElFuturo({super.key, required this.screenWidth});
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 80),
        child: SizedBox(
          width: 1120,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScrollAnimatedWrapper(
                  visibilityKey: Key('futuro_empaque'),
                  child: Image.asset('assets/img/home/home1.webp', width: (screenWidth * 0.5).clamp(0, 1120)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),

                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key('futuro_empaque_text'),
                    child: Text(
                      "El futuro está en el empaque.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: (screenWidth * 0.05).clamp(25, 50),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key('futuro_empaque_description'),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Convierte tu producto en una experiencia inolvidable. Con Packvision, llevas tu marca al siguiente nivel con empaques que combinan innovación, sostenibilidad y diseño de alto impacto. Elige SmartBag si buscas elegancia, funcionalidad y presencia premium en el punto de venta. Opta por EcoBag si tu marca apuesta por lo ecológico, con materiales sostenibles y una menor huella ambiental.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.02).clamp(16, 28), height: 1, color: Colors.black45),
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

//Animacion y posicionamiento de las cards
class AnimatedPositionedCard extends StatelessWidget {
  final int index;
  final bool isExpanded;
  final bool isAnotherExpanded;
  final double screenWidth;
  final CardPackWithConscience card;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;
  final Animation<double> textFadeAnimation;
  final Animation<Offset> textSlideAnimation;

  const AnimatedPositionedCard({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.isAnotherExpanded,
    required this.screenWidth,
    required this.card,
    required this.onExpand,
    required this.onCollapse,
    required this.textFadeAnimation,
    required this.textSlideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final double width =
        isExpanded
            ? screenWidth * 0.5
            : isAnotherExpanded
            ? screenWidth * 0.32
            : screenWidth * 0.21;

    final double padding = screenWidth * 0.01;
    final double fontSizeTitle = screenWidth * 0.012;
    final double fontSizeDescription = screenWidth * 0.013;
    final double iconSize = screenWidth * 0.03;

    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      width: width,
      height: screenWidth * 0.3,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Reutilizable y estable
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(card.image, fit: BoxFit.cover, gaplessPlayback: true, filterQuality: FilterQuality.low),
          ),

          // Título fijo
          Positioned(
            top: 20,
            left: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: fontSizeTitle * 2.5,
                  width: fontSizeTitle * 8,
                  padding: EdgeInsets.only(left: padding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withAlpha(200),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(padding), bottomRight: Radius.circular(padding)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(card.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeTitle)),
                  ),
                ),
              ),
            ),
          ),

          // Descripción solo si está expandido
          if (isExpanded)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: textFadeAnimation,
                child: Container(
                  padding: EdgeInsets.only(top: screenWidth * 0.13),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.5, 0.7],
                      colors: [Color.fromARGB(0, 255, 255, 255), Colors.white54, Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: padding + 40, left: padding, top: screenWidth * 0.01, bottom: screenWidth * 0.01),
                    child: SlideTransition(
                      position: textSlideAnimation,
                      child: Text(
                        card.description,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: fontSizeDescription, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Botón de acción
          Positioned(
            bottom: padding,
            right: padding,
            child: _AnimatedExpandCollapseIcon(
              isExpanded: isExpanded,
              iconSize: iconSize,
              onTap: isExpanded ? onCollapse : onExpand,
              primaryColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

//Boton de expansión/colapso animado
class _AnimatedExpandCollapseIcon extends StatelessWidget {
  final bool isExpanded;
  final double iconSize;
  final VoidCallback onTap;
  final Color primaryColor;

  const _AnimatedExpandCollapseIcon({required this.isExpanded, required this.iconSize, required this.onTap, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey<bool>(isExpanded),
      tween: Tween<double>(begin: 0, end: isExpanded ? 0.785 : 0.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, angle, _) {
        return Transform.rotate(
          angle: angle,
          child: IconButton(
            iconSize: iconSize,
            onPressed: onTap,
            icon: Icon(CupertinoIcons.add_circled_solid, color: isExpanded ? primaryColor : Colors.white),
          ),
        );
      },
    );
  }
}

//Seccion porque packvision
class SliverPorquePackvision extends StatefulWidget {
  final double screenWidth;
  const SliverPorquePackvision({super.key, required this.screenWidth});

  @override
  State<SliverPorquePackvision> createState() => _SliverPorquePackvisionState();
}

class _SliverPorquePackvisionState extends State<SliverPorquePackvision> {
  final ScrollController _scrollController = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = true;

  final items = const [
    (
      icon: CupertinoIcons.car,
      title: "Empaque que trasciende",
      text: "Diseñamos experiencias, no solo empaques. Cada detalle potencia tu producto desde el primer contacto.",
    ),
    (
      icon: CupertinoIcons.cube_box,
      title: "Hecho para lo esencial",
      text: "Cuidamos lo que hace único a tu producto. Protección, aroma, sabor y forma garantizados.",
    ),
    (
      icon: CupertinoIcons.paperplane,
      title: "Pensado para el planeta",
      text: "EcoBag reduce el impacto ambiental con materiales compostables y estructuras sostenibles.",
    ),
    (
      icon: CupertinoIcons.star,
      title: "Diseño sin límites",
      text: "Texturas, formas y acabados que hablan por tu marca. Comunica calidad sin decir una palabra.",
    ),
    (
      icon: CupertinoIcons.arrow_2_circlepath,
      title: "Tecnología multicapa",
      text: "SmartBag ofrece hasta 5 capas de protección para frescura, resistencia y elegancia superior.",
    ),
    (
      icon: CupertinoIcons.arrowshape_turn_up_right_fill,
      title: "Listo para alta velocidad",
      text: "Flowpack: solución perfecta para líneas automáticas. Rápido, preciso y visualmente impactante.",
    ),
    (
      icon: CupertinoIcons.doc_on_doc,
      title: "Personalización total",
      text: "Desde válvulas y zipper hasta ventanas y tintas. Tu empaque refleja tu identidad.",
    ),
  ];

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
    final double paddingX = widget.screenWidth * 0.06;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimatedWrapper(
            visibilityKey: const Key('porque_packvision_title'),
            child: Padding(
              padding: EdgeInsets.only(left: paddingX, right: paddingX, top: 10, bottom: 80),
              child: Text(
                "¿Por qué Packvision?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: (widget.screenWidth * 0.05).clamp(25, 45),
                ),
              ),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: const Key('porque_packvision_list'),
            child: SizedBox(
              height: 400,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder:
                    (_, index) => _ItemPorque(
                      icon: items[index].icon,
                      title: items[index].title,
                      text: items[index].text,
                      screenWidth: widget.screenWidth,
                      isFirst: index == 0,
                      isLast: index == items.length - 1,
                    ),
              ),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: const Key('porque_packvision_arrows'),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingX, vertical: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ArrowButton(
                    enabled: canScrollLeft,
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 450,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  _ArrowButton(
                    enabled: canScrollRight,
                    icon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 450,
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
    );
  }
}

//Widget para cada item de "Porque Packvision"
class _ItemPorque extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final double screenWidth;
  final bool isFirst;
  final bool isLast;

  const _ItemPorque({
    required this.icon,
    required this.title,
    required this.text,
    required this.screenWidth,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = screenWidth.clamp(1000, 2000) * 0.28;
    final double cardHeight = cardWidth / 2.2;

    return Padding(
      padding: EdgeInsets.only(left: isFirst ? screenWidth * 0.06 : 0, right: isLast ? screenWidth * 0.06 : 20, bottom: 50),
      child: Container(
        width: cardWidth.clamp(260, 380),
        height: cardHeight.clamp(120, 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: (screenWidth * 0.032).clamp(0, 20)),
            ),
            const SizedBox(height: 8),
            Text(text, textAlign: TextAlign.justify, style: TextStyle(color: Colors.black87, fontSize: (screenWidth * 0.032).clamp(0, 20))),
          ],
        ),
      ),
    );
  }
}

//Flechas de navegación para el scroll horizontal de "Porque Packvision"
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

//Seccion SmartBag y Ecobag
class SliverSmartAndEco extends StatelessWidget {
  const SliverSmartAndEco({super.key, required this.screenWidth, required this.isMobile});

  final double screenWidth;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: (screenWidth * 0.05).clamp(40, 80)),
        child: ScrollAnimatedWrapper(visibilityKey: const Key('smart_and_eco'), child: isMobile ? _mobile() : _desktop()),
      ),
    );
  }

  Widget _desktop() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: width * 0.3,
          width: width,
          child: Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: videoBlurNotifier,
                  builder: (context, isBlur, _) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
                      child: VideoFlutter(
                        src: 'assets/assets/videos/smartbag/smart1.webm',
                        blur: isBlur,
                        loop: true,
                        showControls: false,
                        //isPause: false,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: videoBlurNotifier,
                  builder: (context, isBlur, _) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
                      child: VideoFlutter(
                        src: 'assets/assets/videos/ecobag/eco1.webm',
                        blur: isBlur,
                        loop: true,
                        showControls: false,
                        //isPause: false,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mobile() {
    return SizedBox(
      height: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset('assets/img/home/smart.webp', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 3.5),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Image.asset('assets/img/home/eco.webp', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

//Seccion de productos Smartbbag y Ecobag
class SliverProducts extends StatelessWidget {
  const SliverProducts({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final cards = [
      {'title': '4PRO', 'subtitle': 'Variedad de colores.', 'image': 'assets/img/ecobag/4pro.webp', 'isEcobag': true},
      {'title': '5PRO', 'subtitle': 'Evolución para tí.', 'image': 'assets/img/smartbag/5pro.webp', 'isEcobag': false},
      {'title': 'Flowpack', 'subtitle': 'Alto estilo, alta presencia.', 'image': 'assets/img/ecobag/flowpack.webp', 'isEcobag': true},
      {'title': 'Cojín', 'subtitle': 'Compacto y perfecto.', 'image': 'assets/img/smartbag/cojin.webp', 'isEcobag': false},
      {'title': 'DoyPack', 'subtitle': 'No hay mejor selle que este.', 'image': 'assets/img/ecobag/doypack.webp', 'isEcobag': true},
      {'title': 'Accesorios', 'subtitle': 'Válvulas y peel.', 'image': 'assets/img/smartbag/valvula.webp', 'isEcobag': false},
    ];

    final crossAxisCount = screenWidth > 800 ? 2 : 1;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) => ProductCard(card: cards[index], screenWidth: screenWidth), childCount: cards.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: screenWidth > 800 ? 1.5 : 1,
        ),
      ),
    );
  }
}

//Producto de ecobag o smartbag
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> card;
  final double screenWidth;

  const ProductCard({required this.card, required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEcobag = card['isEcobag'] == true;
    final Color mainColor = isEcobag ? const Color(0xFF4B8D2C) : Theme.of(context).primaryColor;
    final String title = card['title'];
    final String subtitle = card['subtitle'];
    final String image = card['image'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                card['isEcobag'] == true ? const Color(0xD2FCFCFC) : const Color(0xD2FCFCFC),
                card['isEcobag'] == true ? const Color(0xFFDDF8D0).withAlpha(100) : const Color(0xFFD0E0F8).withAlpha(100),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Expanded(child: Image.asset(image, fit: BoxFit.cover)),
              Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: mainColor)),
              if (isEcobag) const Text("Materiales sostenibles", style: TextStyle(fontSize: 10, color: Color(0xFF4B8D2C))),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: (screenWidth * 0.025).clamp(0, 22), color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              _ActionButtons(card: card, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}

//Botones para las cards
class _ActionButtons extends StatelessWidget {
  final Map<String, dynamic> card;
  final double screenWidth;

  const _ActionButtons({required this.card, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = card['isEcobag'] == true ? const Color(0xFF4B8D2C) : Theme.of(context).primaryColor;
    final String title = card['title'];

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        children: [
          _PopupButton(label: 'Conocer', color: mainColor, routeBase: title, routeSuffix: ''),
          _PopupButton(label: "Crear mi $title", color: mainColor, routeBase: title, routeSuffix: '/crea-tu-empaque', outlined: true),
        ],
      ),
    );
  }
}

//Boton popup para las cards de productos
class _PopupButton extends StatefulWidget {
  final String label;
  final String routeBase;
  final String routeSuffix;
  final Color color;
  final bool outlined;

  const _PopupButton({required this.label, required this.routeBase, required this.routeSuffix, required this.color, this.outlined = false});

  @override
  State<_PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<_PopupButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: "",
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        String base;
        if (value == 'ecobag') {
          base = 'EcoBag';
        } else if (value == 'smartbag') {
          base = 'SmartBag';
        } else {
          return;
        }
        final route = '/$base/Explora-$base/${widget.routeBase}${widget.routeSuffix}';
        navigateWithSlide(context, route);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'ecobag',
              child: Row(
                children: const [
                  Icon(CupertinoIcons.tree, color: Color(0xFF4B8D2C)),
                  SizedBox(width: 10),
                  Text('Ecobag', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'smartbag',
              child: Row(
                children: [
                  Icon(CupertinoIcons.lightbulb, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 10),
                  const Text('Smartbag', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovering = true),
        onExit: (_) => setState(() => isHovering = false),
        cursor: SystemMouseCursors.click,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.outlined ? (isHovering ? widget.color : Colors.white) : widget.color,
            ),
            child: Text(
              widget.label,
              style: TextStyle(fontWeight: FontWeight.bold, color: widget.outlined ? (isHovering ? Colors.white : Colors.black) : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//Seccion de servicios
class SliverCarrouselServices extends StatefulWidget {
  const SliverCarrouselServices({super.key});

  @override
  State<SliverCarrouselServices> createState() => _SliverCarrouselServicesState();
}

class _SliverCarrouselServicesState extends State<SliverCarrouselServices> with TickerProviderStateMixin {
  int _currentIndexServices = 0;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<String> imageUrls = List.generate(4, (_) => 'assets/img/home/cumplimiento.webp');
  final List<String> titles = ['Publicidad', 'Fotografía', 'Diseño', 'Modelado 3D'];
  final List<String> texts = [
    'Campañas visuales que conectan con tu audiencia',
    'Capturamos la esencia de tu marca en cada imagen',
    'Creatividad que comunica y deja huella',
    'Visualizaciones realistas para productos impactantes',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= 1000;

    return SliverToBoxAdapter(
      child: ScrollAnimatedWrapper(
        visibilityKey: const Key('services_carousel'),
        child: CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: imageUrls.length,
          options: CarouselOptions(
            height: 600,
            viewportFraction: 0.8,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: false,
            autoPlayCurve: Curves.easeInOut,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() => _currentIndexServices = index);
              _controller
                ..reset()
                ..forward();
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final bool isCenter = index == _currentIndexServices;
            return _ServiceSlideItem(
              imageUrl: imageUrls[index],
              title: titles[index],
              text: texts[index],
              isCenter: isCenter,
              isWide: isWide,
              fadeAnimation: _fadeAnimation,
              slideAnimation: _slideAnimation,
              onTap: () => _carouselController.animateToPage(index),
              screenWidth: screenWidth,
            );
          },
        ),
      ),
    );
  }
}

//Item de la seccion de servicios
class _ServiceSlideItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String text;
  final bool isCenter;
  final bool isWide;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onTap;
  final double screenWidth;

  const _ServiceSlideItem({
    required this.imageUrl,
    required this.title,
    required this.text,
    required this.isCenter,
    required this.isWide,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onTap,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedOpacity(
                opacity: isCenter ? 1.0 : 0.3,
                duration: const Duration(milliseconds: 500),
                child: Image.asset(imageUrl, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 200,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black54, Colors.transparent]),
                  ),
                ),
              ),
              if (isCenter)
                AnimatedBuilder(
                  animation: fadeAnimation,
                  builder:
                      (context, _) => Positioned(
                        bottom: isWide ? 30 : 40,
                        left: isWide ? 30 : 20,
                        right: 20,
                        child: AnimatedOpacity(
                          opacity: fadeAnimation.value,
                          duration: const Duration(milliseconds: 400),
                          child: Transform.translate(
                            offset: slideAnimation.value * 50,
                            child:
                                isWide
                                    ? Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Theme.of(context).primaryColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Text(
                                              title,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.03).clamp(0, 25)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            text,
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: (screenWidth * 0.025).clamp(0, 20),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    : Column(
                                      children: [
                                        Text(
                                          text,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: (screenWidth * 0.03).clamp(0, 25),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Theme.of(context).primaryColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Text(
                                              title,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.025).clamp(0, 20)),
                                            ),
                                          ),
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
    );
  }
}

//Clase para las tarjetas de las sedes
class HeardquartersCards {
  final String img;
  final String name;
  final double latitude;
  final double longitude;
  final String map;

  HeardquartersCards({required this.img, required this.name, required this.latitude, required this.longitude, required this.map});
}

//Lista de tarjetas de las sedes
final List<HeardquartersCards> cardHQ = [
  HeardquartersCards(
    img: "assets/img/home/carvajal.webp",
    name: "Carvajal - Bogotá D.C",
    latitude: 4.60971,
    longitude: -74.08175,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
  HeardquartersCards(
    img: "assets/img/home/norte.webp",
    name: "Nogal - Bogotá D.C",
    latitude: 4.6610239150862025,
    longitude: -74.05414093434182,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
  HeardquartersCards(
    img: "assets/img/home/mosquera.webp",
    name: "Mosquera - Cundinamarca",
    latitude: 4.695486,
    longitude: -74.190506,
    map:
        "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1988.4503945679396!2d-74.1391054034424!3d4.611774599445512!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f776877ed45bf%3A0x126f76b8116c49e3!2sPACKVISI%C3%93N%20SAS%20SEDE%20CARVAJAL!5e0!3m2!1ses!2sco!4v1744147530535!5m2!1ses!2sco",
  ),
];

class SliverHeadquarters extends StatelessWidget {
  const SliverHeadquarters({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 50),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return ScrollAnimatedWrapper(
              visibilityKey: const Key('headquarter_title'),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text("Sedes.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.06).clamp(0, 55))),
              ),
            );
          }

          final sede = cardHQ[index - 1];
          return ScrollAnimatedWrapper(
            visibilityKey: Key('headquarter_card_${sede.name}'),
            child: _HeadquarterCard(sede: sede, screenWidth: screenWidth),
          );
        }, childCount: cardHQ.length + 1),
      ),
    );
  }
}

class _HeadquarterCard extends StatelessWidget {
  final HeardquartersCards sede;
  final double screenWidth;

  _HeadquarterCard({required this.sede, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final isMobileLayout = screenWidth <= 1000;
    final primary = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            _showHeadquarterDialog(context, sede);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 120),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
            ),
            child:
                isMobileLayout
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 180, child: Image.asset(sede.img)),
                        const SizedBox(height: 24),
                        Text("${sede.name}.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.03).clamp(0, 30))),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Encuéntranos", style: TextStyle(color: primary, fontSize: (screenWidth * 0.020).clamp(0, 20))),
                            const SizedBox(width: 5),
                            Icon(CupertinoIcons.location, color: primary, size: (screenWidth * 0.020).clamp(0, 20)),
                          ],
                        ),
                      ],
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sede ${sede.name}.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.03).clamp(0, 30))),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Encuéntranos", style: TextStyle(color: primary, fontSize: (screenWidth * 0.020).clamp(0, 20))),
                                const SizedBox(width: 5),
                                Icon(CupertinoIcons.placemark, color: primary, size: (screenWidth * 0.020).clamp(0, 20)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 120, child: Image.asset(sede.img)),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  void _showHeadquarterDialog(BuildContext context, HeardquartersCards headquarter) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double dialogWidth = screenWidth.clamp(350.0, 700.0);
    final double dialogHeight = screenHeight * 0.85;

    final String viewId = 'iframe-${headquarter.name.toLowerCase().replaceAll(' ', '-')}';

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: dialogWidth,
                  constraints: BoxConstraints(maxHeight: dialogHeight),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(180),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 10)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 30), // Para simetría
                          Text(
                            "Sede ${headquarter.name}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(CupertinoIcons.xmark_circle_fill),
                            color: Theme.of(context).primaryColor,
                            iconSize: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: buildHeadquarterIframe(viewId, headquarter.map))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final Set<String> _registeredViewTypes = {};

  Widget buildHeadquarterIframe(String viewId, String url) {
    if (!_registeredViewTypes.contains(viewId)) {
      platformViewRegistry.registerViewFactory(viewId, (int _) {
        final iframe =
            web.HTMLIFrameElement()
              ..src = url
              ..style.border = 'none'
              ..style.width = '100%'
              ..style.height = '100%'
              ..allowFullscreen = true;

        return iframe;
      });
      _registeredViewTypes.add(viewId);
    }

    return HtmlElementView(viewType: viewId);
  }
}
