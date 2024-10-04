import 'dart:core';
import 'package:flutter/material.dart';
import 'task.dart';
import '../themes.dart';

class TaskList {
  final String id;
  String title;
  String? backgroundImage;
  int defaultImage;
  Map<String, dynamic>? sortByType;
  Color themeColor;
  List<Task> tasks;

  TaskList({
    required this.id,
    required this.title,
    this.backgroundImage,
    this.defaultImage = -1,
    this.themeColor = MyTheme.blueColor,
    this.sortByType,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];

  TaskList copyWith({
    String? id,
    String? title,
    String? backgroundImage,
    int? defaultImage,
    Map<String, dynamic>? sortByType,
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
      title: title ?? this.title,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      defaultImage: defaultImage ?? this.defaultImage,
      sortByType: sortByType ?? this.sortByType,
      themeColor: themeColor ?? this.themeColor,
      tasks: newTasks,
    );
  }

  void copyFrom({required TaskList copyTaskList}) {
    title = copyTaskList.title;
    backgroundImage = copyTaskList.backgroundImage;
    defaultImage = copyTaskList.defaultImage;
    sortByType = copyTaskList.sortByType;
    themeColor = copyTaskList.themeColor;
    tasks = copyTaskList.tasks;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'backgroundImage': backgroundImage});
    result.addAll({'defaultImage': defaultImage});
    result.addAll({'sortByType': sortByType});
    result.addAll({'themeColor': themeColor});
    result.addAll({'taskList': tasks});

    return result;
  }

  factory TaskList.fromMap(Map<String, dynamic> map) {
    return TaskList(
      id: map['id'] ?? '-1',
      title: map['title'] ?? 'Untitle list',
      backgroundImage: map['backgroundImage'],
      defaultImage: map['defaultImage'],
      sortByType: map['sortByType'],
      themeColor: map['themeColor'],
      tasks: map['taskList'] ?? [],
    );
  }
}
