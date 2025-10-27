import 'package:flutter/material.dart';
import 'package:password_generator/save_screen/save_read_function.dart';
import 'package:password_generator/generate_screen/widgets/protein_bar.dart';  // Add this import

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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
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
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final nickname = nicknameController.text;
              final password = passwordController.text;
              
              if (password.isNotEmpty) {
                try {
                  final DateTime now = DateTime.now();
                  final String formattedDateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
                  String passwordKey = nickname + formattedDateTime;
                  
                  await savePassword(passwordKey, password);
                  
                  Navigator.of(context).pop();
                  
                  // Use protein bar instead of SnackBar
                  proteinBarM(
                    context, 
                    nickname.isEmpty 
                      ? 'Password saved!' 
                      : 'Password "$nickname" saved!',
                    icon: Icons.check_outlined,
                  );
                  
                  if (onSaved != null) {
                    onSaved();
                  }
                } catch (e) {
                  // Use protein bar for error as well
                  proteinBarM(
                    context,
                    'Failed to save password',
                    icon: Icons.error_outline,
                  );
                }
              } else {
                // Use protein bar for validation error
                proteinBarM(
                  context,
                  'Please enter a password',
                  icon: Icons.warning_amber_rounded,
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
