import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:password_generator/l10n/app_localizations.dart';
import '../main.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.secondary.withOpacity(0.2))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            index: 0,
            icon: LucideIcons.home,
            label: AppLocalizations.of(context)!.navGenerate,
          ),
          _navItem(
            index: 1,
            icon: LucideIcons.lock,
            label: AppLocalizations.of(context)!.navSaved,
          ),
          _navItem(
            index: 2,
            icon: LucideIcons.settings,
            label: AppLocalizations.of(context)!.navSettings,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final cs = Theme.of(context).colorScheme;
    final bool selected = selectedIndex.value == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex.value = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? cs.secondary.withOpacity(0.15)   // Soft rounded bg
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: selected ? cs.primary : cs.secondary, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? cs.primary : cs.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
