import 'package:flutter/material.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class LegalPolicies extends StatefulWidget {
  const LegalPolicies({super.key});

  @override
  State<LegalPolicies> createState() => _LegalPoliciesState();
}

class _LegalPoliciesState extends State<LegalPolicies> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
      fontSize: 18,
    );

    final hoverStyle = defaultStyle.copyWith(decoration: TextDecoration.underline);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 100,
                    horizontal: MediaQuery.of(context).size.width > 1024 ? 100 : 20,
                  ),
                  width: 1200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title(title: "PACKVISIÓN S.A.S - POLÍTICAS LEGALES Y REGLAMENTARIAS"),
                      const SizedBox(height: 10),
                      Text(
                        "Última actualización: Abril 3, 2025",
                        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      ),
                      const SizedBox(height: 60),

                      // Índice
                      Center(child: Title(title: "Contenido")),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            glossaryitem.map((item) => Glosaryitem(number: item.index, about: item.title)).toList(),
                      ),
                      const SizedBox(height: 40),
                      ...glossaryitem.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Title(
                                title: "${item.index}. ${item.title}",
                                color: Theme.of(context).colorScheme.secondary.withAlpha(150),
                              ),
                              const SizedBox(height: 10),
                              if (item.content != null) item.content!,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Packvision, Ecobag, Smartbag, Mitteland y sus logotipos son marcas registradas, se prohíbe su uso y distribución.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Los datos personales serán tratados cumpliendo los principios y regulaciones previstas en las leyes de Colombia, de acuerdo con lo que determina la ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: MouseRegion(
                                    onEnter: (_) => setState(() => _isHovering = true),
                                    onExit: (_) => setState(() => _isHovering = false),
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        navigateWithSlide(context, '/Soporte/Politicas/Tratamiento-de-datos');
                                      },
                                      child: Text(
                                        "Política de Protección de Datos Personales.",
                                        style:
                                            _isHovering
                                                ? hoverStyle.copyWith(
                                                  decoration: TextDecoration.underline,
                                                  decorationColor: Theme.of(context).colorScheme.primary,
                                                  decorationThickness: 2,
                                                )
                                                : defaultStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
          const Header(),
        ],
      ),
    );
  }
}

class Glosaryitem extends StatelessWidget {
  final String number;
  final String about;
  const Glosaryitem({super.key, required this.number, required this.about});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$number. ",
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: " $about",
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withAlpha(200)),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  final Color? color;
  const Title({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.bold, color: color ?? Theme.of(context).primaryColor, fontSize: 30),
    );
  }
}

class Glossaryitem {
  final String index;
  final String title;
  final Widget? content;

  Glossaryitem({required this.index, required this.title, this.content});
}

