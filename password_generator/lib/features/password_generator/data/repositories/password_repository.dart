import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/password_model.dart';

class PasswordRepository {
  static const String _passwordsKey = 'saved_passwords';

  Future<List<PasswordModel>> getSavedPasswords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? passwordsJson = prefs.getString(_passwordsKey);

    if (passwordsJson == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(passwordsJson);
      return jsonList.map((json) => PasswordModel.fromMap(json)).toList();
    } catch (e) {
      print('Error loading passwords: $e');
      return [];
    }
  }

  Future<void> savePassword(PasswordModel password) async {
    final List<PasswordModel> existingPasswords = await getSavedPasswords();

    // Aynı ID'ye sahip password varsa güncelle, yoksa yeni ekle
    final int existingIndex = existingPasswords.indexWhere((p) => p.id == password.id);

    if (existingIndex != -1) {
      existingPasswords[existingIndex] = password;
    } else {
      existingPasswords.add(password);
    }

    await _savePasswordsList(existingPasswords);
  }

  Future<void> saveNewPassword({
    required String password,
    required String? nickname,
  }) async {
    final PasswordModel newPassword = PasswordModel(
      password: password,
      nickname: nickname?.isEmpty == true ? null : nickname,
    );

    await savePassword(newPassword);
  }

  Future<void> deletePassword(String id) async {
    final List<PasswordModel> existingPasswords = await getSavedPasswords();
    existingPasswords.removeWhere((p) => p.id == id);
    await _savePasswordsList(existingPasswords);
  }

  Future<void> _savePasswordsList(List<PasswordModel> passwords) async {
    final prefs = await SharedPreferences.getInstance();
    final String passwordsJson = json.encode(
      passwords.map((p) => p.toMap()).toList(),
    );
    await prefs.setString(_passwordsKey, passwordsJson);
  }
}