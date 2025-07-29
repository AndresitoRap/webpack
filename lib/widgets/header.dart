import 'dart:ui' as ui show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webpack/main.dart';

final ValueNotifier<bool> videoBlurNotifier = ValueNotifier(false);

// Normaliza el texto para crear rutas amigables
String normalizePath(String input) {
  const diacritics = {'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u', 'Á': 'A', 'É': 'E', 'Í': 'I', 'Ó': 'O', 'Ú': 'U', 'ñ': 'n', 'Ñ': 'N'};

  final withoutDiacritics = input.split('').map((char) => diacritics[char] ?? char).join();

  return withoutDiacritics
      .replaceAll(RegExp(r'[^\w\s-]'), '') // elimina símbolos especiales
      .replaceAll(' ', '-') // espacios por guiones
      .replaceAllMapped(
        RegExp(r'(^|-)(\w)'), // capitaliza después de inicio o guion
        (match) => '${match.group(1)}${match.group(2)!.toUpperCase()}',
      );
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isLogoHovered = false;
  bool isBagHovered = false;
  bool isMenuOpen = false;
  int? selectedMenuIndex;

  void toggleMenu() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      isMenuOpen = !isMenuOpen;
      selectedMenuIndex = null;
      videoBlurNotifier.value = isMenuOpen;
    });
  }

  void navigateTo(BuildContext context, String menuTitle, {String? subTitle, String? sectionTitle}) {
    // Normaliza cada segmento si existe
    final segments = [
      normalizePath(menuTitle),
      if (subTitle != null && subTitle.isNotEmpty) normalizePath(subTitle),
      if (sectionTitle != null && sectionTitle.isNotEmpty) normalizePath(sectionTitle),
    ];

    // Construye ruta
    final route = '/${segments.join('/')}';
    navigateWithSlide(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    final colorheader =
        routeName.toLowerCase().contains('ecobag')
            ? const Color.fromARGB(255, 75, 141, 44) // Verde
            : Theme.of(context).primaryColor; // Azul

    final isMobile = screenWidth < 850;
    final heightContainer = isMenuOpen ? screenHeight : 45.0;

    return Stack(
      children: [
        if (isMenuOpen == true)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: Container()),
          ),
        ClipRRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: MouseRegion(
              onExit: (_) {
                setState(() {
                  isMenuOpen = false;
                  selectedMenuIndex = null;
                  videoBlurNotifier.value = false;
                });
              },
              child: AnimatedContainer(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastEaseInToSlowEaseOut,
                width: screenWidth,
                height:
                    isMobile
                        ? heightContainer
                        : isMenuOpen
                        ? 300
                        : 45,
                decoration: BoxDecoration(color: colorheader.withAlpha(200)),
                child: MouseRegion(
                  onExit: (_) {
                    if (isMobile) {
                      setState(() {
                        isMenuOpen = false;
                        selectedMenuIndex = null;
                        videoBlurNotifier.value = false;
                      });
                    }
                  },
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child:
                          isMobile
                              //CELULAR Y TABLET
                              ? _buildMobile(screenWidth, isMobile)
                              //ESCRITORIO
                              : _buildDesktop(screenWidth, isMobile),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktop(double screenWidth, bool isMobile) {
    return ListView(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {
                    setState(() {
                      isMenuOpen = false;
                      selectedMenuIndex = null;
                      isLogoHovered = true;
                      videoBlurNotifier.value = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      isLogoHovered = false;
                      videoBlurNotifier.value = false;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      navigateWithSlide(context, '/');
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      opacity: isLogoHovered ? 1.0 : 0.7,
                      child: SvgPicture.asset(
                        "assets/img/home/WIsotipo.svg",
                        height: 23,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                ...List.generate(menu.length, (index) {
                  final isSelected = selectedMenuIndex == index;
                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        isMenuOpen = true;
                        selectedMenuIndex = index;
                        videoBlurNotifier.value = true;
                      });
                    },
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMenuOpen = !isMenuOpen;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              navigateTo(context, menu[index].title);
                            },
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 250),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white70,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: (screenWidth * 0.03).clamp(14, 16),
                              ),
                              child: Text(menu[index].title),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {
                    setState(() {
                      isMenuOpen = false;
                      selectedMenuIndex = null;
                      isBagHovered = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      isBagHovered = false;
                      videoBlurNotifier.value = false;
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOut,
                    child: IconButton(
                      key: ValueKey(isBagHovered),
                      icon: Icon(CupertinoIcons.bag, color: isBagHovered ? Colors.white : Colors.white70, size: (screenWidth * 0.05).clamp(20, 26)),
                      onPressed: () {
                        navigateWithSlide(context, '/cart');
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (isMenuOpen && selectedMenuIndex != null)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  switchInCurve: Curves.easeOut,
                  layoutBuilder: (currentChild, previousChildren) => currentChild!,
                  child: Row(
                    key: ValueKey(menu[selectedMenuIndex!].title),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                        menu[selectedMenuIndex!].items.map((sub) {
                          final columnIndex = menu[selectedMenuIndex!].items.indexOf(sub);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    sub.title,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: (screenWidth * 0.025).clamp(12, 14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ...List.generate(sub.sections.length, (i) {
                                  final section = sub.sections[i];
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        navigateTo(context, menu[selectedMenuIndex!].title, subTitle: sub.title, sectionTitle: section);
                                      },
                                      child: DelayedMenuItem(
                                        title: section,
                                        delayMilliseconds: (columnIndex * 100) + (i * 80),
                                        screenWidth: screenWidth,
                                        isMobile: isMobile,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobile(double screenWidth, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.decelerate,
                  opacity: isMenuOpen ? 0.0 : 1.0,
                  child: SvgPicture.asset(
                    "assets/img/home/wisotipo.svg",
                    height: 23,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.decelerate,
                  opacity: selectedMenuIndex != null ? 1.0 : 0.0,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.chevron_left, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        selectedMenuIndex = null;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.decelerate,
                  opacity: isMenuOpen ? 0.0 : 1.0,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.bag, color: Colors.white, size: (screenWidth * 0.05).clamp(20, 26)),
                    onPressed: () {
                      navigateWithSlide(context, '/cart');
                    },
                  ),
                ),
                HamburgerIcon(isOpen: isMenuOpen, onTap: toggleMenu),
              ],
            ),
          ],
        ),

        if (isMenuOpen)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
                  final fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOut);
                  return SlideTransition(position: offsetAnimation, child: FadeTransition(opacity: fadeAnimation, child: child));
                },
                child:
                    selectedMenuIndex == null
                        ? ListView(
                          key: const ValueKey('mainMenuList'),
                          children: List.generate(menu.length, (index) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMenuIndex = index;
                                  });
                                },
                                child: DelayedMenuItem(
                                  title: menu[index].title,
                                  delayMilliseconds: index * 100,
                                  screenWidth: screenWidth,
                                  isMobile: isMobile,
                                ),
                              ),
                            );
                          }),
                        )
                        : ListView(
                          key: const ValueKey('subMenuList'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(context, menu[selectedMenuIndex!].title);
                                },
                                child: Text(
                                  "Explora todo sobre ${menu[selectedMenuIndex!].title}",
                                  style: TextStyle(color: Colors.white, fontSize: (screenWidth * 0.045).clamp(18, 22)),
                                ),
                              ),
                            ),
                            ...menu[selectedMenuIndex!].items.expand((sub) {
                              return sub.sections.map(
                                (section) => MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      navigateTo(context, menu[selectedMenuIndex!].title, subTitle: sub.title, sectionTitle: section);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        section,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: (screenWidth * 0.04).clamp(16, 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
              ),
            ),
          ),
      ],
    );
  }
}

//CLASE PARA EL MENU
class Menu {
  final String title;
  final List<SubMenu> items;

  Menu({required this.title, required this.items});
}

//CLASE PARA EL SUBMENU
class SubMenu {
  final String title;
  final List<String> sections;

  SubMenu({required this.title, required this.sections});
}

//LISTA DE LOS MENUS Y SUBMENUS
final List<Menu> menu = [
  Menu(
    title: "SmartBag®",
    items: [
      SubMenu(title: "Explora SmartBag®", sections: ["4PRO", "5PRO", "Doypack", "Flowpack"]),
      SubMenu(title: "Especiales SmartBag®", sections: ["Cojín", "Piramidal", "Standpack"]),
    ],
  ),
  Menu(
    title: "EcoBag®",
    items: [
      SubMenu(title: "Explora EcoBag®", sections: ["4PRO", "5PRO", "Doypack", "Flowpack"]),
      SubMenu(title: "Especiales EcoBag®", sections: ["Cojín", "Piramidal"]),
    ],
  ),
  Menu(
    title: "Accesorios",
    items: [
      SubMenu(title: "Accesorios Destacados", sections: ["Peel & Stick", "Válvula"]),
    ],
  ),
  Menu(
    title: "Catálogo",
    items: [
      SubMenu(title: "Nuestros Catálogos", sections: ["Catálogo"]),
    ],
  ),
  Menu(
    title: "Nosotros",
    items: [
      SubMenu(title: "Quienes somos?", sections: ["Identidad corporativa", "Nuestros valores"]),
    ],
  ),
  Menu(
    title: "Soporte",
    items: [
      SubMenu(title: "Ayuda Rápida", sections: ["Whatsapp"]),
      SubMenu(title: "Politicas", sections: ["Politicas legales y reglamentarias", "Tratamiento de datos"]),
      SubMenu(title: "Tú opinion", sections: ["Encuesta de satisfacción y PQRS"]),
    ],
  ),
];

//ICONO DE MENU
class HamburgerIcon extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;

  const HamburgerIcon({super.key, required this.isOpen, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const double lineWidth = 20;
    const double lineHeight = 2;
    const Duration duration = Duration(milliseconds: 300);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 24,
          color: Colors.transparent,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Línea superior
                AnimatedPositioned(
                  duration: duration,
                  top: isOpen ? 11 : 6,
                  child: AnimatedRotation(
                    turns: isOpen ? 0.125 : 0, // 45° = 1/8
                    duration: duration,
                    child: Container(
                      width: lineWidth,
                      height: lineHeight,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                ),
                // Línea inferior
                AnimatedPositioned(
                  duration: duration,
                  bottom: isOpen ? 11 : 6,
                  child: AnimatedRotation(
                    turns: isOpen ? -0.125 : 0, // -45° = -1/8
                    duration: duration,
                    child: Container(
                      width: lineWidth,
                      height: lineHeight,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
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

//WIDGET PARA LOS ITEMS DEL MENU CON ANIMACION
class DelayedMenuItem extends StatefulWidget {
  final String title;
  final int delayMilliseconds;
  final double screenWidth;
  final bool isMobile;

  const DelayedMenuItem({super.key, required this.title, required this.delayMilliseconds, required this.screenWidth, required this.isMobile});

  @override
  State<DelayedMenuItem> createState() => _DelayedMenuItemState();
}

class _DelayedMenuItemState extends State<DelayedMenuItem> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delayMilliseconds), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 200),
      child: Transform.translate(
        offset: Offset(0, _opacity == 1 ? 0 : 20),
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.isMobile ? 16 : 5),
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: (widget.screenWidth * 0.04).clamp(widget.isMobile ? 16 : 14, widget.isMobile ? 20 : 18)),
          ),
        ),
      ),
    );
  }
}