final List<Glossaryitem> glossaryitem = [
  Glossaryitem(
    index: "1",
    title: "Políticas de legalidad.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "En PACKVISIÓN S.A.S., nos comprometemos con el cumplimiento estricto de la legalidad vigente. Aceptamos órdenes de impresión exclusivamente cuando estas se alinean con la normatividad legal de Colombia, incluidos los registros de marca y todos los requisitos relacionados. Para los pedidos internacionales, se requiere el cumplimiento de las leyes y regulaciones del país destinatario de la exportación.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "En caso de que el pedido no cumpla los requisitos se informará al cliente por escrito explicando las razones específicas de la no aceptación del trabajo, asegurando la transparencia.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Esta política garantiza que nuestras operaciones se mantengan dentro de un marco legal tanto a nivel nacional como internacional, asegurando una práctica ética y responsable en la producción y distribución de nuestros empaques.",
        ),
        const SizedBox(height: 20),
        Text(style: TextStyle(height: 2, fontSize: 15), "Procedimiento de verificación legal:"),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "1. ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Recepción de documentos: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Todos los pedidos deben ir acompañados de la documentación legal requerida. (RUT, CAMARA DE COMERCIO, CEDULA REPRESENTANTE LEGAL, FORMATO DE CREACION Y/0 ACTUALIZACIÓN DE CLIENTES).",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "2. ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Revisión del cumplimiento: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "El departamento de ventas y legal revisarán la documentación en un plazo no mayor a 3 días hábiles.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "3. ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Notificación: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Si se encuentran incumplimientos, se notificará al cliente por escrito en un plazo de 5 días hábiles con las razones específicas.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "4. ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Aprobación: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text: "Solo se procederá con la producción una vez que todos los requisitos legales estén en regla.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "2",
    title: "Políticas para impresos.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Responsabilidad sobre dimensiones de empaque. ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Las especificaciones dimensionales del empaque, incluyendo largo, alto, ancho, entre otros parámetros expresados en centímetros o milímetros, recaen bajo la responsabilidad exclusiva del cliente. Esto se debe a que la adecuación de las medidas del empaque depende intrínsecamente de las particularidades del producto a empacar, como su densidad y otros factores físicos que solo el cliente conoce detalladamente.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "SISTEMA DE IMPRESIÓN LAMINADOS. ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Los empaques fabricados por PACKVISION incluyen policromía en el proceso flexográfico y las etiquetas por sistema de impresión digital e inyección.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Dentro de los parámetros normales, pueden variar los tonos del color en un ±10% entre un rango del máximo, ideal y mínimo, debido al proceso de impresión antes descrito y otros factores externos normales e influyentes como el clima, etc.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "En caso de requerirse un empaque con laminación especial, sea UHT, poliamida o laminaciones con películas particulares se tendrá un incremento hasta del 35% sobre el valor del empaque con base en la lista de precios establecida.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "La cantidad mínima de impresión sera de:",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "1.000 unidades para formatos de empaques 4PRO y Flow pack.\n2.000 unidades para formatos en Doy pack.\n3.000 unidades para formatos tipo cojín (SACHET) menor a 15×15 y Bottom Pro (5PRO).",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
          "Revisión Técnica Preliminar.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Antes de la producción nuestro equipo técnico revisará las especificaciones proporcionadas por el cliente y en caso de ser necesario ofrecerá recomendaciones si llegase a detectar posibles inconsistencias o mejoras.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para la venta en rollo, el cliente debe proporcionar el plano mecánico de la maquina llenadora, confirmando el tipo de desembobinado que será utilizado por el maquilador.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para productos con componentes probablemente químicamente agresivos se solicitará una muestra del producto y su ficha técnica de obligatoriedad antes de iniciar el proceso de producción para realizar pruebas laminación, evitando así, novedades en los empaques.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para confirmar que las dimensiones de los empaques son aptas para la capacidad del producto, se solicitará una muestra de acuerdo con el peso neto a empacar por bolsa teniendo en cuenta el formato y las medidas del empaque ofertado.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff004F9E)),
          "Para estas pruebas de laminación y llenado el cliente deberá asumir el costo según lista de precios establecida.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "3",
    title: "Políticas de cantidades.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Variación de unidades por excesos y faltantes menor a 3.000 unidades solicitadas: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "La variación de excesos resultantes en la fabricación para 1.000 y 2.000 unidades puede oscilar entre un 30% hasta un 50%, por encima o por debajo de la cantidad acordada y esto será de aceptación del cliente en ambos casos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Variación de unidades por excesos y faltantes mayor a 3.000 unidades solicitadas: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "La variación de excesos resultantes en la fabricación para unidades superiores a 3.000 unidades puede oscilar en un 10%, por encima o por debajo de la cantidad acordada y esto será de aceptación del cliente en ambos casos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "4",
    title: "Políticas de aprobaciones.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "El cliente es responsable directo de la verificación, validación y aprobación de los artes, como textos, colores, terminación, dimensiones, legales y demás aspectos técnicos pertenecientes al arte o diseño.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Las aprobaciones de arte deben recibirse de manera formal por parte del cliente por medio de email o WhatsApp adjuntando el plano mecánico debidamente firmado como apreciación de que toda la información anteriormente descrita está correcta y ha sido aprobada.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff004F9E)),
          "A partir de la fecha de aprobación formal del arte por parte del cliente se cuentan los tiempos de entrega.",
        ),
        const SizedBox(height: 20),
      ],
    ),
  ),
  Glossaryitem(
    index: "5",
    title: "Políticas para tiempos de entrega.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "1. Es de treinta (30) días hábiles después de aprobado el arte para pedidos nuevos.\n2. Es de treinta (30) días hábiles después de aprobado el arte para pedidos de repetición con cambio.\n3. Es de (20) días hábiles para pedidos de repetición sin cambios.\n4. Es de (20) días hábiles después de aprobado para proyectos genéricos especiales sin diseño.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff004F9E)),
          "Nota: Son días hábiles contados de lunes a viernes (sin contar sábados, domingos o festivos).",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff004F9E)),
          "Opción de entrega acelerada",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "1. ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Entrega urgente: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Para entregas prioritarias, ofrecemos un servicio de entrega en 10 días hábiles con un recargo del 20% sobre el valor total del pedido.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "2. ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Entrega prioritaria: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Para pedidos urgentes, ofrecemos un servicio en 15 días hábiles con un recargo del 10% sobre el valor total del pedido.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "6",
    title: "Políticas de fotopolímeros.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Los Fotopolímeros, artes, Dummies, Registro de Marca, Sherpas, Branding, Logos, Códigos de Barras, Renders o Mock up SON POR CUENTA DEL CLIENTE, es decir, el cliente asumirá el costo de estos de acuerdo con la lista de precios establecida.",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "El precio del fotopolímero: ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text:
                    "El costo podrá variar por factores como las dimensiones, arte, tamaño de la bolsa y montajes especiales. Sin embargo, se debe considerar:",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "1. El valor mínimo de un fotopolímero es de \$375.000 más IVA para cada color para formatos 4PRO y Flow pack.\n2. Para formatos Doypack, Stand up y en los montajes compartidos tienen un valor mínimo de \$530.000 más IVA para cada color.\n3. Para empaques con capacidad superior o igual a 2.500g tiene un valor mínimo de \$505.000 más IVA por color.\n4. Para repeticiones con cambio el cliente tendrá que pagar nuevamente el fotopolímero, el cual, tendrá el mismo valor siempre y cuando esté en el mismo año calendario.\n5. Habrá una política especial de precios en fotopolímeros según cantidad de empaques solicitados.",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Propiedad de los fotopolímeros: ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "La propiedad de los fotopolímeros es del cliente y la cantidad de fotopolímeros podrá variar de acuerdo con el diseño. Los fotopolímeros son un artículo en consignación, por lo tanto, es responsabilidad del cliente asumir los valores de reposición por uso repetitivo o constante. La reposición de estos es necesaria debido al desgaste que sufre el fotopolímero en el proceso de impresión.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Facturación de los fotopolímeros: ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Se llevará a cabo en la misma fecha de su elaboración y consignación dentro de la base de datos de PACKVISION SAS para su debido alistamiento; esto por temas de control de inventarios.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Duración de los fotopolímeros: ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Los estándares de cambio por desgaste de los fotopolímeros es con base en las películas que se imprimen, se constituyen a los 65.000 metros aproximadamente para poliésteres (PET), polipropilenos (BOPP) y para papel (KRAFT) se establecen 40.000 metros aproximadamente.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "A partir del día 2 de mayo, se establece una nueva política sobre ventas, la cual incluye que los fotopolímeros serán incluidos en el valor del empaque. Esto está diseñado para facilitar el proceso de facturación y pago, eliminar la necesidad de facturaciones separadas y hacer más expedito el servicio de impresión flexográfico.",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Costos adicionales en el proceso de impresión:  ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Para los pedidos que tengan Pantones especiales, lacas, tintas con acabados especiales (fluorescentes, terminado metálico) tendrá un incremento hasta del 15% sobre el valor del empaque con base en la lista de precios. Sin embargo, se evaluará cada caso respectivamente calculando así el precio del empaque con respecto a cada tinta especial.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Costos adicionales en el proceso de impresión para montajes compartidos o coimpresos:  ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Para casos donde se puedan imprimir referencias con las mismas dimensiones en un solo montaje, se debe tener en cuenta que el costo de los fotopolímeros aumentará en un 20% sobre la base según el formato del empaque a trabajar.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para trabajos coimpresos (referencias que comparten montajes) las medidas de las referencias deben ser iguales y el tamaño final del montaje deberá ser apto según parámetros técnicos internos, elaborando cantidades iguales de cada referencia. Luego de elaborar una producción por coimpresión, no se podrán cambiar o modificar las referencias establecidas en cada montaje sin incurrir en costos adicionales. Para futuras producciones se deberán elaborar las mismas cantidades de cada referencia. De acuerdo con la configuración del montaje, si es vertical tener en cuenta que las referencias se entregan surtidas, si es horizontal las referencias se entregan independientes.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "7",
    title: "Políticas de cotizaciones.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Las cotizaciones u ofertas comerciales se elaboran de acuerdo con la solicitud del cliente (tipo de empaque, capacidad, acabado, colores, unidades por referencia, accesorios opcionales adicionales, entre otros.). En ocasiones se elaboran cotizaciones a escala para evaluar la variación en los costos de producción según cantidad de empaques solicitados, por lo tanto, se recomienda tomar el valor unitario como base. Hay que recordar que los valores de los accesorios como válvula y Peel & Stick son adicionales, sin embargo, el cliente deberá confirmar la cantidad de accesorios a instalar antes de cerrar la negociación con el comercial.",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Validez de la oferta: ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text:
                    "Las cotizaciones tienen una vigencia 15 días hábiles a partir del momento de emisión de la propuesta comercial. Luego de este plazo pueden presentarse cambios por actualización de precios.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold),
          "Nota: Si aplica retención en la fuente a PACKVISION SAS, una vez emitida la factura para la entrega, requerimos el certificado de retención en la fuente.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "8",
    title: "Políticas de genéricos.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold),
          "Los empaques genéricos se utilizan para productos como Café, Panela, Frutos secos, Semillas, etc.",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Empaques genéricos: ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text:
                    "El tiempo de entrega del empaque genérico con accesorios varía dependiendo del tipo y cantidades de cada uno.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: Color(0xff052344), borderRadius: BorderRadius.circular(12)),
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Color(0xff004F9E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("REFERENCIA", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("VENTA MÍNIMA", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Referencias de 500g /340g/ 250g / 125g Doypack")),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "La cantidad mínima de venta es de 50 unidades",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Referencias de 125g 4PRO y FLOWPACK o SACHET pequeños igual o menor a 30cm de repetición.",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "La cantidad mínima de venta es de 100 unidades",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Referencias de 1000g/2500g o cojines mayores a 30 cm de repetición."),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "La cantidad mínima de venta es de 30 unidades",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: Color(0xff052344), borderRadius: BorderRadius.circular(12)),
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
            4: FlexColumnWidth(),
          },
          children: const [
            TableRow(
              decoration: BoxDecoration(
                color: Color(0xff004F9E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("ACCESORIOS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("50 a 500", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("501 a 1.000", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("1001 a 3.000", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("3.001 a 10.000", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Con válvula.")),
                Padding(padding: EdgeInsets.all(12), child: Text("En sitio")),
                Padding(padding: EdgeInsets.all(12), child: Text("½ día")),
                Padding(padding: EdgeInsets.all(12), child: Text("1 día hábil")),
                Padding(padding: EdgeInsets.all(12), child: Text("3 días hábiles")),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Con Peel Stick.")),
                Padding(padding: EdgeInsets.all(12), child: Text("En sitio")),
                Padding(padding: EdgeInsets.all(12), child: Text("½ día")),
                Padding(padding: EdgeInsets.all(12), child: Text("1 día hábil")),
                Padding(padding: EdgeInsets.all(12), child: Text("3 días hábiles")),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Con válvula + Peel Stick.")),
                Padding(padding: EdgeInsets.all(12), child: Text("En sitio")),
                Padding(padding: EdgeInsets.all(12), child: Text("½ día")),
                Padding(padding: EdgeInsets.all(12), child: Text("1 día hábil")),
                Padding(padding: EdgeInsets.all(12), child: Text("3 días hábiles")),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Con etiqueta 1 cara.")),
                Padding(padding: EdgeInsets.all(12), child: Text("2 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("4 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("6 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("10 días hábiles")),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Con etiqueta 2 caras.")),
                Padding(padding: EdgeInsets.all(12), child: Text("4 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("5 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("8 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("12 días hábiles")),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Con etiqueta especial cara fuelle o cara dorso.")),
                Padding(padding: EdgeInsets.all(12), child: Text("6 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("8 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("10 días hábiles")),
                Padding(padding: EdgeInsets.all(12), child: Text("15 días hábiles")),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold),
          "Nota: Los días en mención en el cuadro anterior son días hábiles.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "9",
    title: "Políticas de muestras para genéricos.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    "Las muestras de empaques genéricos se venden por paquetes de 10 unidades en su totalidad.  El valor comercial de la muestra varía de acuerdo con el tamaño y referencia de empaque. ",
                style: TextStyle(height: 2, fontSize: 15),
              ),
              TextSpan(
                text: "No se entregan muestras gratis.",
                style: TextStyle(fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Existen en el inventario paquetes prediseñados con contenido de empaques, que se encuentran disponibles en cada una de las sedes caracterizados por tamaño, diferencia de colores y terminados, para que los clientes puedan apreciar calidad, materiales y funcionalidades. Los paquetes de muestras tienen 10 unidades con un costo de 23.800 pesos para empaques hasta 500g y un costo de 38.000 pesos para empaques de 1.000g en adelante, hasta los más grandes de 5000g.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para estas muestras no existen devoluciones ni cambios, las políticas de envío se mantienen vigentes para las entregas de estas muestras.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "10",
    title: "Políticas de pagos.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Forma de pago:  ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "Recibimos todos los medios de pago. Toda venta causa el 19% de impuesto de valor agregado I.V.A.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "1.  ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),
              TextSpan(
                text: "Para clientes de empaques impresos: ",
                style: TextStyle(fontSize: 17, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "El pago será 70% de anticipo (correspondiente al valor total de la cotización Incluyendo el IVA) y el 30% cuando sale la orden de producción. El cliente deberá pagar el 100% del costo de su pedido para que se genere el despacho y entrega de la mercancía.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 1.5, fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff004F9E)),
          "Nota: Pago a crédito de 30, 60 y 90 días aplica para clientes que hayan pasado el estudio de crédito, hayan recibido la aprobación y asignación del cupo. ",
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "2.  ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),

              TextSpan(
                text:
                    "La forma de pago para empaques genéricos se debe realizar en su totalidad antes de despachar el producto.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "3.  ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),

              TextSpan(
                text:
                    "En caso de utilizar Davivienda en consignación en efectivo fuera del casco urbano de Bogotá, se cobra una comisión de \$14.500 pesos que deberán ser asumidos por el cliente.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "4.  ", style: TextStyle(fontSize: 17, color: Color(0xff004F9E))),

              TextSpan(
                text:
                    "En caso de no utilizar el convenio (56553) con Bancolombia se debe asumir la comisión de \$12.700 adiciónales/aplica en caso de corresponsales y consignaciones por el cliente.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Cuando el pago es realizado en moneda nacional:",
          style: TextStyle(fontSize: 30, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Medios de pago:",
                  style: TextStyle(fontSize: 27, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/PSE.webp")),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/Nequi.webp")),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/Daviplata.webp")),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/American_express.webp")),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/Visa.webp")),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/Diners.webp")),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff004F9E)),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage("assets/img/support/Wompi.webp")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Cuando el pago es realizado en dólares:",
          style: TextStyle(fontSize: 30, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: Color(0xff052344), borderRadius: BorderRadius.circular(12)),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.5),
            4: FlexColumnWidth(2),
            5: FlexColumnWidth(2),
          },
          children: const [
            TableRow(
              decoration: BoxDecoration(
                color: Color(0xff004F9E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Nombre del Banco", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Dirección", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Código SWIFT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("ABBA", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Titular de la cuenta",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Número de cuenta", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Davivienda Internacional")),
                Padding(padding: EdgeInsets.all(12), child: Text("801 Brickell Ave. PH1\nMiami FL 33131")),
                Padding(padding: EdgeInsets.all(12), child: Text("CAFEUS3M")),
                Padding(padding: EdgeInsets.all(12), child: Text("066011389")),
                Padding(padding: EdgeInsets.all(12), child: Text("PACKVISION SAS")),
                Padding(padding: EdgeInsets.all(12), child: Text("891254020")),
              ],
            ),
          ],
        ),
        Text(
          "Cuando el pago es realizado en euros:",
          style: TextStyle(fontSize: 30, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: Color(0xff052344), borderRadius: BorderRadius.circular(12)),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
            5: FlexColumnWidth(2),
            6: FlexColumnWidth(2),
            7: FlexColumnWidth(2),
          },
          children: const [
            TableRow(
              decoration: BoxDecoration(
                color: Color(0xff004F9E),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Nombre del Banco", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Dirección", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Código SWIFT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("IBAN", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Banco Beneficiario", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Cuenta del Beneficiario",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Titular de la cuenta",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Número de cuenta", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(padding: EdgeInsets.all(12), child: Text("Standard Chartered Bank Fráncfort")),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Franklinstrasse 46-48\nFráncfort del Meno, Alemania"),
                ),
                Padding(padding: EdgeInsets.all(12), child: Text("SCBLDEFX")),
                Padding(padding: EdgeInsets.all(12), child: Text("DE78 5123 0500 0050 021005")),
                Padding(padding: EdgeInsets.all(12), child: Text("Davivienda Internacional")),
                Padding(padding: EdgeInsets.all(12), child: Text("5002100")),
                Padding(padding: EdgeInsets.all(12), child: Text("PACKVISION SAS")),
                Padding(padding: EdgeInsets.all(12), child: Text("891254020")),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "11",
    title: "Políticas de exportaciones.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Exportaciones: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Los precios son para valores en dólares y en euros, EXW Bogotá y todos los costos y gastos de la operación de la exportación van por cuenta del cliente. Se maneja todos los términos legales establecidos para esta clase de operaciones. No causa IVA, siempre y cuando el cliente anexe el documento DEX legal o certificados equivalentes expedidos por la entidad competente (DIAN).",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  ),
  Glossaryitem(
    index: "12",
    title: "Políticas de envío",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Recomendaciones generales:",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "1. La entrega de pedidos es EXW en nuestra fábrica en Mosquera.\n2. Pedidos de bolsas genéricas de entrega local (Bogotá) mayores a \$1.000.000 de pesos + IVA no pagan flete.",
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "3. Los pagos serán procesados una vez recibido el comprobante de pago, ya sea ",
                style: TextStyle(height: 2, fontSize: 15),
              ),
              TextSpan(
                text:
                    "vía WhatsApp al 317 868 91 25 o al correo electrónico del dominio @empaquespackvision.com del comercial que le atiende.",
                style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "4. Los empaques vendidos en promoción no tienen cambio ni devolución.\n5. Para documentar referencias comerciales y de despachos, por favor enviar el RUT actualizado, indicando dirección de entrega y persona que recibe.\n6. Las entregas se programan por día, NO se especifica una hora determinada.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Política de Entrega:  Envíos Nacionales e Internacionales EXW (Ex Works).",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "PACKVISIÓN SAS desea asegurar que la experiencia de nuestros clientes con nuestros productos de empaque sea excepcional, incluso en el proceso de entrega. Para ello, hemos adoptado la política de entrega EXW (Ex Works), tanto para operaciones nacionales como internacionales, con las siguientes directrices:",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "1. Cobertura Directa interna:",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Para los pedidos impresos ",
                style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "dentro de nuestra cobertura en la ciudad de Bogotá, PACKVISIÓN SAS entregará los productos directamente mediante nuestra flota de vehículos, asegurando la responsabilidad completa sobre la entrega y tiempo hasta que el producto llegue a su destino.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Para pedidos de empaques genéricos ",
                style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "dentro de nuestra cobertura en la ciudad de Bogotá el cliente debe pagar una tarifa mínima de envío de \$20.000 pesos, este envío cubre el transporte de un máximo de 30 kilos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para pedidos de impresos o genéricos fuera de la cobertura el cliente seleccionará la transportadora de su preferencia y por medio de esta PACKVISIÓN hará el envío, el cliente asume los costos de envíos.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "2. Aplicación de Términos EXW:",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Bajo los términos EXW (Ex Works), cuando un pedido internacional esté listo para ser despachado la responsabilidad de PACKVISIÓN SAS se limita a poner la mercancía a disposición del cliente en nuestras instalaciones (SEDE CARVAJAL, SEDE NOGAL, SEDE TECPLAS).",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "3. Selección de la Transportadora según términos EXW:",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Una vez el pedido esté disponible para recogida, el cliente deberá seleccionar y coordinar directamente con una transportadora de su elección para la recogida y entrega de este.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "4. Coordinación con Transportadoras según términos EXW:",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "PACKVISION SAS proporcionará las medidas necesarias para que la recogida de la mercancía se realice de manera ordenada y eficiente, entregando todos los documentos necesarios que permitan el transporte de los productos.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "5. Transferencia de Riesgos:",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "La transferencia del riesgo al cliente ocurre en el momento que la mercancía se pone a disposición en las instalaciones de PACKVISION SAS para entregar a la compañía transportadora que el cliente haya elegido o autorizado previamente. Desde ese momento en adelante, toda la responsabilidad respecto a costos y riesgos de transporte, manejo, entrega y adicionales, correrán por cuenta del cliente.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "6. Sin Responsabilidad Sobre Tiempos de Entrega:",
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "PACKVISION SAS no tendrá responsabilidad sobre los tiempos de entrega una vez el pedido haya sido entregado a la transportadora. Cualquier consulta o reclamación sobre los tiempos de entrega debe ser dirigida a la empresa transportadora elegida por el cliente.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "7. Información y Soporte:",
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Nos comprometemos a brindar la información relevante del pedido que facilitará su seguimiento con la transportadora seleccionada por el cliente.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff004F9E)),
          "Esperamos que la claridad de esta política de envíos nacionales e internacionales EXW (Ex Works), ayude a gestionar de manera efectiva las expectativas y facilitar el proceso de envío para todos nuestros clientes. Para cualquier duda o consulta adicional, nuestro equipo de servicio al cliente estará más que dispuesto a asistirle.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "13",
    title: "Políticas de peticiones, quejas o reclamos.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Peticiones, quejas, reclamos o sugerencias: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Para manejar eficazmente cualquier reclamo de calidad, invitamos a nuestros clientes a comunicarse con nosotros enviando una notificación junto con la evidencia de la discrepancia (fotos y videos) a través de nuestro sistema de Peticiones, Quejas, Reclamos y Sugerencias (PQRS) al correo electrónico servicioalcliente@empaquespackvision.com",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Sobre los productos se da garantía por defectos de fabricación hasta por 30 días calendario, después de entregada la mercancía, a menos que el defecto sea ocasionado por manejo del cliente. La contestación a estos reclamos se realizará dentro de los siguientes 15 días hábiles siguientes a la fecha de la solicitud formal.  ",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Para los clientes tipo persona jurídica que estén bajo los parámetros del RADIAN, las notas crédito solo se pueden realizar dentro las 72 Horas siguientes a la emisión de la factura electrónica. Se debe gestionar la reclamación desde el formato de PQRS.",
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Devoluciones: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "En el caso de solicitar devoluciones de dinero se hará dentro de los 15 días hábiles siguientes cumpliendo los requerimientos de PQRS y descontando los valores causados por artes, renders, Dummies, elaboración de diseño y otros que apliquen, la devolución será sustentada de acuerdo con la política legal implementada para tal fin.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "14",
    title: "Políticas de garantía y devolución.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 17, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Garantía:",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Los productos proporcionados por nuestra empresa están cubiertos por una garantía que protege contra defectos de fabricación durante un período de 30 días calendario, contados a partir de la fecha en que la mercancía es entregada al cliente. Es imprescindible que el cliente examine la mercancía cuidadosamente al recibirla y nos informe inmediatamente de cualquier anomalía dentro del periodo estipulado de 30 días calendario. Pasado este lapso, no se aceptarán reclamaciones por defectos no informados.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Si un reclamo es realizado, nuestro equipo dará respuesta al mismo en un plazo no mayor de 15 días calendario. Para nuestros clientes de tipo persona jurídica que se encuentren sujetos a los parámetros del RADIAN, se informa que las notas de crédito correspondientes a reclamaciones solo podrán ser procesadas dentro de las 72 horas siguientes a la emisión de la factura electrónica. Todo reclamo debe ser gestionado a través de nuestro formato de PǪRS, asegurándose de seguir el procedimiento legalmente establecido. Debe ingresar a nuestra página web https://www.empaquespackvision.com, dirigirse a la parte superior izquierda y dar clic sobre nuestro apartado de políticas y desplegando el menú seleccionando la opción de “Encuesta de satisfacción y PQRS”, se desplegará la encuesta donde podrá ingresar sus datos, describir el problema o novedad  y adjuntar las evidencias fotográficas o de video necesarias para formalizar su petición, queja, reclamo o sugerencia.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 17, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Devolución:",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "El proceso para la solicitud de devolución de dinero será iniciado siguiendo estrictamente los requerimientos que establece la Ley 1480 de 2011. Las solicitudes deben ser realizadas dentro de los 15 días hábiles subsecuentes al hecho que motiva la devolución, y deberán dirigirse al correo electrónico servicioalcliente@empaquespackvision.com, incluyendo la evidencia detallada y documentada de los motivos de la devolución en un comunicado formal.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Debe considerarse que se descontarán del reembolso (en caso de que haya lugar para ello) los valores correspondientes a artes, renders, dummies, diseño y demás costos aplicables que se hayan generado. La devolución estará soportada y se realizará de acuerdo con la política legal que nos rige, previa evaluación y comprobación de los hechos presentados en la reclamación. En todo momento, nos regiremos por los principios de justicia y equidad para garantizar tanto la protección de los derechos del consumidor como la integridad de nuestras operaciones empresariales.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Tenga en cuenta que el compromiso con la calidad y la satisfacción del cliente es nuestra prioridad, y tomaremos todas las medidas necesarias para alcanzar y mantener altos estándares en todos nuestros productos y servicios.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 17, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "MARCO LEGAL LEY 1480 de 2011. Estatuto del Consumidor.",
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Actores principales:",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Consumidores: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Todo individuo o entidad que adquiere, utiliza o disfruta como destinatario final de bienes o servicios.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Productores o Proveedores: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Personas o entidades que producen, distribuyen, comercializan, venden o prestan servicios a los consumidores.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Contraste entre los Actores y Conducto Regular para Devoluciones:",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Derechos de Consumidor: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Los consumidores tienen el derecho a recibir información completa, veraz, transparente y oportuna sobre los productos y servicios que adquieren. Además, tienen derecho a la protección de su salud y seguridad, a la reparación y compensación por daños y perjuicios y a la libre elección del producto o servicio.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Obligaciones del Proveedor: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Es responsabilidad del proveedor asegurarse de que sus bienes y servicios cumplan con los estándares anunciados y no presenten defectos. Deben también proporcionar información precisa sobre sus productos y servicios y ofrecer métodos adecuados de atención al cliente para reclamaciones y devoluciones.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Conducto Regular para Solicitar Devoluciones:",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "1. Notificación de la Novedad: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "El consumidor debe notificar al proveedor sobre la necesidad de devolución, por escrito, ya sea por correo electrónico o mediante el formato de PǪRS (Peticiones, Ǫuejas, Reclamos y Sugerencias) si la empresa lo proporciona.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "2. Presentación de Pruebas: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "El consumidor debe adjuntar pruebas que sustenten su solicitud de devolución, tales como fotografías, descripciones del defecto, y copia de la factura o comprobante de compra.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "3. Plazos: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "De acuerdo con la Ley 1480, se estipula un término de 15 días hábiles para productos no perecederos desde la fecha de compra para que el consumidor ejerza su derecho al retracto (devolución) del bien en las condiciones originales, aunque esto puede variar en caso de defectos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "4. Respuesta del Proveedor: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "El proveedor está obligado a dar respuesta a la solicitud de devolución en un plazo máximo establecido, elaborando si es necesario una nota de crédito o procesando la devolución del dinero.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "5. Resolución: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Una vez evaluada y aceptada la devolución, se procederá según lo establecido en la ley, que podría implicar la reparación del producto, su reemplazo, la rescisión del contrato o la devolución del dinero descontando los valores que apliquen.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Derechos del proovedor:",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "1. Derecho a Recibir Pago: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Los proveedores tienen el derecho de recibir el pago acordado por los bienes y servicios que proporcionan.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "2. Derecho al Trato Justo: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Esperan ser tratados de manera justa y honesta por los consumidores, sin discriminación o abuso.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "3. Derecho a la Protección Legal: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text: "Tienen el derecho de defenderse contra reclamos deshonestos o fraudulentos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "4. Derecho a Rehusar Servicio: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Pueden rehusar el servicio bajo ciertas condiciones, que vayan en disonancia según las leyes del país.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "5. Derecho a la Propiedad Intelectual: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Mantener la propiedad intelectual de sus productos y proteger sus invenciones, marcas y trabajos creativos del robo o la falsificación.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15, color: Color(0xff004F9E), fontWeight: FontWeight.bold),
          "Obligaciones del Consumidor:",
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "1. Pagar los Bienes y Servicios: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text: "Los consumidores están obligados a pagar por los bienes y servicios que han acordado comprar.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "2. No Realizar Actos Fraudulentos: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Deben abstenerse de actividades fraudulentas, como el uso de tarjetas de crédito robadas o la apropiación indebida de descuentos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "3. Uso Adecuado de Productos y Servicios: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Deben utilizar los productos y servicios según las instrucciones y no hacer un uso indebido de ellos.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "4. Respetar las Condiciones de la Garantía: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Deben adherirse a las condiciones de cualquier garantía y seguir los procedimientos adecuados para las reclamaciones.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "5. Información Veraz:  ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text: "Proporcionar información precisa y honesta cuando devuelvan productos o presenten quejas.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "15",
    title: "Política de calidad",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    "En PACKVISION S.A.S., nuestra pasión es crear empaques flexibles de alta calidad que cumplan con las más estrictas normas de tecnología de exportación. Comprometidos con la seguridad alimentaria y la satisfacción del consumidor, ",
                style: TextStyle(height: 2, fontSize: 15),
              ),
              TextSpan(
                text:
                    "nos enorgullece contar con un empaque que no solo está libre de metales pesados, sino que también cumple con las rigurosas pruebas de migración, ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 15, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "asegurando su adecuación a los estándares internacionales para exportación, incluyendo aquellos establecidos por la Administración de Alimentos y Medicamentos de Estados Unidos (FDA).",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "Estamos comprometidos con la mejora continua y la adopción de estándares de calidad elevados. En línea con esto, hemos implementado prácticas de calidad fundamentales basadas en la norma ISO 9001 en nuestra planta y alentamos tanto a empleados como a proveedores a seguir estas directrices de gestión reconocidas mundialmente.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "16",
    title: "Políticas de prestación de servicios publicitarios y diseño",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.justify,
          style: TextStyle(height: 2, fontSize: 15),
          "1. Se generará una factura que incluirá el IVA correspondiente.\n2. Todo diseño o servicio de publicidad se facturará de acuerdo con la cotización previamente aceptada por el cliente.\n3. El tiempo de entrega para servicios de publicidad y diseño será de 20 a 30 días hábiles, sujeto a las características específicas del proyecto y después de haber sido aprobados los cambios.\n4. Para dar inicio al trabajo, se requerirá un pago del 70% del valor total de la cotización.",
        ),
      ],
    ),
  ),
  Glossaryitem(
    index: "17",
    title: "Políticas de códigos de barras de Packvision.",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "1. Proveedor de Códigos de Barras: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "En Packvision, trabajamos exclusivamente con GS1 Colombia para la gestión y obtención de códigos de barras para nuestros clientes. Esta alianza garantiza que los códigos generados cumplan con los estándares internacionales y ofrezcan una amplia compatibilidad y aceptación global.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "2. Formatos de Códigos de Barras: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Los códigos de barras gestionados por Packvision son en formato EAN de 13 dígitos, los cuales son ampliamente aceptados y reconocidos globalmente, incluyendo Estados Unidos. Este formato asegura que sus productos puedan ser comercializados en una variedad de mercados y plataformas a nivel mundial.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "3. Requisitos Especiales: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "En caso de que un cliente requiera un formato especial distinto al formato EAN de 13 dígitos, es imperativo que dicha solicitud sea formalizada por escrito y específica a través del asesor comercial que esté atendiendo al cliente. Esta solicitud debe ser detallada y debe contener la justificación del formato solicitado. ",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "4. Evaluación de Viabilidad: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Una vez recibida la solicitud escrita y específica del cliente para un formato especial, Packvision procederá a evaluar si es procedente o viable ejecutar dicha solicitud por medio de nuestros servicios. La viabilidad será determinada en base a nuestra capacidad técnica, conocimiento, y las políticas del proveedor GS1 Colombia.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "5. Códigos para Empaque (EAN 14): ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "En caso de que el cliente requiera un código de barras para empaque (es decir, unidades que están dentro de un empaque EAN 13), en formato EAN 14, deberá informarnos para que podamos gestionar el nuevo código de barras adecuado para el empaque. Este código adicional se cobrará como nuevo a la misma tarifa.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "6. Costo del Servicio: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "El costo de gestión de cada código de barras en formato EAN de 13 dígitos es de 350.000 COP + IVA. Este costo incluye todos los trámites necesarios para asegurar la obtención del código de barras conforme a los estándares de GS1 Colombia.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "7. Aclaración de Alcance: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Es importante señalar que Packvision cuenta con el conocimiento técnico y procedimental para trabajar con GS1 Colombia. No obstante, nuestras capacidades pueden estar limitadas en cuanto a la gestión de formatos específicos que no se alineen con nuestra política estándar de códigos de barras. En tales casos, el cliente será debidamente informado sobre las posibles limitaciones y alternativas disponibles.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "8. Contacto y Asesoría: ",
                style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 17, color: Color(0xff004F9E)),
              ),
              TextSpan(
                text:
                    "Para cualquier consulta adicional, asesoría, o para formalizar una solicitud de formato especial, los clientes pueden ponerse en contacto con su asesor comercial de Packvision. Nuestro equipo está comprometido con la calidad y la satisfacción del cliente, y estamos disponibles para asistirles en todo momento.",
                style: TextStyle(height: 2, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
];
