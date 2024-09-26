import '../models/task_list.dart';

class TaskListUltility {
  static int countIncompletedTaskByID({required TaskList taskList}) {
    int count = 0;

    for (var task in taskList.tasks) {
      if (!task.isCompleted) count++;
    }
    return count;
  }

  // int countIncompletedMyDayTask() {
  //   int count = 0;
  //   TaskMapList taskList = taskViewModel.readOnMyDayTask();
  //   for (var task in taskList) {
  //     if (!task.keys.first.isCompleted) count++;
  //   }
  //   return count;
  // }

  // int countIncompletedImportantTask() {
  //   int count = 0;
  //   TaskMapList taskList = taskViewModel.readImportantTask();
  //   for (var task in taskList) {
  //     if (!task.keys.first.isCompleted) count++;
  //   }
  //   return count;
  // }

  // int countIncompletedPlannedTask() {
  //   int count = 0;
  //   TaskMapList taskList = taskViewModel.readPlannedTask();
  //   for (var task in taskList) {
  //     if (!task.keys.first.isCompleted) count++;
  //   }
  //   return count;
  // }
}
