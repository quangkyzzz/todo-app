import 'package:flutter/material.dart';
import '../models/settings.dart';
import '../models/task_list.dart';
import '../models/task.dart';

//TODO: impliment all function
class TempTaskListViewModel extends ChangeNotifier {
  TaskListModel taskList;
  Settings settings = Settings(
    isAddNewTaskOnTop: true,
    isMoveStarTaskToTop: true,
    isPlaySoundOnComplete: true,
    isConfirmBeforeDelete: true,
    isShowDueToday: true,
  );

  TempTaskListViewModel({required this.taskList});

  void deleteTaskList({
    required String id,
  }) {
    // TaskListModel taskList = getTaskList(taskListID: id);
    // for (TaskModel task in taskList.tasks) {
    //   // ignore: unawaited_futures
    //   BackGroundService.cancelTaskByID(id: task.id);
    // }

    // taskLists.remove(taskList);
    // notifyListeners();
  }

  void deleteMultipleTaskList({
    required List<TaskListModel> deleteTaskLists,
  }) {
    // taskLists.removeWhere((element) => (deleteTaskLists.contains(element)));
    // notifyListeners();
  }

  void moveToGroup({
    required String id,
    required String groupID,
  }) {
    // getTaskList(taskListID: id).groupID = groupID;
    // notifyListeners();
  }

  void moveFromGroup({
    required String id,
  }) {
    // getTaskList(taskListID: id).groupID = null;
    // notifyListeners();
  }

  void duplicateTaskList({
    required String taskListID,
  }) {
    // TaskListModel originTaskList = getTaskList(taskListID: taskListID);
    // List<TaskModel> newTasks = originTaskList.tasks.map((task) {
    //   TaskModel newTask = task.copyWith(
    //     id: (DateTime.now().millisecondsSinceEpoch + Random().nextInt(500))
    //         .toString(),
    //     createDate: DateTime.now(),
    //   );
    //   newTask.remindTime = null;
    //   newTask.repeatFrequency = null;
    //   return newTask;
    // }).toList();
    // TaskListModel newTaskList = originTaskList.copyWith(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   listName: '${originTaskList.listName} copy',
    //   tasks: newTasks,
    // );
    // newTaskList.sortByType = null;
    // newTaskList.groupID = null;
    // taskLists.add(newTaskList);

    // notifyListeners();
  }

  void renameList({
    required String taskListID,
    required String newName,
  }) {
    // TaskListModel taskList = getTaskList(taskListID: taskListID);
    // taskList.listName = newName;
    // notifyListeners();
  }

  void updateTaskList({
    required String taskListID,
    required TaskListModel newTaskList,
  }) {
    // getTaskList(taskListID: taskListID).copyFrom(copyTaskList: newTaskList);

    // notifyListeners();
  }

  void updateTaskListWith({
    required String taskListID,
    String? listName,
    String? groupID,
    String? backgroundImage,
    int? isDefaultImage,
    Map<String, dynamic>? sortByType,
    List<TaskModel>? tasks,
  }) {
    // TaskListModel taskList = getTaskList(taskListID: taskListID);
    // taskList.listName = listName ?? taskList.listName;
    // taskList.groupID = groupID ?? taskList.groupID;
    // taskList.backgroundImage = backgroundImage ?? taskList.backgroundImage;
    // taskList.isDefaultImage = isDefaultImage ?? taskList.isDefaultImage;
    // taskList.sortByType = sortByType ?? taskList.sortByType;
    // taskList.tasks = tasks ?? taskList.tasks;
  }

  void sortTaskListBy({
    required String taskListID,
    required String sortType,
    required bool isAscending,
  }) {
    // TaskListModel taskList = getTaskList(taskListID: taskListID);
    // int asc = (isAscending) ? 1 : -1;
    // switch (sortType) {
    //   case 'important':
    //     taskList.tasks.sort((a, b) {
    //       if (a.isImportant && !b.isImportant) {
    //         return 1 * asc;
    //       } else if (a.isImportant && b.isImportant) {
    //         return a.createDate.compareTo(b.createDate) * asc;
    //       } else if ((!a.isImportant) && (!b.isImportant)) {
    //         return a.createDate.compareTo(b.createDate) * asc;
    //       } else {
    //         return -1 * asc;
    //       }
    //     });
    //   case 'due date':
    //     taskList.tasks.sort((a, b) {
    //       if ((b.dueDate == null) && (a.dueDate == null)) {
    //         return b.createDate.compareTo(a.createDate) * asc;
    //       } else if ((a.dueDate != null) && (b.dueDate == null)) {
    //         return -1 * asc;
    //       } else if ((a.dueDate == null) && (b.dueDate != null)) {
    //         return 1 * asc;
    //       } else {
    //         return a.dueDate!.compareTo(b.dueDate!) * asc;
    //       }
    //     });
    //   case 'my day':
    //     taskList.tasks.sort((a, b) {
    //       if (a.isOnMyDay && !b.isOnMyDay) {
    //         return 1 * asc;
    //       } else if (a.isOnMyDay && b.isOnMyDay) {
    //         return a.createDate.compareTo(b.createDate) * asc;
    //       } else if ((!a.isOnMyDay) && (!b.isOnMyDay)) {
    //         return a.createDate.compareTo(b.createDate) * asc;
    //       } else {
    //         return -1 * asc;
    //       }
    //     });
    //   case 'alphabetically':
    //     taskList.tasks.sort((a, b) {
    //       return a.title.toLowerCase().compareTo(b.title.toLowerCase()) * asc;
    //     });
    //   case 'create date':
    //     taskList.tasks.sort((a, b) {
    //       return a.createDate.compareTo(b.createDate) * asc;
    //     });
    // }
    // notifyListeners();
  }

  void createTask({
    required String taskListID,
    required String taskName,
    required bool isCompleted,
    bool isOnMyDay = false,
    bool isImportant = false,
  }) {
    // TaskModel task = TaskModel(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   title: taskName,
    //   isCompleted: isCompleted,
    //   isImportant: isImportant,
    //   isOnMyDay: isOnMyDay,
    //   createDate: DateTime.now(),
    // );
    // TaskListModel? taskList = getTaskList(taskListID: taskListID);
    // if (settingsProvider.settings.isAddNewTaskOnTop) {
    //   taskList.tasks.insert(0, task);
    // } else {
    //   taskList.tasks.add(task);
    // }

    // notifyListeners();
  }

  void deleteTask({
    required String taskListID,
    required String taskID,
  }) {
    // TaskListModel? taskList = taskLists.firstWhereOrNull(
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

    // notifyListeners();
  }

  Future<void> updateTask({
    required String taskListID,
    required String taskID,
    required TaskModel newTask,
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
