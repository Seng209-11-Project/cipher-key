import 'package:flutter/material.dart';
import '../utils/password_generator.dart';
import '../widgets/password_length_slider.dart';
import '../widgets/generated_section/generated_section.dart';

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

  void _generatePassword() => setState(() {
    generatedPassword = generateRandomPassword(passwordLength.toInt());
    showGeneratedSection = true;
  });

  Widget _buildHeader() => const Column(
    children: [
      SizedBox(height: 20),
      Text("Password Generator", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      SizedBox(height: 8),
      Text("Create strong and secure passwords", style: TextStyle(fontSize: 15, color: Colors.grey)),
    ],
  );

  Widget _buildMainCard() => Container(
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
          onChanged: (value) => setState(() => passwordLength = value),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: _generatePassword,
          child: const Text("Generate Password", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        if (showGeneratedSection)
          GeneratedSection(password: generatedPassword, nicknameController: nicknameController),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ❌ BUNU SİL: bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
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