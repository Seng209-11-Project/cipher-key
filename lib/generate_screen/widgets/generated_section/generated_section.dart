import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../l10n/app_localizations.dart';
import '../../utils/helpers.dart';
import 'generated_section_actions.dart';
import 'generated_section_styles.dart';
import 'generated_section_widgets.dart';

class GeneratedSection extends StatefulWidget {
  final String password;
  final TextEditingController nicknameController;
  final ValueChanged<String>? onPasswordChanged;

  const GeneratedSection({
    super.key,
    required this.password,
    required this.nicknameController,
    this.onPasswordChanged,
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

  final FocusNode _passwordFocusNode = FocusNode();

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

  void _toggleEdit() {
    setState(() => _isEditing = !_isEditing);

    if (_isEditing) {
      Future.delayed(const Duration(milliseconds: 50), () {
        _passwordFocusNode.requestFocus();
      });
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _passwordController.text = widget.password;
    });
  }

  void _saveEdit() => setState(() => _isEditing = false);

  void _handleHover(String type, bool hovering) =>
      setState(() => _hoverStates[type] = hovering);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Divider(color: cs.secondary.withOpacity(0.3)),
        const SizedBox(height: 16),

        Text(
          t.generatedPassword,
          style: headerTextStyle.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),

        Text(
          _isEditing ? t.editingPassword : t.tapToEditPassword,
          style: TextStyle(
            fontSize: 12,
            color: _isEditing ? cs.primary : cs.secondary,
            fontStyle: FontStyle.italic,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: cs.secondary.withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _isEditing
                    ? TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  maxLength: 32,
                  style: passwordTextStyle.copyWith(color: cs.primary),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    counterText: '', // Hide character counter
                  ),
                  onChanged: (value) {
                    // Notify parent when password is edited
                    widget.onPasswordChanged?.call(value);
                  },
                )
                    : GestureDetector(
                  onTap: _toggleEdit,
                  child: Text(
                    _passwordController.text,
                    style:
                    passwordTextStyle.copyWith(color: cs.primary),
                  ),
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

        Text(
          t.nicknameOptional,
          style: headerTextStyle.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),

        TextField(
          controller: widget.nicknameController,
          decoration: buildInputDecoration(t.enterANickname, context),
        ),

        const SizedBox(height: 4),
        Text(
          t.giveNicknameMeaning,
          style: hintTextStyle.copyWith(color: cs.secondary),
        ),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeneratedSectionWidgets.buildActionButton(
              LucideIcons.copy,
              t.copy,
                  () => copyButtonOnPressed(context, _passwordController.text),
              context: context,
            ),
            const SizedBox(width: 12),

            GeneratedSectionWidgets.buildActionButton(
              LucideIcons.save,
              t.save,
                  () => saveButtonOnPressed(
                  context, widget.nicknameController, _passwordController.text),
              context: context,
            ),
          ],
        ),
      ],
    );
  }
}
