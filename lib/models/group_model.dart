import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:todo_app/models/task_list_model.dart';

@immutable
class GroupModel {
  final String groupID;
  final String groupName;
  final List<TaskListModel>? listTaskList;

  const GroupModel({
    required this.groupID,
    required this.groupName,
    this.listTaskList,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'groupID': groupID});
    result.addAll({'groupName': groupName});
    result.addAll({'listTaskList': listTaskList});
    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      groupID: map['groupID'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
      listTaskList: map['listTaskList'] ?? [],
    );
  }
}
