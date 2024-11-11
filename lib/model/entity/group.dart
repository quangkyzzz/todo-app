// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:core';
import 'package:todo_app/model/entity/task_list.dart';

class Group {
  final String id;
  String groupName;
  List<TaskList> taskLists;

  Group({
    required this.id,
    required this.groupName,
    List<TaskList>? taskLists,
  }) : taskLists = taskLists ?? [];

  Group copyWith({
    String? id,
    String? groupName,
    List<TaskList>? taskLists,
  }) {
    return Group(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      taskLists: taskLists ?? this.taskLists,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'groupName': groupName});
    Map<String, dynamic> taskListsMap = {};
    for (TaskList taskList in taskLists) {
      taskListsMap.addAll({'id${taskList.id}': taskList.toMap()});
    }
    result.addAll({'taskLists': taskListsMap});
    return result;
  }

  factory Group.fromMap(Map map) {
    List<TaskList> taskLists = [];
    if (map['taskLists'] != null) {
      (map['taskLists'] as Map).values.forEach((element) {
        taskLists.add(TaskList.fromMap(element));
      });
    }
    return Group(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: map['groupName'] ?? 'Untitle group',
      taskLists: taskLists,
    );
  }
}
