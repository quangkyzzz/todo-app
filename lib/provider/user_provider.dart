import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = const UserModel(
    id: '1',
    userName: 'Nguyễn Quang',
    userEmail: 'quang.ndt@outlook.com',
  );

  void updateUserName(String newName) {
    _user = _user.copyWith(userName: newName);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    _user = _user.copyWith(userEmail: newEmail);
    notifyListeners();
  }
}
