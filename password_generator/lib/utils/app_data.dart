class AppData {
  static String? lastSavedNickname;
  static String? lastSavedDateTime;

  static void saveData(String nickname, String datetime) {
    lastSavedNickname = nickname;
    lastSavedDateTime = datetime;
  }

  static Map<String, String?> getSavedData() {
    return {
      'nickname': lastSavedNickname,
      'datetime': lastSavedDateTime,
    };
  }

  static void clearData() {
    lastSavedNickname = null;
    lastSavedDateTime = null;
  }
}

