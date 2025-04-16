import 'dart:math' show min;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webpack/class/packwithcon.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';
import 'package:webpack/widgets/heardquarters.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  //Inicio
  VideoPlayerController? _videoController;
  ScrollController _scrollController = ScrollController();
  bool _scrollLocked = true; // Inicialmente está bloqueado
  bool _videoEnded = false;

  //Empaques con conciencia
  int? _expandedIndex;
  List<int> cardIndex = List.generate(cardPWC.length, (index) => index);

  late AnimationController _textAnimationController;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('lib/src/videos/paint.mp4')
          ..setVolume(0.0)
          ..initialize().then((_) {
            if (mounted) {
              setState(() {});
              _videoController!.play();
            }
          });

    _videoController!.addListener(() {
      if (_videoController!.value.position >= _videoController!.value.duration && !_videoEnded) {
        setState(() {
          _scrollLocked = false;
          _videoEnded = true;
        });
        _videoController!.pause();
      }
    });

    _scrollController = ScrollController();

    final screenWidth = MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
    final isMobile = screenWidth < 720;

    _textAnimationController = AnimationController(
      vsync: this,
      duration: isMobile ? Duration(milliseconds: 500) : Duration(milliseconds: 420),
    );

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: isMobile ? Curves.easeInOut : Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _videoController!.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 720;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: _scrollLocked ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Colors.white,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: _videoController!.value.size.width,
                      height: _videoController!.value.size.height,
                      child: VideoPlayer(_videoController!),
                    ),
                  ),
                ),

                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.tertiary, Theme.of(context).primaryColor],
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenWidth * 0.05,
                              top: isMobile ? screenWidth * 0.1 : screenWidth * 0.05,
                              left: screenWidth * 0.06,
                            ),
                            child: Text(
                              "Empaques con conciencia.",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: min(screenWidth * 0.03, 60),
                              ),
                            ),
                          ),
                          isMobile
                              ? Column(
                                children:
                                    cardIndex.map((index) {
                                      final card = cardPWC[index];
                                      final bool isExpanded = _expandedIndex == index;
                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        width: double.infinity,
                                        height: isExpanded ? screenWidth * 0.95 : screenWidth * 0.6,
                                        margin: const EdgeInsets.only(bottom: 12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.zero,
                                          image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
                                        ),
                                        child: Stack(
                                          children: [
                                            // Título
                                            Positioned(
                                              top: 16,
                                              left: 0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor.withAlpha(230),
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(8),
                                                    bottomRight: Radius.circular(8),
                                                  ),
                                                ),
                                                child: Text(
                                                  card.title,
                                                  style: TextStyle(
                                                    fontSize: screenWidth * 0.03,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (isExpanded)
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: FadeTransition(
                                                  opacity: _textFadeAnimation,
                                                  child: Container(
                                                    height: 400,
                                                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                                                    decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors: [Colors.transparent, Colors.white, Colors.white],
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: SlideTransition(
                                                            position: _textSlideAnimation,
                                                            child: Text(
                                                              card.description,
                                                              style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: screenWidth * 0.03,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isExpanded) {
                                                    _textAnimationController.duration = Duration(milliseconds: 200);
                                                    _textAnimationController.reverse().then((_) {
                                                      setState(() {
                                                        _expandedIndex = null;
                                                      });
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _expandedIndex = index;
                                                      _textAnimationController.duration = Duration(milliseconds: 400);
                                                      _textAnimationController.forward(from: 0);
                                                    });
                                                  }
                                                },
                                                child: MouseRegion(
                                                  cursor: SystemMouseCursors.click,
                                                  child: Container(
                                                    width: 36,
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          !isExpanded
                                                              ? const Color.fromARGB(255, 255, 255, 255)
                                                              : Theme.of(context).primaryColor,
                                                    ),
                                                    child: TweenAnimationBuilder<double>(
                                                      key: ValueKey<bool>(isExpanded),
                                                      tween: Tween<double>(begin: 0, end: isExpanded ? 0.785 : 0.0),
                                                      duration: Duration(milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                      builder: (context, angle, child) {
                                                        return Transform.rotate(
                                                          angle: angle,
                                                          child: TweenAnimationBuilder<Color?>(
                                                            tween: ColorTween(
                                                              begin:
                                                                  isExpanded
                                                                      ? Theme.of(context).primaryColor
                                                                      : Colors.white,
                                                              end:
                                                                  isExpanded
                                                                      ? Colors.white
                                                                      : Theme.of(context).primaryColor,
                                                            ),
                                                            duration: Duration(milliseconds: 300),
                                                            builder: (context, iconColor, _) {
                                                              return Icon(
                                                                Icons.add_rounded,
                                                                size: 24,
                                                                color: iconColor,
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              )
                              //PC
                              : Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: screenWidth * 0.05),
                                  child: SizedBox(
                                    height: screenWidth * 0.3,
                                    child: Stack(
                                      children:
                                          cardIndex.map((index) {
                                            bool isExpanded = _expandedIndex == index;
                                            double leftPosition;
                                            if (_expandedIndex == null) {
                                              leftPosition = index * (screenWidth * 0.21 + screenWidth * 0.012);
                                            } else {
                                              if (isExpanded) {
                                                leftPosition = 0;
                                              } else {
                                                int stackIndex = cardIndex.indexOf(index) - 1;
                                                leftPosition =
                                                    screenWidth * 0.5 + screenWidth * 0.02 + stackIndex * 20.0;
                                              }
                                            }
                                            return AnimatedPositioned(
                                              duration: Duration(milliseconds: 300),
                                              left: leftPosition,
                                              child: AnimatedPositionedCard(
                                                index: index,
                                                isExpanded: isExpanded,
                                                screenWidth: screenWidth,
                                                card: cardPWC[index],
                                                onExpand: () {
                                                  setState(() {
                                                    _expandedIndex = index;
                                                    _textAnimationController.forward(from: 0);
                                                  });
                                                },
                                                onCollapse: () {
                                                  setState(() {
                                                    _textAnimationController.reverse();
                                                    _expandedIndex = null;
                                                  });
                                                },
                                                textFadeAnimation: _textFadeAnimation,
                                                textSlideAnimation: _textSlideAnimation,
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(width: screenWidth, decoration: BoxDecoration(color: Colors.white), child: Headquarters()),
                Footer(),
              ],
            ),
          ),
          Header(),
        ],
      ),
    );
  }
}

class AnimatedPositionedCard extends StatelessWidget {
  final int index;
  final bool isExpanded;
  final double screenWidth;
  final CardPackWithConscience card;
  final VoidCallback onExpand;
  final VoidCallback onCollapse;
  final Animation<double> textFadeAnimation;
  final Animation<Offset> textSlideAnimation;

  const AnimatedPositionedCard({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.screenWidth,
    required this.card,
    required this.onExpand,
    required this.onCollapse,
    required this.textFadeAnimation,
    required this.textSlideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: Duration(milliseconds: 300),
      width: isExpanded ? screenWidth * 0.5 : screenWidth * 0.21,
      height: screenWidth * 0.3,
      margin: EdgeInsets.only(right: 120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(card.image), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            child: Container(
              height: screenWidth * 0.03,
              width: screenWidth * 0.10,
              padding: EdgeInsets.only(left: screenWidth * 0.01),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(200),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenWidth * 0.01),
                  bottomRight: Radius.circular(screenWidth * 0.01),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  card.title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: screenWidth * 0.012),
                ),
              ),
            ),
          ),
          if (isExpanded)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: textFadeAnimation,
                child: Container(
                  padding: EdgeInsets.only(top: screenWidth * 0.13),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white, Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenWidth * 0.01,
                      left: screenWidth * 0.01,
                      right: screenWidth * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeTransition(
                          opacity: textFadeAnimation,
                          child: SlideTransition(
                            position: textSlideAnimation,
                            child: Text(
                              card.description,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: screenWidth * 0.013,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: screenWidth * 0.005,
            right: screenWidth * 0.005,
            child: TweenAnimationBuilder<double>(
              key: ValueKey<bool>(isExpanded),
              tween: Tween<double>(begin: 0, end: isExpanded ? 0.785 : 0.0),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (context, angle, child) {
                return Transform.rotate(
                  angle: angle,
                  child: IconButton(
                    onPressed: isExpanded ? onCollapse : onExpand,
                    icon: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: isExpanded ? Colors.white : Theme.of(context).primaryColor,
                        end: isExpanded ? Theme.of(context).primaryColor : Colors.white,
                      ),
                      duration: Duration(milliseconds: 300),
                      builder: (context, color, child) {
                        return Icon(CupertinoIcons.add_circled_solid, color: color, size: screenWidth * 0.03);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
