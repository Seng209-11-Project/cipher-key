import 'package:flutter/material.dart';
import 'sort_button/sort_button.dart';
import 'password_card/password_card.dart';
import 'save_read_function.dart';
import 'password_card/add_password_util.dart';
import '../l10n/app_localizations.dart';
import '../main.dart' show passwordRefreshNotifier;

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  Map<String, String> savedPasswords = {};
  String _currentSortOption = 'Latest';

  void refreshPasswords() {
    _loadPasswords();
  }

  @override
  void initState() {
    super.initState();
    _loadPasswords();
    // Listen for password refresh notifications
    passwordRefreshNotifier.addListener(_onPasswordRefresh);
  }

  void _onPasswordRefresh() {
    _loadPasswords();
  }

  @override
  void dispose() {
    passwordRefreshNotifier.removeListener(_onPasswordRefresh);
    super.dispose();
  }

  Future<void> _loadPasswords() async {
    final passwords = await readPasswords();
    if (mounted) {
      setState(() {
        savedPasswords = passwords;
      });
    }
  }

  void _onSortChanged(String newValue) {
    setState(() {
      _currentSortOption = newValue;
    });
  }

  void _onFavoriteChanged(String passwordId, bool isFavorite) {
    setState(() {
      String? currentValue = savedPasswords[passwordId];
      if (currentValue != null) {
        String cleanPassword = currentValue.startsWith("⭐") ? currentValue.substring(1) : currentValue;
        savedPasswords[passwordId] = isFavorite ? "⭐$cleanPassword" : cleanPassword;
      }
    });
  }

  void _onNicknameChanged(String oldPasswordId, String newPasswordId) {
    setState(() {
      String? currentValue = savedPasswords[oldPasswordId];
      if (currentValue != null) {
        // Move the password to the new key immediately
        savedPasswords[newPasswordId] = currentValue;
        savedPasswords.remove(oldPasswordId);
      }
    });
    
    // Reload passwords to ensure consistency (in case key format differs slightly)
    _loadPasswords();
  }

  List<MapEntry<String, String>> _getSortedEntries() {
    List<MapEntry<String, String>> entries = savedPasswords.entries.toList();

    int parseDateSafe(String key) {
      final RegExp datePattern =
      RegExp(r"(\d{1,2})\/(\d{1,2})\/(\d{4})(?:\s+(\d{1,2}):(\d{2})(?::(\d{2}))?)?");
      final match = datePattern.firstMatch(key);
      if (match == null) return 0;

      final day = int.tryParse(match.group(1) ?? '') ?? 1;
      final month = int.tryParse(match.group(2) ?? '') ?? 1;
      final year = int.tryParse(match.group(3) ?? '') ?? 1970;
      final hour = int.tryParse(match.group(4) ?? '0') ?? 0;
      final minute = int.tryParse(match.group(5) ?? '0') ?? 0;
      final second = int.tryParse(match.group(6) ?? '0') ?? 0;

      return DateTime(year, month, day, hour, minute, second).millisecondsSinceEpoch;
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

    // For Favorites, show ONLY favorites sorted by date (latest first)
    if (_currentSortOption == 'Favorites') {
      List<MapEntry<String, String>> favs =
      entries.where((e) => e.value.startsWith('⭐')).toList();
      favs.sort((a, b) => parseDateSafe(b.key).compareTo(parseDateSafe(a.key)));
      return favs;
    }

    // For By Password and By Nickname, sort ALL together without separating favorites
    if (_currentSortOption == 'By Password') {
      entries.sort((a, b) => cleanValue(a.value).toLowerCase().compareTo(cleanValue(b.value).toLowerCase()));
      return entries;
    }

    if (_currentSortOption == 'By Nickname') {
      entries.sort((a, b) =>
          extractNickname(a.key).toLowerCase().compareTo(extractNickname(b.key).toLowerCase()));
      return entries;
    }

    // For date-based sorts, keep favorites separated and on top
    List<MapEntry<String, String>> favs =
    entries.where((e) => e.value.startsWith('⭐')).toList();
    List<MapEntry<String, String>> nonFavs =
    entries.where((e) => !e.value.startsWith('⭐')).toList();

    void sortGroup(List<MapEntry<String, String>> list) {
      switch (_currentSortOption) {
        case 'Oldest':
          list.sort((a, b) => parseDateSafe(a.key).compareTo(parseDateSafe(b.key)));
          break;
        case 'Latest':
        default:
          list.sort((a, b) => parseDateSafe(b.key).compareTo(parseDateSafe(a.key)));
          break;
      }
    }

    sortGroup(favs);
    sortGroup(nonFavs);

    return [...favs, ...nonFavs];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPasswordDialog(context, onSaved: _loadPasswords);
        },
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
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
                    // ------------------ HEADER ------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.savedPasswordsTitle,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: cs.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t.savedPasswordsSubtitle,
                            style: TextStyle(
                              fontSize: 16,
                              color: cs.secondary,
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
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          color: cs.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: cs.secondary.withOpacity(0.3)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t.noSavedPasswords,
                              style: TextStyle(
                                fontSize: 16,
                                color: cs.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              t.generateOrAddPasswords,
                              style: TextStyle(
                                fontSize: 14,
                                color: cs.secondary,
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

                          RegExp datePattern = RegExp(r'\d{1,2}/\d{1,2}/\d{4}');
                          Match? dateMatch = datePattern.firstMatch(fullKey);

                          if (dateMatch != null) {
                            int dateStartIndex = dateMatch.start;
                            passwordName = fullKey.substring(0, dateStartIndex).trim();
                            passwordDateTime = fullKey.substring(dateStartIndex).trim();
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
                            onFavoriteChanged: (isFavorite) => _onFavoriteChanged(entry.key, isFavorite),
                            onNicknameChanged: (newKey) => _onNicknameChanged(entry.key, newKey),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ------------------ SORT BUTTON ------------------
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 8.0),
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