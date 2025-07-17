import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.hourglass, size: 40, color: Theme.of(context).primaryColor),
                    Text(
                      "Proximamente disponible.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Theme.of(context).primaryColor),
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
