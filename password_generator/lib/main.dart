import 'package:flutter/material.dart';
import 'package:password_generator/pages/password_generator_page.dart';

void main() {
  runApp(const PasswordGeneratorApp());
}

class PasswordGeneratorApp extends StatelessWidget {
  const PasswordGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PasswordGeneratorPage(),
    );
  }
}

// (Başka dosyada verilerin kullanımı
//import '../utils/storage_service.dart';
//
// // Nickname okuma
// String? savedNickname = await StorageService.getNickname();
//
// // Datetime okuma
// String? savedDateTime = await StorageService.getDateTime();
//
// // Veya GeneratedSectionActions ile:
// Map<String, String?> savedData = await GeneratedSectionActions.getSavedData();
// String? nickname = savedData['nickname'];
// String? datetime = savedData['datetime'];
