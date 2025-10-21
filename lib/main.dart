import 'package:flutter/material.dart';
import 'package:password_generator/app_navigation_bar/app_navigation_bar.dart';
import 'package:password_generator/app_theme/theme_provider.dart';
import 'package:password_generator/generate_screen/pages/password_generator_page.dart';
import 'package:password_generator/save_screen/save_screen.dart';
import 'package:provider/provider.dart';
import 'app_theme/app_theme.dart';

ValueNotifier<int> selectedIndex = ValueNotifier(0);
bool isDark = false;

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        home: ManagementWidget()
    );
  }
}

class ManagementWidget extends StatelessWidget {
  final List<Widget> _pages = [
    const PasswordGeneratorPage(),
    const SaveScreen(),
    //const SettingsPage(),
  ];

  ManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(valueListenable: selectedIndex, builder: (_,value,context) {
        return IndexedStack(
          index: value,
          children: _pages,
        );
      }),
      bottomNavigationBar: const AppNavigationBar() // your current widget
    );
  }
}