import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  Task currentTask;
  TaskViewModel({required this.currentTask});

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

    // notifyListeners();
  }
}
