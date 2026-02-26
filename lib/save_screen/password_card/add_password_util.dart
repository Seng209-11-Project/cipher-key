import 'package:flutter/material.dart';
import '../save_read_function.dart';
import '../../app_navigation_bar/protein_bar.dart';
import '../../l10n/app_localizations.dart';

void showAddPasswordDialog(BuildContext context, {VoidCallback? onSaved}) {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final cs = Theme.of(context).colorScheme;
  final t = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: cs.surface, // THEMED
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          t.addNewPassword,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nicknameController,
              style: TextStyle(color: cs.primary),
              decoration: InputDecoration(
                labelText: t.nickname,
                labelStyle: TextStyle(color: cs.secondary),
                hintText: t.enterNickname,
                hintStyle: TextStyle(color: cs.secondary.withOpacity(0.7)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  BorderSide(color: cs.secondary.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: cs.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              style: TextStyle(color: cs.primary),
              decoration: InputDecoration(
                labelText: t.password,
                labelStyle: TextStyle(color: cs.secondary),
                hintText: t.enterPassword,
                hintStyle: TextStyle(color: cs.secondary.withOpacity(0.7)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                  BorderSide(color: cs.secondary.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: cs.primary, width: 2),
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
            child: Text(
              t.cancel,
              style: TextStyle(color: cs.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final nickname = nicknameController.text;
              final password = passwordController.text;

              if (password.isEmpty) {
                proteinBarM(
                  context,
                  t.pleaseEnterPassword,
                  icon: Icons.warning_amber_rounded,
                );
                return;
              }

              try {
                final DateTime now = DateTime.now();
                final String formattedDateTime =
                    '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

                final String passwordKey = '$nickname$formattedDateTime';

                await savePassword(passwordKey, password);

                if (onSaved != null) onSaved();
                Navigator.of(context).pop();

                proteinBarM(
                  context,
                  t.passwordSaved,
                  icon: Icons.check_outlined,
                );
              } catch (e) {
                proteinBarM(
                  context,
                  t.passwordSaveFailed,
                  icon: Icons.error_outline,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(t.save),
          ),
        ],
      );
    },
  );
}
