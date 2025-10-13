import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'custom_button.dart';
import 'nickname_field.dart';

class GeneratedSection extends StatelessWidget {
  final String password;

  const GeneratedSection({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),
        const Text(
          "Generated Password",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            password,
            style: const TextStyle(fontSize: 16, letterSpacing: 1),
          ),
        ),
        const SizedBox(height: 16),
        const NicknameField(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CustomButton(icon: LucideIcons.copy, label: "Copy"),
            SizedBox(width: 12),
            CustomButton(icon: LucideIcons.save, label: "Save"),
          ],
        ),
      ],
    );
  }
}
