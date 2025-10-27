import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final String currentSortOption;
  final ValueChanged<String> onSortChanged;

  const SortButton({super.key, required this.currentSortOption, required this.onSortChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSortChanged,
      color: Colors.white,
      position: PopupMenuPosition.over,
      offset: const Offset(0, -215),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.grey[300]!, width: 1.0),
      ),
      elevation: 4,
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledForegroundColor: Colors.black,
          side: BorderSide(color: Colors.grey[300]!),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_vert, size: 18),
            const SizedBox(width: 8),
            Text(currentSortOption),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: 'Latest', child: Text('Latest First')),
        const PopupMenuItem<String>(value: 'Oldest', child: Text('Oldest First')),
        const PopupMenuItem<String>(value: 'By Password', child: Text('By Password (A-Z)')),
        const PopupMenuItem<String>(value: 'By Nickname', child: Text('By Nickname (A-Z)')),
        const PopupMenuItem<String>(value: 'Favorites', child: Text('Favorites First')),
      ],
    );
  }
}