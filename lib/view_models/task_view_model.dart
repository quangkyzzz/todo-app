import 'package:flutter/material.dart';
import 'package:todo_app/data_source/task_data_source/task_database_service.dart';
import 'package:todo_app/data_source/task_list_data_source/task_list_database_service.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_step.dart';
import 'package:todo_app/models/enum.dart';

class TaskViewModel extends ChangeNotifier {
  Task currentTask;
  bool isLoadingFile = false;
  bool isLoadingTask = false;
  TaskViewModel({required this.currentTask});

  void beginLoad() {
    isLoadingTask = true;
    notifyListeners();
  }

  void reloadTask() async {
    beginLoad();
    currentTask = await TaskDatabaseService.firebase().getTaskByID(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
    );
    isLoadingTask = false;
    notifyListeners();
  }

  void updateTaskTitle({required String newTitle}) {
    currentTask.title = newTitle;
    TaskDatabaseService.firebase().updateTaskTitle(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      newTitle: newTitle,
    );
    notifyListeners();
  }

  void updateIsCompleted({required bool isCompleted}) {
    currentTask.isCompleted = isCompleted;
    TaskDatabaseService.firebase().updateIsCompleted(
        groupID: currentTask.groupID,
        taskListID: currentTask.taskListID,
        taskID: currentTask.id,
        isCompleted: isCompleted);
    notifyListeners();
  }

  void updateIsImportant({required bool isImportant}) {
    currentTask.isImportant = isImportant;
    TaskDatabaseService.firebase().updateIsImportant(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      isImportant: isImportant,
    );
    notifyListeners();
  }

  void updateRemindTime({required DateTime? newRemindTime}) {
    currentTask.remindTime = newRemindTime;
    TaskDatabaseService.firebase().updateRemindTime(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      remindTime: newRemindTime,
    );
    notifyListeners();
  }

  void updateDueDate({required DateTime? newDueDate}) {
    currentTask.dueDate = newDueDate;
    TaskDatabaseService.firebase().updateDueDate(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      dueDate: newDueDate,
    );
    notifyListeners();
  }

  void updateRepeatFrequency({required Frequency? newRepeatFrequency}) {
    currentTask.repeatFrequency = newRepeatFrequency;
    TaskDatabaseService.firebase().updateRepeatFrequency(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      repeatFrequency: newRepeatFrequency,
    );
    notifyListeners();
  }

  void updateFrequencyMultiplier({required int newFrequencyMultiplier}) {
    currentTask.frequencyMultiplier = newFrequencyMultiplier;
    TaskDatabaseService.firebase().updateFrequencyMultiplier(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      frequencyMultiplier: newFrequencyMultiplier,
    );
    notifyListeners();
  }

  void updateIsOnMyDay({required bool isOnMyDay}) {
    currentTask.isOnMyDay = isOnMyDay;
    TaskDatabaseService.firebase().updateIsOnMyDay(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      isOnMyDay: isOnMyDay,
    );
    notifyListeners();
  }

  void updateNote({required String newNote}) {
    currentTask.note = newNote;
    TaskDatabaseService.firebase().updateNote(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      newNote: newNote,
    );
    notifyListeners();
  }

  void addFile({required List<String> filePath}) {
    currentTask.filePath.addAll(filePath);
    TaskDatabaseService.firebase().addFile(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      filePath: filePath,
    );
    notifyListeners();
  }

  void removeFile({required String removeFile}) {
    currentTask.filePath.remove(removeFile);
    TaskDatabaseService.firebase().removeFile(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      filePath: removeFile,
    );
    notifyListeners();
  }

  void addStep({required String stepName, required bool isCompleted}) {
    TaskStep newStep = TaskStep(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      stepName: stepName,
      isCompleted: isCompleted,
    );
    currentTask.stepList.add(newStep);
    TaskDatabaseService.firebase().addStep(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      newStep: newStep,
    );

    notifyListeners();
  }

  void updateStepName({required String stepID, required String newName}) {
    currentTask.stepList
        .firstWhere((element) => element.id == stepID)
        .stepName = newName;
    TaskDatabaseService.firebase().updateStepName(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      stepID: stepID,
      newName: newName,
    );
    notifyListeners();
  }

  void updateStepIsCompleted({required String stepID, required isCompleted}) {
    currentTask.stepList
        .firstWhere((element) => element.id == stepID)
        .isCompleted = isCompleted;
    TaskDatabaseService.firebase().updateStepIsCompleted(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      stepID: stepID,
      isCompleted: isCompleted,
    );

    notifyListeners();
  }

  void deleteStep({required String stepID}) {
    currentTask.stepList.removeWhere((element) => element.id == stepID);
    TaskDatabaseService.firebase().deleteStep(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      stepID: stepID,
    );
    notifyListeners();
  }

  void promoteToTask({required TaskStep promoteStep}) {
    deleteStep(stepID: promoteStep.id);
    Task newTask = Task(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      title: promoteStep.stepName,
      isCompleted: promoteStep.isCompleted,
      isImportant: false,
      isOnMyDay: false,
    );
    TaskListDatabaseService.firebase().addMultipleTask(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      addTasks: [newTask],
    );
  }

  void changeLoadingFileStatus({required bool isLoading}) {
    isLoadingFile = isLoading;
    notifyListeners();
  }

  void deleteTask() {
    TaskDatabaseService.firebase().deleteTask(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
    );
    notifyListeners();
  }
}
