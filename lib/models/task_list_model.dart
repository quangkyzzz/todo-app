import 'dart:core';

import 'package:todo_app/models/task_model.dart';

class TaskListModel {
  final String id;
  String listName;
  String? groupID;
  String? backgroundImage;
  String? themeColor;
  List<TaskModel> tasks;

  TaskListModel({
    required this.id,
    required this.listName,
    this.groupID,
    this.backgroundImage,
    this.themeColor,
    List<TaskModel>? tasks,
  }) : tasks = tasks ?? [];

  TaskListModel copyWith({
    String? id,
    String? listName,
    String? groupID,
    String? backgroundImage,
    String? themeColor,
    List<TaskModel>? taskList,
  }) {
    return TaskListModel(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      groupID: groupID ?? this.groupID,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      themeColor: themeColor ?? this.themeColor,
      tasks: taskList ?? tasks,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listName': listName});
    result.addAll({'backgroundImage': backgroundImage});
    result.addAll({'themeColor': themeColor});
    result.addAll({'groupID': groupID});
    result.addAll({'taskList': tasks});

    return result;
  }

  factory TaskListModel.fromMap(Map<String, dynamic> map) {
    return TaskListModel(
      id: map['id'] ?? '-1',
      listName: map['listName'] ?? 'Untitle list',
      backgroundImage: map['backgroundImage'],
      themeColor: map['themeColor'],
      groupID: map['groupID'],
      tasks: map['taskList'] ?? [],
    );
  }
}
