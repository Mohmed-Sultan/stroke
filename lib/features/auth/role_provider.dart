import 'package:flutter/material.dart';

class RoleProvider with ChangeNotifier {
  String? _role;

  String? get role => _role;

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }
}
