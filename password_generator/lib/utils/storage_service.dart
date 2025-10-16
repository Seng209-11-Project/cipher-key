import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _nicknameKey = 'saved_nickname';
  static const String _datetimeKey = 'saved_datetime';

  static Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nicknameKey, nickname);
  }

  static Future<void> saveDateTime(String datetime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_datetimeKey, datetime);
  }

  static Future<String?> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nicknameKey);
  }

  static Future<String?> getDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_datetimeKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nicknameKey);
    await prefs.remove(_datetimeKey);
  }
}
