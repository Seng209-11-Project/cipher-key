import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class SortButton extends StatelessWidget {
  final String currentSortOption;
  final ValueChanged<String> onSortChanged;

  const SortButton({
    super.key,
    required this.currentSortOption,
    required this.onSortChanged,
  });

  String _getLocalizedSortOption(String option, AppLocalizations t) {
    switch (option) {
      case 'Latest':
        return t.sortLatestFirst;
      case 'Oldest':
        return t.sortOldestFirst;
      case 'By Password':
        return t.sortByPasswordAZ;
      case 'By Nickname':
        return t.sortByNicknameAZ;
      default:
        return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return PopupMenuButton<String>(
      onSelected: onSortChanged,
      color: cs.surface, // THEMED
      position: PopupMenuPosition.over,
      offset: const Offset(0, -215),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: cs.secondary.withOpacity(0.3), width: 1.0),
      ),
      elevation: 4,
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: cs.surface,
          disabledForegroundColor: cs.primary,
          side: BorderSide(color: cs.secondary.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_vert, size: 18, color: cs.primary),
            const SizedBox(width: 8),
            Text(
              _getLocalizedSortOption(currentSortOption, t),
              style: TextStyle(color: cs.primary),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Latest',
          child: Text(
            t.sortLatestFirst,
            style: TextStyle(color: cs.primary),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Oldest',
          child: Text(
            t.sortOldestFirst,
            style: TextStyle(color: cs.primary),
          ),
        ),
        PopupMenuItem<String>(
          value: 'By Password',
          child: Text(
            t.sortByPasswordAZ,
            style: TextStyle(color: cs.primary),
          ),
        ),
        PopupMenuItem<String>(
          value: 'By Nickname',
          child: Text(
            t.sortByNicknameAZ,
            style: TextStyle(color: cs.primary),
          ),
        ),
      ],
    );
  }
}