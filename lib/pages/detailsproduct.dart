import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
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
  //Variables a escoger
  NamedColor? selectedColor;
  String? hoveredColor;
  String? selectedGramaje;
  PeelStickOption? selectedPeelstick;
  String? hoveredPS;
  String? selectedValve;
  String? selectedFinish;
  String? selectedStructure;

  //Modelo
  late Flutter3DController controllerModel;
  late Flutter3DController controllerFinally;
  bool _modelLoaded = false;
  bool _showTutorial = true;

  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    controllerModel = Flutter3DController();
    controllerFinally = Flutter3DController();
    _modelLoaded = true;
    _scrollController =
        ScrollController()..addListener(() {
          setState(() {
            _scrollOffset = _scrollController.offset;
          });
        });
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final product = widget.product;
    final categorie = widget.product.categoria;

    //Validación
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
                                                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
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
                                                              product.name,
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
                                          Positioned(top: -20, left: -600, child: Image.asset(widget.product.image, width: 1200)),
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
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(child: Image.asset(widget.product.image, fit: BoxFit.cover)),
                                              SizedBox(height: 20),
                                              Text(
                                                widget.product.name,
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
                                                product.description,
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
                    child: Center(child: Text("Escoge tu ${product.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
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
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.grey),
                          child:
                              product.categoria.name == "EcoBag"
                                  ? AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: HtmlBackgroundVideo(src: "assets/assets/videos/ecobag/ecobag.mp4", loop: true),
                                  )
                                  : Center(),
                        ),
                        SizedBox(height: 40),
                        if (screenWidth >= 900)
                          //PC
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
                                      child: Container(
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
                                                    if (selectedColor == null) {
                                                      selectedColor = product.colors.first;
                                                    } else {
                                                      selectedColor = selectedColor;
                                                    }
                                                    if (selectedFinish == null) {
                                                      selectedFinish = product.finishes.first;
                                                    } else {
                                                      selectedFinish = selectedFinish;
                                                    }
                                                    if (selectedPeelstick == null) {
                                                      selectedPeelstick = peelStickOptions.first;
                                                    } else {
                                                      selectedPeelstick!.abbreviation;
                                                    }
                                                    controllerModel.setTexture(
                                                      textureName:
                                                          "${selectedColor!.name.replaceAll(" ", "_")}_${_getFinishSuffix(selectedFinish, product)}",
                                                    );
                                                    Future.delayed(Duration(milliseconds: 100), () {
                                                      controllerModel.setTexture(textureName: selectedPeelstick!.abbreviation);
                                                    });
                                                  });
                                                  // final txt = await controllerModel.getAvailableTextures();
                                                  // print("texturas: $txt");
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
                                                  child: Image.network("assets/assets/gifts/cursor.gif", width: 200, height: 200),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: screenWidth * 0.5),
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        width: screenWidth,
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ChooseBagTitle(text1: "Color.", text2: "Empecemos escogiendo tú color.", product: product),
                                            const SizedBox(height: 10),
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
                                              spacing: 10,
                                              runSpacing: 10,
                                              children:
                                                  product.colors.map((c) {
                                                    final isSelected = selectedColor == c;
                                                    return MouseRegion(
                                                      onEnter: (_) {
                                                        setState(() {
                                                          hoveredColor = c.name;
                                                        });
                                                      },
                                                      onExit: (_) {
                                                        setState(() {
                                                          hoveredColor = null;
                                                        });
                                                      },
                                                      cursor: SystemMouseCursors.click,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          String suffix = _getFinishSuffix(selectedFinish, product);
                                                          setState(() {
                                                            selectedColor = c;
                                                          });
                                                          if (_modelLoaded) {
                                                            controllerModel.setTexture(textureName: "${c.name.replaceAll(" ", "_")}_$suffix");
                                                          }
                                                        },
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: c.color,
                                                                border: Border.all(
                                                                  color:
                                                                      isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.withAlpha(100),
                                                                  width: isSelected ? 2 : 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                            ),

                                            const SizedBox(height: 30),
                                            if (product.structures.isNotEmpty) ...[
                                              ChooseBagTitle(text1: "Estructura.", text2: "La resistencia de tú empaque.", product: product),
                                              ...product.structures.map((structure) {
                                                return Selected(
                                                  selected: selectedStructure,
                                                  label: structure,
                                                  onTap: (value) {
                                                    setState(() {
                                                      selectedStructure = value;
                                                    });
                                                  },
                                                );
                                              }),
                                            ],
                                            const SizedBox(height: 30),
                                            ChooseBagTitle(text1: "Gramaje.", text2: "Lo grueso de tú empaque.", product: product),
                                            Selected(
                                              selected: selectedGramaje,
                                              label: "500G",
                                              onTap: (value) {
                                                setState(() {
                                                  selectedGramaje = value;
                                                });
                                              },
                                            ),
                                            Selected(
                                              selected: selectedGramaje,
                                              label: "250G",
                                              onTap: (value) {
                                                setState(() {
                                                  selectedGramaje = value;
                                                });
                                              },
                                            ),
                                            Selected(
                                              selected: selectedGramaje,
                                              label: "125G",
                                              onTap: (value) {
                                                setState(() {
                                                  selectedGramaje = value;
                                                });
                                              },
                                            ),
                                            if (product.subcategorie.enabledPS == true)
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 30),
                                                  ChooseBagTitle(text1: "Peel Stick.", text2: "El accesorio perfecto.", product: product),
                                                  const SizedBox(height: 10),
                                                  Text(() {
                                                    if (hoveredPS != null) {
                                                      return hoveredPS == "Sin Peel Stick" ? "Sin Peel Stick" : "Color - $hoveredPS";
                                                    }
                                                    if (selectedPeelstick != null) {
                                                      return selectedPeelstick!.name == "Sin Peel Stick"
                                                          ? "Sin Peel Stick"
                                                          : "Color - ${selectedPeelstick!.name}";
                                                    }
                                                    return "Color";
                                                  }(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 10),
                                                  Wrap(
                                                    spacing: 10,
                                                    runSpacing: 10,
                                                    children:
                                                        peelStickOptions.map((option) {
                                                          final isSelected = selectedPeelstick == option;
                                                          return MouseRegion(
                                                            onEnter: (_) {
                                                              setState(() {
                                                                hoveredPS = option.name;
                                                              });
                                                            },
                                                            onExit: (_) {
                                                              setState(() {
                                                                hoveredPS = null;
                                                              });
                                                            },
                                                            cursor: SystemMouseCursors.click,

                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedPeelstick = option;
                                                                });
                                                                if (_modelLoaded) {
                                                                  controllerModel.setTexture(textureName: option.abbreviation);
                                                                }
                                                              },
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: option.name == "Sin Peel Stick" ? Colors.transparent : option.color,
                                                                      border: Border.all(
                                                                        color:
                                                                            isSelected
                                                                                ? Theme.of(context).colorScheme.primary
                                                                                : Colors.grey.withAlpha(100),
                                                                        width: isSelected ? 2 : 1,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        option.name == "Sin Peel Stick"
                                                                            ? Center(child: Icon(Icons.block, size: 20, color: Colors.red))
                                                                            : null,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                  ),
                                                ],
                                              ),

                                            const SizedBox(height: 30),
                                            if (product.valves.isNotEmpty) ...[
                                              ChooseBagTitle(text1: "Valvula.", text2: "El respiro a tú empaque.", product: product),
                                              ...product.valves.map((valve) {
                                                return Selected(
                                                  selected: selectedValve,
                                                  label: valve,
                                                  onTap: (value) {
                                                    setState(() {
                                                      selectedValve = value;
                                                    });
                                                  },
                                                );
                                              }),
                                            ],

                                            const SizedBox(height: 30),
                                            if (product.finishes.isNotEmpty) ...[
                                              ChooseBagTitle(text1: "Terminación.", text2: "El acabado a tú empaque.", product: product),
                                              ...product.finishes.map((finish) {
                                                return Selected(
                                                  selected: selectedFinish,
                                                  label: finish,
                                                  onTap: (value) {
                                                    setState(() {
                                                      selectedFinish = value;
                                                    });
                                                    String suffix = _getFinishSuffix(selectedFinish, product);
                                                    if (_modelLoaded) {
                                                      controllerModel.setTexture(textureName: "${selectedColor?.name}_$suffix");
                                                    }
                                                  },
                                                );
                                              }),
                                            ],
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
                          //Celular
                          Column(
                            children: [
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
                                        onLoad: (String _) async {
                                          setState(() {
                                            if (selectedColor == null) {
                                              selectedColor = product.colors.first;
                                            } else {
                                              selectedColor = selectedColor;
                                            }
                                            if (selectedFinish == null) {
                                              selectedFinish = product.finishes.first;
                                            } else {
                                              selectedFinish = selectedFinish;
                                            }
                                            if (selectedPeelstick == null) {
                                              selectedPeelstick = peelStickOptions.first;
                                            } else {
                                              selectedPeelstick!.abbreviation;
                                            }
                                            controllerModel.setTexture(
                                              textureName: "${selectedColor!.name.replaceAll(" ", "_")}_${_getFinishSuffix(selectedFinish, product)}",
                                            );
                                            Future.delayed(Duration(milliseconds: 100), () {
                                              controllerModel.setTexture(textureName: selectedPeelstick!.abbreviation);
                                            });
                                          });
                                        },
                                      ),
                                    ),

                                    AnimatedOpacity(
                                      opacity: _showTutorial ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 500),
                                      child: IgnorePointer(
                                        ignoring: true,
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.black.withAlpha(80)),
                                          alignment: Alignment.center,
                                          child: Image.network("assets/assets/gifts/cursor.gif", width: 200, height: 200),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChooseBagTitle(text1: "Color.", text2: "Empecemos escogiendo tú color.", product: product),
                                    const SizedBox(height: 10),
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
                                      spacing: 10,
                                      runSpacing: 10,
                                      children:
                                          product.colors.map((c) {
                                            final isSelected = selectedColor == c;
                                            return MouseRegion(
                                              onEnter: (_) {
                                                setState(() {
                                                  hoveredColor = c.name;
                                                });
                                              },
                                              onExit: (_) {
                                                setState(() {
                                                  hoveredColor = null;
                                                });
                                              },
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  String suffix = _getFinishSuffix(selectedFinish, product);
                                                  setState(() {
                                                    selectedColor = c;
                                                  });
                                                  if (_modelLoaded) {
                                                    controllerModel.setTexture(textureName: "${c.name.replaceAll(" ", "_")}_$suffix");
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: c.color,
                                                        border: Border.all(
                                                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.withAlpha(100),
                                                          width: isSelected ? 2 : 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),

                                    const SizedBox(height: 30),
                                    if (product.structures.isNotEmpty) ...[
                                      ChooseBagTitle(text1: "Estructura.", text2: "La resistencia de tú empaque.", product: product),
                                      ...product.structures.map((structure) {
                                        return Selected(
                                          selected: selectedStructure,
                                          label: structure,
                                          onTap: (value) {
                                            setState(() {
                                              selectedStructure = value;
                                            });
                                          },
                                        );
                                      }),
                                    ],
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(text1: "Gramaje.", text2: "Lo grueso de tú empaque.", product: product),
                                    Selected(
                                      selected: selectedGramaje,
                                      label: "500G",
                                      onTap: (value) {
                                        setState(() {
                                          selectedGramaje = value;
                                        });
                                      },
                                    ),
                                    Selected(
                                      selected: selectedGramaje,
                                      label: "250G",
                                      onTap: (value) {
                                        setState(() {
                                          selectedGramaje = value;
                                        });
                                      },
                                    ),
                                    Selected(
                                      selected: selectedGramaje,
                                      label: "125G",
                                      onTap: (value) {
                                        setState(() {
                                          selectedGramaje = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    ChooseBagTitle(text1: "Peel Stick.", text2: "El accesorio perfecto.", product: product),
                                    const SizedBox(height: 10),
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
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children:
                                          peelStickOptions.map((option) {
                                            final isSelected = selectedPeelstick == option;
                                            return MouseRegion(
                                              onEnter: (_) {
                                                setState(() {
                                                  hoveredPS = option.name;
                                                });
                                              },
                                              onExit: (_) {
                                                setState(() {
                                                  hoveredPS = null;
                                                });
                                              },
                                              cursor: SystemMouseCursors.click,

                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedPeelstick = option;
                                                  });
                                                  if (_modelLoaded) {
                                                    controllerModel.setTexture(textureName: option.abbreviation);
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: option.name == "Sin Peel Stick" ? Colors.transparent : option.color,
                                                        border: Border.all(
                                                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.withAlpha(100),
                                                          width: isSelected ? 2 : 1,
                                                        ),
                                                      ),
                                                      child:
                                                          option.name == "Sin Peel Stick"
                                                              ? Center(child: Icon(Icons.block, size: 20, color: Colors.red))
                                                              : null,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                    const SizedBox(height: 30),
                                    if (product.valves.isNotEmpty) ...[
                                      ChooseBagTitle(text1: "Valvula.", text2: "El respiro a tú empaque.", product: product),
                                      ...product.valves.map((valve) {
                                        return Selected(
                                          selected: selectedValve,
                                          label: valve,
                                          onTap: (value) {
                                            setState(() {
                                              selectedValve = value;
                                            });
                                          },
                                        );
                                      }),
                                    ],

                                    const SizedBox(height: 30),
                                    if (product.finishes.isNotEmpty) ...[
                                      ChooseBagTitle(text1: "Terminación.", text2: "El acabado a tú empaque.", product: product),
                                      ...product.finishes.map((finish) {
                                        return Selected(
                                          selected: selectedFinish,
                                          label: finish,
                                          onTap: (value) {
                                            setState(() {
                                              selectedFinish = value;
                                            });
                                            String suffix = _getFinishSuffix(selectedFinish, product);
                                            if (_modelLoaded) {
                                              controllerModel.setTexture(textureName: "${selectedColor?.name}_$suffix");
                                            }
                                          },
                                        );
                                      }),
                                    ],
                                  ],
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
                                      bottom: -200,
                                      left: min(300, screenWidth * 0.5),
                                      child: SizedBox(
                                        height: 700,
                                        width: 700,
                                        child: AnimatedOpacity(
                                          opacity: isComplete ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 1200),
                                          curve: Curves.easeInOut,
                                          child: Model(
                                            product: product,
                                            controllerModel: controllerFinally,
                                            autoRotate: false,
                                            gestureDetector: false,
                                            selectedValve: selectedValve,
                                            onLoad: (String _) {
                                              final suffix = _getFinishSuffix(selectedFinish, product);
                                              controllerFinally.setTexture(textureName: "${selectedColor?.name.replaceAll(" ", "_")}_$suffix");
                                              Future.delayed(Duration(milliseconds: 100), () {
                                                controllerFinally.setTexture(textureName: selectedPeelstick!.abbreviation);
                                              });
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
                                                  product: product,
                                                  controllerModel: controllerFinally,
                                                  autoRotate: false,
                                                  gestureDetector: false,
                                                  selectedValve: selectedValve,
                                                  onLoad: (String _) {
                                                    final suffix = _getFinishSuffix(selectedFinish, product);
                                                    controllerFinally.setTexture(textureName: "${selectedColor?.name.replaceAll(" ", "_")}_$suffix");
                                                    Future.delayed(Duration(milliseconds: 100), () {
                                                      controllerFinally.setTexture(textureName: selectedPeelstick!.abbreviation);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        Text(
                                          "Tu nuevo empaque",
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
                                        Text("\$${product.price}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text(selectedGramaje ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text(selectedStructure ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text(selectedPeelstick?.name ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text(selectedValve ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Text(selectedFinish ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              print("cotizado");
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
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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

class Model extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final String fixProductName = product.name.replaceAll(" ", "_");
    String src;

    if (selectedValve == null || selectedValve == "Sin válvula") {
      src = "assets/assets/3Dmodels/${product.subcategorie.title}/$fixProductName/$fixProductName.glb";
    } else if (selectedValve == "Válvula desgasificadora") {
      src = "assets/assets/3Dmodels/${product.subcategorie.title}/$fixProductName/${fixProductName}_D.glb";
    } else if ((selectedValve == "Válvula dosificadora")) {
      src = "assets/assets/3Dmodels/${product.subcategorie.title}/$fixProductName/${fixProductName}_V.glb";
    } else {
      src = "assets/assets/3Dmodels/${product.subcategorie.title}/$fixProductName/$fixProductName.glb";
    }

    return Flutter3DViewer(
      progressBarColor: Colors.transparent,
      //autorotate: autoRotate,
      activeGestureInterceptor: gestureDetector,
      controller: controllerModel,
      onLoad: onLoad,
      src: src,
      onError: (error) {
        print("Error error error error $error");
      },
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

  const Selected({super.key, required this.selected, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == label;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(label!),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey, width: isSelected ? 2 : 1),
          ),
          child: Text(label!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ),
    );
  }
}

// Función que devuelve el sufijo de la terminación seleccionada
String _getFinishSuffix(String? finish, Product product) {
  if (finish != null) {
    if (finish.toLowerCase().contains("brillante")) {
      return "B";
    } else if (finish.toLowerCase().contains("mate")) {
      return "M";
    } else if (finish.toLowerCase().contains("papel")) {
      return "P";
    }
  }
  return product.finishes.first.toLowerCase().startsWith("b")
      ? "B"
      : product.finishes.first.toLowerCase().startsWith("m")
      ? "M"
      : "P";
}
