import 'package:flutter/material.dart';

import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:collection/collection.dart';
import 'package:todo_app/provider/settings_provider.dart';

class TaskListProvider extends ChangeNotifier {
  SettingsProvider settingsProvider;

  TaskListProvider({required this.settingsProvider});

  List<TaskListModel> taskLists = [
    TaskListModel(
      id: '1',
      listName: 'Tasks',
      tasks: [
        TaskModel(
          id: '2',
          title: 'few day',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: true,
          createDate: DateTime(2024, 6, 2),
          dueDate: DateTime(2024, 6, 2),
          repeatFrequency: 'gg',
        ),
        TaskModel(
          id: '1',
          title: 'Tasks',
          isCompleted: false,
          isImportant: false,
          isOnMyDay: false,
          createDate: DateTime(2024, 6, 9),
          stepList: [
            StepModel(
              id: '1',
              stepName: 'step 1',
              isCompleted: false,
            ),
            StepModel(
              id: '2',
              stepName: 'step 2',
              isCompleted: true,
            ),
          ],
          note: 'ntoe dd',
        ),
        TaskModel(
          id: '66',
          title: 'No step',
          isCompleted: false,
          isImportant: false,
          isOnMyDay: true,
          remindTime: DateTime(2024, 9, 1),
          createDate: DateTime(2024, 6, 2),
          dueDate: DateTime(2024, 6, 2),
          repeatFrequency: 'gg',
        ),
      ],
    ),
    TaskListModel(
      id: '2',
      listName: 'personal list 1',
      tasks: [
        TaskModel(
          id: '3',
          title: 'few hour',
          isCompleted: false,
          isImportant: false,
          isOnMyDay: true,
          createDate: DateTime(2024, 7, 2, 7),
        ),
        TaskModel(
          id: '4',
          title: 'recent',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: false,
          createDate: DateTime(2024, 7, 2, 9, 38),
        ),
        TaskModel(
          id: '5',
          title: 'few minute',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: true,
          createDate: DateTime(2024, 7, 2, 9, 30),
        ),
      ],
    ),
    TaskListModel(
      id: 'group 1 list 1',
      listName: 'group 1 list 1',
      groupID: '111',
    ),
    TaskListModel(
      id: 'group 1 list 2',
      listName: 'group 1 list 2',
      groupID: '111',
    ),
    TaskListModel(
      id: 'group 2 list 1',
      listName: 'group 2 list 1',
      groupID: '222',
    ),
    TaskListModel(
      id: 'group 2 list 2',
      listName: 'group 2 list 2',
      groupID: '222',
    ),
  ];

  /////////////////////
  //Task List function
  TaskListModel getTaskList({
    required String taskListID,
  }) {
    return taskLists.firstWhere((element) => (element.id == taskListID));
  }

