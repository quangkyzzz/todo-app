import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class TaskModel {
  final String taskID;
  final String title;
  final bool isCompleted;
  final List<String>? step;
  final DateTime? dueDate;
  final DateTime? notiTime;
  final String? filePath;
  final String? note;

  const TaskModel({
    required this.taskID,
    required this.title,
    required this.isCompleted,
    this.step,
    this.dueDate,
    this.notiTime,
    this.filePath,
    this.note,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'taskID': taskID});
    result.addAll({'title': title});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'step': step});
    result.addAll({'dueDate': dueDate});
    result.addAll({'notiTime': notiTime});
    result.addAll({'filePath': filePath});
    result.addAll({'note': note});
    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskID: map['taskID'],
      title: map['title'] ?? 'title',
      isCompleted: map['isCompleted'] ?? false,
      step: map['step'],
      dueDate: map['dueDate'],
      notiTime: map['notiTime'],
      filePath: map['filePath'],
      note: map['note'],
    );
  }
}
