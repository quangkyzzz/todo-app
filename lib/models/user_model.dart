import 'package:flutter/foundation.dart';
import 'package:todo_app/models/group_model.dart';
import 'dart:core';

import 'package:todo_app/models/task_list_model.dart';

@immutable
class UserModel {
  final String userID;
  final String userName;
  final String userEmail;
  final List<TaskListModel>? taskLists;
  final List<GroupModel>? groups;

  const UserModel({
    required this.userID,
    required this.userName,
    required this.userEmail,
    this.taskLists,
    this.groups,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userID': userID});
    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});
    result.addAll({'taskLists': taskLists});
    result.addAll({'groups': groups});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '-1',
      userName: map['userName'] ?? 'Unknown name',
      userEmail: map['userEmail'] ?? 'Unknown email',
      taskLists: map['taskLists'] ?? [],
      groups: map['groups'] ?? [],
    );
  }
}
