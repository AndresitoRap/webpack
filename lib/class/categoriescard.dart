class CategoriesCard {
  final String img;
  final String title;
  final String description;
  final String sdescription;
  final String dimentions;
  final bool enabled;

  CategoriesCard({
    required this.img,
    required this.title,
    required this.description,
    required this.sdescription,
    required this.dimentions,
    this.enabled = true,
  });
}

final List<CategoriesCard> categoriesCard = [
  CategoriesCard(
    img: "lib/src/img/smartbag/4pro.webp",
    title: "4PRO",
    description: "La bolsa que evoluciona con tu producto.",
    sdescription: "Ideal para cafés premium o alimentos especiales, la 4Pro ofrece frescura, elegancia y resistencia.",
    dimentions: "7,5 × 0,5 × 32 cm",
  ),
  CategoriesCard(
    img: "lib/src/img/smartbag/5pro.webp",
    title: "5PRO",
    description: "La evolución del empaque flexible.",
    sdescription: "Tecnología de 5 capas para máxima protección, sellado perfecto y presencia inigualable.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/smartbag/doypack.webp",
    title: "Doypack",
    description: "Prácticas, elegantes y resellables.",
    sdescription: "El empaque más versátil para marcas que quieren destacarse y proteger su producto con estilo.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/smartbag/cojin.webp",
    title: "Cojín",
    description: "Ligereza y eficiencia en cada empaque.",
    sdescription: "Ideal para empaques de alta rotación: fácil de producir, fácil de usar, siempre efectiva.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/smartbag/flowpack.webp",
    title: "Flowpack",
    description: "Alta velocidad, máxima protección.",
    sdescription: "Diseñada para líneas de producción rápidas y presentaciones visuales atractivas.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/smartbag/standpack.webp",
    title: "Standpack",
    description: "Tu producto siempre en pie.",
    sdescription: "Diseño estable y vistoso que destaca en estanterías y ferias. Ideal para cafés y snacks gourmet.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/smartbag/valvula.webp",
    title: "Accesorios",
    description: "Válvulas, peel & stick y más.",
    sdescription: "Válvulas, zipper, peel stick y más. Complementos esenciales para que tu empaque hable por ti.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
];

final List<CategoriesCard> categoriesCardEco = [
  CategoriesCard(
    img: "lib/src/img/ecobag/4pro.webp",
    title: "4PRO",
    description: "Empaque ecológico con alto rendimiento.",
    sdescription: "Ideal para cafés orgánicos o productos sostenibles. Frescura, elegancia y menor impacto ambiental.",
    dimentions: "7,5 × 0,5 × 32 cm",
  ),
  CategoriesCard(
    img: "lib/src/img/ecobag/5pro.webp",
    title: "5PRO",
    description: "Tecnología flexible con enfoque verde.",
    sdescription:
        "Cinco capas de protección con materiales que respetan el planeta. Sellado perfecto y presencia impactante.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/ecobag/doypack.webp",
    title: "Doypack",
    description: "Versatilidad amigable con el entorno.",
    sdescription: "Diseñado para marcas sostenibles que buscan destacarse con empaques prácticos y biodegradables.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/ecobag/cojin.webp",
    title: "Cojín",
    description: "Eficiencia y conciencia ambiental.",
    sdescription: "Ideal para procesos productivos responsables y empaques de bajo impacto.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
  CategoriesCard(
    img: "lib/src/img/ecobag/flowpack.webp",
    title: "Flowpack",
    description: "Producción rápida, mínima huella.",
    sdescription: "Optimizado para líneas ecológicas, con materiales sostenibles de alta calidad.",
    dimentions: "7,5 × 0,5 × 32 cm",
    enabled: false,
  ),
];
