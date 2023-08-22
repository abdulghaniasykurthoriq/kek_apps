import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // ignore: unused_field

  String _urlPhotoUser = "";

  String get urlPhotoUser => _urlPhotoUser;

  void updateUrlPhotoUser(String value) {
    _urlPhotoUser = value;
  }
}
