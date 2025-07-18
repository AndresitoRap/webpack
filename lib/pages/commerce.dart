import 'package:flutter/material.dart';
import 'package:webpack/class/categories.dart';
import 'package:webpack/pages/ecobag/fourpro.dart';
import 'package:webpack/pages/smartbag/fivepro.dart';
import 'package:webpack/pages/smartbag/fourpro.dart';
import 'package:webpack/widgets/header.dart';

class Commerce extends StatefulWidget {
  final String section;
  final Subcategorie selectedSubcategorie;
  const Commerce({super.key, required this.section, required this.selectedSubcategorie});

  @override
  State<Commerce> createState() => _CommerceState();
}

class _CommerceState extends State<Commerce> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    final section = widget.section.toLowerCase();
    final categoryName = widget.selectedSubcategorie.category.name.toLowerCase();
    Widget content;

    if (categoryName == 'smartbag') {
      switch (section) {
        case '4pro':
          content = FourPro(screenWidth: screenWidth, currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);
          break;

        case '5pro':
          content = FivePro(currentRoute: currentRoute, subcategorie: widget.selectedSubcategorie, section: widget.section);
        default:
          content = const Center(child: Text('En construcción'));
      }
    } else {
      switch (section) {
        case '4pro':
          content = FourProEco(
            screenWidth: screenWidth,
            currentRoute: currentRoute,
            subcategorie: widget.selectedSubcategorie,
            section: widget.section,
          );
          break;

        default:
          content = const Center(child: Text('En construcción'));
      }
    }

    return Scaffold(body: Stack(children: [content, Header()]));
  }
}


//Ecobag

