class SearchUtils {
  static Map<String, String> searchPasswords({
    required Map<String, String> allPasswords,
    required String userSearchText,
  }) {
    if (userSearchText.isEmpty) {
      return allPasswords;
    }

    final searchText = userSearchText.toLowerCase().trim();
    final filteredPasswords = <String, String>{};

    allPasswords.forEach((nicknameWithDate, password) {
      final containsSearch = _containsSearchText(
        nicknameWithDate: nicknameWithDate,
        password: password,
        searchText: searchText,
      );

      if (containsSearch) {
        filteredPasswords[nicknameWithDate] = password;
      }
    });

    return filteredPasswords;
  }

  static bool _containsSearchText({
    required String nicknameWithDate,
    required String password,
    required String searchText,
  }) {
    final nickname = _getNicknamePart(nicknameWithDate);
    if (nickname.toLowerCase().contains(searchText)) {
      return true;
    }

    if (password.toLowerCase().contains(searchText)) {
      return true;
    }

    final dateTime = _getDateTimePart(nicknameWithDate);
    if (dateTime.toLowerCase().contains(searchText)) {
      return true;
    }

    if (nicknameWithDate.toLowerCase().contains(searchText)) {
      return true;
    }

    return false;
  }

  static String _getNicknamePart(String nicknameWithDate) {
    final dateTimeRegex = RegExp(r'\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}');
    final match = dateTimeRegex.firstMatch(nicknameWithDate);

    if (match != null) {
      return nicknameWithDate.substring(0, match.start).trim();
    }

    return nicknameWithDate;
  }

  static String _getDateTimePart(String nicknameWithDate) {
    final dateTimeRegex = RegExp(r'\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}');
    final match = dateTimeRegex.firstMatch(nicknameWithDate);

    if (match != null) {
      return match.group(0)!;
    }

    return '';
  }

  static List<MapEntry<String, String>> sortPasswordsForUser({
    required Map<String, String> passwords,
    required String sortType,
  }) {
    final entries = passwords.entries.toList();

    switch (sortType) {
      case 'Latest':
        entries.sort((a, b) => b.key.compareTo(a.key));
        break;
      case 'Oldest':
        entries.sort((a, b) => a.key.compareTo(b.key));
        break;
      case 'By Password':
        entries.sort((a, b) => a.value.compareTo(b.value));
        break;
      case 'By Nickname':
        entries.sort((a, b) {
          final nicknameA = _getNicknamePart(a.key).toLowerCase();
          final nicknameB = _getNicknamePart(b.key).toLowerCase();
          return nicknameA.compareTo(nicknameB);
        });
        break;
    }

    return entries;
  }
}
