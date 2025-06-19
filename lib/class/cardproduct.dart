class CardProduct {
  final String title;
  final String body;
  final String image;
  final bool isblack;

  CardProduct({required this.title, required this.body, required this.image, this.isblack = false});
}

final List<CardProduct> cardFindS = [
  CardProduct(title: "Diseño que piensa por tí", body: "Tecnología funcional en cada costura.", image: "assets/img/smartbag/discover1.webp"),
  CardProduct(title: "Empaca con inteligencia.", body: "Optimiza cada entrega, reduce cada error.", image: "assets/img/smartbag/discover2.webp"),
  CardProduct(
    title: "Protección inteligente.",
    body: "Cada detalle pensado para el futuro del empaque.",
    image: "assets/img/smartbag/discover3.webp",
  ),
  CardProduct(
    title: "Tecnología que se adapta.",
    body: "Una bolsa, múltiples posibilidades.",
    image: "assets/img/smartbag/discover4.webp",
    isblack: true,
  ),
  CardProduct(
    title: "Elegancia y ciencia, en una bolsa.",
    body: "Porque lo técnico también puede ser bello.",
    image: "assets/img/smartbag/discover5.webp",
  ),
  CardProduct(title: "Más que empaque, una solución.", body: "SmartBag® es rendimiento en acción.", image: "assets/img/smartbag/discover6.webp"),
  CardProduct(title: "Innovación con propósito.", body: "Porque cada gramo cuenta.", image: "assets/img/smartbag/discover7.webp"),
  CardProduct(title: "Versatilidad que empaca todo.", body: "Desde café gourmet hasta alta tecnología.", image: "assets/img/smartbag/discover8.webp"),
  CardProduct(title: "Inteligencia que se ve.", body: "No es solo una bolsa. Es Smart.", image: "assets/img/smartbag/discover9.webp"),
  CardProduct(title: "Lidera con precisión.", body: "Empaque premium que habla de tu marca.", image: "assets/img/smartbag/discover10.webp"),
];

final List<CardProduct> cardFindE = [
  CardProduct(title: "Naturaleza en cada empaque.", body: "El futuro se empaca en verde.", image: "assets/img/ecobag/discover1.webp"),
  CardProduct(title: "Ligera con el planeta.", body: "Fuerte con tu producto.", image: "assets/img/ecobag/discover2.webp"),
  CardProduct(title: "Diseñada para cuidar.", body: "La innovación también es responsable.", image: "assets/img/ecobag/discover3.webp"),
  CardProduct(
    title: "Menos impacto, más intención.",
    body: "Porque empacar también puede ser consciente.",
    image: "assets/img/ecobag/discover4.webp",
    isblack: true,
  ),
  CardProduct(title: "Elegancia ecológica.", body: "Estilo natural en cada curva.", image: "assets/img/ecobag/discover5.webp"),
  CardProduct(title: "Empaque con propósito.", body: "Porque cada gramo cuenta.", image: "assets/img/ecobag/discover6.webp"),
  CardProduct(title: "Verde que inspira.", body: "Tecnología y sostenibilidad en armonía.", image: "assets/img/ecobag/discover7.webp"),
  CardProduct(title: "Tu marca en modo eco.", body: "Diferente, visible, responsable.", image: "assets/img/ecobag/discover8.webp", isblack: true),
  CardProduct(title: "Más allá de lo reciclable.", body: "EcoBag® evoluciona con el planeta.", image: "assets/img/ecobag/discover9.webp"),
  CardProduct(
    title: "Naturalmente diferente.",
    body: "Porque lo verde también puede ser premium.",
    image: "assets/img/ecobag/discover10.webp",
    isblack: true,
  ),
];
