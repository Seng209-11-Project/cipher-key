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

  /// 🔥 Add this method so other screens can refresh SaveScreen
  void refreshPasswords() {
    _loadPasswords();
  }

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
      final RegExp datePattern =
      RegExp(r"(\d{1,2})\/(\d{1,2})\/(\d{4})(?:\s+(\d{1,2}):(\d{2}))?");
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

    List<MapEntry<String, String>> favs =
    entries.where((e) => e.value.startsWith('⭐')).toList();
    List<MapEntry<String, String>> nonFavs =
    entries.where((e) => !e.value.startsWith('⭐')).toList();

    void sortGroup(List<MapEntry<String, String>> list) {
      switch (_currentSortOption) {
        case 'Oldest':
          list.sort(
                  (a, b) => parseDateSafe(a.key).compareTo(parseDateSafe(b.key)));
          break;
        case 'Favorites':
          list.sort(
                  (a, b) => parseDateSafe(b.key).compareTo(parseDateSafe(a.key)));
          break;
        case 'By Password':
          list.sort((a, b) => cleanValue(a.value)
              .toLowerCase()
              .compareTo(cleanValue(b.value).toLowerCase()));
          break;
        case 'By Nickname':
          list.sort((a, b) => extractNickname(a.key)
              .toLowerCase()
              .compareTo(extractNickname(b.key).toLowerCase()));
          break;
        case 'Latest':
        default:
          list.sort(
                  (a, b) => parseDateSafe(b.key).compareTo(parseDateSafe(a.key)));
          break;
      }
    }

    sortGroup(favs);
    sortGroup(nonFavs);

    return [...favs, ...nonFavs];
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: savedPasswords.isEmpty
                          ? Container(
                        width: double.infinity,
                        padding:
                        const EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border:
                          Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No saved passwords yet",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Generate or add passwords to see them here",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                          : Column(
                        children: _getSortedEntries().map((entry) {
                          String fullKey = entry.key;
                          String passwordName = "";
                          String passwordDateTime = "";

                          RegExp datePattern =
                          RegExp(r'\d{1,2}/\d{1,2}/\d{4}');
                          Match? dateMatch =
                          datePattern.firstMatch(fullKey);

                          if (dateMatch != null) {
                            int dateStartIndex = dateMatch.start;
                            passwordName = fullKey
                                .substring(0, dateStartIndex)
                                .trim();
                            passwordDateTime = fullKey
                                .substring(dateStartIndex)
                                .trim();
                          } else {
                            passwordName = fullKey.trim();
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
