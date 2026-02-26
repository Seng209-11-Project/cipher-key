import 'package:flutter/material.dart';

BoxShadow buildBoxShadow(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return BoxShadow(
    color: cs.primary.withOpacity(0.15),
    blurRadius: 6,
    spreadRadius: 1,
    offset: const Offset(0, 2),
  );
}

InputDecoration buildInputDecoration(String hintText, BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: cs.surface.withOpacity(0.5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: cs.secondary.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: cs.secondary.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: cs.primary, width: 1.5),
    ),
    hoverColor: cs.primary.withOpacity(0.05),
    focusColor: cs.primary.withOpacity(0.1),
  );
}

ButtonStyle buildActionButtonStyle(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  return ElevatedButton.styleFrom(
    backgroundColor: cs.surface,
    foregroundColor: cs.primary,
    side: BorderSide(color: cs.secondary.withOpacity(0.3)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );
}
