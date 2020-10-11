import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  bool _isAuth = true;

  get isAuth {
    return _isAuth;
  }

  void logIn() {
    _isAuth = true;
    notifyListeners();
  }

  void logOut() {
    _isAuth = false;
    notifyListeners();
  }
}