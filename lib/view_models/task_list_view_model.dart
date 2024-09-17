import 'package:flutter/material.dart';

import '../models/task_list.dart';
import '../models/task.dart';
import '../provider/settings_provider.dart';
import '../service/background_service.dart';

class TaskListViewModel extends ChangeNotifier {
  SettingsProvider settingsProvider;
  TaskList currentTaskList;
  TaskListViewModel({
    required this.currentTaskList,
    required this.settingsProvider,
  });

  void deleteTaskList({
    required TaskList taskList,
  }) {
    // TaskList tempTaskList = readTaskList(taskListID: taskList.id);
    // for (Task task in tempTaskList.tasks) {
    //   // ignore: unawaited_futures
    //   BackGroundService.cancelTaskByID(id: task.id);
    // }

    // taskLists.remove(taskList);
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
    currentTaskList.listName = newName;
    notifyListeners();
  }

  void updateTaskList({
    required String taskListID,
    required TaskList newTaskList,
  }) {
    currentTaskList.copyFrom(copyTaskList: newTaskList);

    notifyListeners();
  }

  void updateTaskListWith({
    required String taskListID,
    String? listName,
    String? groupID,
    String? backgroundImage,
    int? defaultImage,
    Map<String, dynamic>? sortByType,
    List<Task>? tasks,
    Task? newTask,
  }) {
    currentTaskList.listName = listName ?? currentTaskList.listName;
    currentTaskList.groupID = groupID ?? currentTaskList.groupID;
    currentTaskList.backgroundImage =
        backgroundImage ?? currentTaskList.backgroundImage;
    currentTaskList.defaultImage = defaultImage ?? currentTaskList.defaultImage;
    currentTaskList.sortByType = sortByType ?? currentTaskList.sortByType;
    currentTaskList.tasks = tasks ?? currentTaskList.tasks;
    if (newTask != null) {
      currentTaskList.tasks
          .firstWhere((element) => (element.id == newTask.id))
          .copyFrom(copyTask: newTask);
    }
    notifyListeners();
  }

  void sortTaskListBy({
    required String taskListID,
    required String sortType,
    required bool isAscending,
  }) {
    int asc = (isAscending) ? 1 : -1;
    switch (sortType) {
      case 'important':
        currentTaskList.tasks.sort((a, b) {
          if (a.isImportant && !b.isImportant) {
            return 1 * asc;
          } else if (a.isImportant && b.isImportant) {
            return a.createDate.compareTo(b.createDate) * asc;
          } else if ((!a.isImportant) && (!b.isImportant)) {
            return a.createDate.compareTo(b.createDate) * asc;
          } else {
            return -1 * asc;
          }
        });
      case 'due date':
        currentTaskList.tasks.sort((a, b) {
          if ((b.dueDate == null) && (a.dueDate == null)) {
            return b.createDate.compareTo(a.createDate) * asc;
          } else if ((a.dueDate != null) && (b.dueDate == null)) {
            return -1 * asc;
          } else if ((a.dueDate == null) && (b.dueDate != null)) {
            return 1 * asc;
          } else {
            return a.dueDate!.compareTo(b.dueDate!) * asc;
          }
        });
      case 'my day':
        currentTaskList.tasks.sort((a, b) {
          if (a.isOnMyDay && !b.isOnMyDay) {
            return 1 * asc;
          } else if (a.isOnMyDay && b.isOnMyDay) {
            return a.createDate.compareTo(b.createDate) * asc;
          } else if ((!a.isOnMyDay) && (!b.isOnMyDay)) {
            return a.createDate.compareTo(b.createDate) * asc;
          } else {
            return -1 * asc;
          }
        });
      case 'alphabetically':
        currentTaskList.tasks.sort((a, b) {
          return a.title.toLowerCase().compareTo(b.title.toLowerCase()) * asc;
        });
      case 'create date':
        currentTaskList.tasks.sort((a, b) {
          return a.createDate.compareTo(b.createDate) * asc;
        });
    }
    notifyListeners();
  }

  void addNewTask({
    required String taskListID,
    required String taskName,
    required bool isCompleted,
    bool isOnMyDay = false,
    bool isImportant = false,
  }) {
    Task task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: taskName,
      isCompleted: isCompleted,
      isImportant: isImportant,
      isOnMyDay: isOnMyDay,
      createDate: DateTime.now(),
    );
    if (settingsProvider.settings.isAddNewTaskOnTop) {
      currentTaskList.tasks.insert(0, task);
    } else {
      currentTaskList.tasks.add(task);
    }

    notifyListeners();
  }

  void deleteTask({
    required String taskListID,
    required String taskID,
  }) {
    currentTaskList.tasks.removeWhere((element) {
      if ((element.id == taskID) && (element.remindTime != null)) {
        // ignore: discarded_futures
        BackGroundService.cancelTaskByID(id: taskID);
      }
      return (element.id == taskID);
    });

    notifyListeners();
  }
}
