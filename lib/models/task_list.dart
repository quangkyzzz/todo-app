import 'dart:core';
import 'package:flutter/material.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/themes.dart';

class TaskList {
  final String id;
  String title;
  String? backgroundImage;
  int defaultImage;
  SortType? sortByType;
  bool isAscending;
  Color themeColor;
  List<Task> tasks;

  TaskList({
    required this.id,
    required this.title,
    this.backgroundImage,
    this.defaultImage = -1,
    this.themeColor = MyTheme.blueColor,
    this.sortByType,
    this.isAscending = true,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];

  TaskList copyWith({
    String? id,
    String? title,
    String? backgroundImage,
    int? defaultImage,
    SortType? sortByType,
    bool? isAscending,
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
      isAscending: isAscending ?? this.isAscending,
      themeColor: themeColor ?? this.themeColor,
      tasks: newTasks,
    );
  }

  void copyFrom({required TaskList copyTaskList}) {
    title = copyTaskList.title;
    backgroundImage = copyTaskList.backgroundImage;
    defaultImage = copyTaskList.defaultImage;
    sortByType = copyTaskList.sortByType;
    isAscending = copyTaskList.isAscending;
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
    result.addAll({'isAscending': isAscending});
    result.addAll({'themeColor': themeColor});
    Map<String, dynamic> tasksMap = {};
    for (Task task in tasks) {
      tasksMap.addAll({task.id: task.toMap()});
    }
    result.addAll({'tasks': tasksMap});

    return result;
  }

  factory TaskList.fromMap(Map<String, dynamic> map) {
    List<Task> tasks = [];
    if (map['tasks'] != null) {
      for (Map<String, dynamic> pair in map['tasks']) {
        tasks.add(Task.fromMap(pair.values.first));
      }
    }
    return TaskList(
      id: map['id'] ?? '-1',
      title: map['title'] ?? 'Untitle list',
      backgroundImage: map['backgroundImage'],
      defaultImage: map['defaultImage'],
      sortByType: map['sortByType'],
      isAscending: map['isAscending'] ?? true,
      themeColor: map['themeColor'] ?? MyTheme.blueColor,
      tasks: tasks,
    );
  }
}
