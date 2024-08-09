import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/themes.dart';

class TaskListModel {
  final String id;
  String listName;
  String? groupID;
  File? backgroundImage;
  Map<String, dynamic>? sortByType;
  Color themeColor;
  List<TaskModel> tasks;

  TaskListModel({
    required this.id,
    required this.listName,
    this.groupID,
    this.backgroundImage,
    this.themeColor = MyTheme.blueColor,
    this.sortByType,
    List<TaskModel>? tasks,
  }) : tasks = tasks ?? [];

  TaskListModel copyWith({
    String? id,
    String? listName,
    String? groupID,
    File? backgroundImage,
    Map<String, String>? sortByType,
    Color? themeColor,
    List<TaskModel>? tasks,
  }) {
    return TaskListModel(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      groupID: groupID ?? this.groupID,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      sortByType: sortByType ?? this.sortByType,
      themeColor: themeColor ?? this.themeColor,
      tasks: tasks ?? this.tasks,
    );
  }

  void copyFrom({required TaskListModel copyTaskList}) {
    listName = copyTaskList.listName;
    groupID = copyTaskList.groupID;
    backgroundImage = copyTaskList.backgroundImage;
    sortByType = copyTaskList.sortByType;
    themeColor = copyTaskList.themeColor;
    tasks = copyTaskList.tasks;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listName': listName});
    result.addAll({'backgroundImage': backgroundImage});
    result.addAll({'sortByType': sortByType});
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
      sortByType: map['sortByType'],
      themeColor: map['themeColor'],
      groupID: map['groupID'],
      tasks: map['taskList'] ?? [],
    );
  }
}
