import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class UserModel {
  final String id;
  final String userName;
  final String userEmail;
  //final List<TaskListModel>? taskLists;
  //final List<GroupModel>? groups;

  const UserModel({
    required this.id,
    required this.userName,
    required this.userEmail,
    //this.taskLists,
    //this.groups,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '-1',
      userName: map['userName'] ?? 'Unknown name',
      userEmail: map['userEmail'] ?? 'Unknown email',
    );
  }
}
