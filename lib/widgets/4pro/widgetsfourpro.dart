import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webpack/widgets/header.dart';

class InfoCardData {
  final String? imagePath;
  final String title;
  final String description;
  final bool isVideo;
  final String? videoPath;

  InfoCardData({this.imagePath, this.isVideo = false, this.videoPath, required this.title, required this.description});
}

class InfoCard extends StatefulWidget {
  final InfoCardData data;
  final double maxFontSize;
  final bool isup;

  const InfoCard({super.key, required this.data, required this.maxFontSize, this.isup = false});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  Widget _buildMediaContent() {
    if (widget.data.isVideo && widget.data.videoPath != null) {
      return AspectRatio(
        aspectRatio: 16 / 9, // puedes ajustar el aspecto según tu diseño
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: videoBlurNotifier,
                builder: (context, isBlur, _) {
                  return HtmlBackgroundVideo(
                    src: widget.data.videoPath!,
                    blur: isBlur,
                    loop: false,
                    showControls: false,
                    fit: BoxFit.contain,
                    isPause: false,
                    retry: true,
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(widget.data.imagePath!, fit: BoxFit.contain));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(color: const Color.fromARGB(255, 237, 243, 255), borderRadius: BorderRadius.circular(16)),
      child:
          widget.isup
              ? Column(
                children: [
                  const SizedBox(height: 20),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.data.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: min(screenWidth * 0.015, 15),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: widget.data.description,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.015, 15), color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.015, 15), color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: _buildMediaContent()),
                ],
              )
              : Column(
                children: [
                  Expanded(child: _buildMediaContent()),
                  const SizedBox(height: 20),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.data.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: min(screenWidth * 0.015, 15),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: widget.data.description,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: min(screenWidth * 0.015, 15), color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: max(10, screenWidth * 0.015)),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
    );
  }
}

Widget buildResponsiveInfoCards(BuildContext context) {
  final List<InfoCardData> items = [
    InfoCardData(
      imagePath: "assets/img/smartbag/4pro/cuatrilamina.webp",
      title: "Cuatro capas ",
      description:
          "una protección total. La 4PRO combina PET, BOPP y PE \npara ofrecer una barrera contra la humedad, la luz y el oxígeno,\n con una presentación elegante y segura.",
    ),
    InfoCardData(
      isVideo: true,
      videoPath: "assets/videos/smartbag/accesorios/accesorios.webm",
      imagePath: "assets/img/smartbag/4pro/accesorios.webp",
      title: "Agrega funcionalidad con accesorios inteligentes. ",
      description:
          "\nEl sistema Peel Stick permite abrir y cerrar la bolsa fácilmente.\n Las válvulas desgasificadoras conservan productos frescos por más tiempo.",
    ),
    InfoCardData(
      imagePath: "assets/img/smartbag/4pro/terminacion.webp",
      title: "Tu decides la terminación ",
      description:
          "brillante para un acabado \nmás reflectivo, Mate para una apariencia elegante y sobria, \ny Ventana para mostrar el producto sin perder protección.\n ",
    ),
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 700;

      if (isMobile) {
        return Column(
          children:
              items
                  .map(
                    (data) => SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(padding: const EdgeInsets.all(8.0), child: InfoCard(data: data, maxFontSize: 30)),
                    ),
                  )
                  .toList(),
        );
      } else {
        return SizedBox(
          width: min(constraints.maxWidth, 1300),
          height: 950, // Fuerza altura consistente en ambos lados
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 468, child: InfoCard(data: items[0], maxFontSize: 16, isup: true)),
                    SizedBox(height: 14),
                    SizedBox(height: 468, child: InfoCard(data: items[1], maxFontSize: 16, isup: true)),
                  ],
                ),
              ),
              SizedBox(width: 16), // ← control explícito del espacio horizontal
              Expanded(child: SizedBox(height: 950, child: InfoCard(data: items[2], maxFontSize: 16))),
            ],
          ),
        );
      }
    },
  );
}

//Letras 4pro ecobag
class AnimatedLetter extends StatefulWidget {
  final String char;
  final bool visible;
  final TextStyle textStyle;

  const AnimatedLetter({super.key, required this.char, required this.visible, required this.textStyle});

  @override
  State<AnimatedLetter> createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.visible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedLetter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(opacity: _opacityAnimation, child: Text(widget.char, style: widget.textStyle)),
    );
  }
}
