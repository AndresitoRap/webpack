import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/header.dart';

class FastHelp extends StatelessWidget {
  const FastHelp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 700,
                width: screenWidth,
                color: const Color.fromARGB(255, 209, 218, 237),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("data"), Image.asset("lib/src/img/support/support_chat.png")],
                ),
              ),
            ],
          ),
          Header(),
        ],
      ),
    );
  }
}
