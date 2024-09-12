import '../models/task_list.dart';
import '../view_models/task_list_view_model.dart';
import 'type_def.dart';

class TaskListUltility {
  final TaskListViewModel taskListViewModel;

  TaskListUltility({required this.taskListViewModel});

  int countIncompletedTaskByID({required String taskListID}) {
    int count = 0;
    TaskList taskList = taskListViewModel.getTaskList(taskListID: taskListID);
    for (var task in taskList.tasks) {
      if (!task.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedMyDayTask() {
    int count = 0;
    TaskMapList taskList = taskListViewModel.getOnMyDayTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedImportantTask() {
    int count = 0;
    TaskMapList taskList = taskListViewModel.getImportantTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedPlannedTask() {
    int count = 0;
    TaskMapList taskList = taskListViewModel.getPlannedTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }
}
