import 'dart:math';
import 'dart:ui' as ui show ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webpack/widgets/doypack/collage.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/scrollopacity.dart';

class DoypackEco extends StatelessWidget {
  const DoypackEco({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final green = Color.fromARGB(255, 75, 141, 44);
    final isMobile = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 255, 252),

      body: CustomScrollView(
        slivers: [
          SliverWithStart(screenWidth: screenWidth, screenHeight: screenHeight, green: green),
          SliverWithSostenible(screenWidth: screenWidth, green: green),
          SliverWithCollage(isMobile: isMobile, green: green, screenWidth: screenWidth),
          SliverWithCareUs(screenWidth: screenWidth),
          SliverFinallyDoypackEco(screenWidth: screenWidth, green: green),
        ],
      ),
    );
  }
}

//Inicio
class SliverWithStart extends StatelessWidget {
  const SliverWithStart({super.key, required this.screenWidth, required this.screenHeight, required this.green});

  final double screenWidth;
  final double screenHeight;
  final Color green;

  @override
  Widget build(BuildContext context) {
    final isMobile = screenWidth < 950;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: screenWidth * 0.06),
        child: SizedBox(
          height: screenHeight - 50,
          width: screenWidth,
          child: ScrollAnimatedWrapper(
            visibilityKey: Key("Diseño que respira"),
            child:
                isMobile
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Doypack Ecobag®", style: TextStyle(color: green, fontSize: (screenWidth * 0.08).clamp(20, 30))),
                        Text(
                          "Diseño que respira.",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.1).clamp(40, 60), height: 0.95),
                        ),

                        SizedBox(height: 10),
                        button(),
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
                              Text("Doypack Ecobag®", style: TextStyle(color: green, fontSize: (screenWidth * 0.08).clamp(20, 30))),
                              Text(
                                "Diseño que respira.",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.1).clamp(40, 60), height: 0.95),
                              ),
                            ],
                          ),
                          button(),
                        ],
                      ),
                    ),
          ),
        ),
      ),
    );
  }

  Widget button() {
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
                Text("Crear mi", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: (screenWidth * 0.03).clamp(16, 18))),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white), foregroundColor: WidgetStatePropertyAll(green)),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Doypack", style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.03).clamp(16, 18))),
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

//Sliver con sostenibilidad
class SliverWithSostenible extends StatelessWidget {
  const SliverWithSostenible({super.key, required this.screenWidth, required this.green});

  final double screenWidth;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScrollAnimatedWrapper(
            visibilityKey: Key('image-sostenibilidad'),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 100),
              width: (screenWidth * 0.4).clamp(400, 1000),
              height: 500,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
              child: Center(child: Text("Foto")),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('doypack-with-o'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset("img/ecobag/doypack/o_with_flowers.webp", fit: BoxFit.cover, color: green, colorBlendMode: BlendMode.srcIn),
                ),
                Text(
                  "DOYPACK",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.07).clamp(40, 60), color: green, letterSpacing: 2.4),
                ),
              ],
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('ecobag-doypack'),
            child: Text(
              "EcoBag®",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.04).clamp(22, 24), color: green, letterSpacing: 2.4),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('Sostenibilidad por donde mires'),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: screenWidth * 0.06),
              child: Text(
                textAlign: TextAlign.center,
                "Sostenible por donde lo mires.",
                style: TextStyle(fontSize: (screenWidth * 0.1).clamp(40, 60), fontWeight: FontWeight.w700, color: Colors.black.withAlpha(220)),
              ),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('text-de-sontitbble'),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: SizedBox(
                width: 1000,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Empaques Ecobag que inspiran. Estilo doypack en kraft natural o blanco. Con válvula y zipper para conservar mejor. Tecnología práctica, diseño consciente. Doypack Ecobag®: todo lo que necesitas, en un empaque con propósito.",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: (screenWidth * 0.03).clamp(20, 30)),
                  ),
                ),
              ),
            ),
          ),
          ScrollAnimatedWrapper(
            visibilityKey: Key('crear-doypack'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(30)),
                    child: Text("Crear Doypack", style: TextStyle(color: Colors.white, fontSize: (screenWidth * 0.03).clamp(16, 20))),
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

//Sliver con Collage
class SliverWithCollage extends StatefulWidget {
  const SliverWithCollage({super.key, required this.isMobile, required this.green, required this.screenWidth});

  final bool isMobile;
  final Color green;
  final double screenWidth;

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
            return ScrollAnimatedWrapper(
              visibilityKey: Key("Collage${data.title}"),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ContainerCollage(
                      green: widget.green,
                      isMobile: widget.isMobile,
                      data: data.builder(context),
                      height: data.height!,
                      color: data.color,
                      colorOpen: data.colorOpen,
                      title: data.title,
                      description: data.description,
                    ),
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

            return ScrollAnimatedWrapper(
              visibilityKey: Key('Collage-${rowItems.map((e) => e.title)}'),
              child: Center(
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
                                    green: widget.green,
                                    isMobile: widget.isMobile,
                                    data: data.builder(context),
                                    height: data.height!,
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
    final screenW = MediaQuery.of(context).size.width;
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
                  padding: EdgeInsets.symmetric(horizontal: screenW * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: (screenW * 0.03).clamp(20, 24)),
                      ),
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
                                child: Text(widget.description, style: TextStyle(color: Colors.white, fontSize: (screenW * 0.025).clamp(16, 20))),
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
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: toggle,
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
    this.height = 500,
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
                  visibilityKey: Key('te-importa'),
                  child: Text(
                    "Te importa. Nos importa.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44), fontSize: min(screenWidth * 0.06, 70)),
                  ),
                ),
                SizedBox(height: screenWidth >= 1000 ? 50 : 100),
                ScrollAnimatedWrapper(
                  visibilityKey: Key('nos-importa'),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Desde empaques como 5PRO Ecobag®, diseñados para proteger tu producto y destacar tu marca, hasta soluciones como Ecobag®, que combinan funcionalidad con conciencia ambiental. Usamos materiales reciclables, desarrollamos opciones versátiles como válvulas y cierres herméticos, y te ofrecemos formatos pensados para cada necesidad, siempre con una visión sustentable. Porque cada detalle cuenta cuando quieres hacer las cosas bien.",
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black87, fontSize: min(screenWidth * 0.026, 25), height: 0),
                  ),
                ),
                SizedBox(height: screenWidth >= 1000 ? 50 : 100),

                SizedBox(
                  width: min(screenWidth, 1600),
                  child: ScrollAnimatedWrapper(
                    visibilityKey: Key('info-importa'),
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

//Final
class SliverFinallyDoypackEco extends StatelessWidget {
  const SliverFinallyDoypackEco({super.key, required this.screenWidth, required this.green});

  final double screenWidth;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ScrollAnimatedWrapper(
            visibilityKey: Key('Doypack-lab'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Doypack Lab", style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: (screenWidth * 0.04).clamp(20, 30))),
                  Text(
                    textAlign: TextAlign.center,
                    "Elige el tamaño. Elige el acabado.\nElige tu estilo.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: (screenWidth * 0.05).clamp(30, 40)),
                  ),
                  SizedBox(height: 20),
                  MouseRegion(cursor: SystemMouseCursors.click, child: GestureDetector(onTap: () {}, child: GradientBorderButton())),

                  SizedBox(height: 50),

                  Container(height: 600, width: screenWidth, color: Colors.grey),
                ],
              ),
            ),
          ),
          Footer(),
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
