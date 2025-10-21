import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:password_generator/save_screen/password_card/square_outlined_buttons/square_outlined_buttons.dart';
import 'package:password_generator/generate_screen/widgets/protein_bar.dart';
import 'package:password_generator/save_screen/save_read_function.dart';

class PasswordCard extends StatelessWidget {
  final String password;
  final String passwordName;
  final String passwordDateTime;
  final String passwordId;

  const PasswordCard({
    super.key,
    required this.password,
    required this.passwordName,
    required this.passwordDateTime,
    required this.passwordId,
  });

  void _copyPassword(BuildContext context) {
    Clipboard.setData(ClipboardData(text: password));
    proteinBarM(context, "Password Copied!", icon: Icons.check_outlined);
  }

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    passwordName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Length: ${password.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        passwordDateTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.copy, size: 20),
                  label: const Text(
                    'Copy',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () => _copyPassword(context),  // <-- Changed this line
                )
            ),
            const SizedBox(width: 8),
            SquareOutlinedIconButton(
              icon: LucideIcons.trash2, 
              onPressed: () => _deletePassword(context),
            ),
          ])
        ],
      ),
    );
  }

  void _deletePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Password'),
          content: Text('Are you sure you want to delete this password?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                proteinBarM(context, "Password Deleted!", icon: Icons.delete_outline);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}