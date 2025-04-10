class CardPackWithConscience {
  final String title;
  final String description;
  final String image;

  CardPackWithConscience({required this.title, required this.description, required this.image});
}

final List<CardPackWithConscience> cardPWC = [
  CardPackWithConscience(
    title: "Asesoría",
    description:
        "Ofrecemos asesoría personalizada y especializada para cada etapa de tu proyecto. Nuestro equipo de expertos te acompaña desde la conceptualización hasta la implementación, brindándote soluciones a medida, soporte constante y recomendaciones estratégicas para que tomes las mejores decisiones y logres tus objetivos con éxito.",
    image: "lib/src/img/home/Asesoria.jpg",
  ),
  CardPackWithConscience(
    title: "Calidad",
    description:
        "Nos comprometemos con los más altos estándares de calidad en cada detalle de nuestros productos y servicios. Cada proceso es cuidadosamente supervisado y controlado para garantizar resultados consistentes, duraderos y a la altura de tus expectativas, porque sabemos que la excelencia marca la diferencia.",
    image: "lib/src/img/home/Calidad.jpg",
  ),
  CardPackWithConscience(
    title: "Cumplimiento",
    description:
        "Sabemos lo importante que es el tiempo para ti y tu negocio, por eso garantizamos cumplimiento puntual en cada entrega. Nuestro compromiso es brindarte confianza y seguridad a través de una planificación eficiente, tiempos claros y un seguimiento riguroso que asegure el respeto por los plazos acordados.",
    image: "lib/src/img/home/Cumplimiento.jpg",
  ),
  CardPackWithConscience(
    title: "Servicios",
    description:
        "Contamos con un portafolio de servicios integrales diseñados para impulsar tu negocio. Desde consultoría técnica y desarrollo de soluciones hasta soporte postventa, trabajamos contigo para ofrecerte un acompañamiento completo, adaptado a tus necesidades y enfocado en el crecimiento sostenible de tus proyectos.",
    image: "lib/src/img/home/Servicios.jpg",
  ),
];
