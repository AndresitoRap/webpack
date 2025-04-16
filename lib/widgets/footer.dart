import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir enlaces

class Footer extends StatelessWidget {
  const Footer({super.key});

  // Umbral para cambiar de layout
  static const double mobileBreakpoint = 1000;

  // Datos de horarios
  static const List<Map<String, String>> schedules = [
    {'day': 'Lunes a miércoles', 'time': '7:00 a.m. a 5:00 p.m.'},
    {'day': 'Jueves', 'time': '7:00 a.m. a 4:30 p.m.'},
    {'day': 'Viernes', 'time': '7:00 a.m. a 4:00 p.m.'},
    {'day': 'Sábado y domingo', 'time': 'No tenemos atención'},
  ];

  // Datos de redes sociales
  static const List<Map<String, dynamic>> socialMedia = [
    {'icon': Boxicons.bxl_tiktok, 'url': 'https://www.tiktok.com/@packvision_sas?lang=es'},
    {'icon': Boxicons.bxl_instagram, 'url': 'https://www.instagram.com/packvision_sas/'},
    {'icon': Boxicons.bxl_facebook, 'url': 'https://www.facebook.com/PackvisionSAS/'},
    {'icon': Boxicons.bxl_youtube, 'url': 'https://www.youtube.com/channel/UCWs_xOXcL51lQVUP0VMSZzQ'},
    {'icon': Boxicons.bxl_twitter, 'url': 'https://twitter.com/PackvisionS'},
  ];

  // Función para abrir URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              screenWidth >= mobileBreakpoint
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildScheduleSection(context), _buildSocialMediaSection(context)],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScheduleSection(context),
                      const SizedBox(height: 20),
                      _buildSocialMediaSection(context),
                    ],
                  ),
              const SizedBox(height: 20),
              screenWidth >= mobileBreakpoint
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "Copyright © 2025 Packvision S.A.S Todos los derechos reservados",
                            style: TextStyle(
                              fontSize: 12,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 4
                                    ..color = Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          Text(
                            "Copyright © 2025 Packvision S.A.S Todos los derechos reservados",
                            style: TextStyle(color: Colors.black38, fontSize: 12),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            "Colombia",
                            style: TextStyle(
                              fontSize: 12,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 4
                                    ..color = Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          Text("Colombia", style: TextStyle(color: Colors.black38, fontSize: 12)),
                        ],
                      ),
                    ],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "Copyright © 2025 Packvision S.A.S Todos los derechos reservados",
                            style: TextStyle(
                              fontSize: 12,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 4
                                    ..color = Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          Text(
                            "Copyright © 2025 Packvision S.A.S Todos los derechos reservados",
                            style: TextStyle(color: Colors.black38, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          Text(
                            "Colombia",
                            style: TextStyle(
                              fontSize: 12,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 4
                                    ..color = Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          Text("Colombia", style: TextStyle(color: Colors.black38, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para la sección de horarios
  Widget _buildScheduleSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Text(
              "Horarios de atención:",
              style: TextStyle(
                foreground:
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Text("Horarios de atención:", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        ...schedules.map(
          (schedule) => Stack(
            children: [
              // Texto con trazo (background)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${schedule['day']}: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    TextSpan(
                      text: schedule['time'],
                      style: TextStyle(
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Texto normal (foreground)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${schedule['day']}: ",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(text: schedule['time'], style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget para la sección de redes sociales
  Widget _buildSocialMediaSection(BuildContext context) {
    Color getPrimaryColor(BuildContext context) {
      final route = ModalRoute.of(context)?.settings.name ?? '';

      if (route.toLowerCase().contains('ecobag')) {
        return const Color.fromARGB(255, 75, 141, 44);
      }

      return Theme.of(context).primaryColor;
    }

    return Row(
      children:
          socialMedia.map((social) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _launchUrl(social['url']),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: getPrimaryColor(context), borderRadius: BorderRadius.circular(8)),
                  child: Icon(social['icon'], color: Colors.white),
                ),
              ),
            );
          }).toList(),
    );
  }
}
