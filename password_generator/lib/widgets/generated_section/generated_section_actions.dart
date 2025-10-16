import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/storage_service.dart';
import '../../widgets/protein_bar.dart';

class GeneratedSectionActions {
  static void copyPassword(BuildContext context, String password) {
    Clipboard.setData(ClipboardData(text: password));
    proteinBarM(context, "Copied Password", icon: Icons.check_outlined);
  }

  static void savePassword(
      BuildContext context, TextEditingController nicknameController) async {
    try {
      final String nickname = nicknameController.text;
      if (nickname.isNotEmpty) {
        await StorageService.saveNickname(nickname);
      }

      final DateTime now = DateTime.now();
      final String formattedDateTime =
          '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
      await StorageService.saveDateTime(formattedDateTime);

      proteinBarM(
        context,
        nickname.isEmpty ? "Password Saved!" : "Password '$nickname' Saved!",
        icon: Icons.check_outlined,
      );

      nicknameController.clear();
    } catch (e) {
      proteinBarM(context, "Save Failed!", icon: Icons.error_outline);
    }
  }

  //get variables with this
  static Future<Map<String, String?>> getSavedData() async {
    final String? nickname = await StorageService.getNickname();
    final String? datetime = await StorageService.getDateTime();

    return {
      'nickname': nickname,
      'datetime': datetime,
    };
  }
}
