import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLogin = false;

  bool getIsLoginStatus() {
    return isLogin;
  }

  void login() {
    isLogin = true;
    notifyListeners();
  }

  void logout() {
    isLogin = false;
    notifyListeners();
  }
}
