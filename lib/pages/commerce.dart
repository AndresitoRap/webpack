import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/main.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

class Commerce extends StatefulWidget {
  final String section;
  final List<Product> listproducts;
  final List<Product> productpreferid;
  final Subcategorie selectedSubcategorie;
  const Commerce({
    super.key,
    required this.section,
    required this.listproducts,
    required this.productpreferid,
    required this.selectedSubcategorie,
  });

  @override
  State<Commerce> createState() => _CommerceState();
}

class _CommerceState extends State<Commerce> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = true;

  late final AnimationController _arrowRotationController;
  late final Animation<double> _arrowRotationAnimation;

  bool isDropdownOpen = false;
  String selectedOption = "Destacado";
  final List<String> sortOptions = ["Destacado", "De menor a mayor precio", "De mayor a menor precio"];
  List<Product> get sortedProducts {
    List<Product> sorted = [...widget.listproducts];

    if (selectedOption == "De menor a mayor precio") {
      sorted.sort(
        (a, b) => double.parse(
          a.price.toString().replaceAll('.', ''),
        ).compareTo(double.parse(b.price.toString().replaceAll('.', ''))),
      );
    } else if (selectedOption == "De mayor a menor precio") {
      sorted.sort(
        (a, b) => double.parse(
          b.price.toString().replaceAll('.', ''),
        ).compareTo(double.parse(a.price.toString().replaceAll('.', ''))),
      );
    }

    return sorted;
  }

  final ScrollController _pageScrollController = ScrollController();
  final GlobalKey _collectionKey = GlobalKey();
  int currentPage = 1;
  final int itemsPerPage = 18;
  int get totalPages => (widget.listproducts.length / itemsPerPage).ceil();
  List<Product> get paginatedProducts {
    final sorted = sortedProducts;
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage) > sorted.length ? sorted.length : (start + itemsPerPage);
    return sorted.sublist(start, end);
  }

  _scrollToCollectionSection() {
    final context = _collectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        alignment: 0,
      );
    }
  }

  void _updateScrollButtons() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    setState(() {
      canScrollLeft = currentScroll > 0;
      canScrollRight = currentScroll < maxScroll;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtons);
    _arrowRotationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _arrowRotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _arrowRotationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _arrowRotationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    final GlobalKey sortKey = GlobalKey();

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 45),
            child: SingleChildScrollView(
              controller: _pageScrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: screenWidth,
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Text(
                          widget.selectedSubcategorie.title,
                          style: TextStyle(
                            height: 0,
                            fontWeight: FontWeight.bold,
                            fontSize: min(40, screenWidth * 0.06),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          widget.selectedSubcategorie.description,
                          style: TextStyle(
                            height: 0,
                            fontWeight: FontWeight.bold,
                            color:
                                currentRoute.contains("EcoBag")
                                    ? Color.fromARGB(255, 41, 112, 9).withAlpha(170)
                                    : Theme.of(context).primaryColor.withAlpha(200),
                            fontSize: min(50, screenWidth * 0.06),
                          ),
                        ),
                        Image.asset(widget.selectedSubcategorie.img, height: 600),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                  SizedBox(height: 200),
                  Text(
                    "Las más prefereridas.",
                    style: TextStyle(fontSize: min(50, screenWidth * 0.06), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            widget.productpreferid.map((product) {
                              return Container(
                                margin: EdgeInsets.all(10),
                                height: 500,
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color:
                                      currentRoute.contains("EcoBag")
                                          ? Color.fromARGB(255, 41, 112, 9).withAlpha(16)
                                          : Theme.of(context).primaryColor.withAlpha(16),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 50),
                                    Image.asset(product.image, fit: BoxFit.cover),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                          product.colors.map((c) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(horizontal: 4),
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                color: c.color,
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 0.5, color: Colors.grey),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                    SizedBox(height: 30),
                                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    Text("\$${product.price}", style: TextStyle(fontSize: 16)),
                                    Spacer(),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  if (screenWidth <= 350 * 3 + 60)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                canScrollLeft ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80),
                              ),
                            ),
                            onPressed:
                                canScrollLeft
                                    ? () {
                                      _scrollController.animateTo(
                                        _scrollController.offset - 300,
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
                              backgroundColor: WidgetStateProperty.all(
                                canScrollRight ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80),
                              ),
                            ),
                            onPressed:
                                canScrollRight
                                    ? () {
                                      _scrollController.animateTo(
                                        _scrollController.offset + 300,
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
                  SizedBox(height: 100),
                  Padding(
                    key: _collectionKey,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 50),
                    child: Text(
                      "Nuestras colecciones.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            currentRoute.contains("EcoBag")
                                ? Color.fromARGB(255, 41, 112, 9).withAlpha(170)
                                : Theme.of(context).primaryColor.withAlpha(200),
                        fontSize: min(40, screenWidth * 0.06),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.18),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Filtrado por: ", style: TextStyle(color: Colors.grey)),
                        Row(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                key: sortKey,
                                onTap: () {
                                  if (_dropdownOverlay == null) {
                                    _arrowRotationController.forward();
                                    _showSortDropdown(context, sortKey);
                                  } else {
                                    _arrowRotationController.reverse();
                                    _dropdownOverlay?.remove();
                                    _dropdownOverlay = null;
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(selectedOption, style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 2),
                                    AnimatedBuilder(
                                      animation: _arrowRotationAnimation,
                                      builder: (context, child) {
                                        return Transform.rotate(
                                          angle: _arrowRotationAnimation.value * -2 * pi,
                                          child: Icon(Icons.keyboard_arrow_down, size: 18),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1124),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        double aspectRatio = 0.72;

                        if (constraints.maxWidth >= 1200) {
                          crossAxisCount = 4;
                          aspectRatio = 0.78;
                        } else if (constraints.maxWidth >= 1000) {
                          crossAxisCount = 3;
                          aspectRatio = 0.76;
                        } else if (constraints.maxWidth >= 700) {
                          crossAxisCount = 3;
                          aspectRatio = 0.78;
                        } else if (constraints.maxWidth >= 480) {
                          crossAxisCount = 2;
                          aspectRatio = 0.85;
                        } else {
                          crossAxisCount = 2;
                          aspectRatio = 0.95;
                        }

                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: aspectRatio,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemCount: paginatedProducts.length,

                          itemBuilder: (context, index) {
                            final product = paginatedProducts[index];
                            final bool isFirstInRow = index % crossAxisCount == 0;
                            final bool isLastInRow = (index + 1) % crossAxisCount == 0;
                            String slugify(String text) {
                              return text
                                  .toLowerCase()
                                  .replaceAll(RegExp(r'[^\w\s-]'), '') // quitar símbolos raros
                                  .replaceAll(' ', '-') // reemplazar espacios por guiones
                                  .replaceAll(RegExp('-+'), '-'); // evitar guiones dobles
                            }

                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                                    right:
                                        isLastInRow
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.grey.shade300, width: 1),
                                    left:
                                        isFirstInRow
                                            ? BorderSide.none
                                            : BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      final slug = slugify(product.name);
                                      final base = currentRoute.contains("EcoBag") ? "EcoBag" : "SmartBag";
                                      final route = '/$base/Explora-$base/${widget.section}/$slug';
                                      navigateWithSlide(context, route);
                                    },

                                    child: Column(
                                      children: [
                                        Expanded(flex: 6, child: Image.asset(product.image, fit: BoxFit.contain)),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:
                                              product.colors.map((c) {
                                                return Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                                  height: 12,
                                                  width: 12,
                                                  decoration: BoxDecoration(
                                                    color: c.color,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(width: 0.5, color: Colors.black12),
                                                  ),
                                                );
                                              }).toList(),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 6),
                                        Text("\$${product.price}", style: const TextStyle(color: Colors.black87)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (widget.listproducts.length > itemsPerPage)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_left),
                            onPressed:
                                currentPage > 1
                                    ? () {
                                      setState(() => currentPage--);
                                      _scrollToCollectionSection();
                                    }
                                    : null,
                          ),
                          Text('$currentPage de $totalPages', style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed:
                                currentPage < totalPages
                                    ? () {
                                      setState(() => currentPage++);
                                      _scrollToCollectionSection();
                                    }
                                    : null,
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

  OverlayEntry? _dropdownOverlay;

  void _showSortDropdown(BuildContext context, GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _dropdownOverlay = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _arrowRotationController.reverse();
                  _dropdownOverlay?.remove();
                  _dropdownOverlay = null;
                },
                behavior: HitTestBehavior.translucent,
                child: Container(),
              ),
            ),
            Positioned(
              top: offset.dy + size.height,
              left: offset.dx,
              child: Material(
                elevation: 8,
                color: Colors.transparent,
                child: Container(
                  width: 220,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        sortOptions.map((option) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedOption = option;
                                currentPage = 1;
                              });
                              _scrollToCollectionSection();

                              _arrowRotationController.reverse();
                              _dropdownOverlay?.remove();
                              _dropdownOverlay = null;
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border:
                                    option != sortOptions.last
                                        ? Border(bottom: BorderSide(color: Colors.grey.shade200))
                                        : null,
                              ),
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontWeight: option == selectedOption ? FontWeight.bold : FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_dropdownOverlay!);
  }
}
