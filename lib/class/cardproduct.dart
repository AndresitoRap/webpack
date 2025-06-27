class CardProduct {
  final String title;
  final String body;
  final String descriptionTop;
  final String descriptionDown;
  final String imageTop;
  final String imageDown;
  final String image;
  final bool isblack;

  CardProduct({
    required this.title,
    required this.body,
    required this.descriptionTop,
    required this.descriptionDown,
    required this.imageTop,
    required this.imageDown,
    required this.image,
    this.isblack = false,
  });
}

final List<CardProduct> cardFindS = [
  CardProduct(
    title: "Innovación envuelta en elegancia",
    body: "Diseño para experiencias extraordinarias.",
    image: "assets/img/smartbag/discover1.webp",
    descriptionTop:
        "Eso sí que es inteligente. SmartBag Visos Dorados redefine el empaque con diseño avanzado, materiales premium y una estética que habla por sí sola. Creada para elevar la experiencia, no solo protege tu producto, sino que lo presenta con una elegancia que marca la diferencia.",
    descriptionDown:
        "Encuentra el equilibrio perfecto entre funcionalidad y belleza. Cada detalle ha sido pensado para impresionar, con acabados dorados que capturan la luz y despiertan emociones. Así es como luce el futuro del empaque, ahora al alcance de tu marca.",
    imageTop: "assets/img/smartbag/discover1_Top.webp",
    imageDown: "assets/img/smartbag/discover1_Down.webp",
  ),
  CardProduct(
    title: "Elegancia que se siente.",
    body: "El arte de empacar café con distinción.",
    image: "assets/img/smartbag/discover2.webp",
    descriptionTop:
        "Una fusión de lo clásico y lo moderno. Esta presentación eleva el empaque de café a una pieza de diseño atemporal, con detalles que capturan la esencia del grano y el arte de tostarlo.",
    descriptionDown:
        "Desde el grano hasta el pedestal. Cada bolsa representa una declaración de carácter, donde el minimalismo y la textura dialogan para proyectar una experiencia visual sofisticada y auténtica.",
    imageTop: "assets/img/smartbag/discover2_Top.webp",
    imageDown: "assets/img/smartbag/discover2_Down.webp",
  ),
  CardProduct(
    title: "El origen toma protagonismo.",
    body: "Diseño pensado para destacar lo esencial.",
    image: "assets/img/smartbag/discover3.webp",
    descriptionTop:
        "La bolsa 5PRO está diseñada para resaltar el contenido con distinción. Su estructura firme y detalles únicos convierten el empaque en una experiencia visual que combina funcionalidad y estética de alto nivel.",
    descriptionDown:
        "Más que una bolsa, la 5PRO es una herramienta de presentación sofisticada. Perfecta para productos que requieren una imagen impecable, reciclabilidad y un impacto visual que hable por sí solo.",
    imageTop: "assets/img/smartbag/discover3_Top.webp",
    imageDown: "assets/img/smartbag/discover3_Down.webp",
  ),
  CardProduct(
    title: "Diseño que impone presencia.",
    body: "4PRO es estructura, contraste y precisión.",
    image: "assets/img/smartbag/discover4.webp",
    descriptionTop:
        "Con líneas firmes y detalles metálicos, la bolsa 4PRO transmite carácter desde cualquier ángulo. Su forma vertical estilizada está diseñada para destacar en entornos premium.",
    descriptionDown:
        "La 4PRO no solo protege, también comunica. Su acabado refinado y su diseño simétrico la convierten en una opción ideal para productos que buscan diferenciarse con elegancia y autoridad.",
    imageTop: "assets/img/smartbag/discover4_Top.webp",
    imageDown: "assets/img/smartbag/discover4_Down.webp",
    isblack: true,
  ),
  CardProduct(
    title: "Poder y precisión.",
    body: "Diseñada para entornos que exigen más.",
    image: "assets/img/smartbag/discover5.webp",
    descriptionTop:
        "Inspirada en la fuerza del contraste, esta bolsa destaca por su estructura imponente y acabados técnicos. Su presencia proyecta eficiencia y control, incluso en las condiciones más exigentes.",
    descriptionDown:
        "Un diseño que domina el entorno. Funcionalidad, protección y una estética contundente se fusionan en esta pieza pensada para liderar con fuerza y exactitud.",
    imageTop: "assets/img/smartbag/discover5_Top.webp",
    imageDown: "assets/img/smartbag/discover5_Down.webp",
  ),
  CardProduct(
    title: "Ligereza que impacta.",
    body: "Diseñada para flotar, destacar y proteger.",
    image: "assets/img/smartbag/discover6.webp",
    descriptionTop: "La SmartBag® combina estructura y fluidez. Su diseño ergonómico se adapta a las exigencias del producto y del entorno.",
    descriptionDown:
        "Su resistencia no compromete la elegancia. En cada detalle, funcionalidad y estética se funden para crear una experiencia superior.",
    imageTop: "assets/img/smartbag/discover6_Top.webp",
    imageDown: "assets/img/smartbag/discover6_Down.webp",
  ),
  CardProduct(
    title: "Equilibrio perfecto.",
    body: "Dualidad en forma y función.",
    image: "assets/img/smartbag/discover7.webp",
    descriptionTop: "Cada bolsa refleja una intención: blanco y negro, claro y oscuro, funcional y estético. Todo en armonía.",
    descriptionDown:
        "Desde el rollo hasta el resultado final, SmartBag® es precisión suspendida en movimiento. Un balance entre tecnología y belleza.",
    imageTop: "assets/img/smartbag/discover7_Top.webp",
    imageDown: "assets/img/smartbag/discover7_Down.webp",
  ),
  CardProduct(
    title: "Amor que se envuelve en flores.",
    body: "Una declaración de estilo en cada detalle.",
    image: "assets/img/smartbag/discover8.webp",
    descriptionTop:
        "Rosa Sharon no es solo empaque, es una puesta en escena. Su estética floral y sus tonos serenos elevan la presentación del producto a un lenguaje visual propio.",
    descriptionDown:
        "Diseñada para marcas que entienden el valor de lo bello, esta colección transforma lo cotidiano en una experiencia sofisticada, elegante y memorable.",
    imageTop: "assets/img/smartbag/discover8_Top.webp",
    imageDown: "assets/img/smartbag/discover8_Down.webp",
  ),
  CardProduct(
    title: "Presencia que impone silencio.",
    body: "Diseño inteligente, impacto absoluto.",
    image: "assets/img/smartbag/discover9.webp",
    descriptionTop:
        "SmartBag® redefine la forma de comunicar. Su presencia minimalista habla de precisión, control y carácter sin necesidad de palabras.",
    descriptionDown:
        "Cada línea, cada sombra y cada textura han sido cuidadosamente orquestadas para entregar un empaque que es, en sí mismo, una declaración de diseño.",
    imageTop: "assets/img/smartbag/discover9_Top.webp",
    imageDown: "assets/img/smartbag/discover9_Down.webp",
  ),
  CardProduct(
    title: "Texturas que hablan por ti.",
    body: "Elegancia y carácter en cada superficie.",
    image: "assets/img/smartbag/discover10.webp",
    descriptionTop:
        "Esta línea de SmartBag® se expresa con firmeza: acabados tipo cuero, tonos intensos y una presencia que deja huella desde el primer vistazo.",
    descriptionDown:
        "Pensada para marcas exigentes, combina distinción visual con un tacto memorable. Un empaque que imprime identidad sin necesidad de palabras.",
    imageTop: "assets/img/smartbag/discover10_Top.webp",
    imageDown: "assets/img/smartbag/discover10_Down.webp",
  ),
];

