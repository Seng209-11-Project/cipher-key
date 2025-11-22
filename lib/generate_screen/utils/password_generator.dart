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

String generateRandomPassword(
  int length, {
  bool uppercase = true,
  bool lowercase = true,
  bool numbers = true,
  bool symbols = true,
}) {
  final random = Random();

  // Build available character groups based on settings (following the list logic)
  final List<List<String>> availableGroups = [];
  if (lowercase) availableGroups.add(lowerChars);
  if (uppercase) availableGroups.add(upperChars);
  if (numbers) availableGroups.add(numberChars);
  if (symbols) availableGroups.add(symbolChars);

  // Ensure at least one group is available (fallback to lowercase if all disabled)
  if (availableGroups.isEmpty) {
    availableGroups.add(lowerChars);
  }

  String password = '';
  String lastChar = '';
  String secondLastChar = '';

  // If only one group is available, we can't avoid triple same type, so skip that check
  final bool onlyOneGroup = availableGroups.length == 1;

  for (int i = 0; i < length; i++) {
    String newChar;
    int attempts = 0;
    const maxAttempts = 100; // Safety limit to prevent infinite loops

    do {
      // pick a random character group from available groups (list-based selection)
      final group = availableGroups[random.nextInt(availableGroups.length)];

      // pick a random character from that group
      newChar = group[random.nextInt(group.length)];

      bool isTripleSameChar =
          lastChar == newChar && secondLastChar == newChar;

      // Only check for triple same type if we have multiple groups
      bool isTripleSameType = false;
      if (!onlyOneGroup) {
        isTripleSameType = _isSameType(lastChar, secondLastChar, newChar);
      }

      if (!isTripleSameChar && !isTripleSameType) break;

      attempts++;
      // Safety check: if we've tried too many times, just use the character
      if (attempts >= maxAttempts) {
        break;
      }

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