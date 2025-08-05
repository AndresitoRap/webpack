import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:webpack/pages/accesorios/accesorios.dart';
import 'package:webpack/pages/cartpage.dart';
import 'package:webpack/pages/detailsproduct.dart';
import 'package:webpack/pages/home.dart';
import 'package:webpack/pages/catalog/catalog.dart';
import 'package:webpack/pages/smartandeco.dart';
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

Future<void> navigateWithSlide(BuildContext context, String routeName, {Widget? target}) async {
  final currentRoute = ModalRoute.of(context)?.settings.name;

  // Si ya estás en la misma ruta, no hagas nada
  if (currentRoute == routeName && target == null) return;

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
    final allCards = [...subcategorieSmart, ...subcategorieEco];
    findCard(route) => allCards.firstWhereOrNull((c) => route?.contains(c.route) ?? false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empaques Packvisión',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF1F5FF),
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
        final path = settings.name ?? '/';
        final uri = path.contains('?') ? Uri.parse(path) : Uri(path: path);
        final segments = uri.pathSegments;

        // print(path);
        // print(uri);
        // print(segments);

        if (uri.path == '/') return _buildRoute(settings, const Home());

        final staticRoutes = <String, Widget Function(RouteSettings)>{
          '/': (_) => const Home(),
          '/cart': (_) => CartPage(),
          '/SmartBag': (_) => SmartAndEco(isEcobag: false),
          '/EcoBag': (_) => SmartAndEco(isEcobag: true),
          '/Catalogo': (_) => const Catalog(),
          '/Catalogo/Nuestros-Catalogos/Catalogo': (_) => const Catalog(),
          '/Nosotros': (_) => const Us(),
          '/Soporte': (_) => const SupportHome(),
          '/Soporte/Ayuda-Rapida/Whatsapp': (_) => const WhatsappPage(),
          '/Soporte/Politicas/Politicas-Legales-Y-Reglamentarias': (_) => const LegalPolicies(),
          '/Soporte/Politicas/Tratamiento-De-Datos': (_) => const DataProccessing(),
          '/Soporte/Tu-Opinion/Encuesta-De-Satisfaccion-Y-PQRS': (_) => const PQRS(),
          '/Nosotros/Quienes-Somos/Identidad-Corporativa': (_) => const AboutUs(),
          '/Nosotros/Quienes-Somos/Nuestros-Valores': (_) => const Us(),
          '/Accesorios': (_) => const Accesorios(),
          '/Accesorios/Explora-Accesorios/Peel': (_) => const Us(),
          '/Accesorios/Explora-Accesorios/Valvula': (_) => const Us(),
        };

        if (staticRoutes.containsKey(uri.path)) {
          return _buildRoute(settings, staticRoutes[uri.path]!(settings));
        }

        if (segments.length == 3 &&
            (segments[0] == 'SmartBag' || segments[0] == 'EcoBag') &&
            (segments[1].toLowerCase().startsWith('explora-') || segments[1].toLowerCase().startsWith('especiales-'))) {
          final section = segments[2];
          final routeKey = '${segments[0]}/$section';
          final productList = productSections[routeKey];
          final matchedCard = findCard(settings.name);
          // print("Ruta completa: ${settings.name}");
          // print("Segmentos: ${segments}");

          if (productList != null) {
            if (matchedCard != null) {
              return _buildRoute(settings, Commerce(section: section, selectedSubcategorie: matchedCard));
            } else {
              return _buildRoute(settings, const PageNotFound());
            }
          }
        }

        if (segments.length == 4 &&
            (segments[0].toLowerCase() == 'smartbag' || segments[0].toLowerCase() == 'ecobag') &&
            segments[1].toLowerCase().startsWith('explora-') &&
            segments[3].toLowerCase() == 'crea-tu-empaque') {
          final bagType = segments[0]; // SmartBag o EcoBag
          final section = segments[2]; // 4PRO, DOYPACK, etc.
          final routeKey = '$bagType/$section'; // Ej: SmartBag/4PRO

          final products = productSections[routeKey];
          final matchedCard = findCard(settings.name);

          if (products != null && matchedCard!.route.isNotEmpty) {
            final allProducts = products.expand((t) => t.structures).expand((e) => e.ability).expand((a) => a.product).toList(growable: false);

            final firstProduct = allProducts.firstOrNull;

            if (firstProduct != null) {
              return _buildRoute(settings, DetailsProduct(product: firstProduct, allProducts: allProducts));
            }
          }

          return _buildRoute(settings, const PageNotFound());
        }
        return _buildRoute(settings, const PageNotFound());
      },
    );
  }
}

PageRouteBuilder _buildRoute(RouteSettings settings, Widget page) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, __, ___, child) => child,
    transitionDuration: Duration.zero,
  );
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
    setState(() {
      _showSpinner = true;
      _isSlidingOut = false;
    });
    await onMidCallback();
    setState(() {
      _showSpinner = false;
      _isSlidingOut = true;
    });

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
