import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final bool isDark;
  const Footer({super.key, this.isDark = false});

  static const double mobileBreakpoint = 1000;

  static const List<Map<String, String>> schedules = [
    {'day': 'Lunes a miércoles', 'time': '7:00 a.m. a 5:00 p.m.'},
    {'day': 'Jueves', 'time': '7:00 a.m. a 4:30 p.m.'},
    {'day': 'Viernes', 'time': '7:00 a.m. a 4:00 p.m.'},
    {'day': 'Sábado y domingo', 'time': 'No tenemos atención'},
  ];

  static const List<Map<String, dynamic>> socialMedia = [
    {'icon': Boxicons.bxl_tiktok, 'url': 'https://www.tiktok.com/@packvision_sas?lang=es'},
    {'icon': Boxicons.bxl_instagram, 'url': 'https://www.instagram.com/packvision_sas/'},
    {'icon': Boxicons.bxl_facebook, 'url': 'https://www.facebook.com/PackvisionSAS/'},
    {'icon': Boxicons.bxl_youtube, 'url': 'https://www.youtube.com/channel/UCWs_xOXcL51lQVUP0VMSZzQ'},
    {'icon': Boxicons.bxl_twitter, 'url': 'https://twitter.com/PackvisionS'},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= mobileBreakpoint;
    final Color strokeColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Color(0xff1d1d1f);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isWide
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildScheduleSection(context), _buildSocialMediaRow(context)],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildScheduleSection(context), const SizedBox(height: 20), _buildSocialMediaRow(context)],
                  ),
              const SizedBox(height: 20),
              isWide
                  ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildCopyRight(context), _buildLocation(context)])
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildCopyRight(context), const SizedBox(height: 10), _buildLocation(context)],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCopyRight(BuildContext context) => _OutlinedText("Copyright © 2025 Packvision S.A.S Todos los derechos reservados");

  Widget _buildLocation(BuildContext context) => _OutlinedText("Colombia");

  Widget _buildScheduleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _OutlinedText("Horarios de atención:", bold: true),
        ...schedules.map((s) {
          final String day = s['day']!;
          final String time = s['time']!;
          return _OutlinedText.rich([TextSpan(text: "$day: ", style: const TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: time)]);
        }),
        _OutlinedText.rich([
          const TextSpan(text: "Correo: ", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: "info@empaquespackvision.com",
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse("mailto:info@empaquespackvision.com")),
          ),
        ]),
      ],
    );
  }

  Widget _buildSocialMediaRow(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name?.toLowerCase() ?? '';
    final color = route.contains('ecobag') ? const Color(0xFF4B8D2C) : Theme.of(context).primaryColor;

    return Row(
      children:
          socialMedia.map((social) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse(social['url']), mode: LaunchMode.externalApplication),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                    child: Icon(social['icon'], color: Colors.white),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}

class _OutlinedText extends StatelessWidget {
  final String? text;
  final List<InlineSpan>? spans;
  final bool bold;

  const _OutlinedText(this.text, {this.bold = false}) : spans = null;
  const _OutlinedText.rich(this.spans) : text = null, bold = false;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 14);

    return Stack(
      children: [
        Text.rich(
          spans != null
              ? TextSpan(
                children:
                    spans!.map((span) {
                      return TextSpan(
                        text: (span as TextSpan).text,
                        style: (span.style ?? baseStyle).copyWith(
                          foreground:
                              Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Theme.of(context).scaffoldBackgroundColor,
                        ),
                        recognizer: span.recognizer,
                      );
                    }).toList(),
              )
              : TextSpan(
                text: text,
                style: baseStyle.copyWith(
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
        ),
        Text.rich(spans != null ? TextSpan(children: spans) : TextSpan(text: text, style: baseStyle.copyWith(color: Colors.black))),
      ],
    );
  }
}
