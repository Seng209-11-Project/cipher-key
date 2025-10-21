import 'package:flutter/material.dart';
import 'package:password_generator/save_screen/sort_button/sort_button.dart';
import 'package:password_generator/save_screen/password_card/password_card.dart';
import 'package:password_generator/save_screen/save_read_function.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  Map<String, String> savedPasswords = {};

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: SizedBox(
                width: 672,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
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
                    SizedBox(height: 20),
                    // ADD THIS PART - Display the saved passwords
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: savedPasswords.entries.map((entry) {
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
                            passwordId: entry.key, // <-- Add this line
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
                padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 40.0),
                child: SortButton()
            ),
          ),
        ],
      ),
    );
  }
}