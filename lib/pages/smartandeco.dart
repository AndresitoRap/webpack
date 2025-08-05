import 'dart:math';
import 'dart:ui' as ui show ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webpack/class/cardproduct.dart' show cardFindS, cardFindE, CardProduct;
import 'package:webpack/class/categories.dart';
import 'package:webpack/main.dart';
import 'package:webpack/utils/responsive.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/scrollopacity.dart';

import 'package:webpack/widgets/video.dart';

class SmartAndEco extends StatelessWidget {
  final bool isEcobag;
  SmartAndEco({super.key, required this.isEcobag});

  //Seccion scrolleable
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    final color = isEcobag ? const Color(0xFF4B8D2C) : Theme.of(context).primaryColor;
    final isMobile = r.wp(100) < 850;

    return Scaffold(
      backgroundColor: isEcobag ? const Color(0xFFFBFFF8) : Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          if (isEcobag) const LeafAnimation(),

          CustomScrollView(
            controller: _scrollController,
            slivers: [
              //Inicio con el banner
              StartSliver(r: r, color: color, isEcobag: isEcobag),

              //Titulo con video
              TitleVideoSliver(r: r, isMobile: isMobile, scrollController: _scrollController, isEcobag: isEcobag, color: color),

              //Descubre
              DiscoverSmartSliver(r: r, color: color, isMobile: isMobile, isEcobag: isEcobag),

              //Nuestras lineas
              OurLinesSliver(r: r, color: color, isMobile: isMobile, isEcobag: isEcobag),

              //Footer
              SliverToBoxAdapter(child: Footer()),
            ],
          ),
          Header(),
        ],
      ),
    );
  }
}

//---------Inicio con los cliparts------------

class StartSliver extends StatefulWidget {
  final Responsive r;
  final Color color;
  final bool isEcobag;

  const StartSliver({super.key, required this.r, required this.color, required this.isEcobag});

  @override
  State<StartSliver> createState() => _StartSliverState();
}

class _StartSliverState extends State<StartSliver> {
  final ScrollController _scrollController = ScrollController();
  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;

