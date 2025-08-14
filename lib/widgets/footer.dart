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

  Widget _buildCopyRight(BuildContext context) => _OutlinedText("Copyright © 2025 Packvision S.A.S Todos los derechos reservados", isDark: isDark);

  Widget _buildLocation(BuildContext context) => _OutlinedText("Colombia", isDark: isDark);

  Widget _buildScheduleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _OutlinedText("Horarios de atención:", bold: true, isDark: isDark),
        ...schedules.map((s) {
          final String day = s['day']!;
          final String time = s['time']!;
          return _OutlinedText.rich([
            TextSpan(text: "$day: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: time),
          ], isDark: isDark);
        }),
        _OutlinedText.rich([
          const TextSpan(text: "Correo: ", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: "info@empaquespackvision.com",
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse("mailto:info@empaquespackvision.com")),
          ),
        ], isDark: isDark),
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
              child: GestureDetector(
                onTap: () => launchUrl(Uri.parse(social['url']), mode: LaunchMode.externalApplication),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,

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
  final bool bold, isDark;

  const _OutlinedText(this.text, {this.bold = false, required this.isDark}) : spans = null;
  const _OutlinedText.rich(this.spans, {required this.isDark}) : text = null, bold = false;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 14);

    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    final bgColor = routeName.toLowerCase().contains('ecobag') ? const Color(0xFFFBFFF8) : Theme.of(context).scaffoldBackgroundColor;

    final strokeColor = isDark ? const Color(0xff1d1d1f) : bgColor;
    final fillColor = isDark ? Colors.white : Colors.black;

    return Stack(
      children: [
        // Borde
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
                                ..color = strokeColor,
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
                        ..color = strokeColor,
                ),
              ),
        ),
        // Relleno
        Text.rich(
          spans != null
              ? TextSpan(
                children:
                    spans!.map((span) {
                      return TextSpan(
                        text: (span as TextSpan).text,
                        style: (span.style ?? baseStyle).copyWith(color: fillColor),
                        recognizer: span.recognizer,
                      );
                    }).toList(),
              )
              : TextSpan(text: text, style: baseStyle.copyWith(color: fillColor)),
        ),
      ],
    );
  }
}
