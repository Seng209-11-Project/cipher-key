import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
ValueNotifier<int> passwordRefreshNotifier = ValueNotifier<int>(0);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(key: MyApp.appStateKey),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<_MyAppState> appStateKey = GlobalKey<_MyAppState>();

  static void setLocale(BuildContext context, Locale newLocale) {
    // Try to find state from context first
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    // If not found, use the global key
    state ??= appStateKey.currentState;
    if (state != null) {
      state.setLocale(newLocale);
    } else {
      debugPrint('ERROR: Could not find MyApp state to set locale!');
    }
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Start with default to show app immediately

  @override
  void initState() {
    super.initState();
    _loadLocale(); // Load in background, don't block
  }

  Future<void> _loadLocale() async {
    // Load asynchronously but don't block
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLang = prefs.getString("lang");

      // Check if user has explicitly set a language preference
      // We use a flag to distinguish between "never set" and "explicitly set"
      final hasExplicitLanguage = prefs.getBool("lang_explicitly_set") ?? false;

      if (savedLang != null && savedLang.isNotEmpty && mounted) {
        // Use saved preference - user has set a language
        setState(() {
          _locale = Locale(savedLang);
        });
        return;
      }
      
      // Only detect OS language on TRUE first launch (when user hasn't explicitly set a language)
      if (!hasExplicitLanguage && mounted) {
        final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
        final deviceLocale = platformDispatcher.locale;
        final language = deviceLocale.languageCode;

        String langToUse;
        if (L10n.all.any((loc) => loc.languageCode == language)) {
          langToUse = language;
        } else {
          langToUse = 'en'; // fallback
        }

        // Save the detected language for future launches (don't await)
        prefs.setString("lang", langToUse).catchError((e) {
          debugPrint('Failed to save initial locale: $e');
        });

        if (mounted) {
          setState(() {
            _locale = Locale(langToUse);
          });
        }
      } else if (mounted) {
        // User has explicitly set a language before, but it's missing - keep default English
        setState(() {
          _locale = const Locale('en');
        });
      }
    } catch (e) {
      debugPrint('Failed to load saved locale: $e');
      // Keep default English if everything fails
    }
  }

  void setLocale(Locale locale) {
    if (!mounted) return;
    
    // Validate that the locale is supported
    if (!L10n.all.any((loc) => loc.languageCode == locale.languageCode)) {
      debugPrint('WARNING: Locale ${locale.languageCode} is not supported, falling back to English');
      locale = const Locale('en');
    }
    
    // Always update if language code is different - update IMMEDIATELY
    if (_locale.languageCode != locale.languageCode) {
      debugPrint('Setting locale to: ${locale.languageCode}');
      setState(() {
        _locale = locale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      key: ValueKey(_locale.languageCode), // Force rebuild when locale changes
      debugShowCheckedModeBanner: false,

      locale: _locale,
      supportedLocales: L10n.all,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeData == AppTheme.light
          ? ThemeMode.light
          : ThemeMode.dark,

      home: const ManagementWidget(),
    );
  }
}

class ManagementWidget extends StatelessWidget {
  const ManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current locale to force rebuild when it changes
    final currentLocale = Localizations.localeOf(context);
    
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (_, value, __) {
          // Rebuild pages when locale changes by using locale in key
          final List<Widget> pages = [
            PasswordGeneratorPage(key: ValueKey('gen_${currentLocale.languageCode}')),
            SaveScreen(key: ValueKey('save_${currentLocale.languageCode}')),
            SettingsScreen(key: ValueKey('settings_${currentLocale.languageCode}')),
          ];
          
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