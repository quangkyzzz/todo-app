import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  bool isLogin = false;
  User currentUser = User(
    id: '1',
    userName: 'Nguyễn Quang',
    userEmail: 'quang.ndt@outlook.com',
  );

  bool getIsLoginStatus() {
    return isLogin;
  }

  void updateUserName(String newName) {
    currentUser = currentUser.copyWith(userName: newName);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    currentUser = currentUser.copyWith(userEmail: newEmail);
    notifyListeners();
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
