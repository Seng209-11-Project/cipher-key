import 'package:flutter/material.dart';

void proteinBarM(
    BuildContext context,
    String message, {
      IconData? icon,
      Color iconColor = Colors.white,
      int duration = 3,
    }) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: iconColor, size: 18),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      message,
                      style:  TextStyle(
                          fontSize: 14, color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));

  overlay.insert(overlayEntry);
  Future.delayed(Duration(seconds: duration), () {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}

