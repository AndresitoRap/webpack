import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final bool enabled;
  final IconData icon;
  final bool? isDark;
  final VoidCallback onTap;

  const ArrowButton({super.key, required this.enabled, required this.icon, required this.onTap, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(
        icon,
        color:
            isDark!
                ? enabled
                    ? Colors.white
                    : Colors.white30
                : null,
      ),
      style: ButtonStyle(
        backgroundColor:
            isDark!
                ? WidgetStateProperty.all(enabled ? const Color(0xFFEAEAEA).withAlpha(100) : Colors.grey.withAlpha(80))
                : WidgetStateProperty.all(enabled ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80)),
      ),
    );
  }
}
