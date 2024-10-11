import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/task_step.dart';
import '../models/enum.dart';

class TaskViewModel extends ChangeNotifier {
  Task currentTask;
  bool isLoadingFile = false;
  TaskViewModel({required this.currentTask});

  void updateTaskTitle({required String newTitle}) {
    currentTask.title = newTitle;
    notifyListeners();
  }

  void updateIsCompleted({required bool isCompleted}) {
    currentTask.isCompleted = isCompleted;
    notifyListeners();
  }

  void updateIsImportant({required bool isImportant}) {
    currentTask.isImportant = isImportant;
    notifyListeners();
  }

  void updateRemindTime({required DateTime? newRemindTime}) {
    currentTask.remindTime = newRemindTime;
    notifyListeners();
  }

  void updateDueDate({required DateTime? newDueDate}) {
    currentTask.dueDate = newDueDate;
    notifyListeners();
  }

  void updateRepeatFrequency({required Frequency? newRepeatFrequency}) {
    currentTask.repeatFrequency = newRepeatFrequency;
    notifyListeners();
  }

  void updateFrequencyMultiplier({required int newFrequencyMultiplier}) {
    currentTask.frequencyMultiplier = newFrequencyMultiplier;
    notifyListeners();
  }

  void updateIsOnMyDay({required bool isOnMyDay}) {
    currentTask.isOnMyDay = isOnMyDay;
    notifyListeners();
  }

  void updateNote({required String newNote}) {
    currentTask.note = newNote;
    notifyListeners();
  }

  void addFile({required List<String> filePath}) {
    currentTask.filePath.addAll(filePath);
    notifyListeners();
  }

  void removeFile({required String removeFile}) {
    currentTask.filePath.remove(removeFile);
    notifyListeners();
  }

  void addStep({required String stepName, required bool isCompleted}) {
    TaskStep newStep = TaskStep(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      stepName: stepName,
      isCompleted: isCompleted,
    );
    currentTask.stepList.add(newStep);
    notifyListeners();
  }

  void updateStepName({required String stepID, required String newName}) {
    currentTask.stepList
        .firstWhere((element) => element.id == stepID)
        .stepName = newName;

    notifyListeners();
  }

  void updateStepIsCompleted({required String stepID, required isCompleted}) {
    currentTask.stepList
        .firstWhere((element) => element.id == stepID)
        .isCompleted = isCompleted;

    notifyListeners();
  }

  void deleteStep({required String stepID}) {
    currentTask.stepList.removeWhere((element) => element.id == stepID);
    notifyListeners();
  }

  void changeLoadingFileStatus({required bool isLoading}) {
    isLoadingFile = isLoading;
    notifyListeners();
  }

  void deleteTask() {
    notifyListeners();
  }
}
