import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';
import '../utils/password_generator.dart';
import '../widgets/password_length_slider.dart';
import '../widgets/generated_section/generated_section.dart';
import '../../app_navigation_bar/protein_bar.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  // --- State Variables ---
  double passwordLength = 12;
  bool showGeneratedSection = false;
  bool memoryMode = false;
  String generatedPassword = "";

  // --- Controllers & Keys ---
  final TextEditingController nicknameController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GlobalKey myTargetKey = GlobalKey();

  // --- Password Settings ---
  bool _uppercase = true, _lowercase = true, _numbers = true, _symbols = true;

  @override
  void initState() {
    super.initState();
    _loadPasswordOptions();
  }

  Future<void> _loadPasswordOptions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          _uppercase = prefs.getBool("uppercase") ?? true;
          _lowercase = prefs.getBool("lowercase") ?? true;
          _numbers = prefs.getBool("numbers") ?? true;
          _symbols = prefs.getBool("symbols") ?? true;
        });
      }
    } catch (e) {
      debugPrint('Failed to load settings: $e');
    }
  }

  Future<void> _handleGeneration() async {
    final t = AppLocalizations.of(context)!;

    if (memoryMode) {
      // Logic for Memorable Password (Async word retrieval)
      final pass = await generateMemorable(5);
      setState(() {
        generatedPassword = pass;
        showGeneratedSection = true;
      });
    } else {
      // Standard Logic
      await _loadPasswordOptions();
      if (![_uppercase, _lowercase, _numbers, _symbols].contains(true)) {
        proteinBarM(context, t.atLeastOneOptionRequired, icon: Icons.warning_amber_rounded);
        return;
      }
      setState(() {
        generatedPassword = generateRandomPassword(
          passwordLength.toInt(),
          uppercase: _uppercase,
          lowercase: _lowercase,
          numbers: _numbers,
          symbols: _symbols,
        );
        showGeneratedSection = true;
      });
    }

    // Smooth scroll to the result
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = myTargetKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  // --- UI Components ---

  Widget _buildMemoryModeButton() {
    final cs = Theme.of(context).colorScheme;
    final Color statusColor = memoryMode ? Colors.greenAccent : Colors.grey.shade400;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: memoryMode ? cs.primary : Colors.white,
        foregroundColor: memoryMode ? cs.onPrimary : Colors.black,
        shadowColor: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onPressed: () => setState(() => memoryMode = !memoryMode),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            memoryMode ? Icons.auto_awesome : Icons.auto_awesome_outlined,
            size: 22,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Memorable Mode",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  "(English Only)",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11,),
                ),
              ],
            ),
          ),
          // Status Badge (ON/OFF)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: memoryMode ? Colors.black.withOpacity(0.15) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: statusColor, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LED Dot
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (memoryMode)
                        BoxShadow(color: statusColor.withOpacity(0.6), blurRadius: 4, spreadRadius: 1),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  memoryMode ? "ON" : "OFF",
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeaningBox(String word, String meaning) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.onSurface.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.onSurface.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.toUpperCase(),
            style: TextStyle(color: cs.primary, fontWeight: FontWeight.w900, letterSpacing: 1.2),
          ),
          const Divider(color: Colors.white10, height: 20),
          Text(
            meaning,
            style: TextStyle(color: cs.onSurface.withOpacity(0.7), fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildMeaningSection() {
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: meaningMap,
      builder: (context, meanings, _) {
        if (!memoryMode || !showGeneratedSection || meanings.isEmpty) return const SizedBox.shrink();

        return Column(
          children: meanings.entries.map((entry) =>
              _buildMeaningBox(entry.key, entry.value.toString())
          ).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cs.onSurface.withOpacity(0.1)),
                  color: cs.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMemoryModeButton(),

                    // Conditionally show/hide length slider
                    if (!memoryMode) ...[
                      const SizedBox(height: 24),
                      PasswordLengthSlider(
                        value: passwordLength,
                        onChanged: (v) => setState(() => passwordLength = v),
                      ),
                    ],

                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.onSurface,
                        foregroundColor: cs.surface,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _handleGeneration,
                      child: Text(t.generatePassword, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    if (showGeneratedSection) ...[
                      const SizedBox(height: 20),
                      GeneratedSection(
                        key: myTargetKey,
                        password: generatedPassword,
                        nicknameController: nicknameController,
                        onPasswordChanged: (p) => setState(() => generatedPassword = p),
                      ),
                      _buildMeaningSection(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(t.generatorTitle, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: cs.primary)),
        const SizedBox(height: 8),
        Text(t.generatorSubtitle, style: TextStyle(fontSize: 15, color: cs.secondary)),
      ],
    );
  }
}