import 'dart:core';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task_step.dart';

class Task {
  final String id;
  String title;
  String taskListID;
  bool isCompleted;
  bool isImportant;
  bool isOnMyDay;
  final DateTime createDate;
  List<TaskStep> stepList;
  DateTime? dueDate;
  DateTime? remindTime;
  Frequency? repeatFrequency;
  int frequencyMultiplier;
  List<String> filePath;
  String note;

  Task({
    String? id,
    required this.taskListID,
    required this.title,
    required this.isCompleted,
    required this.isImportant,
    required this.isOnMyDay,
    DateTime? createDate,
    List<TaskStep>? stepList,
    this.dueDate,
    this.remindTime,
    List<String>? filePath,
    this.repeatFrequency,
    this.frequencyMultiplier = 1,
    this.note = '',
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createDate = createDate ?? DateTime.now(),
        stepList = stepList ?? [],
        filePath = filePath ?? [];

  void copyFrom({required Task copyTask}) {
    title = copyTask.title;
    isCompleted = copyTask.isCompleted;
    isImportant = copyTask.isImportant;
    isOnMyDay = copyTask.isOnMyDay;
    stepList = copyTask.stepList;
    dueDate = copyTask.dueDate;
    remindTime = copyTask.remindTime;
    repeatFrequency = copyTask.repeatFrequency;
    frequencyMultiplier = copyTask.frequencyMultiplier;
    filePath = copyTask.filePath;
    note = copyTask.note;
  }

  Task copyWith({
    String? id,
    String? taskListID,
    String? title,
    bool? isCompleted,
    bool? isImportant,
    bool? isOnMyDay,
    DateTime? createDate,
    List<TaskStep>? stepList,
    DateTime? dueDate,
    DateTime? remindTime,
    Frequency? repeatFrequency,
    int? frequencyMultiplier,
    List<String>? filePath,
    String? note,
  }) {
    List<TaskStep> newStepList = [];
    if (stepList != null) {
      newStepList = stepList;
    } else {
      for (TaskStep taskStep in this.stepList) {
        newStepList.add(taskStep.copyWith());
      }
    }
    List<String> newFilePath = [];
    if (filePath != null) {
      newFilePath = newFilePath;
    } else {
      for (String file in this.filePath) {
        newFilePath.add(file);
      }
    }
    return Task(
      id: id ?? this.id,
      taskListID: taskListID ?? this.taskListID,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isImportant: isImportant ?? this.isImportant,
      isOnMyDay: isOnMyDay ?? this.isOnMyDay,
      createDate: createDate ?? this.createDate,
      stepList: newStepList,
      dueDate: dueDate ?? this.dueDate,
      remindTime: remindTime ?? this.remindTime,
      repeatFrequency: repeatFrequency ?? this.repeatFrequency,
      frequencyMultiplier: frequencyMultiplier ?? this.frequencyMultiplier,
      filePath: newFilePath,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'taskListID': taskListID});
    result.addAll({'title': title});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'isImportant': isImportant});
    result.addAll({'isOnMyDay': isOnMyDay});
    result.addAll({'createDate': createDate});
    result.addAll({'stepList': stepList});
    result.addAll({'dueDate': dueDate});
    result.addAll({'remindTime': remindTime});
    result.addAll({'repeatFreaquency': repeatFrequency});
    result.addAll({'frequencyMultiplier': frequencyMultiplier});
    result.addAll({'filePath': filePath});
    result.addAll({'note': note});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      taskListID:
          map['taskListID'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: map['title'] ?? 'Unknown title',
      isCompleted: map['isCompleted'] ?? false,
      isImportant: map['isImportant'] ?? false,
      isOnMyDay: map['isOnMyDay'] ?? false,
      createDate: map['createDate'] ?? DateTime.now(),
      stepList: map['stepList'] ?? [],
      dueDate: map['dueDate'],
      remindTime: map['remindTime'],
      repeatFrequency: map['repeatFrequency'],
      frequencyMultiplier: map['frequencyMultiplier'],
      filePath: map['filePath'] ?? [],
      note: map['note'] ?? '',
    );
  }
}
