import 'package:flutter/material.dart';
import 'package:kek_app/theme.dart';

// ignore: non_constant_identifier_names
InputDecoration SpecialInput2(String namaLengkap) {
  return InputDecoration(
    hintText: namaLengkap,
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: blueColor),
    ),
  );
}
