import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

import 'package:webpack/widgets/video.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final ScrollController _scrollController = ScrollController();
  double _scrollY = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _scrollY = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _calculateOpacity(double start, double end) {
    double range = end - start;
    double value = ((_scrollY - start) / range).clamp(0.0, 1.0);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: videoBlurNotifier,
            builder: (context, isBlur, _) {
              return Positioned.fill(
                child: VideoFlutter(src: 'assets/assets/videos/us/backgroundus.webm', blur: isBlur, loop: true, showControls: true),
              );
            },
          ),

          Positioned.fill(child: Container(color: Colors.black.withAlpha((((_scrollY / 900).clamp(0.1, 0.7)) * 255).toInt()))),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _calculateOpacity(100, 600),
                  child: Text(
                    "La vida en un empaque".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Theme.of(context).scaffoldBackgroundColor, fontWeight: FontWeight.bold),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _calculateOpacity(600, 1100),
                  child: Text(
                    "Empaques que cuentan historias".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Theme.of(context).scaffoldBackgroundColor, fontWeight: FontWeight.bold),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _calculateOpacity(1100, 1600),
                  child: Text(
                    "Diseñamos el futuro, empaque a empaque.".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Theme.of(context).scaffoldBackgroundColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 2.8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.tertiary],
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 1124,
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '¿Quiénes somos?',
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.09),
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                                SizedBox(height: 40),
                                Text(
                                  textAlign: TextAlign.justify,
                                  'En Packvision nos dedicamos a desarrollar respuestas a las necesidades de contención, protección y exhibición de los productos que comercializan nuestros clientes y emprendedores de Colombia, a través de soluciones adecuadas e innovadoras en empaques, respondiendo satisfactoriamente a los requerimientos de un servicio familiar, amable, cálido, justo y respetuoso.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  'Nuestra misión.',
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.09),
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'En PACKVISION SAS, nos dedicamos a desarrollar respuestas a las necesidades de contención, protección y exhibición de los productos que comercializan nuestros clientes y los emprendedores; a través de soluciones adecuadas e innovadoras en empaques, respondiendo satisfactoriamente los requerimientos de un servicio familiar, amable, cálido, justo y respetuoso.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'En PACKVISION SAS, deseamos contribuir a la creación de relaciones comerciales sólidas, equitativas y duraderas, para lo cual trabajamos de forma permanente a empresas con nuevas ideas de producto o proyectos de emprendimiento, velando siempre por ponerlo en manos trabajadoras y justas.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'En PACKVISION SAS, buscamos proporcionar a nuestro equipo de trabajo un ambiente laboral idóneo, a través de la familiaridad, equidad, seguridad social y económica, además de ofrecer a nuestro equipo la oportunidad para su desarrollo personal y tranquilidad familiar; trabajamos siempre motivados por la esperanza y con los valores de la verdad, integridad, servicio, perseverancia, calidad y respeto por la vida y las personas.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 80),

                                Text(
                                  'Nuestra visión.',
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.09),
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'En PACKVISION SAS, nos vemos en el 2026 como una multinacional líder en producción, promoción y comercialización de empaques flexibles, laminados de alta tecnología, y de la clase artesanal en sus estándares únicos, los cuales tendrán un perfecto equilibrio con el medio ambiente y con los productos que en ellos se empacan. Será reconocida por sus marcas de empaques, a nivel nacional e internacional y consolidada como multinacional, por sus numerosos clientes que han encontrado en esta compañía su aliado estratégico, y la alternativa más versátil, justa y única de su empaque.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'Se habrá posicionado por su excelente calidad, variedad, innovación de empaque y su desarrollo dinámico acorde con los nuevos requerimientos de los diferentes sectores económicos de la Nación. Conquistará todo el mercado de Norteamérica, Centroamérica, Latinoamérica, Europa, Asia, Oceanía, África y Antártida, fortaleciendo en todas las líneas a toda la nación, ya que será la primera de impulso de exportación hacia estos países en micro lotes de calidad especializados y cantidades grandes y pequeñas.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'PACKVISION SAS, participará activamente en el cambio y transformación de nuestra nación porque su visión de servicio será ampliamente ejecutada a favor de todos, y especialmente de nuestros campesinos, jóvenes y niños, colocando mercados de negocio abierto que permitan altos ingresos por las ventas internacionales de variedad de productos nativos manejados bajo precios justos. Tendremos la vanguardia de la transformación de Colombia y del tejido social que requiere nuestra nación.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  'Enfoque estrategico',
                                  style: TextStyle(
                                    fontSize: min(60, screenWidth * 0.09),
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),

                                SizedBox(height: 40),

                                Text(
                                  textAlign: TextAlign.justify,
                                  'Participar activamente en las propuestas de cambio y transformación de Colombia, con una vocación única de servicio en beneficio de todos, especialmente de nuestros campesinos, niños y jóvenes. Consolidarnos en los mercados nacional e internacional, con la oferta de diferentes productos colombianos, generando un amplio margen de rentabilidad, garantizando un servicio amable, cálido y respetuoso, impulsando a las comunidades y fortaleciendo el tejido social.',
                                  style: TextStyle(fontSize: min(16, screenWidth * 0.05), fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(height: screenHeight * 0.1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
                  child: Footer(),
                ),
              ],
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}
