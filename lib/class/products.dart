import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class PeelStickOption {
  final String name;
  final Color color;
  final String abbreviation;

  PeelStickOption(this.name, this.color, this.abbreviation);
}

final List<PeelStickOption> peelStickOptions = [
  PeelStickOption("Sin Peel Stick", Colors.transparent, "TR"),
  PeelStickOption("Blanco", Colors.white, "BL"),
  PeelStickOption("Beige", const Color(0xffa08454), "BG"),
  PeelStickOption("Cobre", const Color(0xff502c1c), "CB"),
  PeelStickOption("Dorado", const Color(0xffccab2f), "DR"),
  PeelStickOption("Negro", Colors.black, "NG"),
  PeelStickOption("Rojo", const Color(0xffb80424), "RJ"),
  PeelStickOption("Verde", const Color(0xff083c2c), "VR"),
];

class Product {
  final Categoria categoria;
  final Subcategorie subcategorie;
  final String name;
  final String image;
  final String description;
  final int price;
  final List<NamedColor> colors;
  final List<String> structures;
  final List<String> valves;
  final List<String> finishes;

  Product({
    required this.categoria,
    required this.subcategorie,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.colors,
    required this.structures,
    required this.valves,
    required this.finishes,
  });
}

final Map<String, List<Product>> productSections = {
  // SmartBag
  'SmartBag/4PRO': fourprosmartshop,
  // 'SmartBag/5PRO': fiveprosmartshop,
  // 'SmartBag/FlowPack': flowpacksmartshop,
  // 'SmartBag/DoyPack': doypacksmartshop,

  // EcoBag
  'EcoBag/4PRO': fourproecoshop,
  // 'EcoBag/5PRO': fiveproecoshop,
  // 'EcoBag/FlowPack': flowpackecoshop,
  // 'EcoBag/DoyPack': doypackecoshop,
};
final Map<String, List<Product>> productPreferid = {
  // SmartBag
  'SmartBag/4PRO': pPFourSmart,
  // 'SmartBag/5PRO': fiveprosmartshop,
  // 'SmartBag/FlowPack': flowpacksmartshop,
  // 'SmartBag/DoyPack': doypacksmartshop,

  // EcoBag
  'EcoBag/4PRO': pPFourEco,
  // 'EcoBag/5PRO': fiveproecoshop,
  // 'EcoBag/FlowPack': flowpackecoshop,
  // 'EcoBag/DoyPack': doypackecoshop,
};

final List<Product> pPFourSmart = [
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Rosa de Sharon",
    image: "assets/img/smartbag/4pro.webp",
    description: "",
    price: 34690,
    colors: [NamedColor("Clavelina", Colors.white)],
    structures: [],
    valves: [],
    finishes: [],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Barroco",
    image: "assets/img/smartbag/4pro.webp",
    description: "",
    price: 37900,
    colors: [NamedColor("Clavelina", Colors.white)],
    structures: [],
    valves: [],
    finishes: [],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Bella",
    image: "assets/img/smartbag/4pro.webp",
    description: "",
    price: 39900,
    colors: [NamedColor("Clavelina", Colors.white)],
    structures: [],
    valves: [],
    finishes: [],
  ),
];

final List<Product> pPFourEco = [
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Eco",
    image: "assets/img/smartbag/4pro.webp",
    description: "",
    price: 34690,
    colors: [NamedColor("Clavelina", Colors.white)],
    structures: [],
    valves: [],
    finishes: [],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Barroco",
    image: "assets/img/smartbag/4pro.webp",
    description: "",
    price: 37900,
    colors: [NamedColor("Clavelina", Colors.white)],
    structures: [],
    valves: [],
    finishes: [],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Bella",
    image: "assets/img/smartbag/4pro.webp",
    description: "",
    price: 39900,
    colors: [NamedColor("Clavelina", Colors.white)],
    structures: [],
    valves: [],
    finishes: [],
  ),
];

