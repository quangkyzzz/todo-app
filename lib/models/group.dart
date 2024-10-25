import 'dart:core';
import 'package:todo_app/models/task_list.dart';

//TODO: fix all to map function
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
      taskListsMap.addAll({taskList.id: taskList.toMap()});
    }
    result.addAll({'taskLists': taskListsMap});
    return result;
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    List<TaskList> taskLists = [];
    if (map['taskLists'] != null) {
      for (var value in (map['taskLists'] as Map<String, dynamic>).values) {
        taskLists.add(TaskList.fromMap(value));
      }
    }
    return Group(
      id: map['id'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
      taskLists: taskLists,
    );
  }
}
