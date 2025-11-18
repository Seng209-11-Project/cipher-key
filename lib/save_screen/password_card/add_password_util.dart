import 'package:flutter/material.dart';
import 'package:password_generator/save_screen/save_read_function.dart';
import '../../app_navigation_bar/protein_bar.dart';

void showAddPasswordDialog(BuildContext context, {VoidCallback? onSaved}) {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: const Text(
          'Add New Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
                hintText: 'Enter a nickname for this password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter the password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () async {
              final nickname = nicknameController.text;
              final password = passwordController.text;

              if (password.isEmpty) {
                proteinBarM(
                  context,
                  'Please enter a password',
                  icon: Icons.warning_amber_rounded,
                );
                return;
              }

              try {
                final DateTime now = DateTime.now();
                final String formattedDateTime =
                    '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

                final String passwordKey = '$nickname$formattedDateTime';

                await savePassword(passwordKey, password);

                // FIRST refresh the SaveScreen
                if (onSaved != null) onSaved();

                // THEN close the dialog
                Navigator.of(context).pop();

                // THEN show success message
                proteinBarM(
                  context,
                  'Password saved!',
                  icon: Icons.check_outlined,
                );
              } catch (e) {
                proteinBarM(
                  context,
                  'Failed to save password',
                  icon: Icons.error_outline,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
