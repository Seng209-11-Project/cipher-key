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

  // LOAD USER SETTINGS
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedLang = prefs.getString("lang") ?? "en";
      _isDarkMode = prefs.getBool("darkMode") ?? false;
      _requireFingerprint = prefs.getBool("requireFingerprint") ?? false;

      _uppercase = prefs.getBool("uppercase") ?? true;
      _lowercase = prefs.getBool("lowercase") ?? true;
      _numbers = prefs.getBool("numbers") ?? true;
      _symbols = prefs.getBool("symbols") ?? true;
    });

    // APPLY THEME TO PROVIDER
    final provider = context.read<ThemeProvider>();
    final isCurrentlyDark = provider.themeData == AppTheme.dark;

    if (_isDarkMode != isCurrentlyDark) {
      provider.toggleTheme();
    }
  }

  Future<void> _savePref(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) prefs.setBool(key, value);
    if (value is String) prefs.setString(key, value);
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
              Text(t.settingsLanguage,
                  style: TextStyle(
                      color: cs.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(t.selectPreferredLanguage,
                  style: TextStyle(color: cs.secondary, fontSize: 14)),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // DROPDOWN BUTTON
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedLang,
            icon: Icon(Icons.arrow_drop_down, color: cs.primary),
            dropdownColor: cs.surface,
            borderRadius: BorderRadius.circular(10),
            style: TextStyle(color: cs.primary, fontSize: 14),

            items: const [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "tr",
                child: Text("Türkçe"),
              ),
            ],

            onChanged: (value) async {
              if (value == null) return;

              setState(() => _selectedLang = value);
              await _savePref("lang", value);

              MyApp.setLocale(context, Locale(value));
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
        Text(t.deleteAllPasswordsHeader,
            style: TextStyle(color: cs.secondary)),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _confirmDelete,
          icon: const Icon(Icons.delete_outline),
          label: Text(t.deleteAllPasswords,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
        )
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
