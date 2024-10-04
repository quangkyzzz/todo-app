import 'package:flutter/material.dart';
import '../models/task.dart';
import '../service/background_service.dart';

class TaskViewModel extends ChangeNotifier {
  Task currentTask;
  bool isLoadingFile = false;
  TaskViewModel({required this.currentTask});

  void updateTask({required updatedTask}) {
    currentTask = updatedTask;
    notifyListeners();
  }

  void deleteTask() {
    if (currentTask.remindTime != null) {
      BackGroundService.cancelTaskByID(id: currentTask.id);
    }
    notifyListeners();
  }

  void changeLoadingFileStatusToFalse() {
    isLoadingFile = false;
    notifyListeners();
  }

  void changeLoadingFileStatusToTrue() {
    isLoadingFile = true;
    notifyListeners();
  }
}
