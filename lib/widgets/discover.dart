import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webpack/widgets/build_recommended.dart';
import 'package:webpack/class/cardproduct.dart' show cardFindS;

// ignore: must_be_immutable
class Discover extends StatefulWidget {
  final String title;
  final ScrollController scrollController;
  final List<bool> ishoverlist;
  final List<bool> ishovericonlist;
  bool scrollControllerLeft = false;
  bool scrollControllerRigth = true;
  final dynamic list;
  Discover({
    required this.title,
    super.key,
    required this.list,
    required this.scrollController,
    required this.ishoverlist,
    required this.ishovericonlist,
    required this.scrollControllerLeft,
    required this.scrollControllerRigth,
  });

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Color getPrimaryColor(BuildContext context) {
      final route = ModalRoute.of(context)?.settings.name ?? '';

      if (route.toLowerCase().contains('ecobag')) {
        return const Color.fromARGB(255, 75, 141, 44);
      }

      return Theme.of(context).primaryColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.04),
          child: Stack(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: min(screenWidth * 0.07, 55),
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4
                        ..color = Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.07, 55))),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: widget.scrollController,
          child: Row(
            children: List.generate(widget.list.length, (int index) {
              final card = widget.list[index];
              final double horizontalPadding = screenWidth * 0.06;
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? horizontalPadding : 0, right: index == widget.list.length - 1 ? horizontalPadding : 20),
                child: AnimatedScale(
                  scale: widget.ishoverlist[index] ? 1.02 : 1.0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => widget.ishoverlist[index] = true),
                    onExit: (_) => setState(() => widget.ishoverlist[index] = false),
                    child: GestureDetector(
                      onTap: () {
                        ourservicesdialog(context, index, widget.list);
                      },
                      child: Container(
                        width: min(screenWidth * 0.52, 380),
                        height: min(screenWidth * 0.93, 700),
                        padding: EdgeInsets.only(top: 22, left: 22),
                        margin: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: MouseRegion(
                                onEnter: (_) => setState(() => widget.ishovericonlist[index] = true),
                                onExit: (_) => setState(() => widget.ishovericonlist[index] = false),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeInBack,
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.ishovericonlist[index] ? getPrimaryColor(context) : getPrimaryColor(context).withAlpha(200),
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: widget.ishovericonlist[index] ? 1 : 0.5,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(Icons.add_rounded, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card.title,
                                    style: TextStyle(
                                      height: 0,
                                      color: card.isblack ? Colors.black : Colors.white,
                                      fontSize: min(screenWidth * 0.02, 20),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    card.body,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 0,
                                      color: card.isblack ? Colors.black : Colors.white,
                                      fontSize: min(screenWidth * 0.03, 25),
                                      fontWeight: FontWeight.bold,
                                    ),
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
              );
            }),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(widget.scrollControllerLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                ),
                onPressed:
                    widget.scrollControllerLeft
                        ? () {
                          widget.scrollController.animateTo(
                            widget.scrollController.offset - 500,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        }
                        : null,
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(width: 20),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(widget.scrollControllerRigth ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
                ),
                onPressed:
                    widget.scrollControllerRigth
                        ? () {
                          widget.scrollController.animateTo(
                            widget.scrollController.offset + 500,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        }
                        : null,
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void ourservicesdialog(BuildContext context, int index, dynamic list) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final card = list[index];

        // ✅ Detectar si es SmartBag y aplicar color
        final bool isSmartBag = list == cardFindS;
        final Color primaryColor =
            isSmartBag
                ? const Color(0xFF0056A3) // Azul para SmartBag
                : const Color(0xFF4B8D2C); // Verde para EcoBag

        final ScrollController scrollController = ScrollController();

        return LayoutBuilder(
          builder: (context, constraints) {
            return Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(color: Colors.transparent)),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 50),
                            width: min(screenWidth * 0.9, 1260),
                            padding: EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: min(76, screenWidth * 0.09)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 60),

                                  // ✅ Título y subtítulo con color según tipo
                                  Text(card.title, style: TextStyle(fontSize: 20, color: primaryColor)),
                                  Text(
                                    card.body,
                                    style: TextStyle(fontSize: min(50, screenWidth * 0.06), fontWeight: FontWeight.bold, color: primaryColor),
                                  ),

                                  const SizedBox(height: 50),

                                  // ✅ Contenido inferior
                                  buildDialogContent(context, index, isSmartBag: isSmartBag),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // ❌ Botón cerrar (mismo diseño, se puede cambiar también si deseas)
                        Positioned(
                          top: 60,
                          right: 10,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(CupertinoIcons.xmark_circle_fill, size: 40, color: const Color.fromARGB(255, 71, 71, 71)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
