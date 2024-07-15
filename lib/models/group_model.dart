import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:todo_app/models/task_list_model.dart';

@immutable
class GroupModel {
  final String id;
  final String groupName;
  final List<TaskListModel>? taskLists;

  const GroupModel({
    required this.id,
    required this.groupName,
    this.taskLists,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'groupName': groupName});
    result.addAll({'taskLists': taskLists});
    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
      taskLists: map['taskLists'] ?? [],
    );
  }
}
