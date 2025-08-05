class CardProduct {
  final String title;
  final String body;
  final String? onTitle;
  final String? onBody;
  final String descriptionTop;
  final String? descriptionTitleDown;
  final String descriptionDown;
  final String imageTop;
  final String imageDown;
  final String image;
  final bool isblack;

  CardProduct({
    required this.title,
    required this.body,
    this.onTitle,
    this.onBody,
    this.descriptionTitleDown,
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
    title: "Impacto con ligereza.",
    body: "Llamativo, ligero y altamente protector en el punto de venta.",
    onTitle: 'Innovación en cada detalle. Elegancia en cada curva.',
    onBody: 'Diseño para experiencias extraordinarias.',
    image: "assets/img/smartbag/discover1.webp",
    descriptionTop:
        "Esto es más que una simple bolsa; es una declaración de intenciones. La SmartBag Visos Dorados redefine el empaque, fusionando un diseño vanguardista con materiales premium para crear una estética que impacta.\n\nNo se limita a proteger tu producto, lo eleva a un nuevo nivel. Cada curva, cada brillo dorado, ha sido concebido para envolver la experiencia del consumidor en un aura de lujo y exclusividad, marcando una diferencia audaz en cualquier estantería y comunicando, sin palabras, la excelencia de tu marca.",
    descriptionDown:
        "El arte de la presentación. La ciencia de la protección. Encuentra el equilibrio perfecto entre funcionalidad y belleza.\n\nEste empaque es una obra maestra de ingeniería y arte. Hemos logrado el equilibrio perfecto, donde cada detalle ha sido minuciosamente diseñado para cautivar e impresionar. Los acabados dorados no son solo un adorno, son un juego de luz que despierta emociones, un reflejo de la calidad inigualable que contiene. ",
    imageTop: "assets/img/smartbag/discover1_Top.webp",
    imageDown: "assets/img/smartbag/discover1_Down.webp",
  ),
  CardProduct(
    title: "Equilibrio entre estética y funcionalidad.",
    body: "Equilibrio perfecto entre diseño y función para destacar su producto.",
    image: "assets/img/smartbag/discover2.webp",
    onTitle: 'Elegancia que se siente. Un legado de distinción en cada empaque.',
    onBody: 'El arte de empacar café con distinción.',
    descriptionTop:
        "Más que un simple envoltorio, esta presentación es una oda al arte del café. Fusionamos la riqueza de la tradición con la sofisticación del diseño moderno para crear un empaque atemporal.\n\nCada detalle, desde la textura que evoca la tierra donde nace el grano hasta los sutiles elementos visuales, ha sido cuidadosamente seleccionado para capturar la esencia misma del café y la pasión que reside en cada etapa de su tostado.\n\nEste empaque no solo preserva la frescura, sino que también cuenta la historia de un café excepcional, elevando la experiencia desde el primer contacto visual.",
    descriptionDown:
        "Elevando la esencia. Un diseño que inspira. Desde el grano hasta el pedestal. Cada bolsa es una declaración de carácter, una pieza que trasciende la funcionalidad para convertirse en un símbolo de sofisticación y autenticidad.\n\nEn su minimalismo reside una fuerza expresiva donde la textura y la forma dialogan para proyectar una experiencia visual única y memorable. Este empaque no es un simple contenedor, es una plataforma que eleva tu producto, presentándolo con la dignidad y el cuidado que merece, como una verdadera joya en su pedestal.",
    imageTop: "assets/img/smartbag/discover2_Top.webp",
    imageDown: "assets/img/smartbag/discover2_Down.webp",
  ),
  CardProduct(
    title: "Elegancia y carácter.",
    body: "Empaque elegante que refleja la sofisticación de su marca en cada detalle.",
    image: "assets/img/smartbag/discover3.webp",
    onTitle: 'El origen toma protagonismo. Un diseño que celebra la esencia.',
    onBody: 'Diseño pensado para destacar lo esencial.',
    descriptionTop:
        "La bolsa 5PRO ha sido concebida con una clara misión: resaltar la calidad excepcional de su contenido con una distinción inigualable. Su estructura firme y sus detalles únicos convergen en una experiencia visual que trasciende lo ordinario, fusionando a la perfección funcionalidad y una estética de alto nivel.\n\nCada elemento ha sido cuidadosamente considerado para poner en valor el origen y las características únicas de su producto, convirtiendo el empaque en una poderosa herramienta de comunicación que habla directamente a los sentidos y al espíritu del consumidor exigente.",
    descriptionDown:
        "Más que un empaque, una declaración de principios. Más que una bolsa, la 5PRO es una herramienta de presentación sofisticada. Este no es simplemente un empaque, es una extensión de la filosofía de tu marca.\n\nLa 5PRO ha sido diseñada para aquellos productos que demandan una imagen impecable, ofreciendo además un compromiso tangible con la sostenibilidad gracias a su reciclabilidad. Su impacto visual es innegable, una declaración de sofisticación y atención al detalle que comunica calidad y cuidado sin necesidad de palabras.\n\nEs la elección perfecta para quienes buscan una presentación que hable por sí sola, dejando una impresión duradera y positiva en cada cliente.",
    imageTop: "assets/img/smartbag/discover3_Top.webp",
    imageDown: "assets/img/smartbag/discover3_Down.webp",
  ),
  CardProduct(
    title: "Estructura y contraste 4PRO.",
    body: "Diseño 4PRO: imponente, preciso y estructurado para resaltar su producto.",
    image: "assets/img/smartbag/discover4.webp",
    onTitle: 'Diseño que impone presencia. La perfección en cada línea.',
    onBody: '4PRO es estructura, contraste y precisión.',
    descriptionTop:
        "Más allá de ser un empaque, la bolsa 4PRO es una declaración de poder y sofisticación. Con líneas firmes y detalles metálicos que captan la atención, irradia un carácter inconfundible desde cualquier perspectiva.\n\nSu forma vertical estilizada no es un accidente, sino una decisión de diseño estratégica para dominar y destacar en los entornos más exclusivos y premium.\n\nEste empaque proyecta una imagen de calidad superior, eficiencia y modernidad, convirtiéndose en el aliado perfecto para las marcas que buscan una presencia inolvidable.",
    descriptionDown:
        "Más que un empaque, una comunicación sutil y poderosa. La 4PRO no solo protege, también comunica. Este empaque es una obra de arte funcional, una fusión de refinamiento y estrategia.\n\nSu acabado pulcro y su diseño simétrico no solo garantizan una protección óptima, sino que también envían un mensaje claro de elegancia y autoridad.\n\nLa bolsa 4PRO se convierte en la opción ideal para productos que aspiran a diferenciarse en el mercado, utilizando su estética para transmitir un mensaje de calidad intransigente y un gusto impecable. Es la herramienta definitiva para marcas que entienden que el empaque es la primera y más importante conversación con el cliente.",
    imageTop: "assets/img/smartbag/discover4_Top.webp",
    imageDown: "assets/img/smartbag/discover4_Down.webp",
    isblack: true,
  ),
  CardProduct(
    title: "Diseño robusto y preciso.",
    body: "Diseñado para entornos exigentes, ofrece fuerza y precisión para proteger su producto en todo momento.",
    image: "assets/img/smartbag/discover5.webp",
    onTitle: 'Poder y precisión. El empaque que no conoce límites.',
    onBody: 'Diseñada para entornos que exigen más.',
    descriptionTop:
        "Esta bolsa es el resultado de un diseño audaz, concebido a partir de la fuerza del contraste. Su estructura imponente y sus acabados técnicos no solo garantizan una protección superior, sino que también proyectan una imagen de eficiencia, control y robustez.\n\nEs un empaque que se desenvuelve con maestría en los escenarios más exigentes, demostrando que la funcionalidad y la estética pueden coexistir en perfecta armonía. La elección ideal para marcas que buscan transmitir confianza y durabilidad.",
    descriptionDown:
        "Un diseño que domina el entorno. La fusión perfecta de estética y resistencia. Funcionalidad, protección y una estética contundente convergen en esta pieza magistral.\n\nCada aspecto ha sido pensado para liderar con una fuerza y exactitud inquebrantables. Es un empaque que no se limita a contener, sino que se apodera del espacio, proyectando una imagen de solidez, innovación y liderazgo.\n\nCon este diseño, tu producto no solo estará protegido, sino que se convertirá en un punto de referencia de calidad y buen gusto.",
    imageTop: "assets/img/smartbag/discover5_Top.webp",
    imageDown: "assets/img/smartbag/discover5_Down.webp",
  ),
  CardProduct(
    title: "Innovación y elegancia.",
    body: "Diseño innovador y estético que crea experiencias extraordinarias.",
    image: "assets/img/smartbag/discover6.webp",
    onTitle: 'Ligereza que impacta.',
    onBody: 'La libertad de un diseño superior.',
    descriptionTop:
        "Diseñada para una presencia ligera, para destacar y proteger.La SmartBag® es la perfecta simbiosis de estructura y fluidez. Su diseño ergonómico no solo se adapta a las exigencias más rigurosas de tu producto, sino que también interactúa con el entorno de manera natural y elegante.\n\nEsta bolsa está concebida para una presencia visual ligera que la hace destacar, proyectando una imagen de innovación y modernidad sin sacrificar ni un ápice de su capacidad de protección.",
    descriptionDown:
        "La fuerza de la elegancia. Resistencia sin compromisos. Su resistencia no compromete la elegancia. Este empaque es un testimonio de la ingeniería de diseño, donde cada detalle ha sido concebido para fusionar funcionalidad y estética en una experiencia superior.\n\nLa solidez de sus materiales y la sofisticación de su diseño se combinan para ofrecer una protección inquebrantable, al tiempo que presentan tu producto de la manera más refinada y atractiva posible. Es la elección definitiva para quienes buscan un equilibrio perfecto entre durabilidad y estilo.",
    imageTop: "assets/img/smartbag/discover6_Top.webp",
    imageDown: "assets/img/smartbag/discover6_Down.webp",
  ),
  CardProduct(
    title: "Empaques con distinción.",
    body: "Sofisticación en cada detalle, elevando su marca con elegancia.",
    image: "assets/img/smartbag/discover7.webp",
    onTitle: 'Equilibrio perfecto. La armonía entre ser y hacer.',
    onBody: 'Dualidad en forma y función.',
    descriptionTop:
        "Cada bolsa es la manifestación de una intención clara: blanco y negro, claro y oscuro, funcional y estético. No se trata de opuestos, sino de complementos que convergen en una armonía perfecta.\n\nEste diseño representa la dualidad esencial de un producto excepcional, donde la belleza de su forma se une intrínsecamente a la excelencia de su función. Es un equilibrio cuidadosamente logrado para ofrecer una experiencia completa y satisfactoria.",
    descriptionDown:
        "Precisión en movimiento. La tecnología al servicio de la estética.Desde el rollo hasta el resultado final, SmartBag® es precisión suspendida en movimiento. Representa un balance sofisticado entre la innovación tecnológica y la belleza del diseño.\n\nCada etapa, cada detalle, está imbuido de una precisión que garantiza tanto la funcionalidad impecable como una estética cautivadora. Es la perfecta demostración de cómo la tecnología más avanzada puede dar forma a productos de una belleza singular y atemporal.",
    imageTop: "assets/img/smartbag/discover7_Top.webp",
    imageDown: "assets/img/smartbag/discover7_Down.webp",
  ),
  CardProduct(
    title: "Diseño que resalta la esencia.",
    body: "Diseño minimalista y estratégico que destaca el origen y lo esencial de su producto.",
    image: "assets/img/smartbag/discover8.webp",
    onTitle: 'Amor que se envuelve en flores. Un lenguaje visual que inspira.',
    onBody: 'Una declaración de estilo en cada detalle.',
    descriptionTop:
        "Rosa Sharon no es solo un empaque, es una cuidada puesta en escena. Su estética floral, con delicadas ilustraciones, y sus tonos serenos se unen para elevar la presentación de tu producto a un lenguaje visual propio, lleno de encanto y distinción.\n\nCada detalle ha sido pensado para evocar sentimientos de delicadeza y belleza natural, transformando el acto de descubrir el producto en una experiencia sensorial única y memorable. Este empaque no solo contiene, sino que también enamora.",
    descriptionDown:
        "Belleza que perdura. Transformando lo ordinario en extraordinario. Diseñada para marcas que entienden el valor de lo bello, esta colección transforma lo cotidiano en una experiencia sofisticada, elegante y memorable.\n\nEsta línea de empaques ha sido concebida para aquellas marcas que reconocen el poder de la estética como un valor fundamental. Cada diseño, con sus sutiles motivos florales y su paleta de colores suaves, está pensado para trascender la funcionalidad y convertir cada producto en una experiencia visual sofisticada y elegante.\n\nEsta colección transforma lo ordinario en algo memorable, añadiendo un toque de distinción y refinamiento que cautiva y fideliza al consumidor. Es la elección perfecta para quienes buscan comunicar la belleza intrínseca de su marca en cada presentación.",
    imageTop: "assets/img/smartbag/discover8_Top.webp",
    imageDown: "assets/img/smartbag/discover8_Down.webp",
  ),
  CardProduct(
    title: "Presencia dominante.",
    body: "Diseño inteligente y visualmente impactante que destaca su producto sin decir una palabra.",
    image: "assets/img/smartbag/discover9.webp",
    onTitle: 'Presencia que impone silencio. La elocuencia del minimalismo.',
    onBody: 'Diseño inteligente, impacto absoluto.',
    descriptionTop:
        "SmartBag® redefine la forma de comunicar. Su presencia minimalista, despojada de adornos innecesarios, habla con una fuerza silenciosa de precisión, control y un carácter inconfundible.\n\nCada línea, cada superficie, transmite una sensación de sofisticación y eficiencia, capturando la atención y dejando una impresión duradera sin necesidad de palabras. Este diseño inteligente demuestra que, en ocasiones, la mayor elocuencia reside en la simplicidad.",
    descriptionDown:
        "Una sinfonía visual. El diseño como lenguaje universal. Cada línea, cada sombra y cada textura han sido cuidadosamente orquestadas para entregar un empaque que es, en sí mismo, una declaración de diseño.",
    imageTop: "assets/img/smartbag/discover9_Top.webp",
    imageDown: "assets/img/smartbag/discover9_Down.webp",
  ),
  CardProduct(
    title: "Texturas que comunican.",
    body: "Elegancia y carácter en cada superficie.",
    image: "assets/img/smartbag/discover10.webp",
    onTitle: 'El color como declaración de intenciones. ',
    onBody: 'Un lenguaje de identidad. Pensada para marcas exigentes, combina distinción visual con un tacto memorable.',
    descriptionTop:
        "Esta línea de SmartBag® va más allá de lo visual para ofrecer una experiencia táctil memorable. Se expresa con una firmeza distintiva, gracias a sus acabados tipo cuero y sus tonos intensos, que comunican una presencia que deja huella desde el primer vistazo.\n\nCada superficie es un lienzo que transmite calidad, sofisticación y un carácter inconfundible, invitando al consumidor a interactuar con el producto y a percibir su excelencia con cada toque.",
    descriptionDown:
        "Un empaque que imprime identidad sin necesidad de palabras. Esta colección ha sido meticulosamente diseñada para las marcas que no se conforman con lo común. Cada color vibrante y cada textura cuidadosamente seleccionada se combinan para crear un empaque que no solo es visualmente distintivo, sino también memorable al tacto.\n\nEs una herramienta poderosa para imprimir la identidad de tu marca de manera sutil y elegante, comunicando una historia de calidad y personalidad sin necesidad de una sola palabra. Es la elección perfecta para dejar una impresión duradera y auténtica.",
    imageTop: "assets/img/smartbag/discover10_Top.webp",
    imageDown: "assets/img/smartbag/discover10_Down.webp",
  ),
];

final List<CardProduct> cardFindE = [
  CardProduct(
    title: "Un faro en la penumbra.",
    body: "Presencia que trasciende.",
    image: "assets/img/ecobag/discover1.webp",
    descriptionTop:
        "EcoBag® surge desde la penumbra, resaltando su textura con delicados reflejos de luz. Su silueta firme y elegante establece un diálogo entre el misterio del bosque y la pureza del diseño.",
    descriptionDown:
        "Cada detalle de este empaque está concebido para evocar asombro y sofisticación, transformando la oscuridad en un escenario donde lo esencial brilla con fuerza. Una experiencia visual memorable.",
    imageTop: "assets/img/ecobag/discover1_Top.webp",
    imageDown: "assets/img/ecobag/discover1_Down.webp",
  ),
  CardProduct(
    title: "Raíces y ligereza.",
    body: "Conexión viva con la tierra.",
    image: "assets/img/ecobag/discover2.webp",
    descriptionTop:
        "EcoBag® se posa con suavidad sobre un tronco vivo, integrándose al paisaje con respeto y armonía. Su textura natural y colores orgánicos evocan la frescura de un bosque en pleno despertar.",
    descriptionDown:
        "Pensada para marcas que buscan autenticidad, esta propuesta fusiona sostenibilidad y estilo, mostrándose ligera al tacto y firme en su compromiso con el planeta. Un empaque que respira naturaleza.",
    imageTop: "assets/img/ecobag/discover2_Top.webp",
    imageDown: "assets/img/ecobag/discover2_Down.webp",
  ),
  CardProduct(
    title: "Esencia que despierta.",
    body: "Alma de tradición cafetera.",
    image: "assets/img/ecobag/discover3.webp",
    descriptionTop:
        "Un soplo de historia que evoca mañanas compartidas y el suave murmullo de tazas humeantes, despertando sensaciones con cada nota aromática.",
    descriptionDown:
        "Las vibraciones del origen se entrelazan en cada inhalación, recordándonos que el verdadero sabor brota de la tierra y de la pasión de quienes la cultivan.",
    imageTop: "assets/img/ecobag/discover3_Top.webp",
    imageDown: "assets/img/ecobag/discover3_Down.webp",
  ),
  CardProduct(
    title: "Silueta serena.",
    body: "Elegancia que inspira calma.",
    image: "assets/img/ecobag/discover4.webp",
    isblack: true,
    descriptionTop:
        "Un diseño que respira serenidad. Esta propuesta nace de la contemplación, con líneas limpias y tonos suaves que invitan a la introspección y al descanso visual.",
    descriptionDown:
        "Minimalismo con alma. Su estética natural y equilibrada transforma el empaque en un espacio de silencio y presencia. Ideal para marcas que comunican desde la armonía y la intención.",
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
