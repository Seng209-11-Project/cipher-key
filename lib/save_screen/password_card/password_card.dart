import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:password_generator/save_screen/password_card/square_outlined_buttons/square_outlined_buttons.dart';
import 'package:password_generator/save_screen/save_read_function.dart';

import '../../app_navigation_bar/protein_bar.dart';
import '../../l10n/app_localizations.dart';

class PasswordCard extends StatefulWidget {
  final String password;
  final String passwordName;
  final String passwordDateTime;
  final String passwordId;
  final VoidCallback? onDeleted;

  const PasswordCard({
    super.key,
    required this.password,
    required this.passwordName,
    required this.passwordDateTime,
    required this.passwordId,
    this.onDeleted,
  });

  @override
  _PasswordCardState createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  bool _isEditingPassword = false;
  bool _isEditingNickname = false;
  bool _isFavorite = false;
  String _cleanPassword = "";
  late TextEditingController _passwordController;
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.password.startsWith("⭐");
    _cleanPassword = _isFavorite ? widget.password.substring(1) : widget.password;
    _passwordController = TextEditingController(text: _cleanPassword);
    _nicknameController = TextEditingController(text: widget.passwordName);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _copyPassword(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: _cleanPassword));
    proteinBarM(context, t.passwordCopied, icon: Icons.check_outlined);
  }

  Future<void> _toggleFavorite() async {
    final t = AppLocalizations.of(context)!;

    setState(() {
      _isFavorite = !_isFavorite;
    });

    await editPassword(
      EditType.favorite,
      widget.passwordId,
      isFavorite: _isFavorite,
    );

    if (!mounted) return;

    proteinBarM(
      context,
      _isFavorite ? t.addedToFavorites : t.removedFromFavorites,
      icon: _isFavorite ? Icons.star : Icons.star_border,
    );
  }

  void _togglePasswordEdit() {
    setState(() => _isEditingPassword = !_isEditingPassword);
  }

  void _savePasswordEdit() {
    setState(() => _isEditingPassword = false);
  }

  void _toggleNicknameEdit() {
    setState(() => _isEditingNickname = !_isEditingNickname);
  }

  void _saveNicknameEdit() {
    setState(() => _isEditingNickname = false);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: cs.secondary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(LucideIcons.edit, size: 18, color: cs.secondary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: cs.surface.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: _isEditingNickname
                                ? Border.all(color: cs.primary, width: 2.0)
                                : null,
                          ),
                          child: _isEditingNickname
                              ? TextField(
                            controller: _nicknameController,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: cs.primary),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            autofocus: true,
                          )
                              : GestureDetector(
                            onTap: _toggleNicknameEdit,
                            child: Text(
                              widget.passwordName,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: cs.primary),
                            ),
                          ),
                        ),
                      ),
                      if (_isEditingNickname) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.check, size: 18, color: cs.primary),
                          onPressed: _saveNicknameEdit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 18, color: cs.primary),
                          onPressed: _toggleNicknameEdit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border:
                    _isEditingPassword ? Border.all(color: cs.primary, width: 2.0) : null,
                  ),
                  child: _isEditingPassword
                      ? TextField(
                    controller: _passwordController,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: cs.primary),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    autofocus: true,
                  )
                      : GestureDetector(
                    onTap: _togglePasswordEdit,
                    child: Text(
                      _passwordController.text,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cs.primary),
                    ),
                  ),
                ),
              ),
              if (_isEditingPassword) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.check, size: 18, color: cs.primary),
                  onPressed: _savePasswordEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 18, color: cs.primary),
                  onPressed: _togglePasswordEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                "${t.length}: ${_passwordController.text.length}",
                style: TextStyle(fontSize: 12, color: cs.secondary),
              ),
              const SizedBox(width: 4),
              Text("•", style: TextStyle(fontSize: 12, color: cs.secondary)),
              const SizedBox(width: 4),
              Text(
                widget.passwordDateTime,
                style: TextStyle(fontSize: 12, color: cs.secondary),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: Icon(Icons.copy, size: 20, color: cs.primary),
                label: Text(
                  t.copy,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: cs.primary),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.secondary.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16),
                  backgroundColor: cs.surface,
                ),
                onPressed: () => _copyPassword(context),
              ),
            ),
            const SizedBox(width: 8),

            SquareOutlinedIconButton(
              icon: LucideIcons.star,
              onPressed: _toggleFavorite,
              iconColor: _isFavorite ? Colors.amber : cs.primary,
            ),
            const SizedBox(width: 8),

            SquareOutlinedIconButton(
              icon: LucideIcons.trash2,
              onPressed: () => _deletePassword(context),
              iconColor: Colors.red,
            ),
          ])
        ],
      ),
    );
  }

  void _deletePassword(BuildContext context) async {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cs.surface,
          title: Text(t.deletePassword,
              style: TextStyle(color: cs.primary)),
          content: Text(
            t.confirmDeletePassword,
            style: TextStyle(color: cs.secondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(t.cancel, style: TextStyle(color: cs.primary)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await deletePassword(widget.passwordId);

                if (context.mounted) {
                  proteinBarM(context, t.passwordDeleted,
                      icon: Icons.delete_outline);
                  widget.onDeleted?.call();
                }
              },
              child: Text(
                t.delete,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
