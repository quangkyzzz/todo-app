import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:todo_app/models/task_model.dart';

@immutable
class TaskListModel {
  final String listID;
  final String listName;
  final List<TaskModel>? taskList;

  const TaskListModel({
    required this.listID,
    required this.listName,
    this.taskList,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'listID': listID});
    result.addAll({'listName': listName});
    result.addAll({'taskList': taskList});

    return result;
  }

  factory TaskListModel.fromMap(Map<String, dynamic> map) {
    return TaskListModel(
      listID: map['listID'] ?? '-1',
      listName: map['listName'] ?? 'Untitle list',
      taskList: map['taskList'] ?? [],
    );
  }
}
