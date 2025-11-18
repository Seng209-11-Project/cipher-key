import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:password_generator/save_screen/password_card/square_outlined_buttons/square_outlined_buttons.dart';
import 'package:password_generator/save_screen/save_read_function.dart';

import '../../app_navigation_bar/protein_bar.dart';

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
    Clipboard.setData(ClipboardData(text: _cleanPassword));
    proteinBarM(context, "Password Copied!", icon: Icons.check_outlined);
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    await editPassword(EditType.favorite, widget.passwordId, isFavorite: _isFavorite);
    if (!mounted) return;
    proteinBarM(
      context,
      _isFavorite ? "Added to Favorites!" : "Removed from Favorites!",
      icon: _isFavorite ? Icons.star : Icons.star_border,
    );
  }

  void _togglePasswordEdit() {
    setState(() {
      _isEditingPassword = !_isEditingPassword;
    });
  }

  void _savePasswordEdit() {
    setState(() {
      _isEditingPassword = false;
    });
  }

  void _toggleNicknameEdit() {
    setState(() {
      _isEditingNickname = !_isEditingNickname;
    });
  }

  void _saveNicknameEdit() {
    setState(() {
      _isEditingNickname = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(LucideIcons.edit, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nickname section with buttons OUTSIDE and black outline when editing
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: _isEditingNickname
                                ? Border.all(color: Colors.black, width: 2.0)  // BLACK outline when editing
                                : null,
                          ),
                          child: _isEditingNickname
                              ? TextField(
                            controller: _nicknameController,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      // Buttons OUTSIDE the field, positioned in front
                      if (_isEditingNickname) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.check, size: 18, color: Colors.black),
                          onPressed: _saveNicknameEdit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18, color: Colors.black),
                          onPressed: _toggleNicknameEdit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ],
                  ),
                  // Removed top length/time row (shown below password)
                ],
              ),
            ),
          ]),
          const SizedBox(height: 12),
          // Password section with buttons OUTSIDE and black outline when editing
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: _isEditingPassword
                        ? Border.all(color: Colors.black, width: 2.0)  // BLACK outline when editing
                        : null,
                  ),
                  child: _isEditingPassword
                      ? TextField(
                    controller: _passwordController,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Buttons OUTSIDE the field, positioned in front
              if (_isEditingPassword) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.check, size: 18, color: Colors.black),
                  onPressed: _savePasswordEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18, color: Colors.black),
                  onPressed: _togglePasswordEdit,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          // Move length • time under password (Length on left)
          Row(
            children: [
              Text(
                "Length: ${_passwordController.text.length}",
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(width: 4),
              Text("•", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              const SizedBox(width: 4),
              Text(
                widget.passwordDateTime,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.copy, size: 20),
                  label: const Text(
                    'Copy',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () => _copyPassword(context),  // <-- Changed this line
                )
            ),
            const SizedBox(width: 8),
            SquareOutlinedIconButton(
              icon: LucideIcons.star,
              onPressed: _toggleFavorite,
              iconColor: _isFavorite ? Colors.amber : Colors.black,
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
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Password'),
          content: const Text('Are you sure you want to delete this password?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                // Add this line to actually delete the password:
                await deletePassword(widget.passwordId);
                if (context.mounted) {
                  proteinBarM(context, "Password Deleted!", icon: Icons.delete_outline);
                  // Add callback to refresh the list
                  if (widget.onDeleted != null) {
                    widget.onDeleted!();
                  }
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}