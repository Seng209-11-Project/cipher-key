import 'package:flutter/material.dart';

class GeneratePasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GeneratePasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: onPressed,
      child: const Text(
        "Generate Password",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}