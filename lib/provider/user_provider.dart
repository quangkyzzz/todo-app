import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel(
    id: '1',
    userName: 'Nguyễn Quang',
    userEmail: 'quang.ndt@outlook.com',
  );

  void updateUserName(String newName) {
    user = user.copyWith(userName: newName);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    user = user.copyWith(userEmail: newEmail);
    notifyListeners();
  }
}
