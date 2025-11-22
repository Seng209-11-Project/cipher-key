import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_generator/app_navigation_bar/protein_bar.dart';
import 'package:password_generator/app_theme/theme_provider.dart';
import '../app_theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../save_screen/save_read_function.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _requireFingerprint = false;
  bool _uppercase = true, _lowercase = true, _numbers = true, _symbols = true;

  String _selectedLang = "en"; // STORED AS CODE

  final LocalAuthentication _auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sync selected language with current locale whenever dependencies change
    _syncSelectedLangWithLocale();
  }

  void _syncSelectedLangWithLocale() {
    if (!mounted) return;
    final currentLocale = Localizations.localeOf(context);
    final currentLangCode = currentLocale.languageCode;
    if (_selectedLang != currentLangCode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedLang = currentLangCode;
          });
        }
      });
    }
  }

  // LOAD USER SETTINGS
  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Get saved language - DO NOT save if it doesn't exist, let main.dart handle first launch
      String savedLang = prefs.getString("lang") ?? "";
      
      // If no saved language, just use the current app locale for display (don't save it)
      if (savedLang.isEmpty && mounted) {
        final currentLocale = Localizations.localeOf(context);
        savedLang = currentLocale.languageCode;
        // DO NOT save it here - main.dart handles first launch detection
      }
      
      // Fallback to English if still empty
      if (savedLang.isEmpty) {
        savedLang = "en";
      }
      
      setState(() {
        _selectedLang = savedLang;
        _isDarkMode = prefs.getBool("darkMode") ?? false;
        _requireFingerprint = prefs.getBool("requireFingerprint") ?? false;

        _uppercase = prefs.getBool("uppercase") ?? true;
        _lowercase = prefs.getBool("lowercase") ?? true;
        _numbers = prefs.getBool("numbers") ?? true;
        _symbols = prefs.getBool("symbols") ?? true;
      });

      // Apply the saved locale if it's different from current
      // Note: This will be handled by the app's initial load, so we don't need to set it here
      // Just ensure the dropdown shows the correct value

    // APPLY THEME TO PROVIDER
    final provider = context.read<ThemeProvider>();
    final isCurrentlyDark = provider.themeData == AppTheme.dark;

    if (_isDarkMode != isCurrentlyDark) {
      provider.toggleTheme();
    }
    } catch (e) {
      // If SharedPreferences fails, use defaults
      debugPrint('Failed to load preferences: $e');
      // Keep default values already set in initState
    }
  }

  Future<void> _savePref(String key, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (value is bool) await prefs.setBool(key, value);
      if (value is String) {
        await prefs.setString(key, value);
        // If saving language, mark it as explicitly set by user
        if (key == "lang") {
          await prefs.setBool("lang_explicitly_set", true);
        }
      }
    } catch (e) {
      debugPrint('Failed to save preference: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(t.settingsTitle,
            style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: cs.surface,
        iconTheme: IconThemeData(color: cs.primary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                t.settingsSubtitle,
                style: TextStyle(color: cs.secondary, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),

            _buildCard(t.settingsLanguage, _buildLanguageDropdown()),
            const SizedBox(height: 16),

            _buildCard(t.settingsAppearance, _buildAppearance()),
            const SizedBox(height: 16),

            _buildCard(t.settingsSecurity, _buildSecurity()),
            const SizedBox(height: 16),

            _buildCard(t.settingsPasswordGeneration, _buildPasswordOptions()),
            const SizedBox(height: 16),

            _buildCard(t.settingsDataManagement, _buildDataManagement()),
          ],
        ),
      ),
    );
  }

  // BASIC WRAPPER CARD
  Widget _buildCard(String title, Widget child) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.secondary.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // LANGUAGE DROPDOWN BUTTON (CLEAN + NO OVERFLOW)
  Widget _buildLanguageDropdown() {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cs.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.language, color: cs.primary),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.settingsLanguage,
                style: TextStyle(
                  color: cs.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t.selectPreferredLanguage,
                style: TextStyle(color: cs.secondary, fontSize: 14),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: ValueKey(_selectedLang), // Force rebuild when _selectedLang changes
            value: _selectedLang,
            icon: Icon(Icons.arrow_drop_down, color: cs.primary),
            dropdownColor: cs.surface,
            borderRadius: BorderRadius.circular(10),
            style: TextStyle(color: cs.primary, fontSize: 14),

            items: [
              // Order: English, Turkish, Azerbaijani, Russian, Spanish, Deutsch
              const DropdownMenuItem(value: "en", child: Text("English")),
              const DropdownMenuItem(value: "tr", child: Text("Türkçe")),
              const DropdownMenuItem(value: "az", child: Text("Azərbaycan")),
              const DropdownMenuItem(value: "ru", child: Text("Русский")),
              const DropdownMenuItem(value: "es", child: Text("Español")),
              const DropdownMenuItem(value: "de", child: Text("Deutsch")),
            ],

            onChanged: (value) async {
              if (value == null) return;
              if (value == _selectedLang) return; // Already selected

              debugPrint('Changing language to: $value');
              
              // Update UI immediately
              if (mounted) {
                setState(() => _selectedLang = value);
              }
              
              // Apply the locale globally IMMEDIATELY
              if (mounted) {
                MyApp.setLocale(context, Locale(value));
              }
              
              // Save preference AND mark as explicitly set by user
              await _savePref("lang", value);
            },
          ),
        )
      ],
    );
  }

  // APPEARANCE SECTION
  Widget _buildAppearance() {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    final desc = _isDarkMode ? t.switchToLightTheme : t.switchToDarkTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: cs.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              _isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: cs.primary,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.darkMode,
                  style: TextStyle(
                      color: cs.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(color: cs.secondary)),
            ],
          ),
        ]),

        Switch(
          value: _isDarkMode,
          activeColor: cs.primary,
          onChanged: (v) async {
            setState(() => _isDarkMode = v);
            await _savePref("darkMode", v);

            final provider = context.read<ThemeProvider>();
            final isCurrentlyDark = provider.themeData == AppTheme.dark;

            if (v != isCurrentlyDark) {
              provider.toggleTheme();
            }
          },
        )
      ],
    );
  }

  // SECURITY
  Widget _buildSecurity() {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.requireFingerprint,
                    style: TextStyle(
                        color: cs.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(t.fingerprintDescription,
                    style: TextStyle(color: cs.secondary)),
              ],
            )),
        Switch(
          value: _requireFingerprint,
          activeColor: cs.primary,
          onChanged: (v) async {
            if (v && !await _authenticate()) return;

            setState(() => _requireFingerprint = v);
            await _savePref("requireFingerprint", v);
          },
        )
      ],
    );
  }

  // PASSWORD OPTIONS
  Widget _buildPasswordOptions() {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.charTypeInstructions,
            style: TextStyle(color: cs.secondary, fontSize: 14)),
        const SizedBox(height: 16),

        _buildToggle(t.uppercase, _uppercase, "uppercase"),
        _buildToggle(t.lowercase, _lowercase, "lowercase"),
        _buildToggle(t.numbers, _numbers, "numbers"),
        _buildToggle(t.symbols, _symbols, "symbols"),
      ],
    );
  }

  Widget _buildToggle(String label, bool value, String key) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: cs.primary)),
          Switch(
            value: value,
            activeColor: cs.primary,
            onChanged: (v) async {
              // Check if this would disable the last enabled option
              if (!v) {
                int enabledCount = 0;
                if (key != "uppercase" && _uppercase) enabledCount++;
                if (key != "lowercase" && _lowercase) enabledCount++;
                if (key != "numbers" && _numbers) enabledCount++;
                if (key != "symbols" && _symbols) enabledCount++;
                
                // If this is the last enabled option, prevent disabling
                if (enabledCount == 0) {
                  proteinBarM(
                    context,
                    t.atLeastOneOptionRequired,
                    icon: Icons.warning_amber_rounded,
                  );
                  return; // Don't allow disabling
                }
              }
              
              setState(() {
                if (key == "uppercase") _uppercase = v;
                if (key == "lowercase") _lowercase = v;
                if (key == "numbers") _numbers = v;
                if (key == "symbols") _symbols = v;
              });
              await _savePref(key, v);
            },
          ),
        ],
      ),
    );
  }

  // DATA MANAGEMENT SECTION
  Widget _buildDataManagement() {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.deleteAllPasswordsHeader,
          style: TextStyle(color: cs.secondary),
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _confirmDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_outline, size: 20),
                const SizedBox(width: 10),
                Text(
                  t.deleteAllPasswords,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // AUTHENTICATION
  Future<bool> _authenticate() async {
    final t = AppLocalizations.of(context)!;

    try {
      return await _auth.authenticate(
        localizedReason: t.requireFingerprint,
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      proteinBarM(context, t.authFailed, icon: Icons.error);
      return false;
    }
  }

  // DELETE ALL PASSWORDS
  Future<void> _confirmDelete() async {
    final t = AppLocalizations.of(context)!;

    final all = await readPasswords();
    final userPasswords =
        all.keys.where((k) => !k.startsWith("pref_")).length;

    if (userPasswords == 0) {
      proteinBarM(context, t.noPasswordsToDelete, icon: Icons.info);
      return;
    }

    final cs = Theme.of(context).colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: cs.surface,
        title: Text(t.deleteAllPasswordsDialogTitle,
            style: TextStyle(color: cs.primary)),
        content: Text(
          t.deleteAllPasswordsDialogContent(userPasswords),
          style: TextStyle(color: cs.secondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancel, style: TextStyle(color: cs.primary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
            Text(t.deleteAll, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ??
        false;

    if (confirmed && mounted) await deleteAllPasswords();

    proteinBarM(context, t.allPasswordsDeleted);
  }
}