final List<Product> fourprosmartshop = [
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Barroco",
    image: "assets/img/3DM/SmartBag/4PRO/Barroco.webp",
    description:
        "✨ La Bolsa Barroco 4PRO es mucho más que un empaque, ¡es una obra de arte! 🎨 Inspirada en el lujo del estilo barroco, combina detalles ornamentales con una estética moderna que cautiva a primera vista. 🌟 Hecha con materiales de alta resistencia, es perfecta para productos exclusivos como cafés gourmet ☕️ o especias finas 🌿. Su diseño no solo es elegante, sino también funcional. Con opciones como válvula desgasificadora y peel stick en varios colores, se adapta a la perfección a la estética de tu marca. 🎁 Parte de la línea SmartBag®, esta bolsa une distinción y practicidad, ofreciendo el empaque ideal para quienes buscan destacar con un toque único. 🌹",
    price: 40000,
    colors: [
      NamedColor("Blanco", Color(0xfff7f5f6)),
      NamedColor("Dorado", Color(0xfff1b62b)),
      NamedColor("Negro", Color(0xff252223)),
      NamedColor("Rojo", Color(0xffef2728)),
    ],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula dosificadora"],
    finishes: ["Mate"],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Cobriza",
    image: "assets/img/3DM/SmartBag/4PRO/Cobriza.webp",
    description:
        "✨ La Bolsa Cobriza 4PRO es la esencia de la elegancia rústica. 🌿 Con su hermoso color cobre y un diseño que refleja la sofisticación de lo clásico y lo moderno, esta bolsa está hecha para destacar. Perfecta para marcas que buscan un empaque único y refinado, ideal para productos exclusivos. 🛍️ Fabricada con materiales de alta calidad, la Cobriza ofrece opciones funcionales como válvula dosificadora y peel stick, adaptándose a diferentes necesidades de embalaje. Disponibles en acabados mate y brillante, puedes elegir la opción que mejor complemente la estética de tu marca. 🌟 Parte de la línea SmartBag®, donde la distinción se encuentra con la practicidad. 🎁",
    price: 40000,
    colors: [NamedColor("Cobre", Color(0xffA16546))],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula dosificadora"],
    finishes: ["Mate", "Brillante"],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Rosa de Sharon",
    image: "assets/img/3DM/SmartBag/4PRO/Rosa_de_Sharon.webp",
    description:
        "🌸 La Bolsa Rosa de Sharon 4PRO es un despliegue de elegancia y frescura. 🌷 Con una paleta de colores suaves como Clavelina, Jade y Lovelia, esta bolsa aporta un toque romántico y delicado, perfecta para marcas que buscan transmitir suavidad y distinción. 🌟 Ideal para productos exclusivos y de alta gama, como cosméticos o alimentos gourmet, la Rosa de Sharon destaca por su resistencia y funcionalidad. 🛍️ Ofrece opciones como válvula dosificadora y peel stick, para asegurar que tu producto se mantenga fresco y seguro. Disponible en acabados mate, esta bolsa es parte de la línea SmartBag®, donde la belleza se une a la practicidad. 🎁",
    price: 40000,
    colors: [
      NamedColor("Clavelina", Color(0xffEFF3FF)),
      NamedColor("Jade", Color(0xffC2D4D9)),
      NamedColor("Lovelia", Color(0xff95CDE7)),
      NamedColor("Margalit", Color(0xffE9E69F)),
      NamedColor("Shoshana", Color(0xffAEA2CE)),
      NamedColor("Vered", Color(0xffF8D8EC)),
    ],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula dosificadora"],
    finishes: ["Mate"],
  ),
];

final List<Product> fourproecoshop = [
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Barroco",
    description: "Barroco Kraft",
    image: "assets/img/3DM/EcoBag/4PRO/Barroco.webp",
    price: 34690,
    colors: [NamedColor("Kraft", (Color(0xffA87B50))), NamedColor("Blanco", Color(0xffB4A39B))],
    structures: ["Gruesa"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Papel"],
  ),
];
