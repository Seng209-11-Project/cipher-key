import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_generator/app_navigation_bar/protein_bar.dart';
import 'package:password_generator/app_theme/theme_provider.dart';
import '../generate_screen/utils/password_generator.dart';
import '../save_screen/save_read_function.dart';
import '../generate_screen/utils/helpers.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _requireFingerprint = false;
  bool _uppercase = true, _lowercase = true, _numbers = true, _symbols = true;

  final LocalAuthentication _auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    // PREF LOGIC REMOVED
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text("Customize your password manager", style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),

            _buildCard("Appearance", _buildAppearance()),
            const SizedBox(height: 16),
            _buildCard("Security", _buildSecurity()),
            const SizedBox(height: 16),
            _buildCard("Password Generation", _buildPasswordOptions()),
            const SizedBox(height: 16),
            _buildCard("Data Management", _buildDataManagement()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, Widget child) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [buildBoxShadow()],
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );

  Widget _buildAppearance() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
          child: Icon(_isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: Colors.black),
        ),
        const SizedBox(width: 12),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 4),
          Text("Switch to dark theme", style: TextStyle(color: Colors.grey, fontSize: 14)),
        ]),
      ]),
      Switch(
        value: _isDarkMode,
        activeThumbColor: Colors.black,
        activeTrackColor: Colors.grey.shade400,
        onChanged: (v) => setState(() {
          _isDarkMode = v;
          context.read<ThemeProvider>().toggleTheme();
        }),
      ),
    ],
  );

  Widget _buildSecurity() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Require Fingerprint", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 4),
        Text("Ask for fingerprint authentication on launch", style: TextStyle(color: Colors.grey, fontSize: 14)),
      ])),
      const SizedBox(width: 12),
      Switch(
        value: _requireFingerprint,
        activeThumbColor: Colors.black,
        activeTrackColor: Colors.grey.shade400,
        onChanged: (v) async {
          if (v && !await _authenticate()) return;
          setState(() => _requireFingerprint = v);
        },
      ),
    ],
  );

  Widget _buildPasswordOptions() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Choose which character types to include", style: TextStyle(color: Colors.grey, fontSize: 14)),
      const SizedBox(height: 16),
      ..._buildToggleRows(),
    ],
  );

  List<Widget> _buildToggleRows() => [
    _buildToggle("Uppercase Letters (A-Z)", _uppercase, (v) => _updatePref('uppercase', v)),
    _buildToggle("Lowercase Letters (a-z)", _lowercase, (v) => _updatePref('lowercase', v)),
    _buildToggle("Numbers (0-9)", _numbers, (v) => _updatePref('numbers', v)),
    _buildToggle("Symbols (@#\$%...)", _symbols, (v) => _updatePref('symbols', v)),
  ];

  Widget _buildToggle(String label, bool value, ValueChanged<bool> onChanged) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      Switch(value: value, activeThumbColor: Colors.black, activeTrackColor: Colors.grey.shade400, onChanged: onChanged),
    ]),
  );

  Widget _buildDataManagement() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Ppermanently delete all saved passwords", style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _confirmDelete,
          icon: const Icon(Icons.delete_outline, size: 20),
          label: const Text("Delete All Passwords", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          style: buildActionButtonStyle().copyWith(
            backgroundColor: WidgetStateProperty.all(const Color(0xFFE53935)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
      ),
    ],
  );

  // PREF LOGIC REMOVED — this now ONLY updates UI + charGroups
  Future<void> _updatePref(String key, bool value) async {
    setState(() => _updateState(key, value));

    if (![_uppercase, _lowercase, _numbers, _symbols].any((e) => e)) {
      proteinBarM(context, "At least one option required", icon: Icons.warning);
      setState(() => _uppercase = true);
      charGroups.add(upperChars);
    }
  }

  void _updateState(String key, bool value) {
    switch (key) {
      case 'uppercase':
        _uppercase = value;
        value ? charGroups.add(upperChars) : charGroups.remove(upperChars);
        break;

      case 'lowercase':
        _lowercase = value;
        value ? charGroups.add(lowerChars) : charGroups.remove(lowerChars);
        break;

      case 'numbers':
        _numbers = value;
        value ? charGroups.add(numberChars) : charGroups.remove(numberChars);
        break;

      case 'symbols':
        _symbols = value;
        value ? charGroups.add(symbolChars) : charGroups.remove(symbolChars);
        break;
    }
  }

  Future<bool> _authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Enable fingerprint security',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      proteinBarM(context, "Auth Failed"  , icon: Icons.error);
      return false;
    }
  }

  Future<void> _confirmDelete() async {
    final all = await readPasswords();
    final userPasswords = all.keys.where((k) => !k.startsWith('pref_')).length;

    if (userPasswords == 0) {
      proteinBarM(context, "No passwords to delete", icon: Icons.info);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete All Passwords?"),
        content: Text("This will permanently delete $userPasswords saved passwords."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete All", style: TextStyle(color: Color(0xFFE53935))),
          ),
        ],
      ),
    ) ?? false;

    if (confirmed && mounted) await deleteAllPasswords();
    proteinBarM(context, "Deleted every password!");
  }
}
