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
  final String description;
  final double price;
  final List<NamedColor> colors;
  final List<String> valves;

  Product({
    required this.categoria,
    required this.subcategorie,
    required this.name,
    required this.description,
    required this.price,
    required this.colors,
    required this.valves,
  });
}

class Terminado {
  final String name;
  final List<Estructura> structures;

  Terminado({required this.name, required this.structures});
}

class Estructura {
  final String name;
  final List<Ability> ability;

  Estructura({required this.name, required this.ability});
}

class Ability {
  final String name;
  final List<Product> product;

  Ability({required this.name, required this.product});
}

final Map<String, List<Terminado>> productSections = {
  // SmartBag
  'SmartBag/4PRO': fourprosmartshop,
  'SmartBag/5PRO': fiveprosmartshop,
  'SmartBag/Doypack': doypacksmartshop,
  'SmartBag/Flowpack': flowpacksmartshop,
  // 'SmartBag/Standpack': standpacksmartshop,

  // EcoBag
  'EcoBag/4PRO': fourproecoshop,
  'EcoBag/5PRO': fourproecoshop,
  'EcoBag/Doypack': doypackecoshop,
  'EcoBag/Flowpack': flowpackecoshop,
};

// final List<Product> fourprosmartshop = [
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Barroco",
//     image: "assets/img/3DM/SmartBag/4PRO/Barroco.webp",
//     description:
//         "La Bolsa Barroco 4PRO trasciende el concepto de empaque: es una declaración de estilo. Inspirada en la riqueza visual del arte barroco, fusiona detalles ornamentales con un diseño contemporáneo que atrae desde el primer vistazo. Fabricada con materiales de alta resistencia, es ideal para productos premium como cafés gourmet o especias seleccionadas. Además de su estética refinada, ofrece funcionalidad avanzada: cuenta con opciones como válvula desgasificadora y peel stick en diversos colores para adaptarse perfectamente a la identidad visual de tu marca. Parte de la línea SmartBag®, esta bolsa combina distinción y practicidad, posicionándose como la elección ideal para quienes desean destacar con una presentación única y sofisticada. 🌟🎁",
//     price: 40000,
//     colors: [
//       NamedColor("Blanco", Color(0xfff7f5f6)),
//       NamedColor("Dorado", Color(0xfff1b62b)),
//       NamedColor("Negro", Color(0xff252223)),
//       NamedColor("Rojo", Color(0xffef2728)),
//     ],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Cobriza",
//     image: "assets/img/3DM/SmartBag/4PRO/Cobriza.webp",
//     description:
//         "La Bolsa Cobriza 4PRO captura la esencia de la elegancia rústica. Con su elegante color cobre y un diseño que combina lo clásico y lo moderno, esta bolsa está pensada para destacar. Ideal para marcas que buscan un empaque único y refinado, es perfecta para productos exclusivos. 🛍️ Fabricada con materiales de alta calidad, la Bolsa Cobriza ofrece características funcionales como válvula desgasificadora y peel stick, adaptándose a diversas necesidades de embalaje. Con opciones en acabados mate y brillante, podrás elegir la que mejor complemente la estética de tu marca. Parte de la línea SmartBag®, donde la distinción y la practicidad se encuentran en cada detalle. ",
//     price: 40000,
//     colors: [NamedColor("Cobre", Color(0xffA16546))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate", "Brillante"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Rosa de Sharon",
//     image: "assets/img/3DM/SmartBag/4PRO/Rosa_de_Sharon.webp",
//     description:
//         "La Bolsa Rosa de Sharon 4PRO es el equilibrio perfecto entre elegancia y frescura. Con colores suaves como Clavelina, Jade y Lovelia, esta bolsa aporta un toque romántico y delicado, ideal para marcas que buscan transmitir suavidad y distinción. 🌸 Perfecta para productos exclusivos y de alta gama, como cosméticos o alimentos gourmet, la Rosa de Sharon destaca por su resistencia y funcionalidad. Con opciones como válvula desgasificadora y peel stick, asegura que tu producto se mantenga fresco y seguro. Disponible en acabados mate, esta bolsa forma parte de la línea SmartBag®, donde la belleza se encuentra con la practicidad. ",
//     price: 40000,
//     colors: [
//       NamedColor("Clavelina", Color(0xffEFF3FF)),
//       NamedColor("Jade", Color(0xffC2D4D9)),
//       NamedColor("Lovelia", Color(0xff95CDE7)),
//       NamedColor("Margalit", Color(0xffE9E69F)),
//       NamedColor("Shoshana", Color(0xffAEA2CE)),
//       NamedColor("Vered", Color(0xffF8D8EC)),
//     ],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Bella",
//     image: "assets/img/3DM/SmartBag/4PRO/Bella.webp",
//     description:
//         "La SmartBag Bella 4PRO es la opción perfecta para quienes buscan un empaque elegante y funcional. Su diseño limpio y moderno, disponible en un sofisticado color blanco, es ideal para productos que requieren un toque de distinción. 🌟 Con opciones de estructura gruesa o delgada, esta bolsa se adapta a una amplia variedad de necesidades, asegurando la máxima protección para el contenido. Su acabado mate aporta un toque de sofisticación discreta, mientras que las opciones de válvula desgasificadora o sin válvula garantizan que tu producto se mantenga fresco y seguro. La SmartBag Bella es sinónimo de calidad, funcionalidad y estilo, perfecta para marcas que buscan destacar con un empaque premium. 🛍️",
//     price: 1234567,
//     colors: [NamedColor("Blanco", Color(0xffDBE3F5))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Costal",
//     image: "assets/img/3DM/SmartBag/4PRO/Costal.webp",
//     description:
//         "La SmartBag 4PRO Tipo Costal es la elección ideal para quienes buscan un empaque resistente y versátil, con un toque rústico y auténtico. Su diseño tipo costal, hecho con materiales de alta calidad, combina la funcionalidad con una estética única. Perfecta para productos de gran volumen o aquellos que requieren un empaque robusto, esta bolsa ofrece una protección superior, manteniendo la frescura y seguridad de los productos en todo momento. Disponible con opciones de válvula desgasificadora o sin válvula, y en acabados que refuerzan su aspecto natural, la SmartBag Tipo Costal es perfecta para marcas que buscan una presentación diferente y sólida, con un toque de distinción. 🌿🛍️",
//     price: 1234567,
//     colors: [NamedColor("Costal", Color(0xff7E553A))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Decembrina",
//     image: "assets/img/3DM/SmartBag/4PRO/Decembrina.webp",
//     description:
//         "La SmartBag Decembrina 4PRO es el empaque perfecto para capturar la esencia festiva de la temporada. Con un diseño inspirado en los colores y la magia de diciembre, esta bolsa es ideal para productos de temporada, regalos exclusivos o artículos de lujo. Su acabado elegante y resistente asegura que tu producto llegue con la mejor presentación, mientras que las opciones como válvula desgasificadora y acabados mate garantizan funcionalidad y frescura. Perfecta para marcas que buscan destacar durante las fiestas, la SmartBag Decembrina no solo ofrece estética, sino también la máxima calidad para tus productos. 🎄✨",
//     price: 1234567,
//     colors: [NamedColor("Rojo", Color(0xffED1C18))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Fuelle dorado",
//     image: "assets/img/3DM/SmartBag/4PRO/Fuelle_dorado.webp",
//     description:
//         "La SmartBag 4PRO con fuelle dorado es la opción ideal para marcas que buscan una presentación sofisticada y moderna sin perder de vista la sostenibilidad. Con su elegante fuelle dorado, esta bolsa no solo aporta un toque de lujo, sino que también está fabricada con materiales ecológicos, lo que la convierte en una solución responsable para el empaque de productos premium. Perfecta para alimentos gourmet, cosméticos de alta gama o artículos exclusivos, la SmartBag combina estilo y funcionalidad, brindando una alternativa que resalta el compromiso de tu marca con el medio ambiente. ✨",
//     price: 1234567,
//     colors: [NamedColor("Negro", Color(0xff070A08))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Grano café",
//     image: "assets/img/3DM/SmartBag/4PRO/Grano_café.webp",
//     description:
//         "La SmartBag Grano Café es la elección perfecta para aquellos que buscan un empaque elegante y funcional para productos de café de alta calidad. Su diseño innovador y su material ecológico garantizan una protección óptima para mantener la frescura del grano, mientras que su estilo moderno y sofisticado refleja la excelencia del producto que contiene. Ideal para marcas que buscan destacar en el mercado de cafés premium, la SmartBag ofrece una solución sostenible sin comprometer la presentación ni la funcionalidad. ☕✨",
//     price: 1234567,
//     colors: [NamedColor("Beige", Color(0xff7F593C))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Negra flor de café",
//     image: "assets/img/3DM/SmartBag/4PRO/Negra_flor_de_cafe.webp",
//     description:
//         "La SmartBag Negra Flor de Café es la opción perfecta para empaques sofisticados y de alta calidad para productos gourmet. Con su elegante diseño negro y un detalle especial de flor de café, esta bolsa transmite lujo y autenticidad. Fabricada con materiales ecológicos, ofrece una solución sostenible sin sacrificar el estilo ni la funcionalidad. Ideal para cafés premium, productos artesanales o cualquier artículo que requiera una presentación de alto nivel, la SmartBag Negra Flor de Café conserva la frescura y el aroma del producto, brindando una alternativa responsable y refinada. 🌸☕",
//     price: 1234567,
//     colors: [NamedColor("Negro", Color(0xff171818))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Odre",
//     image: "assets/img/3DM/SmartBag/4PRO/Odre.webp",
//     description:
//         "La SmartBag Odre es la opción ideal para quienes buscan un empaque de lujo con un toque sofisticado y rústico. Fabricada con materiales que imitan la textura del cuero, esta bolsa tiene un acabado elegante y resistente, perfecto para productos que requieren una presentación premium. Su diseño único combina la durabilidad con la estética, ofreciendo una solución ecológica que no compromete la calidad ni el estilo. Ideal para artículos exclusivos, cosméticos de alta gama o alimentos gourmet, la SmartBag Odre proporciona una protección excepcional y un empaque con carácter. 🌿✨",
//     price: 1234567,
//     colors: [
//       NamedColor("Verde Menta", Color(0xff438574)),
//       NamedColor("Azul Noche", Color(0xff3A5168)),
//       NamedColor("Blanca Mate", Color(0xffCEC9BD)),
//       NamedColor("Morado Real", Color(0xff663E52)),
//     ],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Pastel",
//     image: "assets/img/3DM/SmartBag/4PRO/Pastel.png",
//     description:
//         "La SmartBag Pastel es la elección perfecta para quienes buscan un empaque que combine elegancia y frescura en un solo producto. Con su acabado sofisticado que imita la textura del cuero, esta bolsa ofrece una presentación premium para productos exclusivos o cosméticos de alta gama. Su diseño delicado y sus colores suaves no solo aportan un aire moderno, sino que también brindan resistencia y durabilidad. Ideal para quienes desean destacar con un empaque único que también respeta el medio ambiente. 🌿",
//     price: 1234567,
//     colors: [
//       NamedColor("Jade", Color(0xffB0C0BE)),
//       NamedColor("Margalit", Color(0xffBABA81)),
//       NamedColor("Shoshana", Color(0xff9F94B9)),
//       NamedColor("Vered", Color(0xffB49CA3)),
//     ],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[0],
//     name: "Visos Dorados",
//     image: "assets/img/3DM/SmartBag/4PRO/Visos_dorados.webp",
//     description:
//         "La SmartBag con visos dorados es la opción ideal para quienes buscan un empaque que combine sofisticación y un toque de lujo. Con su acabado de alta calidad que imita la textura del cuero, esta bolsa destaca por sus detalles dorados que agregan un toque de elegancia y distinción. Perfecta para productos premium, cosméticos exclusivos o regalos especiales, ofrece tanto resistencia como un diseño único. Ideal para quienes desean destacar con un empaque elegante, moderno y que no pasa desapercibido. ✨",
//     price: 1234567,
//     colors: [NamedColor("Dorado", Color.fromARGB(255, 213, 162, 8))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
// ];
// final List<Product> fiveprosmartshop = [
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[1],
//     name: "Barroco",
//     image: "assets/img/3DM/SmartBag/5PRO/Barroco.webp",
//     description:
//         "La 5Pro SmartBag Barroco es una bolsa de diseño innovador que combina funcionalidad y estilo de manera excepcional. Su estructura robusta y acabados mate de alta calidad aseguran una durabilidad sin igual. Con un sistema de válvula desgasificadora opcional, esta bolsa mantiene tus productos frescos por más tiempo, mientras que su elegancia en blanco puro la convierte en una opción ideal para quienes buscan lo mejor en tecnología y moda. 🌟",
//     price: 1234567,
//     colors: [NamedColor("Blanco", Color(0xffEFF1F7))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[1],
//     name: "Unicolor",
//     image: "assets/img/3DM/SmartBag/5PRO/Unicolor.webp",
//     description:
//         "Un empaque que habla con sutileza y elegancia. La línea Unicolor de nuestra SmartBag 5PRO combina la tecnología de alto rendimiento con un diseño minimalista que resalta la pureza del color. Sin gráficos, sin ruido visual—solo una presencia sólida y sofisticada que potencia el valor de tu producto ✨. Ideal para marcas modernas que entienden que menos, a veces, es mucho más 🖤.",
//     price: 1234567,
//     colors: [NamedColor("Blanco", Color(0xffDDDBDD)), NamedColor("Negro", Color(0xff242425))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[1],
//     name: "Bottom flores",
//     image: "assets/img/3DM/SmartBag/5PRO/Bottom_flores.webp",
//     description:
//         "Donde la tecnología se encuentra con el arte. Nuestra SmartBag 5PRO en su versión Bottom Flores incorpora detalles florales sutiles en la base, añadiendo un toque distintivo y sofisticado sin comprometer la elegancia del diseño 🌸. Un empaque de alto rendimiento pensado para marcas que buscan destacar con estilo, carácter y una identidad visual única ✨.",
//     price: 1234567,
//     colors: [NamedColor("Negro", Color(0xff1D1E1F))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Mate"],
//   ),
// ];
// final List<Product> doypacksmartshop = [
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[2],
//     name: "Grano café",
//     image: "assets/img/3DM/SmartBag/Doypack/Grano_café.webp",
//     description:
//         "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
//     price: 1234566,
//     colors: [NamedColor("Beige", Color(0xff825F4A))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula"],
//     finishes: ["Mate"],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[2],
//     name: "Unicolor",
//     image: "assets/img/3DM/SmartBag/Doypack/Unicolor.webp",
//     description:
//         "La simplicidad que destaca. La SmartBag Doypack Unicolor ofrece un diseño limpio y moderno que se adapta a cualquier estilo de marca. Su superficie lisa y sin elementos gráficos transmite confianza, pureza y sofisticación visual ✨. Perfecta para productos premium que buscan una presentación sobria pero impactante, con la funcionalidad icónica del formato doypack 🖤.",
//     price: 1234566,
//     colors: [NamedColor("Negro", Color(0xff312F2D)), NamedColor("Blanco", Color(0xffE9E6E5))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula"],
//     finishes: ["Mate"],
//   ),
// ];
final List<Terminado> fourprosmartshop = [
  Terminado(
    name: "Mate",
    structures: [
      Estructura(
        name: "115G/m²",
        ability: [
          Ability(
            name: "50Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "70Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [
                  NamedColor("Azul Institucional", Colors.blue),
                  NamedColor("Blanco", Colors.white),
                  NamedColor("Dorado", Colors.amber),
                  NamedColor("Negro", Colors.amber),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "125Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor("Azul institucional", Colors.white),
                  NamedColor("Blanco", Colors.amber),
                  NamedColor("Decembrina Roja", Colors.amber),
                  NamedColor("Dorado", Colors.amber),
                  NamedColor("Grano de cafe beige", Colors.amber),
                  NamedColor("Grano de cafe rojo", Colors.amber),
                  NamedColor("Metalizada", Colors.amber),
                  NamedColor("Naranja", Colors.amber),
                  NamedColor("Negro", Colors.amber),
                  NamedColor("Roja lechosa", Colors.amber),
                  NamedColor("Roja holografica", Colors.amber),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
      Estructura(name: "84G/m²", ability: []),
    ],
  ),
  Terminado(name: "Brillante", structures: [Estructura(name: "101G/m²", ability: []), Estructura(name: "70G/m²", ability: [])]),
];

final List<Terminado> fiveprosmartshop = [
  Terminado(
    name: "Mate",
    structures: [
      Estructura(
        name: "115G/m²",
        ability: [
          Ability(
            name: "50Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "70Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [
                  NamedColor("Azul Institucional", Colors.blue),
                  NamedColor("Blanco", Colors.white),
                  NamedColor("Dorado", Colors.amber),
                  NamedColor("Negro", Colors.amber),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "125Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor("Azul institucional", Colors.white),
                  NamedColor("Blanco", Colors.amber),
                  NamedColor("Decembrina Roja", Colors.amber),
                  NamedColor("Dorado", Colors.amber),
                  NamedColor("Grano de cafe beige", Colors.amber),
                  NamedColor("Grano de cafe rojo", Colors.amber),
                  NamedColor("Metalizada", Colors.amber),
                  NamedColor("Naranja", Colors.amber),
                  NamedColor("Negro", Colors.amber),
                  NamedColor("Roja lechosa", Colors.amber),
                  NamedColor("Roja holografica", Colors.amber),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
      Estructura(name: "84G/m²", ability: []),
    ],
  ),
  Terminado(name: "Brillante", structures: [Estructura(name: "101G/m²", ability: []), Estructura(name: "70G/m²", ability: [])]),
];

final List<Terminado> doypacksmartshop = [
  Terminado(
    name: "Mate",
    structures: [
      Estructura(
        name: "132G/m²",
        ability: [
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[2],
                name: "Doypack",
                description:
                    "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
                price: 994.00,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[2],
                name: "Doypack",
                description:
                    "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
                price: 1188.00,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "1000Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[2],
                name: "Doypack",
                description:
                    "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
                price: 1946.00,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "2500Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[2],
                name: "Doypack",
                description:
                    "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
                price: 3208.00,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  Terminado(
    name: "Brillante",
    structures: [
      Estructura(
        name: "135G/m²",
        ability: [
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[2],
                name: "Doypack",
                description:
                    "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
                price: 970.00,
                colors: [NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[2],
                name: "Doypack",
                description:
                    "Inspirado en la esencia del café, este diseño evoca calidez, naturalidad y autenticidad. La SmartBag Doypack Grano Café resalta con su tono terroso y elegante, ideal para productos que quieren transmitir tradición y calidad artesanal ☕. Su estructura funcional y diseño refinado la convierten en la opción perfecta para marcas que valoran tanto la presentación como la protección de su contenido 🌰.",
                price: 1150.00,
                colors: [NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

final List<Terminado> flowpacksmartshop = [
  Terminado(
    name: "Mate",
    structures: [
      Estructura(
        name: "115G/m²",
        ability: [
          Ability(
            name: "50Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Diseño minimalista que potencia tu marca. Acabado mate, estructura ligera de 115G/m² y resistencia de 125Gr. Ideal para producción en alto volumen con estilo, protección y eficiencia ⚡🖤.",
                price: 554.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5)), NamedColor('Negro', Color(0xff000000))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "70Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Diseño minimalista que potencia tu marca. Acabado mate, estructura ligera de 115G/m² y resistencia de 125Gr. Ideal para producción en alto volumen con estilo, protección y eficiencia ⚡🖤.",
                price: 554.00,
                colors: [
                  NamedColor("Azul institucional", Colors.blue),
                  NamedColor('Blanco', Colors.white),
                  NamedColor('Dorado', Colors.amberAccent),
                  NamedColor('Naranja Holografico', Colors.orange),
                  NamedColor('Negro', Colors.black),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "125Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Diseño minimalista que potencia tu marca. Acabado mate, estructura ligera de 115G/m² y resistencia de 125Gr. Ideal para producción en alto volumen con estilo, protección y eficiencia ⚡🖤.",
                price: 554.00,
                colors: [
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor('Azul institucional', Colors.blueAccent),
                  NamedColor('Blanco', Colors.white),
                  NamedColor('Decembrina Roja', Colors.red),
                  NamedColor('Dorado', Colors.amber),
                  NamedColor('Grano de café beige', Colors.brown),
                  NamedColor('Grano de café rojo', Colors.red),
                  NamedColor('Metalizada', Colors.blueGrey),
                  NamedColor('Naranja', Colors.deepOrange),
                  NamedColor('Negro', Colors.black),
                  NamedColor('Roja lechosa', Colors.redAccent),
                  NamedColor('Roja holografica', Colors.red),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Impacto visual con acabado mate y estructura ligera de 115G/m². Su resistencia de 250Gr la hace perfecta para productos exigentes que necesitan protección sin perder estilo ni agilidad ⚡🤍.",
                price: 950.00,
                colors: [
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor('Azul institucional', Colors.blueAccent),
                  NamedColor('Barroco roja', Colors.red),
                  NamedColor('Blanca boca angosta', Colors.white),
                  NamedColor('Blanco', Colors.white),
                  NamedColor('Blanco mate perlado', Colors.white),
                  NamedColor('Bella blanca', Colors.white),
                  NamedColor('Costal', Colors.brown),
                  NamedColor('Decembrina Roja', Colors.red),
                  NamedColor('Dorado', Colors.amber),
                  NamedColor('Grano de café beige', Colors.brown),
                  NamedColor('Grano de café naranja', Colors.orange),
                  NamedColor('Metalizada', Colors.blueGrey),
                  NamedColor('Naranja', Colors.deepOrange),
                  NamedColor('Naranja leche', Colors.deepOrange),
                  NamedColor('Negra delgada', Colors.black),
                  NamedColor('Negro', Colors.black),
                  NamedColor('Pastel Jade (Verde)', Colors.green),
                  NamedColor('Pastel Margalit (Amarillo)', Colors.yellow),
                  NamedColor('Pastel Shoshana (Lila)', Colors.purpleAccent),
                  NamedColor('Pastel Vered (Rosado)', Colors.pinkAccent),
                  NamedColor('Roja lechosa', Colors.redAccent),
                  NamedColor('Roja holografica', Colors.red),
                  NamedColor('Roja', Colors.red),
                  NamedColor('Textura cuerdo morado oscuro', Colors.purple),
                  NamedColor('Verde Manzana', Colors.greenAccent),
                  NamedColor('Vino tinto', Colors.red),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "340Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Estilo limpio con máxima capacidad. Acabado mate y estructura de 115G/m² que conserva ligereza y aporta presencia. Ideal para cargas mayores sin perder estética ni eficiencia ⚡🤍.",
                price: 1102.00,
                colors: [
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor('Azul institucional', Colors.blueAccent),
                  NamedColor('Blanco', Colors.white),
                  NamedColor('Blanco mate perlado', Colors.white),
                  NamedColor('Beige', Colors.brown),
                  NamedColor('Naranja', Colors.deepOrange),
                  NamedColor('Negro', Colors.black),
                  NamedColor('Roja', Colors.red),
                  NamedColor('Textura cuerdo azul oscuro', Colors.blue),
                  NamedColor('Textura cuerdo morado oscuro', Colors.purple),
                  NamedColor('Textura cuerdo verde menta', Colors.greenAccent),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Estilo limpio con máxima capacidad. Acabado mate y estructura de 115G/m² que conserva ligereza y aporta presencia. Ideal para cargas mayores sin perder estética ni eficiencia ⚡🤍.",
                price: 1102.00,
                colors: [
                  NamedColor("Amarillo colombia", Colors.yellow),
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor('Azul institucional', Colors.blueAccent),
                  NamedColor('Barroco blanco', Colors.white),
                  NamedColor('Barroco dorada', Colors.amber),
                  NamedColor('Barroco negra', Colors.black),
                  NamedColor('Barroco roja', Colors.red),
                  NamedColor('Blanco', Colors.white),
                  NamedColor('Blanco mate perlado', Colors.white),
                  NamedColor('Beige', Colors.brown),
                  NamedColor('Bella blanca', Colors.white),
                  NamedColor('Bella cafe', Colors.brown),
                  NamedColor('Bella rojo', Colors.red),
                  NamedColor('Cafe oscuro', Colors.brown),
                  NamedColor('Costal', Colors.brown),
                  NamedColor('Curuba', Colors.orangeAccent),
                  NamedColor('Decembrina Roja', Colors.red),
                  NamedColor('Dorado', Colors.amber),
                  NamedColor('Dorado mate con visos', Colors.amber),
                  NamedColor('Negra con flores', Colors.black),

                  NamedColor('Negra delgada', Colors.black),
                  NamedColor('Negro', Colors.black),
                  NamedColor('Pastel Jade (Verde)', Colors.green),
                  NamedColor('Pastel Margalit (Amarillo)', Colors.yellow),
                  NamedColor('Pastel Shoshana (Lila)', Colors.purpleAccent),
                  NamedColor('Pastel Vered (Rosado)', Colors.pinkAccent),
                  NamedColor('Roja lechosa', Colors.redAccent),
                  NamedColor('Roja holografica', Colors.red),
                  NamedColor('Roja', Colors.red),
                  NamedColor('Textura cuerdo morado oscuro', Colors.purple),
                  NamedColor('Verde Manzana', Colors.greenAccent),
                  NamedColor('Vino tinto', Colors.red),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "2500Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 2689.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  Terminado(
    name: "Brillante",
    structures: [
      Estructura(
        name: "101G/m²",
        ability: [
          Ability(
            name: "50Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Metalizados",
                description:
                    "Brillante, audaz y memorable. La SmartBag Flowpack Metalizada eleva la presencia de tu producto con acabados en dorado o plateado que capturan miradas al instante. Su diseño ligero y eficiente está hecho para altos volúmenes, sin renunciar a la elegancia. Perfecta para marcas que quieren destacar en el punto de venta con un empaque moderno, dinámico y con mucha actitud ✨⚙️.",
                price: 384.08,
                colors: [NamedColor("Metalizado", Color(0xff8B8E8F))],

                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "70Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[4],
                name: "Metalizados",
                description:
                    "Brillante, audaz y memorable. La SmartBag Flowpack Metalizada eleva la presencia de tu producto con acabados en dorado o plateado que capturan miradas al instante. Su diseño ligero y eficiente está hecho para altos volúmenes, sin renunciar a la elegancia. Perfecta para marcas que quieren destacar en el punto de venta con un empaque moderno, dinámico y con mucha actitud ✨⚙️.",
                price: 384.08,
                colors: [NamedColor("Metalizado", Color(0xff8B8E8F)), NamedColor("Dorado", Color(0xffB39D00))],

                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  //
];

// final List<Product> standpacksmartshop = [
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[5],
//     name: "Fruta",
//     image: "assets/img/3DM/SmartBag/Standpack/Fruta.webp",
//     description:
//         "Fresco, funcional y totalmente visible. Este Standpack transparente pone el producto al centro, mostrando su frescura real sin filtros. Diseñado para destacar en estantería, su estructura resistente y práctica es ideal para frutas listas para llevar. Ligero, moderno y con una presentación limpia que conecta al instante con consumidores que valoran lo natural 🍓👀.",
//     price: 1234566,
//     colors: [NamedColor("Transparente", Colors.white)],
//     structures: ["Gruesa"],
//     valves: [],
//     finishes: [],
//   ),
//   Product(
//     categoria: categorieSmart,
//     subcategorie: subcategorieSmart[5],
//     name: "Pollo",
//     image: "assets/img/3DM/SmartBag/Standpack/Pollo.webp",
//     description:
//         "Resistente, práctico y con alto impacto visual. Este Standpack para pollo está diseñado para conservar, proteger y exhibir el producto con total seguridad. Su estructura gruesa asegura durabilidad y confianza, mientras que el diseño atractivo y directo potencia la visibilidad en góndola. Ideal para marcas que priorizan frescura, higiene y presencia sólida en el punto de venta 🔴🔥.",
//     price: 1234566,
//     colors: [NamedColor("Rojo", Colors.red)],
//     structures: ["Gruesa"],
//     valves: [],
//     finishes: [],
//   ),
// ];

final List<Terminado> doypackecoshop = [
  Terminado(
    name: "Papel",
    structures: [
      Estructura(
        name: "146G/m²",
        ability: [
          Ability(
            name: "125Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Doypack",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 554.00,
                colors: [NamedColor("Natural", Color(0xffB89267))],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Unicolor",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 950.00,
                colors: [NamedColor("Blanco", Color(0xffE9E6E5)), NamedColor("Natural", Color(0xffB89267))],

                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Unicolor",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 1102.00,
                colors: [NamedColor("Blanco", Color(0xffE9E6E5)), NamedColor("Natural", Color(0xffB89267))],

                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "1000Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Unicolor",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 1662.00,
                colors: [NamedColor("Natural", Color(0xffB89267))],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "2500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Unicolor",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 2689.00,
                colors: [NamedColor("Natural", Color(0xffB89267))],

                valves: ["Sin válvula"],
              ),
            ],
          ),
        ],
      ),
      Estructura(
        name: "141G/m²",
        ability: [
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Doypack",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 994.00,
                colors: [NamedColor("Blanco", Colors.white)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieEco[2],
                name: "Doypack",
                description:
                    "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
                price: 1188.00,
                colors: [NamedColor("Blanco", Colors.white)],
                valves: ["Sin válvula"],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

final List<Terminado> flowpackecoshop = [
  Terminado(
    name: "Papel",
    structures: [
      Estructura(
        name: "129G/m²",
        ability: [
          Ability(
            name: "70Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 384.08,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5)), NamedColor('Natural', Color(0xffAF7F53))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "125Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 554.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5)), NamedColor('Natural', Color(0xffAF7F53))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 950.00,
                colors: [NamedColor('Natural', Color(0xffAF7F53))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 1102.00,
                colors: [NamedColor('Natural', Color(0xffAF7F53))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "1000Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 1662.00,
                colors: [NamedColor('Natural', Color(0xffAF7F53))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "2500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 2689.00,
                colors: [NamedColor('Natural', Color(0xffAF7F53))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
      Estructura(
        name: "124G/m²",
        ability: [
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 1102.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
      Estructura(
        name: "135G/m²",
        ability: [
          Ability(
            name: "250Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 950.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "340Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 997.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "500Gr",
            product: [
              Product(
                categoria: categorieEco,
                subcategorie: subcategorieSmart[4],
                name: "Unicolor",
                description:
                    "Limpio, directo y visualmente impactante. La SmartBag Flowpack Unicolor destaca por su diseño minimalista que potencia la identidad de tu marca desde el primer vistazo. Su estructura ligera y eficiente está pensada para altos volúmenes de producción sin perder estilo. Ideal para productos dinámicos que requieren agilidad, protección y una estética moderna ⚡🖤.",
                price: 1102.00,
                colors: [NamedColor("Blanco", Color(0xffDCE4F5))],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

final List<Terminado> fourproecoshop = [
  Terminado(
    name: "Mate",
    structures: [
      Estructura(
        name: "115G/m²",
        ability: [
          Ability(
            name: "50Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [NamedColor("Blanco", Colors.white), NamedColor("Negro", Colors.black)],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "70Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [
                  NamedColor("Azul Institucional", Colors.blue),
                  NamedColor("Blanco", Colors.white),
                  NamedColor("Dorado", Colors.amber),
                  NamedColor("Negro", Colors.amber),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
          Ability(
            name: "125Gr",
            product: [
              Product(
                categoria: categorieSmart,
                subcategorie: subcategorieSmart[0],
                name: "Unicolor",
                description: "",
                price: 384.08,
                colors: [
                  NamedColor("Azul aguamarina", Colors.blue),
                  NamedColor("Azul institucional", Colors.white),
                  NamedColor("Blanco", Colors.amber),
                  NamedColor("Decembrina Roja", Colors.amber),
                  NamedColor("Dorado", Colors.amber),
                  NamedColor("Grano de cafe beige", Colors.amber),
                  NamedColor("Grano de cafe rojo", Colors.amber),
                  NamedColor("Metalizada", Colors.amber),
                  NamedColor("Naranja", Colors.amber),
                  NamedColor("Negro", Colors.amber),
                  NamedColor("Roja lechosa", Colors.amber),
                  NamedColor("Roja holografica", Colors.amber),
                ],
                valves: ["Sin válvula", "Válvula desgasificadora"],
              ),
            ],
          ),
        ],
      ),
      Estructura(name: "84G/m²", ability: []),
    ],
  ),
  Terminado(name: "Brillante", structures: [Estructura(name: "101G/m²", ability: []), Estructura(name: "70G/m²", ability: [])]),
];

// final List<Product> fourproecoshop = [
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[0],
//     name: "Barroco",
//     description:
//         "La EcoBag Barroco Kraft 4PRO es el empaque ideal para quienes buscan una opción ecológica sin comprometer la elegancia. Con su diseño inspirado en el estilo barroco, esta bolsa combina la calidez del kraft con una estética sofisticada, perfecta para productos que requieren un toque natural pero refinado. 🌿 Disponible en colores Kraft y Blanco, ofrece una estructura gruesa que asegura la protección del contenido, mientras que su acabado en papel refuerza su carácter ecológico. Además, puedes elegir entre opciones funcionales como válvula desgasificadora o sin válvula, adaptándose a las necesidades de tu producto. Con la EcoBag Barroco, estarás contribuyendo al cuidado del medio ambiente sin perder la distinción. 🌱",
//     image: "assets/img/3DM/EcoBag/4PRO/Barroco.webp",
//     price: 34690,
//     colors: [NamedColor("Kraft", (Color(0xffA87B50))), NamedColor("Blanco", Color(0xffB4A39B))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[0],
//     name: "Costal",
//     image: "assets/img/3DM/EcoBag/4PRO/Costal.webp",
//     description:
//         "La EcoBag 4PRO es el empaque ideal para marcas que buscan una opción sostenible sin sacrificar calidad. Con un diseño ecológico y funcional, esta bolsa está fabricada con materiales amigables con el medio ambiente, ofreciendo una alternativa responsable para productos de diversas categorías. Su resistencia y versatilidad la hacen perfecta para productos orgánicos, alimentos gourmet, o cualquier artículo que requiera un empaque práctico y ecológico. Con opciones como válvula desgasificadora y acabados en mate, la EcoBag se adapta perfectamente a las necesidades de tu marca, brindando una opción de empaque que destaca por su compromiso con el planeta. 🌱♻️",
//     price: 1234567,
//     colors: [NamedColor("Costal", Color(0xff7E553A))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[0],
//     name: "Envejecida",
//     image: "assets/img/3DM/EcoBag/4PRO/Envejecida.png",
//     description:
//         "La EcoBag 4PRO Bolsa Envejecida es la opción perfecta para marcas que desean transmitir un estilo vintage y ecológico al mismo tiempo. Con su acabado envejecido, esta bolsa no solo tiene una estética única, sino que también está hecha de materiales sostenibles, lo que la convierte en una alternativa responsable para envases de productos variados. Ideal para productos gourmet, artículos artesanales o cualquier artículo que se beneficie de un toque de distinción natural. La EcoBag mantiene su funcionalidad sin comprometer el respeto por el medio ambiente, ofreciendo un empaque robusto y estilizado. 🌍",
//     price: 1234567,
//     colors: [NamedColor("Café", Color(0xffAA714A))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[0],
//     name: "Grano café",
//     image: "assets/img/3DM/EcoBag/4PRO/Grano_café.webp",
//     description:
//         "La EcoBag Grano Café es una opción ecológica y responsable para empacar granos de café frescos y de calidad. Fabricada con materiales amigables con el medio ambiente, esta bolsa conserva la frescura y el aroma del café gracias a su diseño práctico y eficiente. Su acabado rústico y su compromiso con la sostenibilidad la convierten en la opción ideal para marcas que quieren ofrecer un producto natural y ecológico, sin perder la esencia de un buen café. 🌱☕",
//     price: 1234567,
//     colors: [NamedColor("Beige", Color(0xff7F593C))],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[0],
//     name: "Kraft",
//     image: "assets/img/3DM/EcoBag/4PRO/Kraft.webp",
//     description:
//         "La EcoBag Kraft es la opción perfecta para marcas que buscan una alternativa ecológica y robusta para sus productos. Fabricada con materiales reciclables y de alta calidad, esta bolsa destaca por su acabado kraft natural, que le da un toque rústico y auténtico. Ideal para todo tipo de productos, desde alimentos orgánicos hasta artículos artesanales, la EcoBag Kraft combina funcionalidad y estética, asegurando una protección óptima y un impacto mínimo en el medio ambiente. Con su diseño resistente y su compromiso con la sostenibilidad, es la elección ideal para marcas que valoran la naturaleza. 🌿",
//     price: 1234567,
//     colors: [
//       NamedColor("Blanco", Color(0xffD0B8A5)),
//       NamedColor("Natural", Color(0xffB48758)),
//       NamedColor("Negro", Color(0xff0A0A0A)),
//       NamedColor("Rojo", Color(0xffA3231C)),
//       NamedColor("Verde Oliva", Color(0xff3A421D)),
//     ],
//     structures: ["Gruesa", "Delgada"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
// ];
// final List<Product> fiveproecoshop = [
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[1],
//     name: "Unicolor",
//     image: "assets/img/3DM/EcoBag/5PRO/Unicolor.webp",
//     description:
//         "Un diseño limpio que refleja un compromiso auténtico con el planeta. La línea Unicolor de nuestra EcoBag combina estética minimalista con conciencia ecológica ♻️. Sin elementos distractores, este empaque liso y elegante resalta tu producto con sobriedad y respeto por el entorno. Ideal para marcas que apuestan por lo esencial, lo funcional y lo sustentable 🌱.",
//     price: 1234567,
//     colors: [NamedColor("Blanco", Color(0xffCEB6A5)), NamedColor("Natural", Color(0xffAA8057))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
// ];
// final List<Product> doypackecoshop = [
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[2],
//     name: "Unicolor",
//     image: "assets/img/3DM/EcoBag/Doypack/Unicolor.webp",
//     description:
//         "Sencillez con propósito. La EcoBag Doypack Unicolor combina un diseño minimalista con una actitud consciente hacia el planeta 🌱. Su acabado limpio y uniforme refleja modernidad y compromiso ecológico, ideal para marcas que valoran lo esencial sin renunciar al estilo. Un empaque que transmite confianza, pureza y responsabilidad en cada detalle ♻️.",
//     price: 1234566,
//     colors: [NamedColor("Negro", Color(0xff312F2D)), NamedColor("Blanco", Color(0xffE9E6E5)), NamedColor("Natural", Color(0xffB89267))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula"],
//     finishes: ["Papel"],
//   ),
// ];
// final List<Product> flowpackecoshop = [
//   Product(
//     categoria: categorieEco,
//     subcategorie: subcategorieEco[4],
//     name: "Unicolor",
//     image: "assets/img/3DM/EcoBag/Flowpack/Natural.webp",
//     description:
//         "Natural, simple y con propósito. La EcoBag Flowpack Unicolor combina diseño minimalista con materiales responsables que transmiten autenticidad desde el primer vistazo. Su estructura ligera pero resistente está diseñada para grandes volúmenes sin sacrificar el compromiso ambiental. Perfecta para marcas que buscan un empaque funcional, moderno y alineado con valores sostenibles 🌱🤎.",
//     price: 1234566,
//     colors: [NamedColor("Blanco", Color(0xffBEB0AB)), NamedColor("Natural", Color(0xffA7794F))],
//     structures: ["Gruesa"],
//     valves: ["Sin válvula", "Válvula desgasificadora"],
//     finishes: ["Papel"],
//   ),
// ];