    setState(() {
      _showRightArrow = current < maxScroll - 10;
      _showLeftArrow = current > 10;
    });
  }

  void _scrollBy(double offset) {
    final newPosition = _scrollController.offset + offset;
    _scrollController.animateTo(
      newPosition.clamp(_scrollController.position.minScrollExtent, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categorie = widget.isEcobag ? subcategorieEco : subcategorieSmart;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ScrollAnimatedWrapper(
          child: Container(
            width: widget.r.wp(100),
            color: widget.isEcobag ? const Color(0xC5F2FEEE) : const Color(0xC5E0F0FF),
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: widget.r.wp(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          categorie.where((item) => item.clipArt != null && item.clipArt!.isNotEmpty).map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  navigateWithSlide(context, item.route);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(item.clipArt!, height: 70),
                                      const SizedBox(height: 8),
                                      Text(item.title, style: TextStyle(fontSize: widget.r.fs(1.1, max(14, 16)), color: widget.color)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),

                // FLECHA IZQUIERDA
                if (widget.r.wp(100) < 750) ...[
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: _arrow(_showLeftArrow, -0.2, -150, CupertinoIcons.chevron_left, [
                      const Color.fromARGB(255, 224, 240, 255),
                      const Color.fromARGB(0, 255, 255, 255),
                    ]),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: _arrow(_showRightArrow, 0.2, 150, CupertinoIcons.chevron_right, [
                      const Color.fromARGB(0, 255, 255, 255),

                      const Color.fromARGB(255, 224, 240, 255),
                    ]),
                  ),

                  // FLECHA DERECHA
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedSlide _arrow(bool showscroll, double offset, double scroll, IconData icon, List<Color> colors) {
    return AnimatedSlide(
      offset: showscroll ? Offset.zero : Offset(offset, 0),
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: showscroll ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () => _scrollBy(scroll), // scroll a la izquierda
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(gradient: LinearGradient(colors: colors, begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Icon(icon, color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}

//---------Titulo con video------------
class TitleVideoSliver extends StatefulWidget {
  const TitleVideoSliver({
    super.key,
    required this.r,
    required this.isMobile,
    required this.scrollController,
    required this.isEcobag,
    required this.color,
  });
  final bool isEcobag, isMobile;
  final Color color;
  final Responsive r;
  final ScrollController scrollController;

  @override
  State<TitleVideoSliver> createState() => _TitleVideoSliverState();
}

class _TitleVideoSliverState extends State<TitleVideoSliver> {
  double scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();

    // Listener de scroll principal
    widget.scrollController.addListener(() {
      final offset = widget.scrollController.offset.clamp(0, 200);
      final progress = offset / 200;

      setState(() {
        scrollProgress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: widget.r.dp(4, max: 40)),
              child: ScrollAnimatedWrapper(
                child:
                    !widget.isMobile
                        ? Center(
                          child: SizedBox(
                            width: 1300,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Descubra ${widget.isEcobag ? "EcoBag®" : "SmartBag®"}",
                                    style: TextStyle(fontSize: widget.r.fs(4, 80), fontWeight: FontWeight.bold, color: widget.color),
                                  ),
                                  Text(
                                    "La fusión perfecta de diseño,\nempaque y protección ",
                                    style: TextStyle(fontSize: widget.r.fs(1.4, 28), height: 0, fontWeight: FontWeight.bold, color: widget.color),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        : Padding(
                          padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Descubra ${widget.isEcobag ? "EcoBag®" : "SmartBag®"}",
                                style: TextStyle(fontSize: widget.r.fs(4, 70), fontWeight: FontWeight.bold, color: widget.color),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "La fusión perfecta de diseño,\nempaque y protección ",
                                style: TextStyle(fontSize: widget.r.fs(2, 28), height: 0, fontWeight: FontWeight.bold, color: widget.color),
                              ),
                            ],
                          ),
                        ),
              ),
            ),

            Center(
              child: Builder(
                builder: (context) {
                  final borderRadius = BorderRadius.circular(30 * scrollProgress);
                  final horizontalPadding = widget.r.wp(100) * 0.055 * scrollProgress;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: SizedBox(
                        width: double.infinity,
                        height: min(widget.r.hp(100) * 0.8, 1100),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return VideoFlutter(
                                  src:
                                      widget.isEcobag
                                          ? 'assets/videos/ecobag/EcobagInicio.webm'
                                          : 'assets/assets/videos/smartbag/SmartbagInicio.webm',
                                  blur: isBlur,
                                  loop: true,
                                  showControls: true,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------Descubre Smart/Eco------------
class DiscoverSmartSliver extends StatefulWidget {
  final Responsive r;
  final Color color;
  final bool isMobile, isEcobag;

  const DiscoverSmartSliver({super.key, required this.r, required this.color, required this.isMobile, required this.isEcobag});

  @override
  State<DiscoverSmartSliver> createState() => _DiscoverSmartSliverState();
}

List<CardProduct> getCardProductList({bool isSmartBag = true}) {
  return isSmartBag ? cardFindS : cardFindE;
}

class _DiscoverSmartSliverState extends State<DiscoverSmartSliver> {
  final ScrollController _scroll = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_updateScroll);
  }

  void _updateScroll() {
    final maxScroll = _scroll.position.maxScrollExtent;
    final currentScroll = _scroll.position.pixels;

    setState(() {
      canScrollLeft = currentScroll > 0;
      canScrollRight = currentScroll < maxScroll;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.isEcobag ? cardFindE : cardFindS;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollAnimatedWrapper(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6), vertical: widget.r.hp(6)),
              child: Text(
                'Descubre ${widget.isEcobag ? 'Eco' : 'Smart'}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.r.fs(4, 60), color: widget.color),
              ),
            ),
          ),
          SizedBox(
            height: min(widget.r.wp(100) * 0.93, 700) + 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scroll,
              itemCount: cards.length,
              padding: EdgeInsets.symmetric(horizontal: widget.r.wp(6)),
              itemBuilder: (context, index) {
                final card = cards[index];
                final ValueNotifier<bool> isHoverCard = ValueNotifier(false);
                final ValueNotifier<bool> isHoverIcon = ValueNotifier(false);
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      ourservicesdialog(context, index, cards, widget.r);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => isHoverCard.value = true,
                      onExit: (_) => isHoverCard.value = false,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isHoverCard,
                        builder: (_, hover, __) {
                          return AnimatedScale(
                            scale: hover ? 1.02 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Container(
                              width: widget.r.dp(28, max: 500),
                              height: widget.r.dp(30, max: 600),
                              padding: const EdgeInsets.only(top: 22, left: 22),
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 22),
                                image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: MouseRegion(
                                      onEnter: (_) => isHoverIcon.value = true,
                                      onExit: (_) => isHoverIcon.value = false,
                                      child: ValueListenableBuilder<bool>(
                                        valueListenable: isHoverIcon,
                                        builder: (_, isHoveringIcon, __) {
                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            curve: Curves.easeInBack,
                                            width: widget.r.dp(3, max: 40),
                                            height: widget.r.dp(3, max: 40),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isHoveringIcon ? widget.color : widget.color.withAlpha(200),
                                            ),
                                            child: AnimatedOpacity(
                                              duration: const Duration(milliseconds: 300),
                                              opacity: isHoveringIcon ? 1 : 0.5,
                                              child: const Icon(Icons.add_rounded, color: Colors.white),
                                            ),
                                          );
                                        },
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
                                            fontSize: widget.r.fs(1.3, 20),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          card.body,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 0,
                                            color: card.isblack ? Colors.black : Colors.white,
                                            fontSize: widget.r.fs(1.5, 25),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: widget.r.dp(10, max: 50), horizontal: widget.r.wp(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _button(canScrollLeft, -500, Icons.arrow_back_ios_new_rounded),
                const SizedBox(width: 20),
                _button(canScrollRight, 500, Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _button(bool scroll, double offset, IconData icon) {
    return IconButton(
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(scroll ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80))),
      onPressed:
          scroll
              ? () {
                _scroll.animateTo(_scroll.offset + offset, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
              }
              : null,
      icon: Icon(icon),
    );
  }

  void ourservicesdialog(BuildContext context, int index, dynamic list, Responsive r) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final card = list[index];

        final ScrollController scrollController = ScrollController();

        return LayoutBuilder(
          builder: (context, constraints) {
            return Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
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

                                  Text(card.onTitle, style: TextStyle(fontSize: r.fs(1.1, 20), color: widget.color)),
                                  SizedBox(height: 10),
                                  Text(
                                    card.onBody,
                                    style: TextStyle(height: 0.99, fontSize: r.fs(1.8, 50), fontWeight: FontWeight.bold, color: widget.color),
                                  ),

                                  const SizedBox(height: 50),
                                  Column(children: [screenWidth < 1070 ? _buildPhone(card, r) : _buildDesktop(card, r)]),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  Column _buildDesktop(CardProduct card, Responsive r) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(card.imageTop, fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Column(
                        children: [
                          Text(
                            card.descriptionTop,
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 126, 129),
                              fontWeight: FontWeight.bold,
                              fontSize: r.fs(1.2, 22),
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: card.descriptionDown,
                                  style: TextStyle(color: Color(0xFF7D7E81), fontWeight: FontWeight.bold, fontSize: r.fs(1, 20), height: 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(card.imageDown, fit: BoxFit.cover)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildPhone(CardProduct card, Responsive r) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(4)),
                child: Text(
                  card.descriptionTop,
                  style: TextStyle(color: Color(0xFF7D7E81), fontWeight: FontWeight.bold, fontSize: r.fs(1, 20), height: 1.2),
                ),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(card.imageTop, fit: BoxFit.cover)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.wp(4)),

                child: Text(
                  card.descriptionDown,
                  style: TextStyle(color: Color(0xFF7D7E81), fontWeight: FontWeight.bold, fontSize: r.fs(1, 20), height: 1.2),
                ),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(card.imageDown, fit: BoxFit.cover)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//---------Conoce las lineas Smart/Eco------------
class OurLinesSliver extends StatelessWidget {
  final Responsive r;
  final Color color;
  final bool isMobile, isEcobag;

  const OurLinesSliver({super.key, required this.r, required this.color, required this.isMobile, required this.isEcobag});

  @override
  Widget build(BuildContext context) {
    final lines = isEcobag ? subcategorieEco : subcategorieSmart;
    return SliverToBoxAdapter(
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: r.wp(20, max: 100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollAnimatedWrapper(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                  child: Text(
                    "Nuestras lineas ${isEcobag ? 'EcoBag®' : 'SmartBag®'}",
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: r.fs(3, 40)),
                  ),
                ),
              ),
              ScrollAnimatedWrapper(
                child: SizedBox(
                  height: 650,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lines.length,
                    padding: EdgeInsets.symmetric(horizontal: r.wp(6)),
                    itemBuilder: (context, index) {
                      final categorie = lines[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 50, top: 80),
                        child: SizedBox(
                          width: min(300, r.wp(100)),
                          child: Column(
                            crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(categorie.img, height: 250, width: double.infinity, fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 20),
                              Text(categorie.title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: r.fs(3, 26))),
                              const SizedBox(height: 20),
                              Text(categorie.description, style: TextStyle(fontSize: r.fs(1.4, 20))),
                              const SizedBox(height: 10),
                              Text(categorie.sdescription, style: TextStyle(fontWeight: FontWeight.bold, fontSize: r.fs(1.2, 18))),
                              const Spacer(),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    navigateWithSlide(context, categorie.route);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
                                    child: Text("Saber más", style: TextStyle(color: Colors.white, fontSize: 16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------Animación de hojas para EcoBag®------------

class LeafAnimation extends StatefulWidget {
  const LeafAnimation({super.key});

  @override
  State<LeafAnimation> createState() => _LeafAnimationState();
}

class _LeafAnimationState extends State<LeafAnimation> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final List<LeafData> _leaves = [];
  final Random _random = Random();

  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();

    // Inicializar las hojas
    for (int i = 0; i < 10; i++) {
      _leaves.add(_generateLeaf());
    }

    // Crear ticker que se actualiza constantemente
    _ticker = createTicker((Duration elapsed) {
      setState(() {
        for (int i = 0; i < _leaves.length; i++) {
          _leaves[i].y += _leaves[i].speed;

          // Si se fue de la pantalla, reemplazar por una nueva
          if (_leaves[i].y > screenHeight + _leaves[i].size) {
            _leaves[i] = _generateLeaf(); // reemplazar hoja
          }
        }
      });
    });

    _ticker.start();
  }

  LeafData _generateLeaf() {
    return LeafData(
      image: 'assets/img/ecobag/hoja${_random.nextInt(3) + 1}.webp',
      x: _random.nextDouble(),
      y: -50.0 - _random.nextDouble() * 300,
      speed: 1.0 + _random.nextDouble() * 2.0,
      size: 40.0 + _random.nextDouble() * 30,
      rotation: _random.nextDouble() * pi,
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children:
          _leaves.map((leaf) {
            return Positioned(
              left: leaf.x * screenWidth,
              top: leaf.y,
              child: Transform.rotate(angle: leaf.rotation + leaf.y * 0.01, child: Image.asset(leaf.image, width: leaf.size)),
            );
          }).toList(),
    );
  }
}

class LeafData {
  final String image;
  final double x;
  double y;
  final double speed;
  final double size;
  final double rotation;

  LeafData({required this.image, required this.x, required this.y, required this.speed, required this.size, required this.rotation});
}
