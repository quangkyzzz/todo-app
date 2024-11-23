import 'package:flutter/material.dart';
import 'package:todo_app/model/data/task_data_source/task_data_repository.dart';
import 'package:todo_app/model/data/task_list_data_source/task_list_data_repository.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_step.dart';
import 'package:todo_app/model/entity/enum.dart';

class TaskViewModel extends ChangeNotifier {
  late Task currentTask;
  String currentTaskID;
  String taskListID;
  String groupID;

  bool isLoadingFile = false;
  bool isLoadingTask = true;
  TaskViewModel({
    required this.currentTaskID,
    required this.taskListID,
    required this.groupID,
  });

  void initCurrentTask() async {
    currentTask = await TaskDataRepository.initDataSource().getTaskByID(
      groupID: groupID,
      taskListID: taskListID,
      taskID: currentTaskID,
    );
    isLoadingTask = false;
    notifyListeners();
  }

  void reloadTask() async {
    isLoadingTask = true;
    notifyListeners();
    currentTask = await TaskDataRepository.initDataSource().getTaskByID(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
    );
    isLoadingTask = false;
    notifyListeners();
  }

  void updateTaskTitle({required String newTitle}) {
    currentTask.title = newTitle;
    TaskDataRepository.initDataSource().updateTaskTitle(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      newTitle: newTitle,
    );
    notifyListeners();
  }

  void updateIsCompleted({required bool isCompleted}) {
    currentTask.isCompleted = isCompleted;
    TaskDataRepository.initDataSource().updateIsCompleted(
        groupID: currentTask.groupID,
        taskListID: currentTask.taskListID,
        taskID: currentTask.id,
        isCompleted: isCompleted);
    notifyListeners();
  }

  void updateIsImportant({required bool isImportant}) {
    currentTask.isImportant = isImportant;
    TaskDataRepository.initDataSource().updateIsImportant(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      isImportant: isImportant,
    );
    notifyListeners();
  }

  void updateRemindTime({required DateTime? newRemindTime}) {
    currentTask.remindTime = newRemindTime;
    TaskDataRepository.initDataSource().updateRemindTime(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      remindTime: newRemindTime,
    );
    notifyListeners();
  }

  void updateDueDate({required DateTime? newDueDate}) {
    currentTask.dueDate = newDueDate;
    TaskDataRepository.initDataSource().updateDueDate(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      dueDate: newDueDate,
    );
    notifyListeners();
  }

  void updateRepeatFrequency({required Frequency? newRepeatFrequency}) {
    currentTask.repeatFrequency = newRepeatFrequency;
    TaskDataRepository.initDataSource().updateRepeatFrequency(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      repeatFrequency: newRepeatFrequency,
    );
    notifyListeners();
  }

  void updateFrequencyMultiplier({required int newFrequencyMultiplier}) {
    currentTask.frequencyMultiplier = newFrequencyMultiplier;
    TaskDataRepository.initDataSource().updateFrequencyMultiplier(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      frequencyMultiplier: newFrequencyMultiplier,
    );
    notifyListeners();
  }

  void updateIsOnMyDay({required bool isOnMyDay}) {
    currentTask.isOnMyDay = isOnMyDay;
    TaskDataRepository.initDataSource().updateIsOnMyDay(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      isOnMyDay: isOnMyDay,
    );
    notifyListeners();
  }

  void updateNote({required String newNote}) {
    currentTask.note = newNote;
    TaskDataRepository.initDataSource().updateNote(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      newNote: newNote,
    );
    notifyListeners();
  }

  void addFile({required List<String> filePath}) {
    currentTask.filePath.addAll(filePath);
    TaskDataRepository.initDataSource().addFile(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
      filePath: filePath,
    );
    notifyListeners();
  }

  void removeFile({required String removeFile}) {
    currentTask.filePath.remove(removeFile);
    TaskDataRepository.initDataSource().removeFile(
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
    TaskDataRepository.initDataSource().addStep(
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
    TaskDataRepository.initDataSource().updateStepName(
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
    TaskDataRepository.initDataSource().updateStepIsCompleted(
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
    TaskDataRepository.initDataSource().deleteStep(
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
    TaskDataRepository.initDataSource().createNewTask(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      newTask: newTask,
    );
  }

  void changeLoadingFileStatus({required bool isLoading}) {
    isLoadingFile = isLoading;
    notifyListeners();
  }

  void deleteTask() {
    TaskDataRepository.initDataSource().deleteTask(
      groupID: currentTask.groupID,
      taskListID: currentTask.taskListID,
      taskID: currentTask.id,
    );
    notifyListeners();
  }
}
