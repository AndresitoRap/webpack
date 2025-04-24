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
        "La Bolsa Barroco 4PRO trasciende el concepto de empaque: es una declaración de estilo. Inspirada en la riqueza visual del arte barroco, fusiona detalles ornamentales con un diseño contemporáneo que atrae desde el primer vistazo. Fabricada con materiales de alta resistencia, es ideal para productos premium como cafés gourmet o especias seleccionadas. Además de su estética refinada, ofrece funcionalidad avanzada: cuenta con opciones como válvula desgasificadora y peel stick en diversos colores para adaptarse perfectamente a la identidad visual de tu marca. Parte de la línea SmartBag®, esta bolsa combina distinción y practicidad, posicionándose como la elección ideal para quienes desean destacar con una presentación única y sofisticada. 🌟🎁",
    price: 40000,
    colors: [
      NamedColor("Blanco", Color(0xfff7f5f6)),
      NamedColor("Dorado", Color(0xfff1b62b)),
      NamedColor("Negro", Color(0xff252223)),
      NamedColor("Rojo", Color(0xffef2728)),
    ],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Mate"],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Cobriza",
    image: "assets/img/3DM/SmartBag/4PRO/Cobriza.webp",
    description:
        "La Bolsa Cobriza 4PRO captura la esencia de la elegancia rústica. Con su elegante color cobre y un diseño que combina lo clásico y lo moderno, esta bolsa está pensada para destacar. Ideal para marcas que buscan un empaque único y refinado, es perfecta para productos exclusivos. 🛍️ Fabricada con materiales de alta calidad, la Bolsa Cobriza ofrece características funcionales como válvula desgasificadora y peel stick, adaptándose a diversas necesidades de embalaje. Con opciones en acabados mate y brillante, podrás elegir la que mejor complemente la estética de tu marca. Parte de la línea SmartBag®, donde la distinción y la practicidad se encuentran en cada detalle. ",
    price: 40000,
    colors: [NamedColor("Cobre", Color(0xffA16546))],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Mate", "Brillante"],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Rosa de Sharon",
    image: "assets/img/3DM/SmartBag/4PRO/Rosa_de_Sharon.webp",
    description:
        "La Bolsa Rosa de Sharon 4PRO es el equilibrio perfecto entre elegancia y frescura. Con colores suaves como Clavelina, Jade y Lovelia, esta bolsa aporta un toque romántico y delicado, ideal para marcas que buscan transmitir suavidad y distinción. 🌸 Perfecta para productos exclusivos y de alta gama, como cosméticos o alimentos gourmet, la Rosa de Sharon destaca por su resistencia y funcionalidad. Con opciones como válvula desgasificadora y peel stick, asegura que tu producto se mantenga fresco y seguro. Disponible en acabados mate, esta bolsa forma parte de la línea SmartBag®, donde la belleza se encuentra con la practicidad. ",
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
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Mate"],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Bella",
    image: "assets/img/3DM/SmartBag/4PRO/Bella.webp",
    description:
        "La SmartBag Bella 4PRO es la opción perfecta para quienes buscan un empaque elegante y funcional. Su diseño limpio y moderno, disponible en un sofisticado color blanco, es ideal para productos que requieren un toque de distinción. 🌟 Con opciones de estructura gruesa o delgada, esta bolsa se adapta a una amplia variedad de necesidades, asegurando la máxima protección para el contenido. Su acabado mate aporta un toque de sofisticación discreta, mientras que las opciones de válvula desgasificadora o sin válvula garantizan que tu producto se mantenga fresco y seguro. La SmartBag Bella es sinónimo de calidad, funcionalidad y estilo, perfecta para marcas que buscan destacar con un empaque premium. 🛍️",
    price: 1234567,
    colors: [NamedColor("Blanco", Color(0xffDBE3F5))],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Mate"],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Costal",
    image: "assets/img/3DM/SmartBag/4PRO/Costal.webp",
    description:
        "La SmartBag 4PRO Tipo Costal es la elección ideal para quienes buscan un empaque resistente y versátil, con un toque rústico y auténtico. Su diseño tipo costal, hecho con materiales de alta calidad, combina la funcionalidad con una estética única. Perfecta para productos de gran volumen o aquellos que requieren un empaque robusto, esta bolsa ofrece una protección superior, manteniendo la frescura y seguridad de los productos en todo momento. Disponible con opciones de válvula desgasificadora o sin válvula, y en acabados que refuerzan su aspecto natural, la SmartBag Tipo Costal es perfecta para marcas que buscan una presentación diferente y sólida, con un toque de distinción. 🌿🛍️",
    price: 1234567,
    colors: [NamedColor("Costal", Color(0xff7E553A))],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Mate"],
  ),
];

final List<Product> fourproecoshop = [
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Barroco",
    description:
        "La EcoBag Barroco Kraft 4PRO es el empaque ideal para quienes buscan una opción ecológica sin comprometer la elegancia. Con su diseño inspirado en el estilo barroco, esta bolsa combina la calidez del kraft con una estética sofisticada, perfecta para productos que requieren un toque natural pero refinado. 🌿 Disponible en colores Kraft y Blanco, ofrece una estructura gruesa que asegura la protección del contenido, mientras que su acabado en papel refuerza su carácter ecológico. Además, puedes elegir entre opciones funcionales como válvula desgasificadora o sin válvula, adaptándose a las necesidades de tu producto. Con la EcoBag Barroco, estarás contribuyendo al cuidado del medio ambiente sin perder la distinción. 🌱",
    image: "assets/img/3DM/EcoBag/4PRO/Barroco.webp",
    price: 34690,
    colors: [NamedColor("Kraft", (Color(0xffA87B50))), NamedColor("Blanco", Color(0xffB4A39B))],
    structures: ["Gruesa"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Papel"],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieSmart[0],
    name: "Costal",
    image: "assets/img/3DM/EcoBag/4PRO/Costal.webp",
    description:
        "La EcoBag 4PRO es el empaque ideal para marcas que buscan una opción sostenible sin sacrificar calidad. Con un diseño ecológico y funcional, esta bolsa está fabricada con materiales amigables con el medio ambiente, ofreciendo una alternativa responsable para productos de diversas categorías. Su resistencia y versatilidad la hacen perfecta para productos orgánicos, alimentos gourmet, o cualquier artículo que requiera un empaque práctico y ecológico. Con opciones como válvula desgasificadora y acabados en mate, la EcoBag se adapta perfectamente a las necesidades de tu marca, brindando una opción de empaque que destaca por su compromiso con el planeta. 🌱♻️",
    price: 1234567,
    colors: [NamedColor("Costal", Color(0xff7E553A))],
    structures: ["Gruesa", "Delgada"],
    valves: ["Sin válvula", "Válvula desgasificadora"],
    finishes: ["Mate"],
  ),
];
