import 'package:flutter/material.dart';
import 'package:todo_app/model/entity/user.dart';

class UserViewModel extends ChangeNotifier {
  User currentUser = User(
    id: '1',
    userName: 'Nguyễn Quang',
    userEmail: 'quang.ndt@outlook.com',
  );

  void updateUserName(String newName) {
    currentUser = currentUser.copyWith(userName: newName);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    currentUser = currentUser.copyWith(userEmail: newEmail);
    notifyListeners();
  }
}
