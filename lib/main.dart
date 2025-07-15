import 'package:flutter/material.dart';
import 'package:webpack/pages/cartpage.dart';
import 'package:webpack/pages/detailsproduct.dart';
import 'package:webpack/pages/home.dart';
import 'package:webpack/pages/catalog/catalog.dart';
import 'package:webpack/pages/ecobag/ecobag.dart';
import 'package:webpack/pages/smartbag/smartbag.dart';
import 'package:webpack/pages/support/dataproccessing.dart';
import 'package:webpack/pages/support/legalpolicies.dart';
import 'package:webpack/pages/support/pqrs.dart';
import 'package:webpack/pages/support/whatsapppage.dart';
import 'package:webpack/pages/support/support.dart';
import 'package:webpack/pages/us/aboutUs.dart';
import 'package:webpack/pages/us/us.dart';
import 'package:webpack/widgets/page_not_found.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/pages/commerce.dart';

final GlobalKey<TransitionOverlayState> transitionOverlayKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

void navigateWithSlide(BuildContext context, String routeName, {Widget? target}) {
  transitionOverlayKey.currentState?.playTransition(() async {
    if (target == null) {
      Navigator.pushNamed(context, routeName);
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => target, transitionsBuilder: (_, __, ___, child) => child, transitionDuration: Duration.zero),
      );
    }
  }, routeName);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empaques Packvisión',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 245, 255),
        primaryColor: const Color(0xFF004F9E),
        fontFamily: 'D-DINExp',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004F9E),
          primary: const Color(0xFF3EB7EA),
          secondary: const Color(0xFF015081),
          tertiary: const Color(0xFF052344),
        ),
      ),
      builder: (context, child) {
        return TransitionOverlay(key: transitionOverlayKey, child: child!);
      },

      initialRoute: '/',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/');
        if (uri.path == '/') return _buildRoute(settings, const Home());

        final staticRoutes = {
          '/': const Home(),
          '/cart': CartPage(),
          '/SmartBag': const SmartBag(),
          '/EcoBag': const EcoBag(),
          '/Catalogo': const Catalog(),
          '/Catalogo/Nuestros-Catalogos/Catalogo': const Catalog(),
          '/Nosotros': const Us(),
          '/Soporte': const SupportHome(),
          '/Soporte/Ayuda-Rapida/Whatsapp': const WhatsappPage(),
          '/Soporte/Ayuda-Rapida/Telefono': const WhatsappPage(),
          '/Soporte/Politicas/Politicas-legales-y-reglamentarias': const LegalPolicies(),
          '/Soporte/Politicas/Tratamiento-de-datos': const DataProccessing(),
          '/Soporte/Tu-opinion/Encuesta-de-satisfaccion-y-PQRS': const PQRS(),
          '/Nosotros/Quienes-somos/Identidad-corporativa': const AboutUs(),
          '/Nosotros/Quienes-somos/Nuestros-valores': const Us(),
        };

        if (staticRoutes.containsKey(uri.path)) {
          return _buildRoute(settings, staticRoutes[uri.path]!);
        }

        if (uri.pathSegments.length == 3 &&
            (uri.pathSegments[0] == 'SmartBag' || uri.pathSegments[0] == 'EcoBag') &&
            uri.pathSegments[1].toLowerCase().startsWith('explora-')) {
          final section = uri.pathSegments[2];
          final routeKey = '${uri.pathSegments[0]}/$section';
          final productList = productSections[routeKey];
          final allCards = [...subcategorieSmart, ...subcategorieEco];
          final matchedCard = allCards.firstWhere((card) => card.route == settings.name, orElse: null);
          if (matchedCard == null) {
            return _buildRoute(settings, const PageNotFound());
          }
          print("Ruta completa: ${settings.name}");
          print("Segmentos: ${uri.pathSegments}");

          if (productList != null) {
            return _buildRoute(settings, Commerce(section: section, selectedSubcategorie: matchedCard));
          }
        }

        if (uri.pathSegments.length == 4 &&
            (uri.pathSegments[0].toLowerCase() == 'smartbag' || uri.pathSegments[0].toLowerCase() == 'ecobag') &&
            uri.pathSegments[1].toLowerCase().startsWith('explora-') &&
            uri.pathSegments[3].toLowerCase() == 'crea-tu-empaque') {
          final bagType = uri.pathSegments[0]; // SmartBag o EcoBag
          final section = uri.pathSegments[2]; // 4PRO, DOYPACK, etc.
          final routeKey = '$bagType/$section'; // Ej: SmartBag/4PRO

          final products = productSections[routeKey];

          final allCards = [...subcategorieSmart, ...subcategorieEco];
          final matchedCard = allCards.firstWhere(
            (card) => uri.path.contains(card.route),
            orElse: () => throw Exception('No matching Subcategorie found'),
          );

          if (products != null && matchedCard.route.isNotEmpty) {
            final allProducts =
                products
                    .expand((terminado) => terminado.structures)
                    .expand((estructura) => estructura.ability)
                    .expand((ability) => ability.product)
                    .toList();

            if (allProducts.isNotEmpty) {
              return _buildRoute(
                settings,
                DetailsProduct(
                  product: allProducts.first, // ✅ PASA UN SOLO Product
                  allProducts: allProducts, // ✅ Aquí sí va la lista
                ),
              );
            }
          }

          return _buildRoute(settings, const PageNotFound());
        }
      },
    );
  }

  PageRouteBuilder _buildRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, __, ___, child) => child,
      transitionDuration: Duration.zero,
    );
  }
}

class TransitionOverlay extends StatefulWidget {
  final Widget child;
  const TransitionOverlay({super.key, required this.child});

  @override
  State<TransitionOverlay> createState() => TransitionOverlayState();
}

class TransitionOverlayState extends State<TransitionOverlay> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideIn;
  late Animation<Offset> _slideOut;
  bool _showOverlay = false;
  bool _isSlidingOut = false;
  String _incomingRoute = '/';
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _slideIn = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastEaseInToSlowEaseOut));
    _slideOut = Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0)).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
  }

  void playTransition(Function onMidCallback, String incomingRoute) async {
    setState(() {
      _showOverlay = true;
      _isSlidingOut = false;
      _incomingRoute = incomingRoute;
    });

    await _controller.forward(from: 0);
    setState(() => _showSpinner = true);
    await onMidCallback();
    setState(() => _showSpinner = false);
    setState(() => _isSlidingOut = true);
    await _controller.forward(from: 0);

    setState(() => _showOverlay = false);
  }

  void handlePop(BuildContext context) async {
    setState(() {
      _isSlidingOut = true;
    });
    await _controller.forward(from: 0);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showOverlay)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final isEcoBag = _incomingRoute.toLowerCase().contains('ecobag');
                final color = isEcoBag ? const Color(0xff4b8d2c) : const Color(0xFF004F9E);
                return SlideTransition(
                  position: _isSlidingOut ? _slideOut : _slideIn,
                  child: Container(
                    color: color,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _showSpinner ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: const CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

String _slugify(String text) {
  return text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s-]'), '') // quitar símbolos raros
      .replaceAll(' ', '-') // reemplazar espacios por guiones
      .replaceAll(RegExp('-+'), '-'); // evitar guiones dobles
}