  void createTaskList({
    required String name,
  }) {
    TaskListModel newTaskList = TaskListModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      listName: name,
    );
    taskLists.add(newTaskList);
    notifyListeners();
  }

  void addTaskList({
    required List<TaskListModel> addTaskLists,
  }) {
    taskLists.addAll(addTaskLists);
    notifyListeners();
  }

  void deleteTaskList({
    required String id,
  }) {
    taskLists.removeWhere((element) => (element.id == id));
    notifyListeners();
  }

  void deleteMultipleTaskList({
    required List<TaskListModel> deleteTaskLists,
  }) {
    taskLists.removeWhere((element) => (deleteTaskLists.contains(element)));
    notifyListeners();
  }

  void moveToGroup({
    required String id,
    required String groupID,
  }) {
    getTaskList(taskListID: id).groupID = groupID;
    notifyListeners();
  }

  void moveFromGroup({
    required String id,
  }) {
    getTaskList(taskListID: id).groupID = null;
    notifyListeners();
  }

  void duplicateTaskList({
    required String taskListID,
  }) {
    TaskListModel originTaskList = getTaskList(taskListID: taskListID);
    List<TaskModel> newTasks = originTaskList.tasks.map((task) {
      return task.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );
    }).toList();
    TaskListModel newTaskList = originTaskList.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      listName: '${originTaskList.listName} copy',
      taskList: newTasks,
    );
    newTaskList.groupID = null;
    taskLists.add(newTaskList);

    notifyListeners();
  }

  void renameList({
    required String taskListID,
    required String newName,
  }) {
    TaskListModel taskList = getTaskList(taskListID: taskListID);
    taskList.listName = newName;
    notifyListeners();
  }

  void updateTaskList({
    required String taskListID,
    required TaskListModel newTaskList,
  }) {
    getTaskList(taskListID: taskListID).copyFrom(copyTaskList: newTaskList);

    notifyListeners();
  }

  ////////////////
  //Task function
  TaskModel getTask({
    required String taskListID,
    required String taskID,
  }) {
    return getTaskList(taskListID: taskListID)
        .tasks
        .firstWhere((element) => (element.id == taskID));
  }

  void createTask({
    required String taskListID,
    required String taskName,
    required bool isCompleted,
    bool isOnMyDay = false,
    bool isImportant = false,
  }) {
    TaskModel task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: taskName,
      isCompleted: isCompleted,
      isImportant: isImportant,
      isOnMyDay: isOnMyDay,
      createDate: DateTime.now(),
    );
    TaskListModel? taskList = getTaskList(taskListID: taskListID);
    if (settingsProvider.settings.isAddNewTaskOnTop) {
      taskList.tasks.insert(0, task);
    } else {
      taskList.tasks.add(task);
    }

    notifyListeners();
  }

  void deleteTask({
    required String taskListID,
    required String taskID,
  }) {
    TaskListModel? taskList = taskLists.firstWhereOrNull(
      (element) => (element.id == taskListID),
    );
    if (taskList != null) {
      taskList.tasks.removeWhere((element) => (element.id == taskID));
    }

    notifyListeners();
  }

  void updateTask({
    required String taskListID,
    required String taskID,
    required TaskModel newTask,
  }) {
    TaskListModel taskList = getTaskList(taskListID: taskListID);
    TaskModel task = getTask(taskListID: taskListID, taskID: taskID);
    if ((settingsProvider.settings.isMoveStarTaskToTop) &&
        (newTask.isImportant) &&
        (!task.isImportant)) {
      task.copyFrom(copyTask: newTask);
      if (task.note == '') task.note = null;
      taskList.tasks.remove(task);
      taskList.tasks.insert(0, task);
    } else {
      task.copyFrom(copyTask: newTask);
      if (task.note == '') task.note = null;
    }

    notifyListeners();
  }

  List<Map<TaskModel, TaskListModel>> getAllTaskWithTaskList() {
    List<Map<TaskModel, TaskListModel>> result = [];
    for (TaskListModel taskList in taskLists) {
      for (TaskModel task in taskList.tasks) {
        result.add({task: taskList});
      }
    }
    return result;
  }

  List<Map<TaskModel, TaskListModel>> searchTaskByName({
    required String searchName,
  }) {
    searchName = searchName.toLowerCase();
    List<Map<TaskModel, TaskListModel>> result = [];
    List<Map<TaskModel, TaskListModel>> all = getAllTaskWithTaskList();
    for (var pair in all) {
      if (pair.keys.first.title.toLowerCase().contains(searchName)) {
        result.add(pair);
      }
    }
    return result;
  }

  List<Map<TaskModel, TaskListModel>> getOnMyDayTask() {
    List<Map<TaskModel, TaskListModel>> result = [];
    List<Map<TaskModel, TaskListModel>> allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.isOnMyDay) {
        result.add(pair);
      }
    }
    return result;
  }

  List<Map<TaskModel, TaskListModel>> getImportantTask() {
    List<Map<TaskModel, TaskListModel>> result = [];
    List<Map<TaskModel, TaskListModel>> allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.isImportant) {
        result.add(pair);
      }
    }
    return result;
  }

  List<Map<TaskModel, TaskListModel>> getPlannedTask() {
    List<Map<TaskModel, TaskListModel>> result = [];
    List<Map<TaskModel, TaskListModel>> allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.dueDate != null) {
        result.add(pair);
      }
    }
    return result;
  }
}
