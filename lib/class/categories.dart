import 'dart:ui';

class Categoria {
  final String name;
  final Color color;

  Categoria({required this.name, required this.color});
}

final Categoria categorieSmart = Categoria(name: "SmartBag", color: const Color(0xFF004F9E));

final Categoria categorieEco = Categoria(name: "EcoBag", color: const Color(0xff4b8d2c));

class Subcategorie {
  final String? clipArt;
  final Categoria category;
  final String img;
  final String title;
  final String description;
  final String sdescription;
  final String infoBuild;
  final String route;
  final bool enabledPS;
  final bool enabled;

  Subcategorie({
    this.clipArt,
    required this.category,
    required this.img,
    required this.title,
    required this.description,
    required this.sdescription,
    required this.infoBuild,
    required this.route,
    this.enabledPS = false,
    this.enabled = true,
  });
}

final List<Subcategorie> subcategorieSmart = [
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_4pro.svg",
    category: categorieSmart,
    img: "img/smartbag/Costal.webp",
    title: "4PRO",
    description: "La bolsa que redefine la presentación de su producto.",
    sdescription: " Ideal para cafés de especialidad o alimentos selectos, la 4PRO ofrece frescura, distinción y una estética impecable. ",
    infoBuild:
        "🌟 La 4PRO es una bolsa de alta gama diseñada para productos que exigen elegancia, funcionalidad y conservación superior. Su estructura multilaminada le brinda una resistencia excepcional, ideal para cafés premium, superfoods, productos gourmet o suplementos nutricionales. 💪 Cuenta con un diseño de base estable que permite que se mantenga en pie, facilitando su exhibición en estanterías. Puede incorporar válvula desgasificadora, zipper resellable y acabados mate o brillantes que proyectan una imagen sofisticada y moderna. Gracias a su excelente barrera contra humedad, oxígeno y luz, la 4PRO mantiene la frescura y propiedades del contenido por más tiempo. Es la opción perfecta para marcas que buscan diferenciarse con un empaque funcional y visualmente impactante. ✨",
    route: "/SmartBag/Explora-SmartBag/4PRO",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_5pro.svg",
    category: categorieSmart,
    img: "img/smartbag/5pro.webp",
    title: "5PRO",
    description: "La evolución del empaque flexible.",
    sdescription: "Tecnología de cinco capas para una protección superior, sellado perfecto y una presencia inigualable que realza su producto. ",
    infoBuild: "",
    route: "/SmartBag/Explora-SmartBag/5PRO",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_doypack.svg",
    category: categorieSmart,
    img: "img/smartbag/doypack.webp",
    title: "Doypack",
    description: "Prácticas, elegantes y versátiles.",
    sdescription: "El empaque ideal para marcas que desean sobresalir y preservar su producto con un toque de sofisticación. ",
    infoBuild:
        "El Doypack es un empaque flexible y moderno que se mantiene de pie por sí solo, ideal para exhibiciones llamativas en anaquel 🛍️. Gracias a su diseño resellable con zipper, permite conservar la frescura del contenido y ofrecer comodidad al consumidor. Su laminado metalizado le da un acabado brillante y elegante ✨, siendo perfecto para alimentos gourmet, suplementos, cosméticos y más. Además, admite múltiples opciones de impresión para realzar la identidad de tu marca.",

    route: "/SmartBag/Explora-SmartBag/Doypack",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_flowpack.svg",
    category: categorieSmart,
    img: "img/smartbag/flowpack.webp",
    title: "Flowpack",
    description: "Alta eficiencia, impacto visual garantizado.",
    sdescription: "Diseñada para líneas de producción ágiles y presentaciones que capturan la atención con elegancia.",
    infoBuild:
        "✨ Flowpack es un empaque flexible, laminado y metalizado, pensado para líneas de producción automáticas que requieren velocidad, precisión y eficiencia. Gracias a su diseño estilizado y acabado brillante, ofrece una presencia visual impactante que realza cualquier producto en el punto de venta. 💡 Este tipo de empaque es perfecto para snacks, barras energéticas, productos cosméticos, suplementos y más, ya que protege contra la humedad, el aire y la luz, conservando la frescura y calidad por más tiempo. Además, su estructura facilita el sellado hermético y asegura un proceso fluido en máquinas de envasado horizontales de alta velocidad. Flowpack no solo envuelve tu producto, lo eleva. Ideal para marcas que quieren destacar en anaquel y transmitir innovación y calidad desde el primer vistazo. 🚀",
    route: "/SmartBag/Explora-SmartBag/Flowpack",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_piramidal.svg",
    category: categorieSmart,
    img: "img/smartbag/piramide.webp",
    title: "Piramidal",
    description: "Una forma distintiva, una presencia memorable.",
    sdescription: "El empaque triangular que destaca en anaquel y comunica innovación y sofisticación.",
    infoBuild:
        "El empaque piramidal ofrece una solución moderna y distintiva para productos premium. Gracias a su forma triangular, no solo maximiza la atención en el punto de venta, sino que también optimiza el espacio interno para productos sólidos o en polvo. 💼 Su estructura laminada y sellado hermético garantizan protección contra la humedad y el oxígeno, lo que lo hace ideal para productos delicados como té, café gourmet, especias, o suplementos. Además, su geometría permite apilado eficiente y diferenciación visual frente a empaques tradicionales. Piramidal es más que forma: es una declaración de marca. ✨",
    route: "/SmartBag/Especiales-SmartBag/Piramidal",
  ),

  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_cojin.svg",
    category: categorieSmart,
    img: "img/smartbag/cojin.webp",
    title: "Cojín",
    description: "Ligereza y eficiencia en cada envío.",
    sdescription: "Ideal para empaques de alta rotación: fácil de manipular, práctico de usar, siempre efectivo.",
    infoBuild: "",
    route: "/SmartBag/Especiales-SmartBag/Cojin",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_standpack.svg",
    category: categorieSmart,
    img: "img/smartbag/standpack.webp",
    title: "Standpack",
    description: "Su producto siempre con una presentación impecable.",
    sdescription: "Un diseño estable y atractivo, ideal para destacar en estanterías y realzar la calidad de cafés y selectos snacks gourmet.",
    infoBuild: "",
    route: "/SmartBag/Especiales-SmartBag/Standpack",
  ),
  Subcategorie(
    category: categorieSmart,
    img: "img/smartbag/valvula.webp",
    title: "Accesorios",
    description: "Detalles que perfeccionan su empaque.",
    sdescription: "Válvulas, zipper, peel & stick y más. Complementos esenciales para personalizar y optimizar la experiencia de su empaque.",
    infoBuild: "",
    route: "/Accesorios",
  ),
];

