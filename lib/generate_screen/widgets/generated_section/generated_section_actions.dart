import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../../save_screen/save_read_function.dart';
import '../../../app_navigation_bar/protein_bar.dart';
import '../../../main.dart' show passwordRefreshNotifier;

void copyButtonOnPressed(BuildContext context, String password) {
  Clipboard.setData(ClipboardData(text: password));
  proteinBarM(context, AppLocalizations.of(context)!.passwordCopied, icon: Icons.check_outlined);
}

Future<void> saveButtonOnPressed(
    BuildContext context,
    TextEditingController nicknameController,
    String password,
    {VoidCallback? onSaved}
    ) async {
  final DateTime now = DateTime.now();
  // Include seconds to ensure each save is unique, allowing multiple saves
  final String formattedDateTime =
      '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  final String nickname = nicknameController.text;
  final String toPass = nickname + formattedDateTime;

  await savePassword(toPass, password);

  proteinBarM(
    context,
    AppLocalizations.of(context)!.passwordSaved,
    icon: Icons.check_outlined,
  );

  // Don't clear nickname - allow user to save multiple times with same nickname
  // nicknameController.clear();

  // Trigger SaveScreen refresh
  passwordRefreshNotifier.value = passwordRefreshNotifier.value + 1;
  
  // Call custom callback if provided
  if (onSaved != null) {
    onSaved();
  }
}
