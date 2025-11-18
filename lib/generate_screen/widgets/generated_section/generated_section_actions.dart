import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../save_screen/save_read_function.dart';
import '../../../app_navigation_bar/protein_bar.dart';

void copyButtonOnPressed(BuildContext context, String password) {
  Clipboard.setData(ClipboardData(text: password));
  proteinBarM(context, "Copied Password", icon: Icons.check_outlined);
}

Future<void> saveButtonOnPressed(
    BuildContext context,
    TextEditingController nicknameController,
    String password,
    {VoidCallback? onSaved}
    ) async {
  final DateTime now = DateTime.now();
  final String formattedDateTime =
      '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

  final String nickname = nicknameController.text;
  final String toPass = nickname + formattedDateTime;

  await savePassword(toPass, password);

  proteinBarM(
    context,
    "Password Saved!",
    icon: Icons.check_outlined,
  );

  nicknameController.clear();

  // 🔥 Refresh SaveScreen if provided
  if (onSaved != null) {
    onSaved();
  }
}
