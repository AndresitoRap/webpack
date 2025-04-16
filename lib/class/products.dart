import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';

class Product {
  final Categoria categoria;
  final Subcategorie subcategorie;
  final String name;
  final String image;
  final String description;
  final String price;
  final List<Color> colors;

  Product({
    required this.categoria,
    required this.subcategorie,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.colors,
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
    image: "lib/src/img/smartbag/4pro.webp",
    description: "",
    price: "34.690",
    colors: [
      Colors.white,
      Color(0xffd0dfd8),
      Color(0xffa1d8e6),
      Color(0xffefea9b),
      Color(0xffc3b3d9),
      Color(0xfff5d4d7),
    ],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Barroco",
    image: "lib/src/img/smartbag/4pro.webp",
    description: "",
    price: "37.900",
    colors: [Colors.white, Colors.black, Color(0xffeeb311), Color(0xffda2727)],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Bella",
    image: "lib/src/img/smartbag/4pro.webp",
    description: "",
    price: "39.900",
    colors: [Colors.orange, Colors.amber, Colors.yellow, Colors.brown],
  ),
];

final List<Product> pPFourEco = [
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Eco",
    image: "lib/src/img/smartbag/4pro.webp",
    description: "",
    price: "34.690",
    colors: [Colors.white, Color(0xffd0dfd8), Color(0xffa1d8e6)],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Barroco",
    image: "lib/src/img/smartbag/4pro.webp",
    description: "",
    price: "37.900",
    colors: [Colors.white, Colors.black, Color(0xffeeb311), Color(0xffda2727)],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Bella",
    image: "lib/src/img/smartbag/4pro.webp",
    description: "",
    price: "39.900",
    colors: [Colors.orange, Colors.amber, Colors.yellow, Colors.brown],
  ),
];

final List<Product> fourprosmartshop = [
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Rosa de Sharon",
    description:
        "La Bolsa Rosa de Sharon 4PRO de 500g es la combinación perfecta de elegancia, funcionalidad y resistencia. Su acabado mate realza la presentación de cualquier producto, mientras que su estructura de alta calidad garantiza una excelente conservación. Ideal para cafés especiales, productos gourmet o marcas que buscan destacar, esta bolsa admite opciones como válvula desgasificadora y peel stick en múltiples colores (negro, dorado, kraft, rojo, verde, blanco), permitiéndote personalizarla según tu identidad visual. Disponible dentro de nuestra línea SmartBag®, la 4PRO Rosa de Sharon se adapta a las exigencias del mercado moderno sin perder estilo. 🌸",
    image: "lib/src/img/smartbag/4pro.webp",
    price: "34.690",
    colors: [
      Colors.white,
      Color(0xffd0dfd8),
      Color(0xffa1d8e6),
      Color(0xffefea9b),
      Color(0xffc3b3d9),
      Color(0xfff5d4d7),
    ],
  ),
];

final List<Product> fourproecoshop = [
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[2],
    name: "Kraft natural",
    description:
        "Bolsa 4PRO Kraft Natural. Autenticidad, funcionalidad y sostenibilidad en un solo empaque. Esta bolsa tipo 4PRO está elaborada con papel kraft natural, ideal para marcas que buscan destacar su compromiso ecológico sin sacrificar estilo ni calidad. Su diseño robusto y su acabado mate transmiten naturalidad y elegancia en cualquier presentación. Disponible en múltiples capacidades (de 70g a 2500g), puedes personalizarla con válvula desgasificadora y peel stick en distintos colores como negro, kraft, dorado o verde. Perfecta para cafés orgánicos, productos a granel o alimentos sostenibles, forma parte de nuestra línea EcoBag®, pensada para un mundo más consciente 🌱",
    image: "lib/src/img/ecobag/4pro.webp",
    price: "34.690",
    colors: [Color(0xffcca87b)],
  ),
];
