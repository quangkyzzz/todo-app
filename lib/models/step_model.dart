import 'dart:core';

class StepModel {
  final String id;
  String stepName;
  bool isCompleted;

  StepModel({
    required this.id,
    required this.stepName,
    required this.isCompleted,
  });

  StepModel copyWith({
    String? id,
    String? stepName,
    bool? isCompleted,
  }) {
    return StepModel(
      id: id ?? this.id,
      stepName: stepName ?? this.stepName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'stepName': stepName});
    result.addAll({'isCompleted': isCompleted});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      id: map['id'] ?? '-1',
      stepName: map['stepName'] ?? 'Unknown name',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
