import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true,);

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());



// Legacy functions for backward compatibility
Future<void> savePassword(String passwordName, String password) async {
  await storage.write(key: passwordName, value: password);
}

Future<Map<String, String>> readPasswords() async {
  Map<String, String> allValues = await storage.readAll();
  return allValues;
}

Future<void> deletePassword(String passwordName, String password) async {
  await storage.delete(key: passwordName);
}

// Delete password by ID (new method)
Future<void> deletePasswordById(String passwordId) async {
  await storage.delete(key: passwordId);
}

enum EditType {
  name,
  password
}

// Future<void> editPassword(EditType type,String oldName,{String newName = "",String newPassword = ""}) async{
//   String passwordName = await storage.read(key: oldName);
// }

