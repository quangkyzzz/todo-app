import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import '../service/background_service.dart';

class TaskListViewModel extends ChangeNotifier {
  TaskList currentTaskList;
  TaskListViewModel({
    required this.currentTaskList,
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
    required String newName,
  }) {
    currentTaskList.listName = newName;
    notifyListeners();
  }

  void updateTaskList({
    required TaskList newTaskList,
  }) {
    currentTaskList.copyFrom(copyTaskList: newTaskList);

    notifyListeners();
  }

  void updateTaskListWith({
    required Settings settings,
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
      Task oldTask = currentTaskList.tasks
          .firstWhere((element) => (element.id == newTask.id));
      if ((settings.isMoveStarTaskToTop) &&
          (newTask.isImportant) &&
          (!oldTask.isImportant)) {
        currentTaskList.tasks.remove(oldTask);
        currentTaskList.tasks.insert(0, newTask);
      } else {
        oldTask.copyFrom(copyTask: newTask);
      }
    }
    notifyListeners();
  }

  void sortTaskListBy({
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
    required String taskName,
    required bool isCompleted,
    required Settings settings,
    bool isOnMyDay = false,
    bool isImportant = false,
    DateTime? dueDate,
    DateTime? remindTime,
    String? repeatFrequency,
  }) {
    Task task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: taskName,
      isCompleted: isCompleted,
      isImportant: isImportant,
      isOnMyDay: isOnMyDay,
      createDate: DateTime.now(),
      dueDate: dueDate,
      remindTime: remindTime,
      repeatFrequency: repeatFrequency,
    );
    if (settings.isAddNewTaskOnTop) {
      currentTaskList.tasks.insert(0, task);
    } else {
      currentTaskList.tasks.add(task);
    }
    if (task.remindTime != null) {
      if (task.repeatFrequency == null) {
        BackGroundService.executeScheduleBackGroundTask(
          task: task,
          taskList: currentTaskList,
          isPlaySound: settings.isPlaySoundOnComplete,
          remindTime: task.remindTime!,
        );
      } else {
        BackGroundService.executePeriodicBackGroundTask(
          task: task,
          taskList: currentTaskList,
          remindTime: task.remindTime!,
          frequency: task.repeatFrequency!,
          isPlaySound: settings.isPlaySoundOnComplete,
        );
      }
    }
    notifyListeners();
  }

  // void deleteTask({
  //   required String taskID,
  // }) {
  //   currentTaskList.tasks.removeWhere((element) {
  //     if ((element.id == taskID) && (element.remindTime != null)) {
  //       // ignore: discarded_futures
  //       BackGroundService.cancelTaskByID(id: taskID);
  //     }
  //     return (element.id == taskID);
  //   });

  //   notifyListeners();
  // }
}
