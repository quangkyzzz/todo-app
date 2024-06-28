import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class StepModel {
  final String stepID;
  final String stepName;
  final bool isCompleted;

  const StepModel({
    required this.stepID,
    required this.stepName,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'stepID': stepID});
    result.addAll({'stepName': stepName});
    result.addAll({'isCompleted': isCompleted});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      stepID: map['stepID'] ?? '-1',
      stepName: map['stepName'] ?? 'Unknown name',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
