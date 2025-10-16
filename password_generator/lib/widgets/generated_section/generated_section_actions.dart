import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_data.dart'; // ✅ YENİ IMPORT
import '../../widgets/protein_bar.dart';

// ✅ ACTION FONKSİYONLARI
class GeneratedSectionActions {
  static void copyPassword(BuildContext context, String password) {
    Clipboard.setData(ClipboardData(text: password));
    proteinBarM(context, "Copied Password", icon: Icons.check_outlined);
  }

  static void savePassword(BuildContext context, TextEditingController nicknameController) {
    try {
      // ✅ NICKNAME ve DATETIME'ı GLOBAL VARIABLE'A KAYDET
      final String nickname = nicknameController.text;
      final DateTime now = DateTime.now();
      final String formattedDateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

      AppData.saveData(nickname, formattedDateTime);

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

  // ✅ SAKLANAN VERİLERİ OKU (Başka yerden kullanmak için)
  static Map<String, String?> getSavedData() {
    return AppData.getSavedData();
  }
}