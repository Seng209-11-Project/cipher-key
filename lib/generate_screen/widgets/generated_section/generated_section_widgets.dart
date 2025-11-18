import 'package:flutter/material.dart';

import '../../utils/helpers.dart';
import 'generated_section_styles.dart';

class GeneratedSectionWidgets {
  static Widget buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isHovering,
    required Function(bool) onHover,
  }) {
    return Builder(
      builder: (context) {
        final cs = Theme.of(context).colorScheme;

        return MouseRegion(
          onEnter: (_) => onHover(true),
          onExit: (_) => onHover(false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // uses themed shadow (helpers.dart should now take context)
              boxShadow: isHovering ? [buildBoxShadow(context)] : [],
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 20,
                color: cs.primary, // THEMED instead of Colors.black
              ),
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(),
              style: editButtonStyle, // style def comes from generated_section_styles.dart
            ),
          ),
        );
      },
    );
  }

  static Widget buildActionButton(
      IconData icon,
      String label,
      VoidCallback onPressed, {
        BuildContext? context, // optional, for explicit theming if you want
      }) {
    return Builder(
      builder: (ctx) {
        final useCtx = context ?? ctx;

        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 18),
          label: Text(label),
          // uses themed button style from helpers.dart
          style: buildActionButtonStyle(useCtx),
        );
      },
    );
  }

  static Widget buildEditButtons({
    required bool isEditing,
    required Map<String, bool> hoverStates,
    required Function(String, bool) onHover,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required VoidCallback onEdit,
  }) {
    if (isEditing) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          buildIconButton(
            icon: Icons.check,
            onPressed: onSave,
            isHovering: hoverStates['check']!,
            onHover: (hovering) => onHover('check', hovering),
          ),
          const SizedBox(width: 4),
          buildIconButton(
            icon: Icons.close,
            onPressed: onCancel,
            isHovering: hoverStates['close']!,
            onHover: (hovering) => onHover('close', hovering),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: buildIconButton(
          icon: Icons.edit,
          onPressed: onEdit,
          isHovering: hoverStates['edit']!,
          onHover: (hovering) => onHover('edit', hovering),
        ),
      );
    }
  }
}
