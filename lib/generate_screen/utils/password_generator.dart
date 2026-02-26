import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

final meaningMap = ValueNotifier<Map<String, dynamic>>({});

const List<String> lowerChars = [
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
  'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
];

const List<String> upperChars = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

const List<String> numberChars = [
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
];

const List<String> symbolChars = [
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
  bool isMemory = false,
})
{
  final random = Random.secure();

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

Future<String> generateMemorable(int length) async {
  final Queue<int> numberQueue = Queue<int>();
  final Random random = Random.secure();
  String password = "";

  // 1. Generate the Queue (Same logic as before)
  for (int i = 0; i < length; i++) {
    if (i % 2 == 0) {
      numberQueue.add(random.nextInt(3)); // 0, 1, or 2
    } else {
      numberQueue.add(random.nextInt(5) + 3); // 3, 4, 5, 6, or 7
    }
  }

  // 2. Process the Queue
  int currentIndex = 0;
  final specialChars = ['!', '@', '#', '\$', '%', '&', '*', '?', '+', '='];

  while (numberQueue.isNotEmpty) {
    int val = numberQueue.removeFirst();

    if (currentIndex % 2 == 0) {
      // EVEN INDEX LOGIC
      if (val == 0) {
        // Special character
        password += specialChars[random.nextInt(specialChars.length)];
      } else if (val == 1) {
        // Single digit (0-9)
        password += random.nextInt(10).toString();
      } else if (val == 2) {
        // Two digits (10-99)
        password += (random.nextInt(90) + 10).toString();
      }
    } else {
      // ODD INDEX LOGIC: val is the word length (3-7)
      String? word = await _getWordFromJson(val);
      password += word!;
    }

    currentIndex++;
  }

  return password;
}

Future<String?> _getWordFromJson(int length) async {
  try {
    // 1. Load the string
    final String response = await rootBundle.loadString('assets/words/${length}l.json');

    // 2. Decode and Cast (Crucial for Map methods)
    final Map<String, dynamic> decodedData = json.decode(response);

    if (decodedData.isEmpty) return "WORD_MISSING";

    // 3. Select Random Key
    final keys = decodedData.keys.toList();
    final random = Random.secure();
    final String randomKey = keys[random.nextInt(keys.length)];
    final String? randomWord = decodedData[randomKey] as String?;

    // 4. Update state by passing to a NEW map (Triggers UI)
    meaningMap.value = {
      ...meaningMap.value,
      randomKey: randomWord ?? "No definition found",
    };

    return randomKey; // Or randomWord, depending on your UI needs

  } catch (e) {
    debugPrint('FAILED TO LOAD WORD: length $length. Error: $e');
    return "ERROR";
  }
}