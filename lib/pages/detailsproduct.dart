import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: SingleChildScrollView(
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
                                  colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.tertiary],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (int index) {
                                  final List<double> opacities = [1.0, 0.5, 0.1];
                                  return Opacity(
                                    opacity: opacities[index],
                                    child: Text(
                                      "${widget.product.subcategorie!.title} " * 10,

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
                                              color: Theme.of(context).primaryColor.withAlpha(100),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(32),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                                              children: List.generate(4, (int index) {
                                                                return Container(
                                                                  margin: EdgeInsets.only(left: 2, right: 10),
                                                                  width: 16,
                                                                  height: 16,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.red,
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                            const SizedBox(height: 20),
                                                            const Text(
                                                              textAlign: TextAlign.justify,
                                                              "Nuestra Bolsa Rosa de Sharon Clavelina mate de 500g es elegante y de alta calidad, diseñada para envasar cualquier tipo de producto. Opcionalmente, puedes agregar una válvula desgasificadora y peel stick para mayor comodidad. Combina estilo y funcionalidad para destacar tu marca en el mercado.",
                                                              style: TextStyle(color: Colors.white70, fontSize: 16),
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
                                      color: Theme.of(context).primaryColor.withAlpha(100),
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
                                                    SizedBox(height: 500, child: Image.asset(widget.product.image)),

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
                                                      children: List.generate(4, (int index) {
                                                        return Container(
                                                          margin: EdgeInsets.only(left: 2, right: 10),
                                                          width: 16,
                                                          height: 16,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.circle,
                                                          ),
                                                        );
                                                      }),
                                                    ),

                                                    const SizedBox(height: 20),
                                                    Text(
                                                      "Nuestra Bolsa Rosa de Sharon Clavelina mate de 500g es elegante y de alta calidad, diseñada para envasar cualquier tipo de producto. Opcionalmente, puedes agregar una válvula desgasificadora y peel stick para mayor comodidad. Combina estilo y funcionalidad para destacar tu marca en el mercado.",
                                                      style: TextStyle(color: Colors.white70, fontSize: 16),
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
