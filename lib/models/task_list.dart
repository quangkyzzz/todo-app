import 'dart:core';
import 'package:flutter/material.dart';
import 'task.dart';
import '../themes.dart';

class TaskListModel {
  final String id;
  String listName;
  String? groupID;
  String? backgroundImage;
  int isDefaultImage;
  Map<String, dynamic>? sortByType;
  Color themeColor;
  List<TaskModel> tasks;

  TaskListModel({
    required this.id,
    required this.listName,
    this.groupID,
    this.backgroundImage,
    this.isDefaultImage = -1,
    this.themeColor = MyTheme.blueColor,
    this.sortByType,
    List<TaskModel>? tasks,
  }) : tasks = tasks ?? [];

  TaskListModel copyWith({
    String? id,
    String? listName,
    String? groupID,
    String? backgroundImage,
    int? isDefaultImage,
    Map<String, String>? sortByType,
    Color? themeColor,
    List<TaskModel>? tasks,
  }) {
    return TaskListModel(
      id: id ?? this.id,
      listName: listName ?? this.listName,
      groupID: groupID ?? this.groupID,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      isDefaultImage: isDefaultImage ?? this.isDefaultImage,
      sortByType: sortByType ?? this.sortByType,
      themeColor: themeColor ?? this.themeColor,
      tasks: tasks ?? this.tasks,
    );
  }

  void copyFrom({required TaskListModel copyTaskList}) {
    listName = copyTaskList.listName;
    groupID = copyTaskList.groupID;
    backgroundImage = copyTaskList.backgroundImage;
    isDefaultImage = copyTaskList.isDefaultImage;
    sortByType = copyTaskList.sortByType;
    themeColor = copyTaskList.themeColor;
    tasks = copyTaskList.tasks;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listName': listName});
    result.addAll({'backgroundImage': backgroundImage});
    result.addAll({'isDefaultImage': isDefaultImage});
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
      isDefaultImage: map['isDefaultImage'],
      sortByType: map['sortByType'],
      themeColor: map['themeColor'],
      groupID: map['groupID'],
      tasks: map['taskList'] ?? [],
    );
  }
}
