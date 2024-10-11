import 'dart:core';
import 'package:todo_app/models/task_list.dart';

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
    result.addAll({'taskLists': taskLists});
    return result;
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
      taskLists: map['taskLists'] ?? [],
    );
  }
}
