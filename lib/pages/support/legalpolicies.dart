import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class LegalPolicies extends StatelessWidget {
  const LegalPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                width: 1024,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(title: "PACKVISION S.A.S POLITICAS LEGALES Y REGLAMENTARIAS"),
                    Text(
                      "Ultima actualización: Abril 3, 2025",
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                    ),
                    SizedBox(height: 60),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [Title(title: "Contenido")]),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Glosaryitem(number: "1. ", about: "Políticas de legalidad."),
                          Glosaryitem(number: "2. ", about: "Políticas para impresos."),
                          Glosaryitem(number: "3. ", about: "Políticas de cantidades."),
                          Glosaryitem(number: "4. ", about: "Políticas para aprobaciones."),
                          Glosaryitem(number: "5. ", about: "Políticas para tiempos de entrega."),
                          Glosaryitem(number: "6. ", about: "Políticas de fotopolímeros y servicios."),
                          Glosaryitem(number: "7. ", about: "Políticas de cotizaciones."),
                          Glosaryitem(number: "8. ", about: "Políticas para genéricos."),
                          Glosaryitem(number: "9. ", about: "Políticas de muestras para genéricos."),
                          Glosaryitem(number: "10. ", about: "Políticas de pagos."),
                          Glosaryitem(number: "11. ", about: "Políticas de exportaciones."),
                          Glosaryitem(number: "12. ", about: "Políticas de peticiones, quejas o reclamos."),
                          Glosaryitem(number: "13. ", about: "Políticas de garatía y devolución."),
                          Glosaryitem(number: "14. ", about: "Políticas de calidad."),
                          Glosaryitem(
                            number: "15. ",
                            about: "Políticas de prestación de servicios publicitarios y diseño.",
                          ),
                          Glosaryitem(number: "16. ", about: "Políticas de códigos de barras de Packvisión."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Footer(),
            ],
          ),
          Header(),
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
            text: number,
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withAlpha(200)),
          ),
          TextSpan(
            text: about,
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withAlpha(200)),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 30),
    );
  }
}
