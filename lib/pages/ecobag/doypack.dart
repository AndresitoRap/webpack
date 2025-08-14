import 'dart:ui' as ui show ImageFilter;
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/4pro/widgetsfourpro.dart';
import 'package:webpack/widgets/doypack/collage.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';
import 'package:webpack/widgets/video.dart';

class DoypackEco extends StatelessWidget {
  final Responsive r;
  final Subcategorie subcategorie;
  const DoypackEco({super.key, required this.r, required this.subcategorie});

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF4B8D2C);
    final route = '${subcategorie.route}/crea-tu-empaque';
    final isMobile = r.wp(100) < 850;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 255, 252),

      body: CustomScrollView(
        slivers: [
          StartDoypackSliver(r: r, green: green, isMobile: isMobile, route: route),
          SustainableSliver(r: r, green: green, route: route),
          SliverWithCollage(isMobile: isMobile, green: green, r: r),
          WeCareUsSliver(r: r, isMobile: isMobile, green: green),
          SliverFinallyDoypackEco(r: r, green: green, route: route),
          SliverToBoxAdapter(child: const Footer()),
        ],
      ),
    );
  }
}

//---------Inicio de Doypack------------
class StartDoypackSliver extends StatelessWidget {
  const StartDoypackSliver({super.key, required this.r, required this.green, required this.isMobile, required this.route});
  final Responsive r;
  final Color green;
  final bool isMobile;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: r.hp(100),
        width: r.wp(100),

        child: Stack(
          fit: StackFit.expand,
          children: [
            isMobile
                ? Image.asset("img/BLogo.webp")
                : ValueListenableBuilder<bool>(
                  valueListenable: videoBlurNotifier,
                  builder: (context, isBlur, _) {
                    return VideoFlutter(
                      src: 'assets/videos/ecobag/4pro/videoBolsas.webm',
                      loop: true,
                      isPause: false,
                      fit: BoxFit.cover,
                      blur: isBlur,
                    );
                  },
                ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 45, horizontal: r.wp(6)),
              child: SizedBox(
                height: r.hp(100) - 50,
                width: r.wp(100),
                child: ScrollAnimatedWrapper(
                  child:
                      isMobile
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Doypack Ecobag®", style: TextStyle(color: green, fontSize: r.fs(2, 30))),
                              Text("Diseño que respira.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(4, 50), height: 0.95)),

                              SizedBox(height: 10),
                              button(context, route),
                            ],
                          )
                          : Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Doypack Ecobag®", style: TextStyle(color: green, fontSize: r.fs(2, 30))),
                                    Text("Diseño que respira.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(4, 50), height: 0.95)),
                                  ],
                                ),
                                button(context, route),
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

  Padding button(BuildContext context, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(26), color: green.withAlpha(170)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Crear mi", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: r.fs(1.8, 18))),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white), foregroundColor: WidgetStatePropertyAll(green)),
                  onPressed: () {
                    navigateWithSlide(context, route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Doypack", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(1.8, 18))),
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

//---------Sustentabilidad de Doypack------------
class SustainableSliver extends StatelessWidget {
  const SustainableSliver({super.key, required this.r, required this.green, required this.route});

  final Responsive r;
  final Color green;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: r.hp(6, max: 100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6), vertical: 30),
                child: Container(
                  width: r.wp(100, max: 700),
                  height: r.wp(100, max: 700),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(image: AssetImage("img/BIsotipo.webp")),
                  ),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset("img/ecobag/doypack/o_with_flowers.webp", fit: BoxFit.cover, color: green, colorBlendMode: BlendMode.srcIn),
                  ),
                  Text("DOYPACK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(4, 60), color: green, letterSpacing: 2.4)),
                ],
              ),
            ),
            ScrollAnimatedWrapper(
              child: Text("EcoBag®", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(2, 24), color: green, letterSpacing: 2.4)),
            ),
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: r.wp(6)),
                child: Text(
                  textAlign: TextAlign.center,
                  "Sostenible por donde lo mires.",
                  style: TextStyle(fontSize: r.fs(4, 60), fontWeight: FontWeight.w700, color: Colors.black.withAlpha(220)),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                child: SizedBox(
                  width: 1000,
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Empaques Ecobag que inspiran. Estilo doypack en kraft natural o blanco. Con válvula y zipper para conservar mejor. Tecnología práctica, diseño consciente. Doypack Ecobag®: todo lo que necesitas, en un empaque con propósito.",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: r.fs(2.2, 30)),
                    ),
                  ),
                ),
              ),
            ),
            ScrollAnimatedWrapper(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(green), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    navigateWithSlide(context, route);
                  },
                  child: Text("Crear mi Doypack", style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(1.6, 26))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------Collage------------
