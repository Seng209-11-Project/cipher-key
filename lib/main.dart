import 'package:flutter/material.dart';
import 'package:password_generator/generate_screen/pages/password_generator_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: PasswordGeneratorPage()
    );
  }
}