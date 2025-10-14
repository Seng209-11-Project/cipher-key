import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:password_generator/features/password_generator/data/repositories/password_repository.dart';
import 'package:password_generator/shared/widgets/protein_bar.dart';

class GeneratedSection extends StatefulWidget {
  final String password;
  final VoidCallback onCopy;
  final VoidCallback onSave;
  final TextEditingController nicknameController;
  final ValueChanged<String> onPasswordChanged;

  const GeneratedSection({
    super.key,
    required this.password,
    required this.onCopy,
    required this.onSave,
    required this.nicknameController,
    required this.onPasswordChanged,
  });

  @override
  State<GeneratedSection> createState() => _GeneratedSectionState();
}

class _GeneratedSectionState extends State<GeneratedSection> {
  late TextEditingController _passwordController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: widget.password); // ✅ widget burada
  }

  @override
  void didUpdateWidget(GeneratedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.password != oldWidget.password && !_isEditing) { // ✅ widget burada
      _passwordController.text = widget.password; // ✅ widget burada
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        widget.onPasswordChanged(_passwordController.text); // ✅ widget burada
      }
    });
  }

  void _handleCopy() {
    Clipboard.setData(ClipboardData(text: widget.password)); // ✅ widget burada
    proteinBarM(context, "Copied Password", icon: Icons.check_outlined);

    // Opsiyonel: Üst componente de haber ver
    widget.onCopy(); // ✅ widget burada
  }

  void _handleSave() async {
    try {
      final PasswordRepository repository = PasswordRepository();

      await repository.saveNewPassword(
        password: widget.password, // ✅ widget burada
        nickname: widget.nicknameController.text, // ✅ widget burada
      );

      // Başarılı mesajı göster
      proteinBarM(
        context,
        widget.nicknameController.text.isEmpty // ✅ widget burada
            ? "Password Saved!"
            : "Password '${widget.nicknameController.text}' Saved!", // ✅ widget burada
        icon: Icons.check_outlined,
      );

      // Input'ları temizle
      widget.nicknameController.clear(); // ✅ widget burada

      // Üst componente haber ver (opsiyonel)
      widget.onSave(); // ✅ widget burada

    } catch (e) {
      // Hata mesajı göster
      proteinBarM(
        context,
        "Save Failed!",
        icon: Icons.error_outline,
        backgroundColor: Colors.red,
      );
      print('Save error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Generated Password",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: _toggleEdit,
              icon: Icon(
                _isEditing ? Icons.check : Icons.edit,
                size: 20,
                color: Colors.black,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 8),

        if (!_isEditing) ...[
          const Text(
            "Tap the password field or edit button to customize",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
        ],

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _isEditing
              ? TextField(
            controller: _passwordController,
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: 1,
            ),
            maxLines: 1,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: widget.onPasswordChanged, // ✅ widget burada
          )
              : GestureDetector(
            onTap: _toggleEdit,
            child: Text(
              _passwordController.text,
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ),

        if (_isEditing) ...[
          const SizedBox(height: 8),
          const Text(
            "Editing mode - Click ✓ to save changes",
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],

        const SizedBox(height: 20),
        const Text(
          "Nickname (optional)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.nicknameController, // ✅ widget burada
          decoration: InputDecoration(
            hintText: "Enter a nickname for this password",
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Give this password a memorable name",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _handleCopy,
              icon: const Icon(LucideIcons.copy, size: 18),
              label: const Text("Copy"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _handleSave,
              icon: const Icon(LucideIcons.save, size: 18),
              label: const Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}