class SliverWithCollage extends StatefulWidget {
  const SliverWithCollage({super.key, required this.isMobile, required this.green, required this.r});
  final Responsive r;
  final bool isMobile;
  final Color green;

  @override
  State<SliverWithCollage> createState() => _SliverWithCollageState();
}

class _SliverWithCollageState extends State<SliverWithCollage> {
  final List<int> layoutPattern = [1, 2, 2, 2, 1, 2, 1];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (widget.isMobile) {
            if (index >= containerscollage.length) return null;

            final data = containerscollage[index];
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ContainerCollage(
                    r: widget.r,
                    green: widget.green,
                    isMobile: widget.isMobile,
                    data: data.builder(context),
                    height: data.height ?? widget.r.hp(50),

                    color: data.color,
                    colorOpen: data.colorOpen,
                    title: data.title,
                    description: data.description,
                  ),
                ),
              ),
            );
          } else {
            // 📌 Patrón original
            final List<int> layoutPattern = [1, 2, 2, 2, 1, 2, 1];

            // 🔁 Expande el patrón hasta cubrir todos los items
            List<int> extendedPattern = [];
            int total = 0;
            int i = 0;
            while (total < containerscollage.length) {
              final count = layoutPattern[i % layoutPattern.length];
              extendedPattern.add(count);
              total += count;
              i++;
            }

            // 🧮 Calcular qué índice le toca a esta fila
            int itemIndex = 0;
            for (int j = 0; j < index; j++) {
              itemIndex += extendedPattern[j];
            }

            if (itemIndex >= containerscollage.length) return null;

            final itemsThisRow = extendedPattern[index];
            final rowItems = containerscollage.skip(itemIndex).take(itemsThisRow).toList();

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children:
                        rowItems.map((data) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RepaintBoundary(
                                child: ContainerCollage(
                                  r: widget.r,
                                  green: widget.green,
                                  isMobile: widget.isMobile,
                                  data: data.builder(context),
                                  height: data.height ?? widget.r.hp(70),
                                  color: data.color,
                                  colorOpen: data.colorOpen,
                                  title: data.title,
                                  description: data.description,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            );
          }
        },
        // ✅ el número de filas es el largo del patrón extendido
        childCount:
            widget.isMobile
                ? containerscollage.length
                : () {
                  // recalcular cuántas filas hacen falta
                  final List<int> layoutPattern = [1, 2, 2, 2, 1, 2, 1];
                  int total = 0;
                  int rows = 0;
                  while (total < containerscollage.length) {
                    total += layoutPattern[rows % layoutPattern.length];
                    rows++;
                  }
                  return rows;
                }(),
      ),
    );
  }
}

// Animación de container
class ContainerCollage extends StatefulWidget {
  final Responsive r;
  final Color green, color, colorOpen;
  final bool isMobile;
  final Widget data;
  final double height;
  final String title, description;

  const ContainerCollage({
    super.key,
    required this.green,
    required this.isMobile,
    required this.data,
    required this.height,
    required this.color,
    required this.colorOpen,
    required this.title,
    required this.description,
    required this.r,
  });

  @override
  State<ContainerCollage> createState() => _ContainerCollageState();
}

