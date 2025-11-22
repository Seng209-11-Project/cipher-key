import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true,);

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

Future<void> savePassword(String passwordName, String password) async {
  await storage.write(key: passwordName, value: password);
}

Future<Map<String, String>> readPasswords() async {
  return Map<String, String>.from(await storage.readAll());
}


Future<void> deletePassword(String passwordName) async {
  await storage.delete(key: passwordName);
}

Future<void> deleteAllPasswords() async {
  await storage.deleteAll();
}

enum EditType {
  name,
  password,
  favorite
}

Future<void> editPassword(EditType type, String oldName, {String newName = "", String newPassword = "", bool? isFavorite}) async {
  String? passwordValue = await storage.read(key: oldName);
  if (passwordValue != null) {
    switch (type) {
      case EditType.name:
        // Extract the original datetime from the old key
        final RegExp datePattern = RegExp(r'(\d{1,2}/\d{1,2}/\d{4}(?:\s+\d{1,2}:\d{2})?)');
        final Match? dateMatch = datePattern.firstMatch(oldName);
        
        String formattedDateTime;
        if (dateMatch != null) {
          // Preserve the original datetime
          formattedDateTime = dateMatch.group(1)!;
        } else {
          // Fallback to current time if no date found
          final DateTime now = DateTime.now();
          formattedDateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
        }
        
        String newKey = newName.isEmpty ? formattedDateTime : '$newName$formattedDateTime';
        await storage.write(key: newKey, value: passwordValue);
        await storage.delete(key: oldName);
        break;
      case EditType.password:
        await storage.write(key: oldName, value: newPassword);
        break;
      case EditType.favorite:

        String cleanPassword = passwordValue.startsWith("⭐") ? passwordValue.substring(1) : passwordValue;
        String updatedValue = isFavorite == true ? "⭐$cleanPassword" : cleanPassword;
        await storage.write(key: oldName, value: updatedValue);
        break;
    }
  }
}