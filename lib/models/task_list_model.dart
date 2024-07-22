import 'dart:core';

import 'package:todo_app/models/task_model.dart';

class TaskListModel {
  final String id;
  String listName;
  List<TaskModel> tasks;

  TaskListModel({
    required this.id,
    required this.listName,
    List<TaskModel>? tasks,
  }) : tasks = tasks ?? [];

  TaskListModel copyWith({
    String? id,
    String? listName,
    List<TaskModel>? taskList,
  }) {
    return TaskListModel(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      tasks: taskList ?? tasks,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listName': listName});
    result.addAll({'taskList': tasks});

    return result;
  }

  factory TaskListModel.fromMap(Map<String, dynamic> map) {
    return TaskListModel(
      id: map['id'] ?? '-1',
      listName: map['listName'] ?? 'Untitle list',
      tasks: map['taskList'] ?? [],
    );
  }
}
