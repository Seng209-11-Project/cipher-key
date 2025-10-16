import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../utils/helpers.dart';
import 'generated_section_actions.dart';
import 'generated_section_styles.dart';
import 'generated_section_widgets.dart';

class GeneratedSection extends StatefulWidget {
  final String password;
  final TextEditingController nicknameController;

  const GeneratedSection({
    super.key,
    required this.password,
    required this.nicknameController,
  });

  @override
  State<GeneratedSection> createState() => _GeneratedSectionState();
}

class _GeneratedSectionState extends State<GeneratedSection> {
  late TextEditingController _passwordController;
  bool _isEditing = false;
  final Map<String, bool> _hoverStates = {
    'check': false,
    'close': false,
    'edit': false
  };

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  void didUpdateWidget(GeneratedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.password != oldWidget.password && !_isEditing) {
      _passwordController.text = widget.password;
    }
  }

  void _toggleEdit() => setState(() => _isEditing = !_isEditing);

  void _cancelEdit() => setState(() {
        _isEditing = false;
        _passwordController.text = widget.password;
      });

  void _saveEdit() => setState(() => _isEditing = false);

  void _handleHover(String type, bool hovering) => setState(() {
        _hoverStates[type] = hovering;
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),
        const Text("Generated Password", style: headerTextStyle),
        const SizedBox(height: 8),
        Text(
          _isEditing ? "Editing password..." : "Tap to edit password",
          style: TextStyle(
              fontSize: 12,
              color: _isEditing ? Colors.blue : Colors.grey,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: _isEditing
                    ? TextField(
                        controller: _passwordController,
                        style: passwordTextStyle,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : GestureDetector(
                        onTap: _toggleEdit,
                        child: Text(_passwordController.text,
                            style: passwordTextStyle),
                      ),
              ),
              GeneratedSectionWidgets.buildEditButtons(
                isEditing: _isEditing,
                hoverStates: _hoverStates,
                onHover: _handleHover,
                onSave: _saveEdit,
                onCancel: _cancelEdit,
                onEdit: _toggleEdit,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text("Nickname (optional)", style: headerTextStyle),
        const SizedBox(height: 8),
        TextField(
          controller: widget.nicknameController,
          decoration: buildInputDecoration("Enter a nickname"),
        ),
        const SizedBox(height: 4),
        const Text("Give this password a memorable name", style: hintTextStyle),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeneratedSectionWidgets.buildActionButton(
                LucideIcons.copy,
                "Copy",
                () => GeneratedSectionActions.copyPassword(
                    context, _passwordController.text)),
            const SizedBox(width: 12),
            GeneratedSectionWidgets.buildActionButton(
                LucideIcons.save,
                "Save",
                () => GeneratedSectionActions.savePassword(
                    context, widget.nicknameController)),
          ],
        ),
      ],
    );
  }
}
