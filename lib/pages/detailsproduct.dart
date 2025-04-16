import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class DetailsProduct extends StatefulWidget {
  final Product product;
  const DetailsProduct({super.key, required this.product});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  //Modelo
  late Flutter3DController controller;
  bool _showTutorial = true;

  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    controller = Flutter3DController();
    _scrollController =
        ScrollController()..addListener(() {
          setState(() {
            _scrollOffset = _scrollController.offset;
          });
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _hideTutorial() {
    if (_showTutorial) {
      setState(() {
        _showTutorial = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final product = widget.product;
    final categorie = widget.product.categoria;
    final subcategorie = widget.product.subcategorie;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 1000,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: -1000,
                          child: Transform.rotate(
                            angle: -0.6981,
                            child: Container(
                              width: 3000,
                              height: 400,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  end: AlignmentDirectional.bottomCenter,
                                  begin: AlignmentDirectional.topCenter,
                                  colors:
                                      categorie.name == "SmartBag"
                                          ? [Theme.of(context).primaryColor, Theme.of(context).colorScheme.tertiary]
                                          : [
                                            Color.fromARGB(255, 41, 112, 9).withAlpha(170),
                                            Color.fromARGB(255, 41, 112, 9).withAlpha(200),
                                          ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (int index) {
                                  final List<double> opacities = [1.0, 0.5, 0.1];
                                  return Opacity(
                                    opacity: opacities[index],
                                    child: Text(
                                      "${subcategorie.title} " * 10,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              screenWidth >= 1120
                                  ? Row(
                                    children: [
                                      SizedBox(width: screenWidth * 0.2),
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            width: min(screenWidth * 0.6, 1000),
                                            height: min(screenWidth * 0.6, 600),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(32),
                                              color:
                                                  categorie.name == "SmartBag"
                                                      ? const Color(0xFF004F9E).withAlpha(100)
                                                      : const Color(0xff4b8d2c).withAlpha(100),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(32),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: screenWidth * 0.1),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              product.name,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 40,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children:
                                                                  product.colors.map((color) {
                                                                    return Container(
                                                                      margin: const EdgeInsets.only(left: 2, right: 10),
                                                                      width: 20,
                                                                      height: 20,
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          color: Colors.white,
                                                                          width: 1,
                                                                        ),
                                                                        color: color,
                                                                        shape: BoxShape.circle,
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                            ),
                                                            const SizedBox(height: 20),
                                                            Text(
                                                              textAlign: TextAlign.justify,
                                                              product.description,
                                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -20,
                                            left: -600,
                                            child: Image.asset(widget.product.image, width: 1200),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                  : Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    width: screenWidth - 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      color:
                                          categorie.name == "SmartBag"
                                              ? const Color(0xFF004F9E).withAlpha(100)
                                              : const Color(0xff4b8d2c).withAlpha(100),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 400,
                                                      child: Center(
                                                        child: Image.asset(widget.product.image, fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.product.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children:
                                                          product.colors.map((color) {
                                                            return Container(
                                                              margin: const EdgeInsets.only(left: 2, right: 10),
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.white, width: 1),
                                                                color: color,
                                                                shape: BoxShape.circle,
                                                              ),
                                                            );
                                                          }).toList(),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      textAlign: TextAlign.justify,
                                                      product.description,
                                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.black26, width: 2)),
                    ),
                    child: Center(
                      child: Text(
                        "Escoge tu ${product.name}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      children: [
                        if (product.categoria.name == "EcoBag")
                          Text(
                            "Materiales sostenibles",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 41, 112, 9).withAlpha(170),
                              fontSize: 20,
                            ),
                          ),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          height: 600,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.grey),
                        ),
                        SizedBox(height: 40),
                        if (screenWidth >= 900)
                          SizedBox(
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final maxTop = 1800;
                                final currentTop = _scrollOffset < maxTop ? 0.0 : _scrollOffset - maxTop;

                                return Stack(
                                  children: [
                                    // Producto que se mueve (sticky)
                                    Positioned(
                                      top: min(currentTop, 1300),
                                      left: screenWidth * 0.06,
                                      child: Container(
                                        height: 500,
                                        width: screenWidth * 0.4,
                                        alignment: Alignment.topCenter,
                                        child: Stack(
                                          children: [
                                            Listener(
                                              onPointerDown: (_) => _hideTutorial(),
                                              onPointerMove: (_) => _hideTutorial(),
                                              child: Flutter3DViewer(
                                                activeGestureInterceptor: true,
                                                progressBarColor: Colors.transparent,
                                                enableTouch: true,
                                                controller: controller,
                                                src:
                                                    "lib/src/3Dmodels/SmartBag/4PRO/Rosa-de-Sharon/models/Clavelina_SinPS_Mate.glb",
                                              ),
                                            ),

                                            AnimatedOpacity(
                                              opacity: _showTutorial ? 1.0 : 0.0,
                                              duration: Duration(milliseconds: 500),
                                              onEnd: () {
                                                if (!_showTutorial) {
                                                  // opcional: puedes remover el widget si ya no se ve
                                                }
                                              },
                                              child: IgnorePointer(
                                                ignoring: true,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16),
                                                    color: Colors.black.withOpacity(0.3),
                                                  ),

                                                  alignment: Alignment.center,
                                                  child: Image.network(
                                                    "lib/src/gifts/cursor.gif",
                                                    width: 200,
                                                    height: 200,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Opciones con scroll normal
                                    Padding(
                                      padding: EdgeInsets.only(left: screenWidth * 0.5),
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ChooseBagTitle(
                                              text1: "Color.",
                                              text2: "Empecemos escogiendo tú color.",
                                              product: product,
                                            ),
                                            const SizedBox(height: 10),
                                            Text("Color", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Wrap(
                                                spacing: 10,
                                                children:
                                                    product.colors.map((color) {
                                                      return Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.white, width: 1),
                                                          color: color,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),

                                            const SizedBox(height: 30),
                                            ChooseBagTitle(
                                              text1: "Estructura.",
                                              text2: "Escoje la que prefieras.",
                                              product: product,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Delgada",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Brillante",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            ChooseBagTitle(
                                              text1: "Gramaje.",
                                              text2: "Efectividad en un 100%.",
                                              product: product,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "500G",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "250G",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "125G",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            ChooseBagTitle(
                                              text1: "Peel Stick.",
                                              text2: "El accesorio perfecto.",
                                              product: product,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children:
                                                  product.colors.map((color) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(left: 2, right: 10),
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.white, width: 1),
                                                        color: color,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    );
                                                  }).toList(),
                                            ),
                                            const SizedBox(height: 30),
                                            ChooseBagTitle(
                                              text1: "Valvula.",
                                              text2: "El respiro a tú empaque.",
                                              product: product,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Sin valvula",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Valvula desgasificadora",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Valvula dosificadora",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            ChooseBagTitle(
                                              text1: "Terminación.",
                                              text2: "El acabado a tú empaque.",
                                              product: product,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Brillante",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Mate",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Text(
                                                "Papel",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        else
                          Column(
                            children: [
                              Container(
                                height: 400,
                                child: Stack(
                                  children: [
                                    Listener(
                                      onPointerDown: (_) => _hideTutorial(),
                                      onPointerMove: (_) => _hideTutorial(),
                                      child: Flutter3DViewer(
                                        activeGestureInterceptor: true,
                                        progressBarColor: Colors.transparent,
                                        enableTouch: true,
                                        controller: controller,
                                        src:
                                            "lib/src/3Dmodels/SmartBag/4PRO/Rosa-de-Sharon/models/Clavelina_SinPS_Mate.glb",
                                      ),
                                    ),

                                    AnimatedOpacity(
                                      opacity: _showTutorial ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 500),
                                      onEnd: () {
                                        if (!_showTutorial) {
                                          // opcional: puedes remover el widget si ya no se ve
                                        }
                                      },
                                      child: IgnorePointer(
                                        ignoring: true, // para que los clics pasen al modelo
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: Colors.black.withOpacity(0.3),
                                          ),

                                          alignment: Alignment.center,
                                          child: Image.network("lib/src/gifts/cursor.gif", width: 200, height: 200),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChooseBagTitle(
                                      text1: "Color.",
                                      text2: "Empecemos escogiendo tú color.",
                                      product: product,
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Color", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Row(
                                      children:
                                          product.colors.map((color) {
                                            return Container(
                                              margin: const EdgeInsets.only(left: 2, right: 10),
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 1),
                                                color: color,
                                                shape: BoxShape.circle,
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(
                                      text1: "Estructura.",
                                      text2: "Escoje la que prefieras.",
                                      product: product,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text(
                                        "Delgada",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text(
                                        "Brillante",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(
                                      text1: "Gramaje.",
                                      text2: "Efectividad en un 100%.",
                                      product: product,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text("500G", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text("250G", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text("125G", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(
                                      text1: "Peel Stick.",
                                      text2: "El accesorio perfecto.",
                                      product: product,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children:
                                          product.colors.map((color) {
                                            return Container(
                                              margin: const EdgeInsets.only(left: 2, right: 10),
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 1),
                                                color: color,
                                                shape: BoxShape.circle,
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(
                                      text1: "Valvula.",
                                      text2: "El respiro a tú empaque.",
                                      product: product,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text(
                                        "Sin valvula",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text(
                                        "Valvula desgasificadora",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text(
                                        "Valvula dosificadora",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(
                                      text1: "Terminación.",
                                      text2: "El acabado a tú empaque.",
                                      product: product,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text(
                                        "Brillante",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text("Mate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey, width: 1),
                                      ),
                                      child: Text("Papel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  Footer(),
                ],
              ),
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}

class ChooseBagTitle extends StatelessWidget {
  final String text1;
  final String text2;
  final Product product;
  const ChooseBagTitle({super.key, required this.text1, required this.text2, required this.product});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      TextSpan(
        children: [
          TextSpan(
            text: "$text1 ",
            style: TextStyle(
              color: product.categoria.name == "SmartBag" ? const Color(0xFF004F9E) : const Color(0xff4b8d2c),
            ),
          ),
          TextSpan(text: text2),
        ],
      ),
    );
  }
}
