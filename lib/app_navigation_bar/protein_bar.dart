import 'package:flutter/material.dart';

void proteinBarM(
    BuildContext context,
    String message, {
      IconData? icon,
      Color? backgroundColor,
      Color? textColor,
      Color? iconColor,
      int duration = 3,
    }) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  final cs = Theme.of(context).colorScheme;

  // THEMED COLORS
  final bgColor = backgroundColor ?? cs.surface;
  final txtColor = textColor ?? cs.onSurface;
  final icnColor = iconColor ?? cs.onSurface;

  overlayEntry = OverlayEntry(
    builder: (context) => Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom > 0.0
              ? MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).size.height * 0.05
              : MediaQuery.of(context).size.height * 0.125,
        ),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > 0) {
              overlayEntry.remove();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(500),

                // ✔ THEMED SHADOW FOR DARK MODE
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: icnColor, size: 18),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: txtColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: duration), () {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}
