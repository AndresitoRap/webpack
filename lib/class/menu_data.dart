class MenuData {
  static const List<String> navbarItems = ["SmartBag®", "EcoBag®", "Catálogo", "Nosotros", "Soporte"];

  static const List<List<Map<String, dynamic>>> submenus = [
    [
      {
        "title": "Explora SmartBag®",
        "items": ["4PRO", "5PRO", "Doypack", "Flowpack"],
      },
      {
        "title": "Especiales SmartBag®",
        "items": ["Standpack", "Accesorios"],
      },
    ],
    [
      {
        "title": "Explora EcoBag®",
        "items": ["4PRO", "5PRO", "Doypack", "Flowpack"],
      },
      {
        "title": "Especial de EcoBag®",
        "items": [""],
      },
    ],
    [
      {
        "title": "Nuestros Catálogos",
        "items": ["Catálogo"],
      },
    ],
    [
      {
        "title": "Quienes somos?",
        "items": ["Identidad corporativa", "Nuestros valores"],
      },
    ],
    [
      {
        "title": "Ayuda Rápida",
        "items": ["Whatsapp"],
      },
      {
        "title": "Politicas",
        "items": ["Politicas legales y reglamentarias", "Tratamiento de datos"],
      },
      {
        "title": "Tú opinion",
        "items": ["Encuesta de satisfacción y PQRS"],
      },
    ],
  ];
}
