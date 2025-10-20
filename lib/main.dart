import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'home_page/home_page.dart';
=======
import 'package:test_group_project/save_screen/save_screen.dart';
>>>>>>> feature/save_screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

<<<<<<< HEAD
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage()
=======
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const SaveScreen()
>>>>>>> feature/save_screen
    );
  }
}
