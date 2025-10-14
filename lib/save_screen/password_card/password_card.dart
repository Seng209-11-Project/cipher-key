import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:test_group_project/save_screen/password_card/square_outlined_buttons/square_outlined_buttons.dart';

class PasswordCard extends StatelessWidget {
  final String password;
  const PasswordCard({super.key, required this.password});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(LucideIcons.edit, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text('Add Nickname', style: TextStyle(color: Colors.grey[600]))
          ]),
          const SizedBox(height: 12),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8)),
              child: Text
                  (password,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))
          ),
          const SizedBox(height: 12),
          Text('Length: ${password.length}  ·  Oct 13, 2025, 01:55 PM',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.copy, size: 20),
                  label: const Text(
                    'Copy',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // same corner radius as icon buttons
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                )
            ),
            const SizedBox(width: 8),
            SquareOutlinedIconButton(icon: LucideIcons.star, onPressed: () {},),
            SquareOutlinedIconButton(icon: LucideIcons.trash2, onPressed: () {})
          ])
        ],
      ),
    );
  }
}