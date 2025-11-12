import 'package:flutter/material.dart';
import 'package:password_generator/save_screen/sort_button/sort_button.dart';
import 'package:password_generator/save_screen/password_card/password_card.dart';
import 'package:password_generator/save_screen/save_read_function.dart';
import 'package:password_generator/save_screen/password_card/add_password_util.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  Map<String, String> savedPasswords = {};
  String _currentSortOption = 'Latest';

  @override
  void initState() {
    super.initState();
    _loadPasswords();
  }

  Future<void> _loadPasswords() async {
    final passwords = await readPasswords();
    setState(() {
      savedPasswords = passwords;
    });
  }

  void _onSortChanged(String newValue) {
    setState(() {
      _currentSortOption = newValue;
    });
  }

  List<MapEntry<String, String>> _getSortedEntries() {
    List<MapEntry<String, String>> entries = savedPasswords.entries.toList();

    int parseDateSafe(String key) {
      // Extract date-time substring like 'd/m/yyyy hh:mm'
      final RegExp datePattern = RegExp(r"(\d{1,2})\/(\d{1,2})\/(\d{4})(?:\s+(\d{1,2}):(\d{2}))?");
      final match = datePattern.firstMatch(key);
      if (match == null) return 0;
      final day = int.tryParse(match.group(1) ?? '') ?? 1;
      final month = int.tryParse(match.group(2) ?? '') ?? 1;
      final year = int.tryParse(match.group(3) ?? '') ?? 1970;
      final hour = int.tryParse(match.group(4) ?? '0') ?? 0;
      final minute = int.tryParse(match.group(5) ?? '0') ?? 0;
      return DateTime(year, month, day, hour, minute).millisecondsSinceEpoch;
    }

    String extractNickname(String key) {
      final RegExp datePattern = RegExp(r'\d{1,2}\/\d{1,2}\/\d{4}');
      final Match? dateMatch = datePattern.firstMatch(key);
      if (dateMatch != null) {
        return key.substring(0, dateMatch.start).trim();
      }
      return key;
    }

    String cleanValue(String value) {
      return value.startsWith('⭐') ? value.substring(1) : value;
    }

    switch (_currentSortOption) {
      case 'Oldest':
        entries.sort((a, b) => parseDateSafe(a.key).compareTo(parseDateSafe(b.key)));
        break;
      case 'Favorites':
        entries.sort((a, b) {
          final aFav = a.value.startsWith('⭐');
          final bFav = b.value.startsWith('⭐');
          if (aFav == bFav) {
            // If both same fav status, sort by Latest within group
            return parseDateSafe(b.key).compareTo(parseDateSafe(a.key));
          }
          return aFav ? -1 : 1; // favorite first
        });
        break;
      case 'By Password':
        entries.sort((a, b) => cleanValue(a.value).toLowerCase().compareTo(cleanValue(b.value).toLowerCase()));
        break;
      case 'By Nickname':
        entries.sort((a, b) => extractNickname(a.key).toLowerCase().compareTo(extractNickname(b.key).toLowerCase()));
        break;
      case 'Latest':
      default:
        entries.sort((a, b) => parseDateSafe(b.key).compareTo(parseDateSafe(a.key)));
        break;
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPasswordDialog(context, onSaved: _loadPasswords);
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: SizedBox(
                width: 672,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saved Passwords',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'View and manage your saved passwords',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Display the saved passwords (sorted)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: _getSortedEntries().map((entry) {
                          // Split the key to separate name and datetime
                          String fullKey = entry.key;
                          String passwordName = "";
                          String passwordDateTime = "";

                          // Find where the datetime starts (look for pattern like "12/25/2024")
                          RegExp datePattern = RegExp(r'\d{1,2}/\d{1,2}/\d{4}');
                          Match? dateMatch = datePattern.firstMatch(fullKey);

                          if (dateMatch != null) {
                            int dateStartIndex = dateMatch.start;
                            passwordName = fullKey.substring(0, dateStartIndex);
                            passwordDateTime = fullKey.substring(dateStartIndex);
                          } else {
                            // Fallback if no date pattern found
                            passwordName = fullKey;
                            passwordDateTime = "";
                          }

                          return PasswordCard(
                            key: ValueKey(entry.key),
                            password: entry.value,
                            passwordName: passwordName,
                            passwordDateTime: passwordDateTime,
                            passwordId: entry.key,
                            onDeleted: _loadPasswords,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 40.0),
                child: SortButton(
                  currentSortOption: _currentSortOption,
                  onSortChanged: _onSortChanged,
                )
            ),
          ),
        ],
      ),
    );
  }
}