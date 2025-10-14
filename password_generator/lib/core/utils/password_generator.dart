import 'dart:math';
import '../constants/app_constants.dart';

class PasswordGenerator {
  static final Random _random = Random();

  static String generateRandomPassword(int length) {
    final List<String> allCharacters = [
      ...AppConstants.lowercaseChars.split(''),
      ...AppConstants.uppercaseChars.split(''),
      ...AppConstants.numberChars.split(''),
      ...AppConstants.symbolChars.split('')
    ];

    String password = '';
    List<String> lastTwoChars = ['', ''];

    for (int i = 0; i < length; i++) {
      String newChar;
      bool isValid = false;
      int attempts = 0;

      while (!isValid && attempts < 100) {
        newChar = allCharacters[_random.nextInt(allCharacters.length)];

        // Rule 1: No 3 same characters in a row
        if (lastTwoChars[0] == newChar && lastTwoChars[1] == newChar) {
          attempts++;
          continue;
        }

        // Rule 2: No 3 same character types in a row
        if (lastTwoChars[0].isNotEmpty && lastTwoChars[1].isNotEmpty) {
          String charType1 = _getCharType(lastTwoChars[0]);
          String charType2 = _getCharType(lastTwoChars[1]);
          String newCharType = _getCharType(newChar);

          if (charType1 == charType2 && charType2 == newCharType) {
            attempts++;
            continue;
          }
        }

        isValid = true;
        password += newChar;

        // Update last two characters
        if (lastTwoChars[0].isEmpty) {
          lastTwoChars[0] = newChar;
        } else if (lastTwoChars[1].isEmpty) {
          lastTwoChars[1] = newChar;
        } else {
          lastTwoChars[0] = lastTwoChars[1];
          lastTwoChars[1] = newChar;
        }
      }

      if (!isValid) {
        newChar = _getFallbackChar(password);
        password += newChar;

        if (lastTwoChars[0].isEmpty) {
          lastTwoChars[0] = newChar;
        } else if (lastTwoChars[1].isEmpty) {
          lastTwoChars[1] = newChar;
        } else {
          lastTwoChars[0] = lastTwoChars[1];
          lastTwoChars[1] = newChar;
        }
      }
    }

    return password;
  }

  static String _getCharType(String char) {
    if (AppConstants.lowercaseChars.contains(char)) return 'lowercase';
    if (AppConstants.uppercaseChars.contains(char)) return 'uppercase';
    if (AppConstants.numberChars.contains(char)) return 'number';
    return 'symbol';
  }

  static String _getFallbackChar(String currentPassword) {
    int lowerCount = 0, upperCount = 0, numberCount = 0, symbolCount = 0;

    for (int i = 0; i < currentPassword.length; i++) {
      String char = currentPassword[i];
      String type = _getCharType(char);

      switch (type) {
        case 'lowercase': lowerCount++; break;
        case 'uppercase': upperCount++; break;
        case 'number': numberCount++; break;
        case 'symbol': symbolCount++; break;
      }
    }

    List<Map<String, dynamic>> counts = [
      {'type': 'lowercase', 'count': lowerCount, 'chars': AppConstants.lowercaseChars},
      {'type': 'uppercase', 'count': upperCount, 'chars': AppConstants.uppercaseChars},
      {'type': 'number', 'count': numberCount, 'chars': AppConstants.numberChars},
      {'type': 'symbol', 'count': symbolCount, 'chars': AppConstants.symbolChars},
    ];

    counts.sort((a, b) => a['count'].compareTo(b['count']));
    return counts[0]['chars'][_random.nextInt(counts[0]['chars'].length)];
  }
}