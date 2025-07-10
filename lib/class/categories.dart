import 'dart:ui';

class Categoria {
  final String name;
  final Color color;

  Categoria({required this.name, required this.color});
}

final Categoria categorieSmart = Categoria(name: "SmartBag", color: const Color(0xFF004F9E));

final Categoria categorieEco = Categoria(name: "EcoBag", color: const Color(0xff4b8d2c));

class Subcategorie {
  final Categoria category;
  final String img;
  final String title;
  final String description;
  final String sdescription;
  final String infoBuild;
  final String dimentions;
  final String route;
  final bool enabledPS;
  final bool enabled;

  Subcategorie({
    required this.category,
    required this.img,
    required this.title,
    required this.description,
    required this.sdescription,
    required this.infoBuild,
    required this.dimentions,
    required this.route,
    this.enabledPS = false,
    this.enabled = true,
  });
}

final List<Subcategorie> subcategorieSmart = [
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/Costal.webp",
    title: "4PRO",
    description: "La bolsa que evoluciona con tu producto.",
    sdescription: "Ideal para cafés premium o alimentos especiales, la 4Pro ofrece frescura, elegancia y resistencia.",
    infoBuild:
        "🌟 La 4PRO es una bolsa de alta gama diseñada para productos que exigen elegancia, funcionalidad y conservación superior. Su estructura multilaminada le brinda una resistencia excepcional, ideal para cafés premium, superfoods, productos gourmet o suplementos nutricionales. 💪 Cuenta con un diseño de base estable que permite que se mantenga en pie, facilitando su exhibición en estanterías. Puede incorporar válvula desgasificadora, zipper resellable y acabados mate o brillantes que proyectan una imagen sofisticada y moderna. Gracias a su excelente barrera contra humedad, oxígeno y luz, la 4PRO mantiene la frescura y propiedades del contenido por más tiempo. Es la opción perfecta para marcas que buscan diferenciarse con un empaque funcional y visualmente impactante. ✨",
    route: "/SmartBag/Explora-SmartBag/4PRO",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabledPS: true,
  ),
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/5pro.webp",
    title: "5PRO",
    description: "La evolución del empaque flexible.",
    sdescription: "Tecnología de 5 capas para máxima protección, sellado perfecto y presencia inigualable.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/SmartBag/Explora-SmartBag/5PRO",
    enabled: false,
  ),
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/doypack.webp",
    title: "Doypack",
    description: "Prácticas, elegantes y resellables.",
    sdescription: "El empaque más versátil para marcas que quieren destacarse y proteger su producto con estilo.",
    infoBuild:
        "El Doypack es un empaque flexible y moderno que se mantiene de pie por sí solo, ideal para exhibiciones llamativas en anaquel 🛍️. Gracias a su diseño resellable con zipper, permite conservar la frescura del contenido y ofrecer comodidad al consumidor. Su laminado metalizado le da un acabado brillante y elegante ✨, siendo perfecto para alimentos gourmet, suplementos, cosméticos y más. Además, admite múltiples opciones de impresión para realzar la identidad de tu marca.",

    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/SmartBag/Explora-SmartBag/Doypack",
  ),
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/cojin.webp",
    title: "Cojín",
    description: "Ligereza y eficiencia en cada empaque.",
    sdescription: "Ideal para empaques de alta rotación: fácil de producir, fácil de usar, siempre efectiva.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/SmartBag/Explora-SmartBag/Cojín",

    enabled: false,
  ),
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/flowpack.webp",
    title: "Flowpack",
    description: "Alta velocidad, máxima protección.",
    sdescription: "Diseñada para líneas de producción rápidas y presentaciones visuales atractivas.",
    infoBuild:
        "✨ Flowpack es un empaque flexible, laminado y metalizado, pensado para líneas de producción automáticas que requieren velocidad, precisión y eficiencia. Gracias a su diseño estilizado y acabado brillante, ofrece una presencia visual impactante que realza cualquier producto en el punto de venta. 💡 Este tipo de empaque es perfecto para snacks, barras energéticas, productos cosméticos, suplementos y más, ya que protege contra la humedad, el aire y la luz, conservando la frescura y calidad por más tiempo. Además, su estructura facilita el sellado hermético y asegura un proceso fluido en máquinas de envasado horizontales de alta velocidad. Flowpack no solo envuelve tu producto, lo eleva. Ideal para marcas que quieren destacar en anaquel y transmitir innovación y calidad desde el primer vistazo. 🚀",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/SmartBag/Explora-SmartBag/Flowpack",
  ),
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/standpack.webp",
    title: "Standpack",
    description: "Tu producto siempre en pie.",
    sdescription: "Diseño estable y vistoso que destaca en estanterías y ferias. Ideal para cafés y snacks gourmet.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/SmartBag/Explora-SmartBag/Standpack",
  ),
  Subcategorie(
    category: categorieSmart,
    img: "assets/img/smartbag/valvula.webp",
    title: "Accesorios",
    description: "Válvulas, peel & stick y más.",
    sdescription: "Válvulas, zipper, peel stick y más. Complementos esenciales para que tu empaque hable por ti.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/SmartBag/Explora-SmartBag/Accesorios",
    enabled: false,
  ),
];