final List<Subcategorie> subcategorieEco = [
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_4pro.svg",
    category: categorieEco,
    img: "img/ecobag/4pro.webp",
    title: "4PRO",
    description: "Empaque ecológico con alto rendimiento.",
    sdescription: "Ideal para cafés orgánicos o productos sostenibles. Frescura, elegancia y menor impacto ambiental.",
    infoBuild: "",
    route: "/EcoBag/Explora-EcoBag/4PRO",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_5pro.svg",
    category: categorieEco,
    img: "img/ecobag/5pro.webp",
    title: "5PRO",
    description: "Tecnología flexible con enfoque verde.",
    sdescription: "Cinco capas de protección con materiales que respetan el planeta. Sellado perfecto y presencia impactante.",
    infoBuild: "",
    route: "/EcoBag/Explora-EcoBag/5PRO",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_doypack.svg",
    category: categorieEco,
    img: "img/ecobag/doypack.webp",
    title: "Doypack",
    description: "Versatilidad amigable con el entorno.",
    sdescription: "Diseñado para marcas sostenibles que buscan destacarse con empaques prácticos y biodegradables.",
    infoBuild:
        "El Doypack EcoBag es la opción ideal para marcas comprometidas con el planeta 🌍. Fabricado con materiales biodegradables y compostables, este empaque combina funcionalidad con sostenibilidad. Su diseño resellable y autoportante lo hace perfecto para productos orgánicos, saludables o ecológicos, manteniendo frescura y practicidad 🌿. Además, su apariencia moderna y natural refuerza el mensaje de responsabilidad ambiental de tu marca.",

    route: "/EcoBag/Explora-EcoBag/Doypack",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_flowpack.svg",
    category: categorieEco,
    img: "img/ecobag/flowpack.webp",
    title: "Flowpack",
    description: "Producción rápida, mínima huella.",
    sdescription: "Optimizado para líneas ecológicas, con materiales sostenibles de alta calidad.",
    infoBuild:
        "El Flowpack EcoBag combina velocidad de empaque con conciencia ambiental 🌱. Diseñado para líneas de producción automáticas, está fabricado con materiales sostenibles que reducen el impacto ecológico sin comprometer la calidad. Su estructura laminada ofrece una excelente barrera contra la humedad y el oxígeno, ideal para snacks, barras y productos naturales. Su acabado brillante y limpio aporta una presentación moderna y responsable ♻️.",

    route: "/EcoBag/Explora-EcoBag/Flowpack",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_piramidal.svg",
    category: categorieEco,
    img: "img/ecobag/piramidal.webp",
    title: "Piramidal",
    description: "Diseño ecológico con formato innovador.",
    sdescription: "Ideal para infusiones, productos gourmet y porciones individuales con bajo impacto ambiental.",
    infoBuild:
        "🍃 El empaque Piramidal EcoBag combina diseño innovador con compromiso ambiental. Su forma permite una distribución eficiente del contenido, mientras utiliza materiales sostenibles que reducen el impacto ecológico. 💧 Perfecto para productos como té, suplementos o snacks gourmet en porciones individuales. Además de su funcionalidad, ofrece una presentación atractiva que comunica conciencia y calidad. 🧩 Compatible con procesos automatizados y opciones de sellado ecológicas. Elige Piramidal para destacar y cuidar el planeta al mismo tiempo.",
    route: "/EcoBag/Especiales-EcoBag/Piramidal",
  ),
  Subcategorie(
    clipArt: "img/smartbag/clipart/cpa_cojin.svg",
    category: categorieEco,
    img: "img/ecobag/cojin.webp",
    title: "Cojín",
    description: "Eficiencia y conciencia ambiental.",
    sdescription: "Ideal para procesos productivos responsables y empaques de bajo impacto.",
    infoBuild: "",
    route: "/EcoBag/Especiales-EcoBag/Cojin",
  ),
];
