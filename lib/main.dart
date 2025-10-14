import 'package:flutter/material.dart';
import 'package:test_group_project/save_screen/save_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const SaveScreen()
    );
  }
}
