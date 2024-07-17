import 'dart:core';

import 'package:todo_app/models/task_list_model.dart';

class GroupModel {
  final String id;
  String groupName;
  List<TaskListModel> taskLists;

  GroupModel({
    required this.id,
    required this.groupName,
    this.taskLists = const [],
  });

  GroupModel copyWith({
    String? id,
    String? groupName,
    List<TaskListModel>? taskLists,
  }) {
    return GroupModel(
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

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
      taskLists: map['taskLists'] ?? [],
    );
  }
}
