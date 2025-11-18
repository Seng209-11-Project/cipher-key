import 'dart:math';

final List<String> lowerChars =
List.generate(26, (i) => String.fromCharCode(i + 97));

final List<String> upperChars =
List.generate(26, (i) => String.fromCharCode(i + 65));

final List<String> numberChars =
List.generate(10, (i) => i.toString());

final List<String> symbolChars = [
  '!', '@', '#', r'$', '%', '^', '&', '*', '(', ')',
  '_', '-', '+', '=', '<', '>', '?', '/', '\\'
];

final List<List<String>> charGroups = [
  lowerChars,
  upperChars,
  numberChars,
  symbolChars,
];

String generateRandomPassword(int length) {
  final random = Random();

  String password = '';
  String lastChar = '';
  String secondLastChar = '';

  for (int i = 0; i < length; i++) {
    String newChar;

    do {
      // pick a random character group
      final group = charGroups[random.nextInt(charGroups.length)];

      // pick a random character from that group
      newChar = group[random.nextInt(group.length)];

      bool isTripleSameChar =
          lastChar == newChar && secondLastChar == newChar;

      bool isTripleSameType =
      _isSameType(lastChar, secondLastChar, newChar);

      if (!isTripleSameChar && !isTripleSameType) break;

    } while (true);

    password += newChar;
    secondLastChar = lastChar;
    lastChar = newChar;
  }

  return password;
}

bool _isSameType(String c1, String c2, String c3) {
  if (c1.isEmpty || c2.isEmpty) return false;

  return _getCharType(c1) ==
      _getCharType(c2) &&
      _getCharType(c2) ==
      _getCharType(c3);
}

String _getCharType(String c) {
  if (lowerChars.contains(c)) return 'lower';
  if (upperChars.contains(c)) return 'upper';
  if (numberChars.contains(c)) return 'number';
  return 'symbol';
}