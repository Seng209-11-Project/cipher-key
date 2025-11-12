import 'package:flutter/material.dart';
import 'package:password_generator/app_navigation_bar/app_navigation_bar.dart';
import 'sort_button/sort_button.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // ✅ SAVED INDEX
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