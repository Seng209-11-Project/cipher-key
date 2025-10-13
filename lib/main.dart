import 'package:flutter/material.dart';
import 'package:test_group_project/components/app_navigation_bar/app_navigation_bar.dart';
import 'package:test_group_project/protein_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: AppNavigationBar(),
        body: Center(
          child: GestureDetector(
            onTap: () {
              proteinBarM(context, "Copied Password",icon: Icons.check_outlined);
            },
          ),
        ),
      )
    );
  }
}
