import 'package:flutter/material.dart';

class SquareOutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  const SquareOutlinedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: iconColor),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}