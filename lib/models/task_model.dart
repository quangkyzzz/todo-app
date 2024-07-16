import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:todo_app/models/step_model.dart';

@immutable
class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;
  final bool isImportant;
  final DateTime createDate;
  final List<StepModel>? stepList;
  final DateTime? dueDate;
  final DateTime? remindTime;
  final String? repeatFrequency;
  final String? filePath;
  final String? note;
  final String? backgroundImage;
  final String? themeColor;

  const TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.isImportant,
    required this.createDate,
    this.stepList,
    this.dueDate,
    this.remindTime,
    this.repeatFrequency,
    this.filePath,
    this.note,
    this.backgroundImage,
    this.themeColor,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    bool? isImportant,
    DateTime? createDate,
    List<StepModel>? stepList,
    DateTime? dueDate,
    DateTime? remindTime,
    String? repeatFrequency,
    String? filePath,
    String? note,
    String? backgroundImage,
    String? themeColor,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isImportant: isImportant ?? this.isImportant,
      createDate: createDate ?? this.createDate,
      stepList: stepList ?? this.stepList,
      dueDate: dueDate ?? this.dueDate,
      remindTime: remindTime ?? this.remindTime,
      repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      filePath: filePath ?? this.filePath,
      note: note ?? this.note,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      themeColor: themeColor ?? this.themeColor,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'isImportant': isImportant});
    result.addAll({'createDate': createDate});
    result.addAll({'stepList': stepList});
    result.addAll({'dueDate': dueDate});
    result.addAll({'remindTime': remindTime});
    result.addAll({'repeatFreaquency': repeatFrequency});
    result.addAll({'filePath': filePath});
    result.addAll({'note': note});
    result.addAll({'backgroundImage': backgroundImage});
    result.addAll({'themeColor': themeColor});
    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '-1',
      title: map['title'] ?? 'title',
      isCompleted: map['isCompleted'] ?? false,
      isImportant: map['isImportant'] ?? false,
      createDate: map['createDate'] ?? DateTime.now(),
      stepList: map['stepList'],
      dueDate: map['dueDate'],
      remindTime: map['remindTime'],
      repeatFrequency: map['repeatFrequency'],
      filePath: map['filePath'],
      note: map['note'],
      backgroundImage: map['backgroundImage'],
      themeColor: map['themeColor'],
    );
  }
}
