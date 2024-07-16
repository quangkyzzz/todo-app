import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:todo_app/models/task_model.dart';

@immutable
class TaskListModel {
  final String id;
  final String listName;
  final List<TaskModel>? taskList;

  const TaskListModel({
    required this.id,
    required this.listName,
    this.taskList,
  });

  TaskListModel copyWith({
    String? id,
    String? listName,
    List<TaskModel>? taskList,
  }) {
    return TaskListModel(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      taskList: taskList ?? this.taskList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listName': listName});
    result.addAll({'taskList': taskList});

    return result;
  }

  factory TaskListModel.fromMap(Map<String, dynamic> map) {
    return TaskListModel(
      id: map['id'] ?? '-1',
      listName: map['listName'] ?? 'Untitle list',
      taskList: map['taskList'] ?? [],
    );
  }
}
