import 'package:flutter/material.dart';
import '../../../generate_screen/utils/helpers.dart'; // Doğru import

class SquareOutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SquareOutlinedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
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
        icon: Icon(icon, size: 20),
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