final List<CardProduct> cardFindE = [
  CardProduct(
    title: "Un ícono en medio del silencio.",
    body: "Diseño con alma propia.",
    image: "assets/img/ecobag/discover1.webp",
    descriptionTop:
        "EcoBag® se alza como un símbolo contemporáneo. Su presencia en escena no busca imitar la naturaleza, sino convivir con ella desde el respeto visual.",
    descriptionDown: "Más que sostenible: evocador, envolvente y memorable. Esta línea demuestra que lo consciente también puede ser extraordinario.",
    imageTop: "assets/img/ecobag/discover1_Top.webp",
    imageDown: "assets/img/ecobag/discover1_Down.webp",
  ),
  CardProduct(
    title: "Ligera con el planeta.",
    body: "Firme con lo que protege.",
    image: "assets/img/ecobag/discover2.webp",
    descriptionTop: "EcoBag® en su expresión más esencial. Hecha para integrarse sin esfuerzo, destacar con sutileza y proteger con eficiencia.",
    descriptionDown:
        "Ideal para marcas conscientes que valoran la simplicidad con propósito. Un empaque que respira naturalidad sin perder presencia.",
    imageTop: "assets/img/ecobag/discover2_Top.webp",
    imageDown: "assets/img/ecobag/discover2_Down.webp",
  ),
  CardProduct(
    title: "Diseñada para preservar lo esencial.",
    body: "Donde el aroma se encuentra con la intención.",
    image: "assets/img/ecobag/discover3.webp",
    descriptionTop:
        "Un diseño que protege lo valioso. La textura visual evoca profundidad, mientras su estructura conserva el carácter del producto intacto.",
    descriptionDown: "Pensado para destacar con sobriedad y propósito. Ideal para marcas que entienden que el empaque también transmite esencia.",
    imageTop: "assets/img/ecobag/discover3_Top.webp",
    imageDown: "assets/img/ecobag/discover3_Down.webp",
  ),
  CardProduct(
    title: "Menos impacto, más intención.",
    body: "Sutil, esencial y perfectamente equilibrado.",
    image: "assets/img/ecobag/discover4.webp",
    isblack: true,
    descriptionTop: "Un empaque que encuentra belleza en lo simple. Su presencia discreta realza el producto sin competir con él.",
    descriptionDown: "Ideal para quienes valoran el diseño silencioso y consciente. Porque cada elección visual también comunica propósito.",
    imageTop: "assets/img/ecobag/discover4_Top.webp",
    imageDown: "assets/img/ecobag/discover4_Down.webp",
  ),

  CardProduct(
    title: "Eso es inteligente.",
    body: "Diseño simple, resultados extraordinarios.",
    image: "assets/img/ecobag/discover5.webp",
    descriptionTop:
        "Creado para quienes valoran lo esencial. Con una estructura precisa y materiales ligeros, este empaque se adapta sin esfuerzo y habla en voz baja, pero firme.",
    descriptionDown:
        "Diseñada con intención. Fabricada con respeto. Y pensada para ofrecer funcionalidad real sin renunciar al estilo. Así se ve la simplicidad bien hecha.",
    imageTop: "assets/img/ecobag/discover5_Top.webp",
    imageDown: "assets/img/ecobag/discover5_Down.webp",
  ),
  CardProduct(
    title: "Eso es inteligente.",
    body: "Diseño simple, resultados extraordinarios.",
    image: "assets/img/ecobag/discover6.webp",
    descriptionTop:
        "Cuando el empaque no compite, sino complementa. Una estructura limpia y funcional que pone el enfoque en lo importante: el contenido.",
    descriptionDown: "Precisión, proporción y claridad. Este diseño demuestra que lo inteligente no necesita adornos para ser memorable.",
    imageTop: "assets/img/ecobag/discover6_Top.webp",
    imageDown: "assets/img/ecobag/discover6_Down.webp",
  ),
  CardProduct(
    title: "Inspiración, hecha empaque.",
    body: "Sutil. Preciso. Atemporal.",
    image: "assets/img/ecobag/discover7.webp",
    descriptionTop:
        "Diseñado con cuidado, pensado para integrarse con elegancia. Este empaque equilibra forma y función sin renunciar a la estética.",
    descriptionDown: "Desde la textura hasta la composición, cada elemento transmite intención. Porque lo que protege también puede inspirar.",
    imageTop: "assets/img/ecobag/discover7_Top.webp",
    imageDown: "assets/img/ecobag/discover7_Down.webp",
  ),
  CardProduct(
    title: "Diseño que respira equilibrio.",
    body: "Natural. Estético. Consciente.",
    image: "assets/img/ecobag/discover8.webp",
    isblack: true,
    descriptionTop:
        "Una pieza que se integra con armonía. Su material y forma evocan simplicidad elegante, mientras su presencia comunica propósito sin excesos.",
    descriptionDown: "Perfecta para marcas que buscan diferenciarse desde lo esencial. Este empaque no compite con el entorno, lo complementa.",
    imageTop: "assets/img/ecobag/discover8_Top.webp",
    imageDown: "assets/img/ecobag/discover8_Down.webp",
  ),
  CardProduct(
    title: "Sutil por fuera. Preciso por dentro.",
    body: "Diseño que acompaña con elegancia.",
    image: "assets/img/ecobag/discover9.webp",
    descriptionTop:
        "Una pieza pensada para entornos donde la estética importa. Su forma discreta y su acabado limpio armonizan con espacios de calma y sofisticación.",
    descriptionDown:
        "Más que funcional: equilibrada, serena y presente. El empaque ideal para quienes entienden que el detalle define la experiencia.",
    imageTop: "assets/img/ecobag/discover9_Top.webp",
    imageDown: "assets/img/ecobag/discover9_Down.webp",
  ),
  CardProduct(
    title: "Ligera por naturaleza.",
    body: "Minimalismo que flota con intención.",
    image: "assets/img/ecobag/discover10.webp",
    isblack: true,
    descriptionTop:
        "Diseño claro, contenido visible. Esta propuesta celebra lo esencial con una estética limpia y una sensación de ingravidez que eleva su presencia.",
    descriptionDown: "Perfecta para marcas que valoran lo simple y lo bien hecho. Una forma silenciosa de destacar, sin peso innecesario.",
    imageTop: "assets/img/ecobag/discover10_Top.webp",
    imageDown: "assets/img/ecobag/discover10_Down.webp",
  ),
];
