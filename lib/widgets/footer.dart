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

  // Datos de contacto
  static const List<Map<String, String>> contacts = [
    {'label': 'Teléfono', 'value': '+57 (601) 746 05 33'},
    {'label': 'Whatsapp', 'value': '+57 317 868 9152'},
    {'label': 'Email', 'value': 'info@empaquespackvision.com'},
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
                    children: [_buildScheduleSection(), _buildContactSection(), _buildSocialMediaSection(context)],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScheduleSection(),
                      const SizedBox(height: 20),
                      _buildContactSection(),
                      const SizedBox(height: 20),
                      _buildSocialMediaSection(context),
                    ],
                  ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    maxLines: 2,
                    "Copyright © 2025 Packvision S.A.S Todos los derechos reservados",
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                  Text("Colombia", style: TextStyle(color: Colors.black38, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para la sección de horarios
  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Horarios de atención:", style: TextStyle(fontWeight: FontWeight.bold)),
        ...schedules.map(
          (schedule) => Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "${schedule['day']}: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: schedule['time']),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget para la sección de contactos
  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          contacts
              .map(
                (contact) => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "${contact['label']}: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: contact['value']),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  // Widget para la sección de redes sociales
  Widget _buildSocialMediaSection(BuildContext context) {
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(social['icon'], color: Colors.white),
                ),
              ),
            );
          }).toList(),
    );
  }
}
