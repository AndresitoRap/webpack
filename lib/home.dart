import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollrecomended = ScrollController();
  bool isExpanded = false;
  String hoveredMenu = '';
  late List<bool> isHover;
  late List<bool> isHoverIcon;
  late List<bool> isHoverpackwithconscience;
  int selectedpackwithconscience = 0;
  bool isExpandedwithconscience = false;

  List<Map<String, List<String>>> submenuItems = [];

  final Map<String, List<Map<String, List<String>>>> submenus = {
    "SmartBag®": [
      {
        "Explora SmartBag®": [
          "Nuevos Productos",
          "Más Vendidos",
          "Tendencia",
          "Novedades Smart",
          "Reseñas De Clientes",
        ],
        "Compra SmartBag®": [
          "Bolsas Smart",
          "Empaques Smart",
          "Accesorios Smart",
          "Edición limitada",
          "Tarjetas de regalo",
        ],
        "Más de SmartBag®": [
          "Acerca de SmartBag®",
          "Tecnolgía",
          "Sostenibilidad",
          "Blog",
          "Carreras",
        ],
      },
    ],
    "EcoBag®": [
      {
        "Explora EcoBag®": [
          "Materiales Eco-Friendly",
          "Bolsas Recicladas",
          "Producción Sostenible",
          "Historia De Clientes",
          "EcoBag® En Acción",
        ],
        "Compra EcoBag®": [
          "Bolas Eco-Friendly",
          "Empaques reciclables",
          "Eco Accesorios",
          "Bolsas De Algodón Orgánico",
          "Tarjetas De Regalo Eco",
        ],
        "Más de EcoBag®": [
          "Acerca de EcoBag®",
          "Practicas Sostenibles",
          "Certificaciones",
          "Blog",
          "Asociación",
        ],
      },
    ],
    "Inicio": [
      {
        "Destacados": ["Bienvenida", "Nuevos productos", "Más vendidos"],
        "Explorar": ["Categorías", "Ofertas especiales", "Recomendados"],
      },
    ],
    "Nosotros": [
      {
        "Nuestra historia": [
          "Quiénes somos",
          "Misión y visión",
          "Nuestros valores",
        ],
        "Conéctate": ["Únete al equipo", "Prensa", "Eventos"],
      },
    ],
    "Catálogo": [
      {
        "Explora el catálogo": ["Café", "Alimentos", "Farmacéuticos", "Otros"],
        "Más información": ["Novedades", "Materiales", "Personalización"],
      },
    ],
    "Visitanos": [
      {
        "Ubicaciones": ["Mapa de tiendas", "Horarios", "Citas"],
        "Servicios": ["Asesoría", "Atención al cliente", "Soporte"],
      },
    ],
    "Políticas": [
      {
        "Normativas": ["Términos y condiciones", "Privacidad", "Garantía"],
        "Legal": ["Derechos de autor", "Devoluciones", "Reembolsos"],
      },
    ],
    "Pago en línea": [
      {
        "Métodos de pago": [
          "Tarjeta de crédito",
          "PayPal",
          "Transferencia bancaria",
        ],
        "Seguridad": [
          "Protección de datos",
          "Políticas de reembolso",
          "Facturación",
        ],
      },
    ],
  };

  void _scrollLeft() {
    _scrollrecomended.animateTo(
      _scrollrecomended.offset - 450,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollrecomended.animateTo(
      _scrollrecomended.offset + 450,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, String>> recommendedItems = [
    {
      "image": "lib/src/img/recommended1.jpg",
      "title": "Rosa de Sharon",
      "description": "Shohana",
    },
    {
      "image": "lib/src/img/recommended2.jpg",
      "title": "Rosa de Sharon",
      "description": "Lobelina",
    },
    {
      "image": "lib/src/img/recommended3.jpg",
      "title": "Rosa de Sharon",
      "description": "Clavelina",
    },
    {
      "image": "lib/src/img/recommended1.jpg",
      "title": "Rosa de Sharon",
      "description": "Shohana",
    },
    {
      "image": "lib/src/img/recommended2.jpg",
      "title": "Rosa de Sharon",
      "description": "Lobelina",
    },
    {
      "image": "lib/src/img/recommended3.jpg",
      "title": "Rosa de Sharon",
      "description": "Clavelina",
    },
    {
      "image": "lib/src/img/recommended1.jpg",
      "title": "Rosa de Sharon",
      "description": "Shohana",
    },
    {
      "image": "lib/src/img/recommended2.jpg",
      "title": "Rosa de Sharon",
      "description": "Lobelina",
    },
    {
      "image": "lib/src/img/recommended3.jpg",
      "title": "Rosa de Sharon",
      "description": "Clavelina",
    },
  ];

  final List<Map<String, String>> packwithconscience = [
    {
      "image": "lib/src/img/Asesoria.jpg",
      "title": "Asesoría",
      "description":
          "No estarás solo, cuentas con nosotros para las dudas que te surjan, tanto en nuestros productos, como en los procesos relacionados con este.",
    },
    {
      "image": "lib/src/img/Calidad.jpg",
      "title": "Empaques de Calidad",
      "description":
          "Nuestros empaques flexibles están comprometidos con la calidad de nuestros clientes orientados al mercado internacional.",
    },
    {
      "image": "lib/src/img/Cumplimiento.jpg",
      "title": "Cumplimiento",
      "description":
          "Es importante que tus productos lleguen el día y la hora pactada, siempre buscamos superar la barrera de la distancia, no tendrás que esperarnos en la puerta, nosotros llamaremos a ella a tiempo.",
    },
    {
      "image": "lib/src/img/Servicios.jpg",
      "title": "Servicios",
      "description":
          "Nuestro enfoque es el servicio, siempre de la mano de nuestros clientes, proporcionando seguridad basada en respaldo y solidez.",
    },
  ];
  @override
  void initState() {
    super.initState();
    isHover = List.generate(recommendedItems.length, (index) => false);
    isHoverIcon = List.generate(recommendedItems.length, (index) => false);
    isHoverpackwithconscience = List.generate(
      packwithconscience.length,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      height: MediaQuery.of(context).size.height / 1.2,
                      width: 1024,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'lib/src/img/Packvision.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Expanded(
                            child: Image.asset(
                              'lib/src/img/Bag&paint.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.1,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Empaques con conciencia",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        SizedBox(
                          height:
                              (MediaQuery.of(context).size.width * 0.3) + 40,
                          child: Stack(
                            children: [
                              for (
                                int i = 0;
                                i < packwithconscience.length;
                                i++
                              )
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                  left:
                                      isExpandedwithconscience
                                          ? (i == selectedpackwithconscience
                                              ? 0
                                              : MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.45 +
                                                  (i - 1) * 60)
                                          : i *
                                              (MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.20 +
                                                  40),
                                  top: 0,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                    width:
                                        isExpandedwithconscience &&
                                                selectedpackwithconscience == i
                                            ? MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.45
                                            : MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.2,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.asset(
                                            packwithconscience[i]['image']!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(
                                                context,
                                              ).primaryColor.withAlpha(100),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomRight: Radius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              packwithconscience[i]['title']!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (isExpandedwithconscience &&
                                            selectedpackwithconscience == i)
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: AnimatedOpacity(
                                              duration: Duration(
                                                milliseconds: 200,
                                              ),
                                              opacity:
                                                  isExpandedwithconscience
                                                      ? 1.0
                                                      : 0.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(16),
                                                        bottomRight:
                                                            Radius.circular(16),
                                                      ),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.white.withAlpha(0),
                                                      Colors.white,
                                                    ],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 100,
                                                        horizontal: 20,
                                                      ),
                                                  child: Text(
                                                    packwithconscience[i]['description']!,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Positioned(
                                          bottom: 16,
                                          right: 16,
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            onEnter: (_) {
                                              setState(() {
                                                isHoverpackwithconscience[i] =
                                                    true;
                                              });
                                            },
                                            onExit: (_) {
                                              setState(() {
                                                isHoverpackwithconscience[i] =
                                                    false;
                                              });
                                            },
                                            child: AnimatedSwitcher(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              child:
                                                  isExpandedwithconscience &&
                                                          selectedpackwithconscience ==
                                                              i
                                                      ? GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isExpandedwithconscience =
                                                                false;
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              isHoverpackwithconscience[i]
                                                                  ? Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .tertiary
                                                                  : Theme.of(
                                                                    context,
                                                                  ).primaryColor,
                                                          child: Icon(
                                                            Icons.close,
                                                            color:
                                                                isHoverpackwithconscience[i]
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .white70,
                                                          ),
                                                        ),
                                                      )
                                                      : GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedpackwithconscience =
                                                                i;
                                                            isExpandedwithconscience =
                                                                true;
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              isHoverpackwithconscience[i]
                                                                  ? Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .tertiary
                                                                  : Theme.of(
                                                                    context,
                                                                  ).primaryColor,
                                                          child: Icon(
                                                            Icons.add,
                                                            color:
                                                                isHoverpackwithconscience[i]
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .white70,
                                                          ),
                                                        ),
                                                      ),
                                            ),
                                          ),
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.1,
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Nuestros \n",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60,
                                  fontFamily: "D-DINExp",
                                ),
                              ),
                              TextSpan(
                                text: "recomendados",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: "D-DINExp",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: _scrollrecomended,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 46),
                      child: Row(
                        children: [
                          SizedBox(width: 35),
                          ...List.generate(recommendedItems.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: 50,
                                top: 10,
                                bottom: 30,
                              ),
                              child: MouseRegion(
                                onEnter:
                                    (_) =>
                                        setState(() => isHover[index] = true),
                                onExit:
                                    (_) =>
                                        setState(() => isHover[index] = false),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      transform:
                                          isHover[index]
                                              ? (Matrix4.identity()
                                                ..scale(1.02))
                                              : Matrix4.identity(),
                                      width: 400,
                                      height: 700,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(26),
                                        boxShadow:
                                            isHover[index]
                                                ? [
                                                  BoxShadow(
                                                    color: Colors.black54,
                                                    blurRadius: 10,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ]
                                                : [],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(26),
                                        child: GestureDetector(
                                          onTap:
                                              () => _showCustomDialog(
                                                context,
                                                recommendedItems[index]["title"]!,
                                                recommendedItems[index]["description"]!,
                                              ),

                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.asset(
                                                  recommendedItems[index]["image"]!,
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  top: 30,
                                                  left: 30,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        recommendedItems[index]['title']!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        recommendedItems[index]['description']!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 35,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 16,
                                                  right: 16,
                                                  child: MouseRegion(
                                                    onEnter:
                                                        (_) => setState(
                                                          () =>
                                                              isHoverIcon[index] =
                                                                  true,
                                                        ),
                                                    onExit:
                                                        (_) => setState(
                                                          () =>
                                                              isHoverIcon[index] =
                                                                  false,
                                                        ),
                                                    cursor:
                                                        SystemMouseCursors
                                                            .click,
                                                    child: AnimatedContainer(
                                                      duration: Duration(
                                                        milliseconds: 200,
                                                      ),
                                                      curve: Curves.easeInOut,
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            isHoverIcon[index]
                                                                ? Theme.of(
                                                                  context,
                                                                ).primaryColor
                                                                : Theme.of(
                                                                      context,
                                                                    )
                                                                    .primaryColor
                                                                    .withAlpha(
                                                                      100,
                                                                    ),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 24,
                                                        color:
                                                            isHoverIcon[index]
                                                                ? Colors.white
                                                                : Colors
                                                                    .white60,
                                                      ),
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
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withAlpha(30),
                          ),
                          child: IconButton(
                            onPressed: _scrollLeft,
                            icon: Icon(CupertinoIcons.chevron_back),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withAlpha(30),
                          ),
                          child: IconButton(
                            onPressed: _scrollRight,
                            icon: Icon(CupertinoIcons.chevron_forward),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.2,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sedes de Packvision S.A",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              width: MediaQuery.of(context).size.width / 3,
                              color: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Image.asset(
                                  "lib/src/img/Carvajal.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isExpanded
              ? Positioned(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  opacity: isExpanded ? 1 : 0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.black12),
                  ),
                ),
              )
              : Container(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: MouseRegion(
                onExit: (_) {
                  Future.delayed(const Duration(milliseconds: 50), () {
                    setState(() {
                      isExpanded = false;
                      hoveredMenu = '';
                      submenuItems = [];
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCirc,
                  height: isExpanded ? 350 : 50,
                  constraints: BoxConstraints(minHeight: 50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withAlpha(150),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).primaryColor.withAlpha(200),
                                Theme.of(context).primaryColor.withAlpha(150),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 13,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 1024,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        child: MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              isExpanded = false;
                                              hoveredMenu = "logo";
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredMenu = '';
                                            });
                                          },
                                          cursor: SystemMouseCursors.click,
                                          child: Opacity(
                                            opacity:
                                                hoveredMenu == "logo" ? 1 : 0.8,
                                            child: Image.asset(
                                              "lib/src/img/WIsotipo.png",
                                              height: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ...submenus.keys.map(
                                        (menu) => _headerItem(menu),
                                      ),

                                      GestureDetector(
                                        onTap: () {},
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          onEnter: (_) {
                                            setState(() {
                                              isExpanded = false;
                                              hoveredMenu = "search";
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredMenu = '';
                                            });
                                          },
                                          child: Opacity(
                                            opacity:
                                                hoveredMenu == "search"
                                                    ? 1
                                                    : 0.7,
                                            child: Icon(
                                              CupertinoIcons.search,
                                              size: 21,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {},
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          onEnter: (_) {
                                            setState(() {
                                              isExpanded = false;
                                              hoveredMenu = "bag";
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hoveredMenu = '';
                                            });
                                          },
                                          child: Opacity(
                                            opacity:
                                                hoveredMenu == "bag" ? 1 : 0.7,
                                            child: Icon(
                                              CupertinoIcons.bag,
                                              size: 21,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // SUBMENÚ
                            if (isExpanded && submenuItems.isNotEmpty)
                              _buildSubMenu(),
                          ],
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
    );
  }

  Widget _headerItem(String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isExpanded = true;
          hoveredMenu = label;
          submenuItems = submenus[label] ?? [];
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: hoveredMenu == label ? Colors.white : Colors.white70,
              fontWeight:
                  hoveredMenu == label ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenu() {
    return Container(
      width: 1024,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            submenuItems.first.entries.map((entry) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...entry.value.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  void _showCustomDialog(
    BuildContext context,
    String name,
    String description,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              insetPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.056,
                vertical: MediaQuery.of(context).size.height * 0.035,
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.056,
                      vertical: MediaQuery.of(context).size.height * 0.07,
                    ),
                    width: 1300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Theme.of(context).primaryColor.withAlpha(50),
                        //     borderRadius: BorderRadius.circular(16),
                        //   ),
                        //   width: double.infinity,
                        //   height: 500,
                        //   child: Row(
                        //     children: [
                        //       Expanded(child: Text("lorem")),
                        //       Expanded(
                        //         child: Container(
                        //           height: 300,
                        //           child: Image.asset(
                        //             "lib/src/img/RosaSharon_Shoshana.png",
                        //             fit: BoxFit.contain,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) {
                          setState(() {
                            hoveredMenu = "close";
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            hoveredMenu = "";
                          });
                        },
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color:
                                hoveredMenu == "close"
                                    ? Colors.white
                                    : Colors.white54,
                            size: 22,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
