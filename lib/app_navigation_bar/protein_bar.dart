import 'package:flutter/material.dart';

OverlayEntry? _currentOverlayEntry;

void proteinBarM(
    BuildContext context,
    String message, {
      IconData? icon,
      Color? backgroundColor,
      Color? textColor,
      Color? iconColor,
      int duration = 3,
    }) {

  if (_currentOverlayEntry != null) {
    if (_currentOverlayEntry!.mounted) {
      _currentOverlayEntry!.remove();
    }
    _currentOverlayEntry = null;
  }

  final overlay = Overlay.of(context);
  final cs = Theme.of(context).colorScheme;

  final bgColor = backgroundColor ?? cs.surface;
  final txtColor = textColor ?? cs.onSurface;
  final icnColor = iconColor ?? cs.onSurface;

  final newEntry = OverlayEntry(
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
              // Dismiss current on swipe down
              if (_currentOverlayEntry != null && _currentOverlayEntry!.mounted) {
                _currentOverlayEntry!.remove();
                _currentOverlayEntry = null;
              }
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
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 14,
                        color: txtColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2, // Prevent massive text overflow
                      overflow: TextOverflow.ellipsis,
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

  _currentOverlayEntry = newEntry;
  overlay.insert(newEntry);

  Future.delayed(Duration(seconds: duration), () {
    if (newEntry.mounted && _currentOverlayEntry == newEntry) {
      newEntry.remove();
      _currentOverlayEntry = null;
    }
  });
}