import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../save_screen/save_read_function.dart';
import '../../widgets/protein_bar.dart';
void copyButtonOnPressed(BuildContext context,String password) {
  Clipboard.setData(ClipboardData(text: password));
  proteinBarM(context, "Copied Password", icon: Icons.check_outlined);
}

Future<void> saveButtonOnPressed(BuildContext context,TextEditingController nicknameController,String password) async{
  final DateTime now = DateTime.now();
  final String formattedDateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  final String nickname = nicknameController.text;
  String toPass = nickname + formattedDateTime;
  proteinBarM(
    context,
    nickname.isEmpty ? "Password Saved!" : "Password '$nickname' Saved!",
    icon: Icons.check_outlined,
  );
  nicknameController.clear();
  savePassword(toPass, password);
}