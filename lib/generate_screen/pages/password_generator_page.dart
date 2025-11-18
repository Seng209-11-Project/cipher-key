import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../utils/password_generator.dart';
import '../widgets/password_length_slider.dart';
import '../widgets/generated_section/generated_section.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

final ScrollController scrollController = ScrollController();
final GlobalKey myTargetKey = GlobalKey();

void scrollToWidget() {
  final context = myTargetKey.currentContext;
  if (context == null) return;

  Scrollable.ensureVisible(
    context,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  double passwordLength = 12;
  bool showGeneratedSection = false;
  String generatedPassword = "";
  final TextEditingController nicknameController = TextEditingController();

  void _generatePassword() => setState(() {
    generatedPassword = generateRandomPassword(passwordLength.toInt());
    showGeneratedSection = true;
  });

  Widget _buildHeader() {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          t.generatorTitle,
          style:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: cs.primary),
        ),
        const SizedBox(height: 8),
        Text(
          t.generatorSubtitle,
          style: TextStyle(fontSize: 15, color: cs.secondary),
        ),
      ],
    );
  }

  Widget _buildMainCard() {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.secondary.withOpacity(0.3)),
        color: cs.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          PasswordLengthSlider(
            value: passwordLength,
            onChanged: (value) => setState(() => passwordLength = value),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              _generatePassword();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollToWidget();
              });
            },
            child: Text(
              t.generatePassword,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          if (showGeneratedSection)
            GeneratedSection(
              key: myTargetKey,
              password: generatedPassword,
              nicknameController: nicknameController,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildMainCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
