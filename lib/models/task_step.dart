import 'dart:core';

class TaskStep {
  final String id;
  String stepName;
  bool isCompleted;

  TaskStep({
    required this.id,
    required this.stepName,
    required this.isCompleted,
  });

  TaskStep copyWith({
    String? id,
    String? stepName,
    bool? isCompleted,
  }) {
    return TaskStep(
      id: id ?? this.id,
      stepName: stepName ?? this.stepName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  void copyFrom({
    required TaskStep newStep,
  }) {
    stepName = newStep.stepName;
    isCompleted = newStep.isCompleted;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'stepName': stepName});
    result.addAll({'isCompleted': isCompleted});

    return result;
  }

  factory TaskStep.fromMap(Map map) {
    return TaskStep(
      id: map['id'] ?? '-1',
      stepName: map['stepName'] ?? 'Unknown name',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
