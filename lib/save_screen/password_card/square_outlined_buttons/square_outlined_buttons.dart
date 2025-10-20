import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SquareOutlinedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SquareOutlinedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<SquareOutlinedIconButton> createState() => _SquareOutlinedIconButtonState();
}

class _SquareOutlinedIconButtonState extends State<SquareOutlinedIconButton> {
  late Color currentColor;
  @override
  void initState() {
    super.initState();
    currentColor = Colors.black87;
  }
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          currentColor == Colors.black87 ? currentColor = Colors.yellow : currentColor = Colors.black87;
        });
        widget.onPressed();
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(48, 48),
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        widget.icon,
        color: widget.icon == LucideIcons.star ? currentColor :Colors.red,
        size: 20,
      ),
    );
  }
}
