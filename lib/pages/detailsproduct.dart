import 'dart:async';
import 'dart:math';
// Gráficos y filtros: siempre vienen de dart:ui
import 'dart:ui' as ui show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:webpack/class/products.dart';
import 'package:webpack/widgets/footer.dart';
import 'package:webpack/widgets/header.dart';

import 'package:webpack/widgets/video.dart';

class DetailsProduct extends StatefulWidget {
  final Product product;
  final List<Product>? allProducts;
  const DetailsProduct({super.key, required this.product, this.allProducts});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  //Lista
  late List<Terminado> terminadosDisponibles;
  Terminado? selectedTerminado;
  late Product currentProduct;

  List<Terminado> findTerminadosForProduct(List<Product> products) {
    final subcat = products.first.subcategorie;
    final cat = products.first.categoria;

    return productSections['${cat.name}/${subcat.title}'] ?? [];
  }

  // Variables a escoger
  NamedColor? selectedColor;
  String? hoveredColor;
  String? selectedGramaje;
  PeelStickOption? selectedPeelstick;
  String? hoveredPS;
  String? selectedValve;
  String? selectedFinish;
  String? selectedStructure;

  double getPrecioSeleccionado() {
    if (selectedTerminado != null && selectedStructure != null && selectedGramaje != null) {
      final estructura = selectedTerminado!.structures.firstWhere(
        (e) => e.name == selectedStructure,
        orElse: () => selectedTerminado!.structures.first,
      );

      final ability = estructura.ability.firstWhere((a) => a.name == selectedGramaje, orElse: () => estructura.ability.first);

      // Buscar el producto coincidente
      final matchingProduct = ability.product.firstWhere(
        (p) => p.name == widget.product.name && p.subcategorie.title == widget.product.subcategorie.title,
        orElse: () => widget.product,
      );

      return matchingProduct.price;
    }

    return widget.product.price;
  }

  // Modelo
  late Flutter3DController controllerModel;
  late Flutter3DController controllerFinally;
  bool _modelLoaded = false;
  bool _finalModelLoaded = false;
  bool _showTutorial = true;

  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  Key _finalModelKey = UniqueKey();
  String? _pendingTextureName;
  String? _pendingPeelStickTexture;

  @override
  void initState() {
    super.initState();
    controllerModel = Flutter3DController();
    controllerFinally = Flutter3DController();
    _modelLoaded = false; // Cambiado a false hasta que el modelo se cargue
    _scrollController =
        ScrollController()..addListener(() {
          setState(() {
            _scrollOffset = _scrollController.offset;
          });
        });

    currentProduct = widget.product;
    final todosLosProductos = widget.allProducts ?? [widget.product];
    terminadosDisponibles = findTerminadosForProduct(todosLosProductos);

    // Inicializar con el terminado "Mate" si está disponible
    if (terminadosDisponibles.isNotEmpty) {
      selectedTerminado = terminadosDisponibles.firstWhere((t) => t.name.toLowerCase() == "mate", orElse: () => terminadosDisponibles.first);
      selectedFinish = selectedTerminado!.name;
    }
  }

