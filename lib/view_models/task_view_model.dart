import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  Task currentTask;
  TaskViewModel({required this.currentTask});

  void createTask({
    required String taskListID,
    required String taskName,
    required bool isCompleted,
    bool isOnMyDay = false,
    bool isImportant = false,
  }) {
    // Task task = Task(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   title: taskName,
    //   isCompleted: isCompleted,
    //   isImportant: isImportant,
    //   isOnMyDay: isOnMyDay,
    //   createDate: DateTime.now(),
    // );
    // TaskList? taskList = getTaskList(taskListID: taskListID);
    // if (settingsProvider.settings.isAddNewTaskOnTop) {
    //   taskList.tasks.insert(0, task);
    // } else {
    //   taskList.tasks.add(task);
    // }

    notifyListeners();
  }

  Future<void> updateTask({
    required String taskListID,
    required String taskID,
    required Task newTask,
  }) async {
    // TaskListModel taskList = getTaskList(taskListID: taskListID);
    // TaskModel task = getTask(taskListID: taskListID, taskID: taskID);
    // if (task.title != newTask.title) {
    //   BackGroundService.cancelTaskByID(id: taskID);
    //   if ((newTask.repeatFrequency == null) && (newTask.remindTime != null)) {
    //     BackGroundService.executeScheduleBackGroundTask(
    //       task: newTask,
    //       taskList: taskList,
    //       isPlaySound: settingsProvider.settings.isPlaySoundOnComplete,
    //       remindTime: newTask.remindTime!,
    //     );
    //   } else if (newTask.remindTime != null) {
    //     BackGroundService.executePeriodicBackGroundTask(
    //       task: newTask,
    //       taskList: taskList,
    //       remindTime: newTask.remindTime!,
    //       frequency: newTask.repeatFrequency!,
    //       isPlaySound: settingsProvider.settings.isPlaySoundOnComplete,
    //     );
    //   }
    // }
    // if ((settingsProvider.settings.isMoveStarTaskToTop) &&
    //     (newTask.isImportant) &&
    //     (!task.isImportant)) {
    //   task.copyFrom(copyTask: newTask);
    //   if (task.note == '') task.note = null;
    //   taskList.tasks.remove(task);
    //   taskList.tasks.insert(0, task);
    // } else {
    //   task.copyFrom(copyTask: newTask);
    //   if (task.note == '') task.note = null;
    // }

    notifyListeners();
  }

  void deleteTask() {
    // TaskList? taskList = taskLists.firstWhereOrNull(
    //   (element) => (element.id == taskListID),
    // );
    // if (taskList != null) {
    //   taskList.tasks.removeWhere((element) {
    //     if ((element.id == taskID) && (element.remindTime != null)) {
    //       // ignore: discarded_futures
    //       BackGroundService.cancelTaskByID(id: taskID);
    //     }
    //     return (element.id == taskID);
    //   });
    // }

    notifyListeners();
  }
}
