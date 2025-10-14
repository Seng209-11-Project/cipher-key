import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/core/utils/password_generator.dart';
import 'package:password_generator/shared/widgets/app_navigation_bar.dart';
import '../widgets/generated_section.dart';
import '../widgets/password_length_slider.dart';
import '../widgets/generate_password_button.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  double passwordLength = 12;
  bool showGeneratedSection = false;
  String generatedPassword = "Qf?!R1<Xa@tz";
  final TextEditingController nicknameController = TextEditingController();

  void _generatePassword() {
    final int length = passwordLength.toInt();
    final String newPassword = PasswordGenerator.generateRandomPassword(length);
    setState(() {
      generatedPassword = newPassword;
      showGeneratedSection = true;
    });
  }

  void _copyPassword() {
    Clipboard.setData(ClipboardData(text: generatedPassword));
    // Protein bar will be called from shared widget
  }

  void _savePassword() {
    // Protein bar will be called from shared widget
    nicknameController.clear();
  }

  void _onPasswordChanged(String newPassword) {
    setState(() {
      generatedPassword = newPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Password Generator",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create strong and secure passwords",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PasswordLengthSlider(
                          value: passwordLength,
                          onChanged: (value) {
                            setState(() => passwordLength = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        GeneratePasswordButton(
                          onPressed: _generatePassword,
                        ),
                        if (showGeneratedSection)
                          GeneratedSection(
                            password: generatedPassword,
                            onCopy: _copyPassword,
                            onSave: _savePassword,
                            nicknameController: nicknameController,
                            onPasswordChanged: _onPasswordChanged,
                          ),
                      ],
                    ),
                  ),
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