  void _hideTutorial() {
    if (_showTutorial) {
      setState(() {
        _showTutorial = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Función para sincronizar el modelo final
  void _updateFinalModel() {
    if (_modelLoaded && selectedColor != null && selectedFinish != null && selectedPeelstick != null) {
      final suffix = getFinishSuffix(selectedTerminado!);

      final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

      // Almacenar texturas pendientes
      _pendingTextureName = textureName;
      _pendingPeelStickTexture = selectedPeelstick!.abbreviation;

      // Forzar la reconstrucción del modelo final
      setState(() {
        _finalModelKey = UniqueKey(); // Cambiar la clave para forzar la reconstrucción
        _finalModelLoaded = false; // Resetear el estado de carga
      });
    }
  }

  // Función para aplicar texturas al modelo final
  void _applyTexturesToFinalModel() {
    if (_finalModelLoaded && _pendingTextureName != null && _pendingPeelStickTexture != null) {
      controllerFinally
          .getAvailableTextures()
          .then((textures) {
            //print("Texturas disponibles para modelo final: $textures");
            if (textures.contains(_pendingTextureName)) {
              controllerFinally.setTexture(textureName: _pendingTextureName!);
              Future.delayed(Duration(milliseconds: 100), () {
                if (textures.contains(_pendingPeelStickTexture)) {
                  controllerFinally.setTexture(textureName: _pendingPeelStickTexture!);
                } else {
                  null;
                  //print("Textura de PeelStick no disponible: $_pendingPeelStickTexture");
                }
              });
            } else {
              null;
              // print("Textura no disponible: $_pendingTextureName");
            }
          })
          .catchError((error) {
            null;
            // print("Error al obtener texturas disponibles: $error");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final product = widget.product;
    final categorie = widget.product.categoria;

    // Validación
    bool isComplete =
        selectedColor != null &&
        selectedGramaje != null &&
        selectedStructure != null &&
        selectedPeelstick != null &&
        selectedValve != null &&
        selectedFinish != null;

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
                                          : [Color.fromARGB(255, 41, 112, 9).withAlpha(170), Color.fromARGB(255, 41, 112, 9).withAlpha(200)],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (int index) {
                                  final List<double> opacities = [1.0, 0.5, 0.1];
                                  return Opacity(
                                    opacity: opacities[index],
                                    child: Text(
                                      "${product.subcategorie.title} " * 10,
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
                                                filter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            product.subcategorie.title == "5PRO"
                                                                ? screenWidth * 0.13
                                                                : product.subcategorie.title == "Doypack"
                                                                ? screenWidth * 0.16
                                                                : product.subcategorie.title == "Standpack"
                                                                ? screenWidth * 0.22
                                                                : screenWidth * 0.1,
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              product.subcategorie.title,
                                                              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                                                            ),
                                                            const SizedBox(height: 10),

                                                            Text(
                                                              textAlign: TextAlign.justify,
                                                              product.subcategorie.infoBuild,
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
                                          Positioned(top: -20, left: -600, child: Image.asset(product.subcategorie.img, width: 1200)),
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
                                        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(child: Image.asset(product.subcategorie.img, fit: BoxFit.cover)),
                                              SizedBox(height: 20),
                                              Text(
                                                product.subcategorie.title,
                                                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children:
                                                    product.colors.map((c) {
                                                      return Container(
                                                        margin: const EdgeInsets.only(left: 2, right: 10),
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.white, width: 1),
                                                          color: c.color,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      );
                                                    }).toList(),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                textAlign: TextAlign.justify,
                                                product.subcategorie.infoBuild,
                                                style: TextStyle(color: Colors.white, fontSize: 16),
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
                    decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.black26, width: 2))),
                    child: Center(child: Text("Crea tu ${product.subcategorie.title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      children: [
                        if (product.categoria.name == "EcoBag")
                          Text("Materiales sostenibles", style: TextStyle(fontWeight: FontWeight.bold, color: const Color(0xff4b8d2c), fontSize: 20)),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          height: 600,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: videoBlurNotifier,
                              builder: (context, isBlur, _) {
                                return VideoFlutter(
                                  src:
                                      product.categoria.name == "SmartBag"
                                          ? 'assets/videos/smartbag/smartbag_products.webm'
                                          : 'assets/assets/videos/ecobag/ecobag.webm',
                                  blur: isBlur,
                                  loop: true,
                                  showControls: true,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        if (screenWidth >= 900)
                          // PC
                          SizedBox(
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final maxTop = 1750;
                                final currentTop = _scrollOffset < maxTop ? 0.0 : _scrollOffset - maxTop;
                                return Stack(
                                  children: [
                                    Positioned(
                                      top: min(currentTop, 1050),
                                      left: screenWidth * 0.06,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Modelo 3D",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: categorie.name == "SmartBag" ? const Color(0xFF004F9E) : const Color(0xff4b8d2c),
                                                  fontSize: min(screenWidth * 0.04, 25),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Tooltip(
                                                message:
                                                    "🖱️ En computador:\n"
                                                    "- Haz clic izquierdo y mantén presionado mientras mueves el ratón para girar el modelo.\n"
                                                    "- Usa la rueda del ratón para hacer zoom (adelante para acercar, atrás para alejar).\n"
                                                    "- Presiona Shift y haz clic izquierdo para mover el modelo sin girarlo.\n\n"
                                                    "📱 En tablet o celular:\n"
                                                    "- Usa un dedo para girar el modelo.\n"
                                                    "- Usa dos dedos para moverlo de posición.\n"
                                                    "- Junta o separa los dedos (pellizcar o expandir) para hacer zoom.",
                                                child: Icon(
                                                  CupertinoIcons.question_circle_fill,
                                                  color:
                                                      categorie.name == "SmartBag"
                                                          ? const Color.fromARGB(255, 0, 49, 98)
                                                          : const Color.fromARGB(255, 42, 79, 24),
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),

                                          Container(
                                            height: 500,
                                            width: screenWidth * 0.4,
                                            alignment: Alignment.topCenter,
                                            child: Stack(
                                              children: [
                                                Listener(
                                                  onPointerDown: (_) => _hideTutorial(),
                                                  onPointerMove: (_) => _hideTutorial(),
                                                  child: Model(
                                                    product: product,
                                                    controllerModel: controllerModel,
                                                    autoRotate: true,
                                                    gestureDetector: true,
                                                    selectedValve: selectedValve,
                                                    onLoad: (String _) {
                                                      setState(() {
                                                        selectedColor ??= product.colors.first;
                                                        selectedFinish ??= terminadosDisponibles.first.name;
                                                        selectedPeelstick ??= peelStickOptions.first;
                                                        _modelLoaded = true;
                                                        controllerModel
                                                            .getAvailableTextures()
                                                            .then((textures) {
                                                              final textureName =
                                                                  "${selectedColor!.name.replaceAll(" ", "_")}_${getFinishSuffix(selectedTerminado!)}";
                                                              // print("Texturas disponibles para modelo inicial: $textures");
                                                              if (textures.contains(textureName)) {
                                                                controllerModel.setTexture(textureName: textureName);
                                                              } else {
                                                                null;
                                                                // print("Textura no disponible para modelo inicial: $textureName");
                                                              }
                                                              Future.delayed(Duration(milliseconds: 100), () {
                                                                if (textures.contains(selectedPeelstick!.abbreviation)) {
                                                                  controllerModel.setTexture(textureName: selectedPeelstick!.abbreviation);
                                                                } else {
                                                                  null;
                                                                  // print("Textura de PeelStick no disponible: ${selectedPeelstick!.abbreviation}");
                                                                }
                                                              });
                                                            })
                                                            .catchError((error) {
                                                              null;
                                                              // print("Error al obtener texturas disponibles: $error");
                                                            });
                                                      });
                                                      _updateFinalModel();
                                                    },
                                                  ),
                                                ),
                                                AnimatedOpacity(
                                                  opacity: _showTutorial ? 1.0 : 0.0,
                                                  duration: Duration(milliseconds: 500),
                                                  child: IgnorePointer(
                                                    ignoring: true,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(16),
                                                        color: Colors.black.withAlpha(70),
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: ColorFiltered(
                                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                        child: Lottie.asset("assets/gifts/cursor.json", width: 130, height: 130),
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
                                    Padding(
                                      padding: EdgeInsets.only(left: screenWidth * 0.5),
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        width: screenWidth,
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                                        child: FormCreateBag(
                                          product: product,
                                          terminadosDisponibles: terminadosDisponibles,
                                          selectedTerminado: selectedTerminado,
                                          selectedStructure: selectedStructure,
                                          selectedGramaje: selectedGramaje,
                                          selectedColor: selectedColor,
                                          hoveredColor: hoveredColor,
                                          onHoverColor: (value) {
                                            setState(() {
                                              hoveredColor = value;
                                            });
                                          },
                                          selectedPeelstick: selectedPeelstick,
                                          hoveredPS: hoveredPS,
                                          onHoverPS: (value) {
                                            setState(() {
                                              hoveredPS = value;
                                            });
                                          },
                                          selectedValve: selectedValve,
                                          selectedFinish: selectedFinish,
                                          controllerModel: controllerModel,
                                          modelLoaded: _modelLoaded,
                                          onSelectTerminado: (t) {
                                            setState(() {
                                              selectedTerminado = t;
                                              selectedStructure = null; // Reiniciar estructura
                                              selectedGramaje = null; // Reiniciar gramaje
                                              selectedColor = null; // Reiniciar color
                                              selectedPeelstick = null; // Reiniciar peel stick
                                              selectedValve = null; // Reiniciar válvula
                                              selectedFinish = t.name; // Actualizar terminado
                                              currentProduct = widget.product; // Reiniciar producto

                                              // Seleccionar el primer color disponible si hay estructuras y gramajes
                                              if (selectedTerminado != null && t.structures.isNotEmpty) {
                                                final estructura = t.structures.first;
                                                if (estructura.ability.isNotEmpty) {
                                                  final ability = estructura.ability.first;
                                                  final producto = ability.product.firstWhere(
                                                    (p) => p.subcategorie.title == widget.product.subcategorie.title,
                                                    orElse: () => widget.product,
                                                  );

                                                  currentProduct = producto;
                                                  selectedColor = producto.colors.isNotEmpty ? producto.colors.first : null;

                                                  // Aplicar la textura del primer color disponible
                                                  if (_modelLoaded && selectedColor != null) {
                                                    final suffix = getFinishSuffix(selectedTerminado!);
                                                    final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                                    controllerModel
                                                        .getAvailableTextures()
                                                        .then((textures) {
                                                          // print("Texturas disponibles para modelo inicial: $textures");
                                                          if (textures.contains(textureName)) {
                                                            controllerModel.setTexture(textureName: textureName);
                                                          } else {
                                                            null;
                                                            // print("Textura no disponible: $textureName");
                                                          }
                                                        })
                                                        .catchError((error) {
                                                          null;
                                                          // print("Error al obtener texturas disponibles: $error");
                                                        });
                                                  }
                                                }
                                              }
                                            });

                                            _updateFinalModel();
                                          },

                                          onSelectStructure: (value) {
                                            setState(() {
                                              selectedStructure = value;
                                              selectedGramaje = null; // Reiniciar gramaje
                                              selectedColor = null; // Reiniciar color
                                              selectedPeelstick = peelStickOptions.isNotEmpty ? peelStickOptions.first : null; // Reiniciar peel stick
                                              selectedValve =
                                                  widget.product.valves.isNotEmpty ? widget.product.valves.first : null; // Reiniciar válvula
                                              currentProduct = widget.product; // Reiniciar producto
                                            });
                                            _updateFinalModel();
                                          },

                                          onSelectGramaje: (value) {
                                            setState(() {
                                              selectedGramaje = value;

                                              if (selectedTerminado != null && selectedStructure != null) {
                                                final estructura = selectedTerminado!.structures.firstWhere(
                                                  (e) => e.name == selectedStructure,
                                                  orElse: () => selectedTerminado!.structures.first,
                                                );

                                                final ability = estructura.ability.firstWhere(
                                                  (a) => a.name == selectedGramaje,
                                                  orElse: () => estructura.ability.first,
                                                );

                                                final producto = ability.product.firstWhere(
                                                  (p) => p.subcategorie.title == widget.product.subcategorie.title,
                                                  orElse: () => widget.product,
                                                );

                                                currentProduct = producto;

                                                // Seleccionar el primer color disponible para el producto
                                                selectedColor = producto.colors.isNotEmpty ? producto.colors.first : null;

                                                // Aplicar la nueva textura al modelo inicial
                                                if (_modelLoaded && selectedColor != null && selectedTerminado != null) {
                                                  final suffix = getFinishSuffix(selectedTerminado!);
                                                  final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                                  controllerModel
                                                      .getAvailableTextures()
                                                      .then((textures) {
                                                        // print("Texturas disponibles para modelo inicial: $textures");
                                                        if (textures.contains(textureName)) {
                                                          controllerModel.setTexture(textureName: textureName);
                                                        } else {
                                                          null;
                                                          // print("Textura no disponible: $textureName");
                                                        }
                                                      })
                                                      .catchError((error) {
                                                        null;
                                                        // print("Error al obtener texturas disponibles: $error");
                                                      });
                                                }
                                              }
                                            });

                                            _updateFinalModel();
                                          },

                                          onSelectColor: (value) {
                                            setState(() {
                                              selectedColor = value;

                                              if (_modelLoaded && selectedTerminado != null) {
                                                final suffix = getFinishSuffix(selectedTerminado!);
                                                final textureName = "${value.name.replaceAll(" ", "_")}_$suffix";

                                                controllerModel
                                                    .getAvailableTextures()
                                                    .then((textures) {
                                                      null;
                                                      // print("Texturas disponibles para modelo inicial: $textures");
                                                      if (textures.contains(textureName)) {
                                                        controllerModel.setTexture(textureName: textureName);
                                                      } else {
                                                        null;
                                                        // print("Textura no disponible: $textureName");
                                                      }
                                                    })
                                                    .catchError((error) {
                                                      null;
                                                      // print("Error al obtener texturas disponibles: $error");
                                                    });
                                              }
                                            });

                                            _updateFinalModel();
                                          },

                                          onSelectPeelstick: (value) {
                                            setState(() {
                                              selectedPeelstick = value;

                                              if (_modelLoaded && selectedColor != null && selectedTerminado != null) {
                                                final suffix = getFinishSuffix(selectedTerminado!);
                                                final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                                controllerModel
                                                    .getAvailableTextures()
                                                    .then((textures) {
                                                      // print("Texturas disponibles para modelo inicial: $textures");
                                                      if (textures.contains(textureName)) {
                                                        controllerModel.setTexture(textureName: textureName);
                                                      } else {
                                                        null;
                                                        // print("Textura no disponible: $textureName");
                                                      }
                                                      if (textures.contains(value.abbreviation)) {
                                                        Future.delayed(Duration(milliseconds: 100), () {
                                                          controllerModel.setTexture(textureName: value.abbreviation);
                                                        });
                                                      } else {
                                                        null;
                                                        // print("Textura de PeelStick no disponible: ${value.abbreviation}");
                                                      }
                                                    })
                                                    .catchError((error) {
                                                      null;
                                                      // print("Error al obtener texturas disponibles: $error");
                                                    });
                                              }
                                            });

                                            _updateFinalModel();
                                          },

                                          onSelectValve: (value) {
                                            setState(() {
                                              selectedValve = value;
                                            });
                                            _updateFinalModel();
                                          },

                                          onSelectFinish: (value) {
                                            setState(() {
                                              selectedFinish = value;

                                              if (_modelLoaded && selectedColor != null && selectedTerminado != null) {
                                                final suffix = getFinishSuffix(selectedTerminado!);
                                                final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                                controllerModel
                                                    .getAvailableTextures()
                                                    .then((textures) {
                                                      // print("Texturas disponibles para modelo inicial: $textures");
                                                      if (textures.contains(textureName)) {
                                                        controllerModel.setTexture(textureName: textureName);
                                                      } else {
                                                        null;
                                                        // print("Textura no disponible: $textureName");
                                                      }
                                                    })
                                                    .catchError((error) {
                                                      null;
                                                      // print("Error al obtener texturas disponibles: $error");
                                                    });
                                              }
                                            });

                                            _updateFinalModel();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        else
                          // Celular
                          Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Modelo 3D",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: min(screenWidth * 0.04, 25),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Tooltip(
                                    message:
                                        "🖱️ En computador:\n"
                                        "- Haz clic izquierdo y mantén presionado mientras mueves el ratón para girar el modelo.\n"
                                        "- Usa la rueda del ratón para hacer zoom (adelante para acercar, atrás para alejar).\n"
                                        "- Presiona Shift y haz clic izquierdo para mover el modelo sin girarlo.\n\n"
                                        "📱 En tablet o celular:\n"
                                        "- Usa un dedo para girar el modelo.\n"
                                        "- Usa dos dedos para moverlo de posición.\n"
                                        "- Junta o separa los dedos (pellizcar o expandir) para hacer zoom.",
                                    child: Icon(CupertinoIcons.question_circle_fill, color: Theme.of(context).colorScheme.tertiary, size: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 400,
                                child: Stack(
                                  children: [
                                    Listener(
                                      onPointerDown: (_) => _hideTutorial(),
                                      onPointerMove: (_) => _hideTutorial(),
                                      child: Model(
                                        product: product,
                                        controllerModel: controllerModel,
                                        autoRotate: true,
                                        gestureDetector: true,
                                        selectedValve: selectedValve,
                                        onLoad: (String _) {
                                          setState(() {
                                            selectedColor ??= product.colors.first;
                                            if (selectedFinish == null && terminadosDisponibles.isNotEmpty) {
                                              selectedFinish = terminadosDisponibles.first.name;
                                            }

                                            selectedPeelstick ??= peelStickOptions.first;
                                            _modelLoaded = true;
                                            controllerModel
                                                .getAvailableTextures()
                                                .then((textures) {
                                                  if (selectedColor == null || selectedTerminado == null || selectedPeelstick == null) {
                                                    // print(
                                                    // "❌ Valores nulos detectados: selectedColor=$selectedColor, selectedTerminado=$selectedTerminado, selectedPeelstick=$selectedPeelstick",
                                                    // );
                                                    return; // no continuar si falta algo
                                                  }

                                                  final textureName =
                                                      "${selectedColor!.name.replaceAll(" ", "_")}_${getFinishSuffix(selectedTerminado!)}";
                                                  // print("Texturas disponibles para modelo inicial: $textures");

                                                  if (textures.contains(textureName)) {
                                                    controllerModel.setTexture(textureName: textureName);
                                                  } else {
                                                    null;
                                                    // print("Textura no disponible para modelo inicial: $textureName");
                                                  }

                                                  Future.delayed(Duration(milliseconds: 100), () {
                                                    if (textures.contains(selectedPeelstick!.abbreviation)) {
                                                      controllerModel.setTexture(textureName: selectedPeelstick!.abbreviation);
                                                    } else {
                                                      null;
                                                      // print("Textura de PeelStick no disponible: ${selectedPeelstick!.abbreviation}");
                                                    }
                                                  });
                                                })
                                                .catchError((error) {
                                                  null;
                                                  // print("Error al obtener texturas disponibles: $error");
                                                });
                                          });
                                          _updateFinalModel();
                                        },
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity: _showTutorial ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 500),
                                      child: IgnorePointer(
                                        ignoring: true,
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.black.withAlpha(70)),
                                          alignment: Alignment.center,
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                            child: Lottie.asset("assets/gifts/cursor.json", width: 130, height: 130),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(30),
                                width: screenWidth,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                                child: FormCreateBag(
                                  product: product,
                                  terminadosDisponibles: terminadosDisponibles,
                                  selectedTerminado: selectedTerminado,
                                  selectedStructure: selectedStructure,
                                  selectedGramaje: selectedGramaje,
                                  selectedColor: selectedColor,
                                  hoveredColor: hoveredColor,
                                  onHoverColor: (value) => {},
                                  selectedPeelstick: selectedPeelstick,
                                  hoveredPS: hoveredPS,
                                  onHoverPS: (value) => {},
                                  selectedValve: selectedValve,
                                  selectedFinish: selectedFinish,
                                  controllerModel: controllerModel,
                                  modelLoaded: _modelLoaded,
                                  onSelectTerminado: (t) {
                                    setState(() {
                                      selectedTerminado = t;
                                      selectedStructure = null; // Reiniciar estructura
                                      selectedGramaje = null; // Reiniciar gramaje
                                      selectedColor = null; // Reiniciar color
                                      selectedPeelstick = null; // Reiniciar peel stick
                                      selectedValve = null; // Reiniciar válvula
                                      selectedFinish = t.name; // Actualizar terminado
                                      currentProduct = widget.product; // Reiniciar producto

                                      // Seleccionar el primer color disponible si hay estructuras y gramajes
                                      if (selectedTerminado != null && t.structures.isNotEmpty) {
                                        final estructura = t.structures.first;
                                        if (estructura.ability.isNotEmpty) {
                                          final ability = estructura.ability.first;
                                          final producto = ability.product.firstWhere(
                                            (p) => p.subcategorie.title == widget.product.subcategorie.title,
                                            orElse: () => widget.product,
                                          );

                                          currentProduct = producto;
                                          selectedColor = producto.colors.isNotEmpty ? producto.colors.first : null;

                                          // Aplicar la textura del primer color disponible
                                          if (_modelLoaded && selectedColor != null) {
                                            final suffix = getFinishSuffix(selectedTerminado!);
                                            final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                            controllerModel
                                                .getAvailableTextures()
                                                .then((textures) {
                                                  // print("Texturas disponibles para modelo inicial: $textures");
                                                  if (textures.contains(textureName)) {
                                                    controllerModel.setTexture(textureName: textureName);
                                                  } else {
                                                    null;
                                                    // print("Textura no disponible: $textureName");
                                                  }
                                                })
                                                .catchError((error) {
                                                  null; // print("Error al obtener texturas disponibles: $error");
                                                });
                                          }
                                        }
                                      }
                                    });

                                    _updateFinalModel();
                                  },

                                  onSelectStructure: (value) {
                                    setState(() {
                                      selectedStructure = value;
                                      selectedGramaje = null; // Reiniciar gramaje
                                      selectedColor = null; // Reiniciar color
                                      selectedPeelstick = peelStickOptions.isNotEmpty ? peelStickOptions.first : null; // Reiniciar peel stick
                                      selectedValve = widget.product.valves.isNotEmpty ? widget.product.valves.first : null; // Reiniciar válvula
                                      currentProduct = widget.product; // Reiniciar producto
                                    });
                                    _updateFinalModel();
                                  },

                                  onSelectGramaje: (value) {
                                    setState(() {
                                      selectedGramaje = value;

                                      if (selectedTerminado != null && selectedStructure != null) {
                                        final estructura = selectedTerminado!.structures.firstWhere(
                                          (e) => e.name == selectedStructure,
                                          orElse: () => selectedTerminado!.structures.first,
                                        );

                                        final ability = estructura.ability.firstWhere(
                                          (a) => a.name == selectedGramaje,
                                          orElse: () => estructura.ability.first,
                                        );

                                        final producto = ability.product.firstWhere(
                                          (p) => p.subcategorie.title == widget.product.subcategorie.title,
                                          orElse: () => widget.product,
                                        );

                                        currentProduct = producto;

                                        // Seleccionar el primer color disponible para el producto
                                        selectedColor = producto.colors.isNotEmpty ? producto.colors.first : null;

                                        // Aplicar la nueva textura al modelo inicial
                                        if (_modelLoaded && selectedColor != null && selectedTerminado != null) {
                                          final suffix = getFinishSuffix(selectedTerminado!);
                                          final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                          controllerModel
                                              .getAvailableTextures()
                                              .then((textures) {
                                                null;
                                                // print("Texturas disponibles para modelo inicial: $textures");
                                                if (textures.contains(textureName)) {
                                                  controllerModel.setTexture(textureName: textureName);
                                                } else {
                                                  null;
                                                  // print("Textura no disponible: $textureName");
                                                }
                                              })
                                              .catchError((error) {
                                                null;
                                                // print("Error al obtener texturas disponibles: $error");
                                              });
                                        }
                                      }
                                    });

                                    _updateFinalModel();
                                  },

                                  onSelectColor: (value) {
                                    setState(() {
                                      selectedColor = value;

                                      if (_modelLoaded && selectedTerminado != null) {
                                        final suffix = getFinishSuffix(selectedTerminado!);
                                        final textureName = "${value.name.replaceAll(" ", "_")}_$suffix";

                                        controllerModel
                                            .getAvailableTextures()
                                            .then((textures) {
                                              // print("Texturas disponibles para modelo inicial: $textures");
                                              if (textures.contains(textureName)) {
                                                controllerModel.setTexture(textureName: textureName);
                                              } else {
                                                null;
                                                // print("Textura no disponible: $textureName");
                                              }
                                            })
                                            .catchError((error) {
                                              null;
                                              // print("Error al obtener texturas disponibles: $error");
                                            });
                                      }
                                    });

                                    _updateFinalModel();
                                  },

                                  onSelectPeelstick: (value) {
                                    setState(() {
                                      selectedPeelstick = value;

                                      if (_modelLoaded && selectedColor != null && selectedTerminado != null) {
                                        final suffix = getFinishSuffix(selectedTerminado!);
                                        final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                        controllerModel
                                            .getAvailableTextures()
                                            .then((textures) {
                                              // print("Texturas disponibles para modelo inicial: $textures");
                                              if (textures.contains(textureName)) {
                                                controllerModel.setTexture(textureName: textureName);
                                              } else {
                                                null;
                                                // print("Textura no disponible: $textureName");
                                              }
                                              if (textures.contains(value.abbreviation)) {
                                                Future.delayed(Duration(milliseconds: 100), () {
                                                  controllerModel.setTexture(textureName: value.abbreviation);
                                                });
                                              } else {
                                                null;
                                                // print("Textura de PeelStick no disponible: ${value.abbreviation}");
                                              }
                                            })
                                            .catchError((error) {
                                              null;
                                              // print("Error al obtener texturas disponibles: $error");
                                            });
                                      }
                                    });

                                    _updateFinalModel();
                                  },

                                  onSelectValve: (value) {
                                    setState(() {
                                      selectedValve = value;
                                    });
                                    _updateFinalModel();
                                  },

                                  onSelectFinish: (value) {
                                    setState(() {
                                      selectedFinish = value;

                                      if (_modelLoaded && selectedColor != null && selectedTerminado != null) {
                                        final suffix = getFinishSuffix(selectedTerminado!);
                                        final textureName = "${selectedColor!.name.replaceAll(" ", "_")}_$suffix";

                                        controllerModel
                                            .getAvailableTextures()
                                            .then((textures) {
                                              // print("Texturas disponibles para modelo inicial: $textures");
                                              if (textures.contains(textureName)) {
                                                controllerModel.setTexture(textureName: textureName);
                                              } else {
                                                null;
                                                // print("Textura no disponible: $textureName");
                                              }
                                            })
                                            .catchError((error) {
                                              null;
                                              // print("Error al obtener texturas disponibles: $error");
                                            });
                                      }
                                    });

                                    _updateFinalModel();
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Stack(
                    children: [
                      Container(
                        color: categorie.name == "SmartBag" ? const Color.fromARGB(255, 219, 230, 255) : const Color.fromARGB(255, 243, 255, 237),
                        width: double.infinity,
                        child: Center(
                          child: SizedBox(
                            width: 1124,
                            child: Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.04, right: screenWidth * 0.04, top: 50),
                              child: Stack(
                                clipBehavior: Clip.antiAlias,
                                children: [
                                  if (screenWidth >= 900)
                                    Positioned(
                                      bottom: 0,
                                      left: min(400, screenWidth * 0.5),
                                      child: SizedBox(
                                        height: min(screenWidth * 0.6, 500),
                                        width: min(screenWidth * 0.6, 500),
                                        child: AnimatedOpacity(
                                          opacity: isComplete ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 1200),
                                          curve: Curves.easeInOut,
                                          child: Model(
                                            key: _finalModelKey,
                                            product: product,
                                            controllerModel: controllerFinally,
                                            autoRotate: true,
                                            gestureDetector: false,
                                            selectedValve: selectedValve,
                                            onLoad: (String _) {
                                              setState(() {
                                                _finalModelLoaded = true;
                                              });
                                              _applyTexturesToFinalModel();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (screenWidth <= 900)
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16),
                                            child: SizedBox(
                                              height: 300,
                                              child: AnimatedOpacity(
                                                opacity: isComplete ? 1.0 : 0.0,
                                                duration: const Duration(milliseconds: 1200),
                                                curve: Curves.easeInOut,
                                                child: Model(
                                                  key: _finalModelKey,
                                                  product: product,
                                                  controllerModel: controllerFinally,
                                                  autoRotate: true,
                                                  gestureDetector: false,
                                                  selectedValve: selectedValve,
                                                  onLoad: (String _) {
                                                    setState(() {
                                                      _finalModelLoaded = true;
                                                    });
                                                    _applyTexturesToFinalModel();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        Text(
                                          "Tu nuevo empaque ${product.subcategorie.title}",
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: categorie.name == "SmartBag" ? Theme.of(context).primaryColor : const Color(0xff4b8d2c),
                                          ),
                                        ),
                                        Text("Justo como lo necesitas.", style: TextStyle(fontSize: 26, color: Colors.grey[600])),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 20),
                                          height: 2,
                                          width: 400,
                                          color:
                                              categorie.name == "SmartBag"
                                                  ? Theme.of(context).primaryColor.withAlpha(200)
                                                  : const Color(0xff4b8d2c).withAlpha(200),
                                        ),
                                        Text(
                                          "${product.categoria.name} ${product.name} ${selectedColor?.name ?? ''}",
                                          style: TextStyle(
                                            fontSize: 26,
                                            color: categorie.name == "SmartBag" ? Theme.of(context).primaryColor : const Color(0xff4b8d2c),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 400,
                                          child: Text(
                                            product.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  categorie.name == "SmartBag"
                                                      ? Theme.of(context).primaryColor.withAlpha(150)
                                                      : const Color(0xff4b8d2c).withAlpha(150),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "\$${getPrecioSeleccionado().toStringAsFixed(2)} por unidad",
                                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                        ),
                                        Text("Gramaje: $selectedGramaje ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text("Estructura $selectedStructure", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        if (product.subcategorie.enabledPS)
                                          Text("Peel Stick: ${selectedPeelstick?.name}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text("Tipo de válvula: $selectedValve", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text("Terminado tipo $selectedFinish", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              // print("cotizado");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                              margin: EdgeInsets.symmetric(vertical: 20),
                                              decoration: BoxDecoration(
                                                color: categorie.name == "SmartBag" ? Theme.of(context).primaryColor : const Color(0xff4b8d2c),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                "¡Cotizar!",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: isComplete ? Colors.white : Colors.grey[700],
                                                  fontSize: 24,
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
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: isComplete,
                          child: AnimatedOpacity(
                            opacity: isComplete ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white.withAlpha(160), border: Border.all(width: 1, color: Colors.grey)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Por favor, completa tu bolsa para continuar.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          categorie.name == "SmartBag"
                                              ? Theme.of(context).primaryColor.withAlpha(150)
                                              : const Color(0xff4b8d2c).withAlpha(150),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.1),
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

class Model extends StatefulWidget {
  final Product product;
  final Flutter3DController controllerModel;
  final bool autoRotate;
  final bool gestureDetector;
  final String? selectedValve;
  final dynamic onLoad;

  const Model({
    super.key,
    required this.product,
    required this.controllerModel,
    required this.autoRotate,
    required this.gestureDetector,
    required this.selectedValve,
    required this.onLoad,
  });

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  Timer? _interactionTimer;

  void _onUserInteraction() {
    _interactionTimer?.cancel();
    _interactionTimer = Timer(Duration(seconds: 3), () {
      widget.controllerModel.resetCameraOrbit();
    });
  }

  @override
  void dispose() {
    _interactionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String src;

    if (widget.selectedValve == null || widget.selectedValve == "Sin válvula") {
      src = "assets/3Dmodels/${widget.product.subcategorie.title}/${widget.product.subcategorie.title}.glb";
      // print("Cargando modelo: $src");
    } else if (widget.selectedValve == "Válvula desgasificadora") {
      src = "assets/3Dmodels/${widget.product.subcategorie.title}/${widget.product.subcategorie.title}_D.glb";
      // print("Cargando modelo: $src");
    } else if (widget.selectedValve == "Válvula dosificadora") {
      src = "assets/3Dmodels/${widget.product.subcategorie.title}/${widget.product.subcategorie.title}_V.glb";
      // print("Cargando modelo: $src");
    } else {
      src = "assets/3Dmodels/${widget.product.subcategorie.title}/${widget.product.subcategorie.title}.glb";
      // print("Cargando modelo: $src");
    }

    return Listener(
      onPointerDown: (_) => _onUserInteraction(),
      onPointerMove: (_) => _onUserInteraction(),
      onPointerUp: (_) => _onUserInteraction(),
      child: Flutter3DViewer(
        progressBarColor: Colors.transparent,
        autorotate: widget.autoRotate,
        activeGestureInterceptor: widget.gestureDetector,
        controller: widget.controllerModel,
        onLoad: widget.onLoad,
        src: src,
        onError: (error) {
          // print("Error loading 3D model: $error");
        },
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
            style: TextStyle(color: product.categoria.name == "SmartBag" ? const Color(0xFF004F9E) : const Color(0xff4b8d2c)),
          ),
          TextSpan(text: text2),
        ],
      ),
    );
  }
}

class Selected extends StatelessWidget {
  final String? selected;
  final String? label;
  final void Function(String value) onTap;
  final bool isEnabled;

  const Selected({super.key, required this.selected, required this.label, required this.onTap, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == label;

    if (!isEnabled) {
      // Mostrar opciones por defecto: 50G, 250G, 500G en gris
      return Column(
        children:
            ["50Gr", "250Gr", "500Gr"].map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.grey.withAlpha(50),
                ),
                child: Text(item, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey)),
              );
            }).toList(),
      );
    }

    // Modo normal
    return MouseRegion(
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () => onTap(label!),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey, width: isSelected ? 2 : 1),
            color: isEnabled ? Colors.white : Colors.grey.withAlpha(50),
          ),
          child: Text(label!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: isEnabled ? Colors.black : Colors.grey)),
        ),
      ),
    );
  }
}

String getFinishSuffix(Terminado terminado) {
  final name = terminado.name.toLowerCase();
  if (name.contains("mate")) return "M";
  if (name.contains("brillante")) return "B";
  if (name.contains("papel")) return "P";
  return "P"; // valor por defecto
}

class FormCreateBag extends StatelessWidget {
  final Product product;
  final List<Terminado> terminadosDisponibles;
  final Terminado? selectedTerminado;
  final String? selectedStructure;
  final String? selectedGramaje;
  final NamedColor? selectedColor;
  final String? hoveredColor;
  final ValueChanged<String?> onHoverColor;

  final PeelStickOption? selectedPeelstick;
  final String? hoveredPS;
  final ValueChanged<String?> onHoverPS;

  final String? selectedValve;
  final String? selectedFinish;
  final ValueChanged<Terminado> onSelectTerminado;
  final ValueChanged<String?> onSelectStructure;
  final ValueChanged<String?> onSelectGramaje;
  final ValueChanged<NamedColor> onSelectColor;
  final ValueChanged<PeelStickOption> onSelectPeelstick;
  final ValueChanged<String?> onSelectValve;
  final ValueChanged<String?> onSelectFinish;
  final Flutter3DController controllerModel;
  final bool modelLoaded;

  const FormCreateBag({
    super.key,
    required this.product,
    required this.terminadosDisponibles,
    required this.selectedTerminado,
    required this.selectedStructure,
    required this.selectedGramaje,
    required this.selectedColor,
    required this.hoveredColor,
    required this.onHoverColor,

    required this.selectedPeelstick,
    required this.hoveredPS,
    required this.onHoverPS,
    required this.selectedValve,
    required this.selectedFinish,
    required this.onSelectTerminado,
    required this.onSelectStructure,
    required this.onSelectGramaje,
    required this.onSelectColor,
    required this.onSelectPeelstick,
    required this.onSelectValve,
    required this.onSelectFinish,
    required this.controllerModel,
    required this.modelLoaded,
  });

  // Obtener los colores disponibles para el gramaje seleccionado
  List<NamedColor> getAvailableColors() {
    if (selectedTerminado != null && selectedStructure != null && selectedGramaje != null) {
      final estructura = selectedTerminado!.structures.firstWhere(
        (e) => e.name == selectedStructure,
        orElse: () => selectedTerminado!.structures.first,
      );

      final ability = estructura.ability.firstWhere((a) => a.name == selectedGramaje, orElse: () => estructura.ability.first);

      final producto = ability.product.firstWhere((p) => p.subcategorie.title == product.subcategorie.title, orElse: () => product);

      return producto.colors;
    }
    return [];
  }

  List<NamedColor> getColorsForSelection() {
    if (selectedTerminado != null && selectedStructure != null && selectedGramaje != null) {
      final estructura = selectedTerminado!.structures.firstWhere(
        (e) => e.name == selectedStructure,
        orElse: () => selectedTerminado!.structures.first,
      );

      final ability = estructura.ability.firstWhere((a) => a.name == selectedGramaje, orElse: () => estructura.ability.first);

      final Set<String> seen = {};
      final List<NamedColor> colors = [];

      for (final product in ability.product) {
        for (final color in product.colors) {
          if (!seen.contains(color.name)) {
            seen.add(color.name);
            colors.add(color);
          }
        }
      }

      return colors;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    final allColors = getColorsForSelection();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Terminado
        ChooseBagTitle(text1: "Dale estilo a tu empaque.", text2: "Elige el terminado.", product: product),
        ...terminadosDisponibles.map((terminado) {
          return Selected(selected: selectedTerminado?.name, label: terminado.name, onTap: (_) => onSelectTerminado(terminado));
        }),

        const SizedBox(height: 30),

        /// Estructura
        if (selectedTerminado != null && selectedTerminado!.structures.isNotEmpty) ...[
          ChooseBagTitle(text1: "Define la estructura", text2: "La base de tu empaque perfecto.", product: product),
          ...selectedTerminado!.structures.map((estructura) {
            return Selected(selected: selectedStructure, label: estructura.name, onTap: (value) => onSelectStructure(value));
          }),
        ] else
          Selected(selected: null, label: null, isEnabled: false, onTap: (_) {}),

        const SizedBox(height: 30),

        /// Gramaje
        if (selectedTerminado != null && selectedStructure != null) ...[
          ChooseBagTitle(text1: "¿Cuánto quieres empacar?", text2: "Elige la capacidad o gramaje de tu bolsa.", product: product),
          ...selectedTerminado!.structures.firstWhere((e) => e.name == selectedStructure).ability.map((a) {
            return Selected(selected: selectedGramaje, label: a.name, onTap: (value) => onSelectGramaje(value));
          }),
        ] else
          Selected(selected: null, label: null, isEnabled: false, onTap: (_) {}),

        const SizedBox(height: 30),

        /// Color
        if (selectedTerminado != null && selectedStructure != null && selectedGramaje != null) ...[
          ChooseBagTitle(text1: "Tu color, tu estilo.", text2: "Escoge el que conecte con tus clientes.", product: product),
          Text(() {
            if (hoveredColor != null) {
              return "Color - $hoveredColor";
            }
            if (selectedColor != null) {
              return "Color - ${selectedColor!.name}";
            }
            return "Color";
          }(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                allColors.map((c) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => onHoverColor(c.name),
                    onExit: (_) => onHoverColor(null),

                    child: GestureDetector(
                      onTap: () {
                        onSelectColor(c);
                        if (modelLoaded && selectedTerminado != null) {
                          final suffix = getFinishSuffix(selectedTerminado!);
                          final textureName = "${c.name.replaceAll(" ", "_")}_$suffix";
                          controllerModel
                              .getAvailableTextures()
                              .then((textures) {
                                // print("Texturas disponibles: $textures");
                                if (textures.contains(textureName)) {
                                  controllerModel.setTexture(textureName: textureName);
                                } else {
                                  null;
                                  // print("Textura no disponible: $textureName");
                                }
                              })
                              .catchError((error) {
                                null;
                                // print("Error al obtener texturas disponibles: $error");
                              });
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: c.color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 2,
                            color: selectedColor?.name == c.name ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],

        /// Peel Stick
        if (product.subcategorie.enabledPS && selectedTerminado != null && selectedStructure != null && selectedGramaje != null) ...[
          const SizedBox(height: 30),
          ChooseBagTitle(text1: "Peel Stick.", text2: "El accesorio perfecto.", product: product),
          Text(() {
            if (hoveredPS != null) {
              return hoveredPS == "Sin Peel Stick" ? "Sin Peel Stick" : "Color - $hoveredPS";
            }
            if (selectedPeelstick != null) {
              return selectedPeelstick!.name == "Sin Peel Stick" ? "Sin Peel Stick" : "Color - ${selectedPeelstick!.name}";
            }
            return "Color";
          }(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...peelStickOptions.map((option) {
            return MouseRegion(
              onEnter: (_) => onHoverPS(option.name),
              onExit: (_) => onHoverPS(null),
              child: Selected(selected: selectedPeelstick?.name, label: option.name, onTap: (_) => onSelectPeelstick(option), isEnabled: true),
            );
          }),
        ],

        /// Válvula
        if (product.valves.isNotEmpty && selectedTerminado != null && selectedStructure != null && selectedGramaje != null) ...[
          const SizedBox(height: 30),
          ChooseBagTitle(text1: "¿Tu empaque lleva válvula?", text2: "Elige si deseas incluirla.", product: product),
          ...product.valves.map((valve) {
            return Selected(selected: selectedValve, label: valve, onTap: (value) => onSelectValve(value));
          }),
        ],
      ],
    );
  }
}
