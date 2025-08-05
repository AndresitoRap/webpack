import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final bool enabled;
  final IconData icon;
  final VoidCallback onTap;

  const ArrowButton({super.key, required this.enabled, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon),
      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(enabled ? Colors.grey.withAlpha(100) : Colors.grey.withAlpha(80))),
    );
  }
}
