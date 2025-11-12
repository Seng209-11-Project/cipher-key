import 'package:flutter/material.dart';

BoxShadow buildBoxShadow() {
  return BoxShadow(
    color: Colors.black.withOpacity(0.15),
    blurRadius: 6,
    spreadRadius: 1,
    offset: const Offset(0, 2),
  );
}

InputDecoration buildInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: Colors.grey.shade100,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 1.5)),
    hoverColor: Colors.black.withOpacity(0.05),
    focusColor: Colors.black.withOpacity(0.1),
  );
}

ButtonStyle buildActionButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    side: BorderSide(color: Colors.grey.shade300),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );
}