import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../models/task.dart';
import '../models/task_list.dart';
import '../models/task_step.dart';
import '../service/background_service.dart';

class TaskViewModel extends ChangeNotifier {
  Task currentTask;
  TaskViewModel({required this.currentTask});

  void updateTaskWith({
    required String taskID,
    required Settings settings,
    required TaskList taskList,
    String? title,
    bool? isCompleted,
    bool? isImportant,
    bool? isOnMyDay,
    List<TaskStep>? stepList,
    DateTime? dueDate,
    DateTime? remindTime,
    String? repeatFrequency,
    List<String>? filePath,
    String? note,
  }) {
    if ((title != null) && (currentTask.title != title)) {
      currentTask.title = title;
      BackGroundService.cancelTaskByID(id: taskID);
      if ((currentTask.repeatFrequency == '') &&
          (currentTask.remindTime != null)) {
        BackGroundService.executeScheduleBackGroundTask(
          task: currentTask,
          taskList: taskList,
          isPlaySound: settings.isPlaySoundOnComplete,
          remindTime: currentTask.remindTime!,
        );
      } else if (remindTime != null) {
        BackGroundService.executePeriodicBackGroundTask(
          task: currentTask,
          taskList: taskList,
          remindTime: remindTime,
          frequency: repeatFrequency!,
          isPlaySound: settings.isPlaySoundOnComplete,
        );
      }
    }
    currentTask.isCompleted = isCompleted ?? currentTask.isCompleted;
    currentTask.isImportant = isImportant ?? currentTask.isImportant;
    currentTask.isOnMyDay = isOnMyDay ?? currentTask.isOnMyDay;
    currentTask.stepList = stepList ?? currentTask.stepList;
    if (dueDate != null) {
      currentTask.dueDate = dueDate;
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      if ((settings.isShowDueToday) &&
          (currentTask.dueDate!.isAtSameMomentAs(today)) &&
          (!currentTask.isOnMyDay)) {
        currentTask.isOnMyDay = true;
      }
    }
    if (remindTime != null) {
      //TODO: fix this with repeat already set
      currentTask.remindTime = remindTime;
      BackGroundService.cancelTaskByID(id: currentTask.id);
      BackGroundService.executeScheduleBackGroundTask(
        task: currentTask,
        taskList: taskList,
        isPlaySound: settings.isPlaySoundOnComplete,
        remindTime: currentTask.remindTime!,
      );
    }
    if (repeatFrequency != null) {
      currentTask.repeatFrequency = repeatFrequency;
      currentTask.remindTime ??= DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        9,
      );
      BackGroundService.cancelTaskByID(id: currentTask.id);
      BackGroundService.executePeriodicBackGroundTask(
        task: currentTask,
        taskList: taskList,
        remindTime: currentTask.remindTime!,
        frequency: repeatFrequency,
        isPlaySound: settings.isPlaySoundOnComplete,
      );
    }
    if (filePath != null) {
      currentTask.filePath ??= [];
      currentTask.filePath!.addAll(filePath);
    }
    currentTask.note = note ?? currentTask.note;

    notifyListeners();
  }

  void updateTaskWithNull({
    required String taskID,
    required TaskList taskList,
    required Settings settings,
    bool dueDate = false,
    bool remindTime = false,
    bool repeatFrequency = false,
    bool filePath = false,
    bool note = false,
  }) {
    if (dueDate) {
      currentTask.dueDate = null;
    }
    if (remindTime) {
      currentTask.remindTime = null;
      BackGroundService.cancelTaskByID(id: currentTask.id);
      currentTask.repeatFrequency = '';
    }
    if (repeatFrequency) {
      currentTask.repeatFrequency = '';
      BackGroundService.cancelTaskByID(id: currentTask.id);
      BackGroundService.executeScheduleBackGroundTask(
        task: currentTask,
        taskList: taskList,
        isPlaySound: settings.isPlaySoundOnComplete,
        remindTime: currentTask.remindTime!,
      );
    }
    if (filePath) currentTask.filePath = null;
    if (note) currentTask.filePath = null;

    notifyListeners();
  }

  void deleteTask() {
    if (currentTask.remindTime != null) {
      BackGroundService.cancelTaskByID(id: currentTask.id);
    }
    notifyListeners();
  }
}
