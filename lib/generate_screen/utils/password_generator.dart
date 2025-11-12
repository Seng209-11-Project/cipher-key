import 'dart:math';

String generateRandomPassword(int length) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_-+=<>?/';

  String password = '';
  String lastChar = '';
  String secondLastChar = '';

  for (int i = 0; i < length; i++) {
    String newChar;

    do {
      newChar = chars[random.nextInt(chars.length)];

      bool isTripleSameChar = lastChar == newChar && secondLastChar == newChar;

      bool isTripleSameType = _isSameType(lastChar, secondLastChar, newChar);

      if (!isTripleSameChar && !isTripleSameType) break;

    } while (true);

    password += newChar;
    secondLastChar = lastChar;
    lastChar = newChar;
  }

  return password;
}

bool _isSameType(String char1, String char2, String char3) {
  if (char1.isEmpty || char2.isEmpty) return false;

  final type1 = _getCharType(char1);
  final type2 = _getCharType(char2);
  final type3 = _getCharType(char3);

  return type1 == type2 && type2 == type3;
}

String _getCharType(String char) {
  if (char.contains(RegExp(r'[a-z]'))) return 'lower';
  if (char.contains(RegExp(r'[A-Z]'))) return 'upper';
  if (char.contains(RegExp(r'[0-9]'))) return 'number';
  return 'symbol';
}