import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:todo_app/models/step_model.dart';

@immutable
class TaskModel {
  final String taskID;
  final String title;
  final bool isCompleted;
  final bool isImportant;
  final DateTime createDate;
  final List<StepModel>? step;
  final DateTime? dueDate;
  final DateTime? notiTime;
  final String? notiFrequency;
  final String? filePath;
  final String? note;

  const TaskModel({
    required this.taskID,
    required this.title,
    required this.isCompleted,
    required this.isImportant,
    required this.createDate,
    this.step,
    this.dueDate,
    this.notiTime,
    this.notiFrequency,
    this.filePath,
    this.note,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'taskID': taskID});
    result.addAll({'title': title});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'isImportant': isImportant});
    result.addAll({'createDate': createDate});
    result.addAll({'step': step});
    result.addAll({'dueDate': dueDate});
    result.addAll({'notiTime': notiTime});
    result.addAll({'notiFrequency': notiFrequency});
    result.addAll({'filePath': filePath});
    result.addAll({'note': note});
    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskID: map['taskID'] ?? '-1',
      title: map['title'] ?? 'title',
      isCompleted: map['isCompleted'] ?? false,
      isImportant: map['isImportant'] ?? false,
      createDate: map['createDate'] ?? DateTime.now(),
      step: map['step'],
      dueDate: map['dueDate'],
      notiTime: map['notiTime'],
      notiFrequency: map['notiFrequency'],
      filePath: map['filePath'],
      note: map['note'],
    );
  }
}