class _ContainerCollageState extends State<ContainerCollage> with TickerProviderStateMixin {
  bool isOpen = false;
  bool showText = false;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.2), // desde arriba
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() async {
    if (!isOpen) {
      setState(() => isOpen = true);
      await Future.delayed(Duration(milliseconds: 500)); // retardo antes de mostrar
      setState(() => showText = true);
      _controller.forward();
    } else {
      await _controller.reverse();
      setState(() => showText = false);
      await Future.delayed(Duration(milliseconds: 200));
      setState(() => isOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: widget.height,
      decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          widget.data,
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: isOpen ? 1 : 0,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                color: widget.colorOpen,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: widget.r.fs(2, 24))),
                      SizedBox(height: 30),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Transform.translate(
                              offset: _slideAnimation.value * 100,
                              child: SizedBox(
                                width: widget.isMobile ? null : 500,
                                child: Text(widget.description, style: TextStyle(color: Colors.white, fontSize: widget.r.fs(1.9, 23))),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: toggle,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  decoration: BoxDecoration(color: isOpen ? Colors.white : widget.green, shape: BoxShape.circle),
                  child: AnimatedRotation(
                    turns: isOpen ? (45 / 360) : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutExpo,
                    child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.add_rounded, color: isOpen ? widget.green : Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Clase del contenedor
class ContainerCollageClass {
  final String title, description;
  final bool? isOpen;
  final Widget Function(BuildContext) builder;
  final Color color, colorOpen;
  final double? height;

  ContainerCollageClass({
    required this.title,
    required this.description,
    required this.color,
    required this.colorOpen,
    this.isOpen = false,
    required this.builder,
    this.height,
  });
}

//Lista de contenedores
final List<ContainerCollageClass> containerscollage = [
  ContainerCollageClass(
    title: "Con sistema de zipper hermético.",
    color: Color(0xffB7E4C7),
    colorOpen: Color(0xff2D6A4F),
    description:
        "El sistema de zipper resellable convierte al Doypack Ecobag de SPACKVISION en un empaque práctico y reutilizable. Perfecto para productos que se consumen en varias ocasiones, como snacks, cafés o suplementos. Sellado firme, apertura cómoda. Diseñado para conservar la frescura y reducir el desperdicio.",
    height: 600,
    builder: buildZipperHermetico,
  ),
  ContainerCollageClass(
    title: "Versión sin cierre, para menor costo y más simpleza.",
    color: Color(0xffDDE5B6),
    colorOpen: Color(0xff6B705C),
    description:
        "Si prefieres una presentación más simple o necesitas reducir costos, el modelo sin zipper es ideal. Mantiene la protección de siempre con su estructura laminada, y se adapta perfectamente a sellado térmico. Una solución versátil para productos de alta rotación o empaques secundarios.",

    builder: buildVersionCierre,
  ),
  ContainerCollageClass(
    title: "Kraft con ventana transparente.",
    color: Color(0xffF6E7D7),
    colorOpen: Color(0xffCBA17A),
    description:
        "El kraft natural con ventana transparente ofrece lo mejor de dos mundos: una imagen ecológica y la posibilidad de mostrar tu producto. Ideal para alimentos naturales, artesanales o gourmet. Una forma directa y honesta de conectar con tus clientes: lo que ves, es lo que obtienes.",

    builder: buildKraftVentanaTransp,
  ),
  ContainerCollageClass(
    title: "Natural por fuera. Sorpresa por dentro.",
    color: Color(0xffE8D8C3),
    colorOpen: Color(0xff8D6E63),
    description:
        "El kraft sin ventana proyecta una estética minimalista, orgánica y premium. Su textura natural transmite sostenibilidad, mientras protege completamente el contenido. Perfecto para marcas que apuestan por una identidad limpia, elegante y consciente del planeta.",

    builder: buildKraftSinVentana,
  ),
  ContainerCollageClass(
    title: "Estructura 146. Máxima barrera.",
    color: Color(0xffC7DDF2),
    colorOpen: Color(0xff3A5A6A),
    description:
        "Esta estructura laminada combina capas de alta resistencia para proteger productos sensibles a la humedad, oxígeno o luz. Ideal para café, suplementos, productos deshidratados o alimentos gourmet. Cuando la conservación es clave, 146 es la respuesta.",
    builder: buildEstrucutra146,
  ),
  ContainerCollageClass(
    title: "Estructura 141. Ligereza optimizada.",
    color: Color(0xffECECEC),
    colorOpen: Color(0xffB0B0B0),
    description:
        "Una opción más ligera y flexible, sin sacrificar calidad. La estructura 141 es perfecta para productos secos, polvos o snacks de consumo rápido. Menor peso, menor costo, mayor eficiencia. Ideal para empresas que buscan optimizar sin perder impacto.",
    builder: buildEstrucutra141,
  ),
  ContainerCollageClass(
    title: "Desde 125g. Perfecta para muestras.",
    color: Color(0xffFFE5B4),
    colorOpen: Color(0xffF4A261),
    description:
        "Los formatos pequeños, como 125g o 250g, son ideales para promociones, kits de degustación o lanzamientos. Conservan las mismas propiedades que los empaques grandes, pero en un formato compacto, fácil de llevar, y perfecto para captar nuevos clientes.",
    builder: buildGramaje125g,
  ),
  ContainerCollageClass(
    title: "Hasta 2500g. Para lo que necesites.",
    color: Color(0xffD2B48C),
    colorOpen: Color(0xff5A4636),
    height: 600,
    description:
        "¿Tienes un producto que se vende en gran volumen? Nuestra Ecobag Doypack soporta hasta 2.5 kg con estructura reforzada y base amplia. Ideal para mercados mayoristas, alimentos a granel o productos industriales. Más espacio, más presencia.",
    builder: buildGramaje2500g,
  ),
  ContainerCollageClass(
    title: "Doypack Ecobag. Listo para tu marca.",
    color: Color(0xffD6EAF8),
    colorOpen: Color(0xff669BBC),
    description:
        "PACKVISION ofrece una línea neutra y personalizable que se adapta a tu identidad visual. Ya sea impresión flexográfica, digital o etiquetas, este empaque está listo para lucir tu marca. Porque tu producto merece una presentación a la altura de su calidad.",
    builder: buildListoParaTuMarca,
  ),
  ContainerCollageClass(
    title: "Siente el kraft. Vive lo natural.",
    color: Color(0xffD0D6C5),
    colorOpen: Color(0xff6B705C),
    description:
        "Más que un material, el kraft es una declaración. Su textura orgánica y tono tierra conectan con el consumidor consciente. Refleja autenticidad, compromiso ambiental y una estética limpia que nunca pasa de moda. Perfecto para destacar en estanterías sostenibles.",
    builder: buildSienteElKraft,
  ),
  ContainerCollageClass(
    title: "11 opciones. Un solo propósito: cuidar.",
    color: Color(0xffC8FACC),
    colorOpen: Color(0xff4CAF50),
    height: 600,

    description:
        "Cada Ecobag Doypack de PACKVISION fue diseñado con un objetivo claro: proteger tu producto, impactar visualmente y reducir la huella ecológica. Ya sea con zipper, ventana, estructuras de alta barrera o kraft natural, hay una versión pensada para lo que tú necesitas.",
    builder: buildResumen,
  ),
];

//Final
class SliverFinallyDoypackEco extends StatelessWidget {
  const SliverFinallyDoypackEco({super.key, required this.r, required this.green, required this.route});

  final Responsive r;
  final Color green;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.wp(6)),

            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: r.wp(100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Doypack Lab", style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: r.fs(2.1, 30))),
                  Text(
                    textAlign: TextAlign.center,
                    "Elige el tamaño. Elige el acabado.\nElige tu estilo.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(3, 40)),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      navigateWithSlide(context, route);
                    },
                    child: MouseRegion(cursor: SystemMouseCursors.click, child: GradientBorderButton()),
                  ),

                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
          Container(
            height: r.hp(60, max: 600),
            width: r.wp(100),
            color: Colors.grey,
            child: ValueListenableBuilder<bool>(
              valueListenable: videoBlurNotifier,
              builder: (context, isBlur, _) {
                return VideoFlutter(src: 'assets/videos/smartbag/doypack/loop.webm', loop: true, isPause: false, fit: BoxFit.cover, blur: isBlur);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GradientBorderButton extends StatefulWidget {
  const GradientBorderButton({super.key});

  @override
  State<GradientBorderButton> createState() => _GradientBorderButtonState();
}

class _GradientBorderButtonState extends State<GradientBorderButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(); // animación circular infinita
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('gradient-border'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
          _controller.repeat();
        } else if (info.visibleFraction <= 0.1 && _visible) {
          setState(() => _visible = false);
          _controller.stop();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(4), // Aumenta este valor para un borde más grueso
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: SweepGradient(
                colors: const [Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.orange],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0, 1.25],
                transform: GradientRotation(_controller.value * 6.28),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
              child: const Text('Crear', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          );
        },
      ),
    );
  }
}
