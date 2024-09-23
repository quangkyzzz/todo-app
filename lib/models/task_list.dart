import 'dart:core';
import 'package:flutter/material.dart';
import 'task.dart';
import '../themes.dart';

//TODO: delete groupID
class TaskList {
  final String id;
  String listName;
  String? groupID;
  String? backgroundImage;
  int defaultImage;
  Map<String, dynamic>? sortByType;
  Color themeColor;
  List<Task> tasks;

  TaskList({
    required this.id,
    required this.listName,
    this.groupID,
    this.backgroundImage,
    this.defaultImage = -1,
    this.themeColor = MyTheme.blueColor,
    this.sortByType,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];

  TaskList copyWith({
    String? id,
    String? listName,
    String? groupID,
    String? backgroundImage,
    int? defaultImage,
    Map<String, String>? sortByType,
    Color? themeColor,
    List<Task>? tasks,
  }) {
    List<Task> newTasks = [];
    if (tasks != null) {
      newTasks = tasks;
    } else {
      for (Task task in this.tasks) {
        newTasks.add(task.copyWith());
      }
    }
    return TaskList(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      groupID: groupID ?? this.groupID,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      defaultImage: defaultImage ?? this.defaultImage,
      sortByType: sortByType ?? this.sortByType,
      themeColor: themeColor ?? this.themeColor,
      tasks: newTasks,
    );
  }

  void copyFrom({required TaskList copyTaskList}) {
    listName = copyTaskList.listName;
    groupID = copyTaskList.groupID;
    backgroundImage = copyTaskList.backgroundImage;
    defaultImage = copyTaskList.defaultImage;
    sortByType = copyTaskList.sortByType;
    themeColor = copyTaskList.themeColor;
    tasks = copyTaskList.tasks;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listName': listName});
    result.addAll({'backgroundImage': backgroundImage});
    result.addAll({'defaultImage': defaultImage});
    result.addAll({'sortByType': sortByType});
    result.addAll({'themeColor': themeColor});
    result.addAll({'groupID': groupID});
    result.addAll({'taskList': tasks});

    return result;
  }

  factory TaskList.fromMap(Map<String, dynamic> map) {
    return TaskList(
      id: map['id'] ?? '-1',
      listName: map['listName'] ?? 'Untitle list',
      backgroundImage: map['backgroundImage'],
      defaultImage: map['defaultImage'],
      sortByType: map['sortByType'],
      themeColor: map['themeColor'],
      groupID: map['groupID'],
      tasks: map['taskList'] ?? [],
    );
  }
}
