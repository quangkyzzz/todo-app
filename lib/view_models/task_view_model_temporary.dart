import 'package:flutter/material.dart';

import '../models/task.dart';
import '../models/task_list.dart';
import '../ultility/type_def.dart';
import 'group_view_model.dart';
import 'task_list_view_model.dart';

//TODO: continue to fix this
class TaskViewModel extends ChangeNotifier {
  TaskListViewModel taskListViewModel;
  GroupViewModel groupViewModel;
  TaskViewModel({
    required this.groupViewModel,
    required this.taskListViewModel,
  });

  TaskMapList getAllTaskWithTaskList() {
    TaskMapList result = [];
    for (TaskList taskList in taskListViewModel.taskLists) {
      for (Task task in taskList.tasks) {
        result.add({task: taskList});
      }
    }
    return result;
  }

  TaskMapList getOnMyDayTask() {
    TaskMapList result = [];
    TaskMapList allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.isOnMyDay) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList getImportantTask() {
    TaskMapList result = [];
    TaskMapList allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.isImportant) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList getPlannedTask() {
    TaskMapList result = [];
    TaskMapList allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.dueDate != null) {
        result.add(pair);
      }
    }
    return result;
  }
}
