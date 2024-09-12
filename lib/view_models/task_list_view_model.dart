import 'package:flutter/material.dart';
import '../models/task_step.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import '../service/background_service.dart';
import '../themes.dart';

typedef TaskMapList = List<Map<TaskModel, TaskListModel>>;

class TaskListViewModel extends ChangeNotifier {
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
        ),
        TaskModel(
          id: '1',
          title: 'Tasks',
          isCompleted: false,
          isImportant: false,
          isOnMyDay: false,
          createDate: DateTime(2024, 6, 9),
          stepList: [
            TaskStep(
              id: '1',
              stepName: 'step 1',
              isCompleted: false,
            ),
            TaskStep(
              id: '2',
              stepName: 'step 2',
              isCompleted: true,
            ),
          ],
          note: 'note',
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
        ),
      ],
    ),
    TaskListModel(
      id: '2',
      listName: 'My Day',
      themeColor: MyTheme.whiteColor,
      backgroundImage: 'assets/backgrounds/bg_my_day.jpg',
      isDefaultImage: 0,
    ),
    TaskListModel(
        id: '3', listName: 'Important', themeColor: MyTheme.pinkColor),
    TaskListModel(id: '4', listName: 'Planned', themeColor: MyTheme.redColor),
    TaskListModel(
        id: '5', listName: 'Assigned to me', themeColor: MyTheme.yellowColor),
    TaskListModel(
        id: '6', listName: 'Flagged email', themeColor: MyTheme.orangeColor),
    TaskListModel(
      id: '222',
      listName: 'personal list 1',
      backgroundImage: '/data/user/0/com.example.todo_app/cache/'
          'file_picker/1723799643254/1000000837.jpg',
      tasks: [
        TaskModel(
            id: '3',
            title: 'few hour',
            isCompleted: false,
            isImportant: false,
            isOnMyDay: true,
            createDate: DateTime(2024, 7, 2, 7),
            note: 'Really long note, long long long'
                'long long long long long long'),
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
  ];

  /////////////////
  //TaskList method
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
    required String taskListID,
  }) {
    TaskListModel taskList = getTaskList(taskListID: taskListID);
    for (TaskModel task in taskList.tasks) {
      // ignore: unawaited_futures
      BackGroundService.cancelTaskByID(id: task.id);
    }

    taskLists.remove(taskList);
    notifyListeners();
  }

  void deleteMultipleTaskList({
    required List<TaskListModel> deleteTaskLists,
  }) {
    taskLists.removeWhere((element) => (deleteTaskLists.contains(element)));
    notifyListeners();
  }

  void cutTaskList({required String taskListID}) {
    taskLists.removeWhere((element) => (element.id == taskListID));
    notifyListeners();
  }

  TaskMapList getAllTaskWithTaskList() {
    TaskMapList result = [];
    for (TaskListModel taskList in taskLists) {
      for (TaskModel task in taskList.tasks) {
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

  int countIncompletedTaskByID({required String taskListID}) {
    int count = 0;
    TaskListModel taskList = getTaskList(taskListID: taskListID);
    for (var task in taskList.tasks) {
      if (!task.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedMyDayTask() {
    int count = 0;
    TaskMapList taskList = getOnMyDayTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedImportantTask() {
    int count = 0;
    TaskMapList taskList = getImportantTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedPlannedTask() {
    int count = 0;
    TaskMapList taskList = getPlannedTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }
}
