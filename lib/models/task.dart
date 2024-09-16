import 'dart:core';

import 'task_step.dart';

class Task {
  final String id;
  String title;
  bool isCompleted;
  bool isImportant;
  bool isOnMyDay;
  final DateTime createDate;
  List<TaskStep>? stepList;
  DateTime? dueDate;
  DateTime? remindTime;
  String? repeatFrequency;
  List<String>? filePath;
  String? note;

  Task({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.isImportant,
    required this.isOnMyDay,
    required this.createDate,
    this.stepList,
    this.dueDate,
    this.remindTime,
    this.filePath,
    this.repeatFrequency,
    this.note,
  });

  void copyFrom({required Task copyTask}) {
    title = copyTask.title;
    isCompleted = copyTask.isCompleted;
    isImportant = copyTask.isImportant;
    isOnMyDay = copyTask.isOnMyDay;
    stepList = copyTask.stepList;
    dueDate = copyTask.dueDate;
    remindTime = copyTask.remindTime;
    repeatFrequency = copyTask.repeatFrequency;
    filePath = copyTask.filePath;
    note = copyTask.note;
  }

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    bool? isImportant,
    bool? isOnMyDay,
    DateTime? createDate,
    List<TaskStep>? stepList,
    DateTime? dueDate,
    DateTime? remindTime,
    String? repeatFrequency,
    List<String>? filePath,
    String? note,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isImportant: isImportant ?? this.isImportant,
      isOnMyDay: isOnMyDay ?? this.isOnMyDay,
      createDate: createDate ?? this.createDate,
      stepList: stepList ?? this.stepList,
      dueDate: dueDate ?? this.dueDate,
      remindTime: remindTime ?? this.remindTime,
      repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      filePath: filePath ?? this.filePath,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'isImportant': isImportant});
    result.addAll({'isOnMyDay': isOnMyDay});
    result.addAll({'createDate': createDate});
    result.addAll({'stepList': stepList});
    result.addAll({'dueDate': dueDate});
    result.addAll({'remindTime': remindTime});
    result.addAll({'repeatFreaquency': repeatFrequency});
    result.addAll({'filePath': filePath});
    result.addAll({'note': note});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: map['title'] ?? 'Unknown title',
      isCompleted: map['isCompleted'] ?? false,
      isImportant: map['isImportant'] ?? false,
      isOnMyDay: map['isOnMyDay'] ?? false,
      createDate: map['createDate'] ?? DateTime.now(),
      stepList: map['stepList'],
      dueDate: map['dueDate'],
      remindTime: map['remindTime'],
      repeatFrequency: map['repeatFrequency'],
      filePath: map['filePath'],
      note: map['note'],
    );
  }
}