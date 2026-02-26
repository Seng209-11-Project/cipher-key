import 'package:flutter/material.dart';
import 'package:password_generator/authguard/authguard.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool requireFingerprint = prefs.getBool("requireFingerprint") ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(
          key: MyApp.appStateKey,
          requireAuth: requireFingerprint
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool requireAuth;

  const MyApp({
    super.key,
    required this.requireAuth
  });

  static final GlobalKey<_MyAppState> appStateKey = GlobalKey<_MyAppState>();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
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
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
        final savedLang = prefs.getString("lang");
      final hasExplicitLanguage = prefs.getBool("lang_explicitly_set") ?? false;

      if (savedLang != null && savedLang.isNotEmpty && mounted) {
        setState(() {
          _locale = Locale(savedLang);
        });
        return;
      }

      if (!hasExplicitLanguage && mounted) {
        final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
        final deviceLocale = platformDispatcher.locale;
        final language = deviceLocale.languageCode;

        String langToUse;
        if (L10n.all.any((loc) => loc.languageCode == language)) {
          langToUse = language;
        } else {
          langToUse = 'en';
        }

        prefs.setString("lang", langToUse).catchError((e) {
          debugPrint('Failed to save initial locale: $e');
        });

        if (mounted) {
          setState(() {
            _locale = Locale(langToUse);
          });
        }
      } else if (mounted) {
        setState(() {
          _locale = const Locale('en');
        });
      }
    } catch (e) {
      debugPrint('Failed to load saved locale: $e');
    }
  }

  void setLocale(Locale locale) {
    if (!mounted) return;

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

    return SafeArea(child: MaterialApp(
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

      home: widget.requireAuth
          ? AuthGuard(child: ManagementWidget())
          : const ManagementWidget(),
    ));
  }
}

class ManagementWidget extends StatelessWidget {
  const ManagementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return Scaffold(
      body: SafeArea(child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (_, value, __) {
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
      ),),
      bottomNavigationBar: const SafeArea(child: AppNavigationBar(),)
    );
  }
}