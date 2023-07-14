import 'package:flutter/material.dart';
import 'package:kek_app/theme.dart';

// ignore: non_constant_identifier_names
Container BtnPrimary(String label, Function onPressed) {
  return Container(
    margin: const EdgeInsets.all(10),
    height: 50,
    width: 280,
    decoration: BoxDecoration(
        color: blueColor3, borderRadius: BorderRadius.circular(55)),
    child: TextButton(
      onPressed: () => onPressed(),
      child: Text(
        label,
        style: popinsWhiteTextStyle.copyWith(fontWeight: bold),
      ),
    ),
  );
}
