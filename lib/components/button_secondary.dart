import 'package:flutter/material.dart';
import 'package:kek_app/theme.dart';

// ignore: non_constant_identifier_names
Expanded BtnCustom(String label, Function onPressed, Color cls) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      decoration:
          BoxDecoration(color: cls, borderRadius: BorderRadius.circular(55)),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: popinsWhiteTextStyle.copyWith(fontWeight: bold),
        ),
      ),
    ),
  );
}
