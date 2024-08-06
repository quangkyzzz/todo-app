import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool isLogin = false;
  UserModel user = UserModel(
    id: '1',
    userName: 'Nguyễn Quang',
    userEmail: 'quang.ndt@outlook.com',
  );

  bool getIsLoginStatus() {
    return isLogin;
  }

  void updateUserName(String newName) {
    user = user.copyWith(userName: newName);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    user = user.copyWith(userEmail: newEmail);
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