final List<Subcategorie> subcategorieEco = [
  Subcategorie(
    category: categorieEco,
    img: "assets/img/ecobag/4pro.webp",
    title: "4PRO",
    description: "Empaque ecológico con alto rendimiento.",
    sdescription: "Ideal para cafés orgánicos o productos sostenibles. Frescura, elegancia y menor impacto ambiental.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/EcoBag/Explora-EcoBag/4PRO",
    enabledPS: true,
  ),
  Subcategorie(
    category: categorieEco,
    img: "assets/img/ecobag/5pro.webp",
    title: "5PRO",
    description: "Tecnología flexible con enfoque verde.",
    sdescription: "Cinco capas de protección con materiales que respetan el planeta. Sellado perfecto y presencia impactante.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/EcoBag/Explora-EcoBag/5PRO",
    enabled: false,
  ),
  Subcategorie(
    category: categorieEco,
    img: "assets/img/ecobag/doypack.webp",
    title: "Doypack",
    description: "Versatilidad amigable con el entorno.",
    sdescription: "Diseñado para marcas sostenibles que buscan destacarse con empaques prácticos y biodegradables.",
    infoBuild:
        "El Doypack EcoBag es la opción ideal para marcas comprometidas con el planeta 🌍. Fabricado con materiales biodegradables y compostables, este empaque combina funcionalidad con sostenibilidad. Su diseño resellable y autoportante lo hace perfecto para productos orgánicos, saludables o ecológicos, manteniendo frescura y practicidad 🌿. Además, su apariencia moderna y natural refuerza el mensaje de responsabilidad ambiental de tu marca.",

    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/EcoBag/Explora-EcoBag/Doypack",
  ),
  Subcategorie(
    category: categorieEco,
    img: "assets/img/ecobag/cojin.webp",
    title: "Cojín",
    description: "Eficiencia y conciencia ambiental.",
    sdescription: "Ideal para procesos productivos responsables y empaques de bajo impacto.",
    infoBuild: "",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
    route: "/EcoBag/Explora-EcoBag/Cojín",
  ),
  Subcategorie(
    category: categorieEco,
    img: "assets/img/ecobag/flowpack.webp",
    title: "Flowpack",
    description: "Producción rápida, mínima huella.",
    sdescription: "Optimizado para líneas ecológicas, con materiales sostenibles de alta calidad.",
    infoBuild:
        "El Flowpack EcoBag combina velocidad de empaque con conciencia ambiental 🌱. Diseñado para líneas de producción automáticas, está fabricado con materiales sostenibles que reducen el impacto ecológico sin comprometer la calidad. Su estructura laminada ofrece una excelente barrera contra la humedad y el oxígeno, ideal para snacks, barras y productos naturales. Su acabado brillante y limpio aporta una presentación moderna y responsable ♻️.",

    dimentions: "7,5 × 0,5 × 32 cm",
    route: "/EcoBag/Explora-EcoBag/Flowpack",
  ),
];
