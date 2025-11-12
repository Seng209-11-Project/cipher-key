import 'package:flutter/material.dart';
import 'package:password_generator/setting_screen/settings_screen.dart';
import 'package:provider/provider.dart';
import 'app_navigation_bar/app_navigation_bar.dart';
import 'app_theme/app_theme.dart';
import 'app_theme/theme_provider.dart';
import 'generate_screen/pages/password_generator_page.dart';
import 'save_screen/save_screen.dart';

ValueNotifier<int> selectedIndex = ValueNotifier(0);

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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeData == AppTheme.light ? ThemeMode.light : ThemeMode.dark,
      home: const ManagementWidget(),
    );
  }
}

class ManagementWidget extends StatelessWidget {
  const ManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const PasswordGeneratorPage(),
      const SaveScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (_, value, context) {
            return IndexedStack(
              index: value,
              children: _pages,
            );
          }
      ),
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}