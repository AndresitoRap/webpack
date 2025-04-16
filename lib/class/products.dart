import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';

class Product {
  final Categoria categoria;
  final Subcategorie subcategorie;
  final String name;
  final String image;
  final String price;
  final List<Color> colors;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.colors,
    required this.categoria,
    required this.subcategorie,
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
    price: "37.900",
    colors: [Colors.white, Colors.black, Color(0xffeeb311), Color(0xffda2727)],
  ),
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Bella",
    image: "lib/src/img/smartbag/4pro.webp",
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
    price: "34.690",
    colors: [Colors.white, Color(0xffd0dfd8), Color(0xffa1d8e6)],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Barroco",
    image: "lib/src/img/smartbag/4pro.webp",
    price: "37.900",
    colors: [Colors.white, Colors.black, Color(0xffeeb311), Color(0xffda2727)],
  ),
  Product(
    categoria: categorieEco,
    subcategorie: subcategorieEco[0],
    name: "Bella",
    image: "lib/src/img/smartbag/4pro.webp",
    price: "39.900",
    colors: [Colors.orange, Colors.amber, Colors.yellow, Colors.brown],
  ),
];

final List<Product> fourprosmartshop = [
  Product(
    categoria: categorieSmart,
    subcategorie: subcategorieSmart[0],
    name: "Rosa de Sharon",
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
    subcategorie: subcategorieEco[1],
    name: "Barroco kraft",
    image: "lib/src/img/ecobag/4pro.webp",
    price: "34.690",
    colors: [Color(0xffcca87b)],
  ),
];
