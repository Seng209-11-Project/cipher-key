import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_navigation_bar/app_navigation_bar.dart';
import 'app_theme/app_theme.dart';
import 'app_theme/theme_provider.dart';
import 'generate_screen/pages/password_generator_page.dart';
import 'save_screen/save_screen.dart';
import 'setting_screen/settings_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';

ValueNotifier<int> selectedIndex = ValueNotifier(0);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// ============================================================================
// MyApp with dynamic locale support
// ============================================================================
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  /// Allow SettingsScreen to change the language immediately
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("en");

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // current language
      locale: _locale,
      supportedLocales: L10n.all,

      // localization delegates
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // THEME CONFIG
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeData == AppTheme.light
          ? ThemeMode.light
          : ThemeMode.dark,

      home: const ManagementWidget(),
    );
  }
}

// ============================================================================
// Controls showing the correct screen (Generate / Saved / Settings)
// ============================================================================
class ManagementWidget extends StatelessWidget {
  const ManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const PasswordGeneratorPage(),
      const SaveScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (_, value, __) {
          return IndexedStack(
            index: value,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}
