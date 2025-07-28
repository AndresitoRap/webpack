import 'package:flutter/material.dart';

Widget buildZipperHermetico(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 900;

  return isMobile
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text("Cierra fácil. Abre mejor", style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),

            child: Text.rich(
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
              TextSpan(
                children: [
                  TextSpan(text: "Con sistema de\n"),
                  TextSpan(text: "zipper hermético.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
                ],
              ),
            ),
          ),
          Expanded(child: Container(color: Colors.transparent)),
        ],
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cierra fácil. Abre mejor", style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text.rich(
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
                    TextSpan(
                      children: [
                        TextSpan(text: "Con sistema de\n"),
                        TextSpan(text: "zipper hermético.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container(color: Colors.transparent)),
        ],
      );
}

Widget buildVersionCierre(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "También sin zipper. Igual de segura",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Versión sin cierre,\n", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
              TextSpan(text: "para menor costo y más simpleza."),
            ],
          ),
        ),
      ),
      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildKraftVentanaTransp(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "Tu empaque, tu ventana al interior",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Kraft con "),
              TextSpan(text: "ventana transparente.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
            ],
          ),
        ),
      ),
      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildKraftSinVentana(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "Natural por fuera. Sorpresa por dentro",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Kraft sin ventana, para "),
              TextSpan(text: "máxima privacidad.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
            ],
          ),
        ),
      ),
      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildEstrucutra146(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Container(color: Colors.transparent)),

      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Alto desempeño "),
              TextSpan(text: "para productos sensibles.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
        child: Text("Estructura 146. Máxima barrera", style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600)),
      ),
    ],
  );
}

Widget buildEstrucutra141(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "Estructura 141. Ligereza optimizada",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Ideal ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
              TextSpan(text: "para "),
              TextSpan(text: "productos ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
              TextSpan(text: "secos o de alta rotación."),
            ],
          ),
        ),
      ),

      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildGramaje125g(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "Desde 125g. Perfecta para muestras",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(
                text: "Tamaño pequeño, impacto grande.",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44)),
              ),
            ],
          ),
        ),
      ),

      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildGramaje2500g(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "Hasta 2500g. Para lo que necesites",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Capacidad XL, ", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
              TextSpan(text: "ideal para mayor volumen."),
            ],
          ),
        ),
      ),

      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildListoParaTuMarca(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "Doypack Ecobag. Listo para tu marca",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Empaque neutro, "),
              TextSpan(text: "personalizable, profesional.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
            ],
          ),
        ),
      ),

      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildSienteElKraft(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text("Siente el kraft. Vive lo natural", style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Textura y apariencia premium "),
              TextSpan(text: "con esencia ecológica.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
            ],
          ),
        ),
      ),

      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}

Widget buildResumen(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          "11 opciones. Un solo propósito: cuidar",
          style: TextStyle(fontSize: (screenWidth * 0.03).clamp(10, 30), fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),

        child: Text.rich(
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: (screenWidth * 0.05).clamp(30, 50), height: 0.99),
          TextSpan(
            children: [
              TextSpan(text: "Toda una familia de "),
              TextSpan(text: "empaques con conciencia.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 141, 44))),
            ],
          ),
        ),
      ),

      Expanded(child: Container(color: Colors.transparent)),
    ],
  );
}
