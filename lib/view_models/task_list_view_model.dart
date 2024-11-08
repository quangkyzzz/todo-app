import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data_source/group_data_source/group_database_service.dart';
import 'package:todo_app/data_source/task_data_source/task_database_service.dart';
import 'package:todo_app/data_source/task_list_data_source/task_list_database_service.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/ultility/general_ultility.dart';

class TaskListViewModel extends ChangeNotifier {
  TaskList currentTaskList;
  bool isLoading = false;
  TaskListViewModel({
    required this.currentTaskList,
  }) {
    if (currentTaskList.sortByType != null) {
      sortTaskListBy(
        sortType: currentTaskList.sortByType!,
        isAscending: currentTaskList.isAscending,
      );
    }
  }

  Future<TaskList> getTaskListByID(String taskListID, String groupID) async {
    TaskList result = await TaskListDatabaseService.firebase().getTaskListByID(
      groupID: groupID,
      taskListID: taskListID,
    );
    return result;
  }

  void updateTaskListToDatabase() async {
    TaskListDatabaseService.firebase().updateTaskListToDatabase(
      groupID: currentTaskList.groupID,
      updatedTaskList: currentTaskList,
    );
  }

  void startReloadTaskList() {
    isLoading = true;
    notifyListeners();
  }

  void reloadTaskList() async {
    startReloadTaskList();
    currentTaskList = await TaskListDatabaseService.firebase().getTaskListByID(
      groupID: currentTaskList.groupID,
      taskListID: currentTaskList.id,
    );
    isLoading = false;
    notifyListeners();
  }

  void renameList({
    required String newName,
  }) {
    currentTaskList.title = newName;
    notifyListeners();
  }

  void updateSortType({
    SortType? newSortType,
    bool isAscending = true,
  }) {
    currentTaskList.sortByType = newSortType;
    currentTaskList.isAscending = isAscending;
    notifyListeners();
  }

  void updateIsCompleted({required Task task, required bool isCompleted}) {
    currentTaskList.tasks
        .firstWhere((element) => element.id == task.id)
        .isCompleted = isCompleted;
    TaskDatabaseService.firebase().updateIsCompleted(
      groupID: task.groupID,
      taskListID: task.taskListID,
      taskID: task.id,
      isCompleted: isCompleted,
    );
    notifyListeners();
  }

  void updateIsImportant({
    required Task task,
    required bool isImportant,
    required bool isMoveStarTaskToTop,
  }) {
    if ((isMoveStarTaskToTop) && (isImportant)) {
      currentTaskList.tasks.remove(task);
      currentTaskList.tasks.insert(0, task);
    }
    currentTaskList.tasks
        .firstWhere((element) => element.id == task.id)
        .isImportant = isImportant;
    TaskDatabaseService.firebase().updateIsImportant(
      groupID: task.groupID,
      taskListID: task.taskListID,
      taskID: task.id,
      isImportant: isImportant,
    );
    notifyListeners();
  }

  void updateBackGroundImage({
    required String? backGroundImage,
    required int defaultImage,
  }) {
    currentTaskList.backgroundImage = backGroundImage;
    currentTaskList.defaultImage = defaultImage;
    notifyListeners();
  }

  void updateThemeColor({
    required Color themeColor,
  }) {
    currentTaskList.themeColor = themeColor;
    notifyListeners();
  }

  void sortTaskListBy({
    required SortType sortType,
    required bool isAscending,
  }) {
    int asc = (isAscending) ? 1 : -1;
    switch (sortType) {
      case SortType.important:
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
      case SortType.dueDate:
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
      case SortType.myDay:
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
      case SortType.alphabetically:
        currentTaskList.tasks.sort((a, b) {
          return a.title.toLowerCase().compareTo(b.title.toLowerCase()) * asc;
        });
      case SortType.createDate:
        currentTaskList.tasks.sort((a, b) {
          return a.createDate.compareTo(b.createDate) * asc;
        });
    }
    notifyListeners();
  }

  void addMultipleTask({required List<Task> tasks}) {
    currentTaskList.tasks.addAll(tasks);
    notifyListeners();
  }

  void createNewTask({
    required String id,
    required String taskName,
    required bool isCompleted,
    required bool isAddNewTaskOnTop,
    bool isOnMyDay = false,
    bool isImportant = false,
    DateTime? dueDate,
    DateTime? remindTime,
    Frequency? repeatFrequency,
    int? frequencyMultiplier,
  }) {
    Task task = Task(
      id: id,
      groupID: currentTaskList.groupID,
      taskListID:
          (int.parse(currentTaskList.id) < 10) ? '1' : currentTaskList.id,
      title: taskName,
      isCompleted: isCompleted,
      isImportant: isImportant,
      isOnMyDay: isOnMyDay,
      createDate: DateTime.now(),
      dueDate: dueDate,
      remindTime: remindTime,
      repeatFrequency: repeatFrequency,
      frequencyMultiplier: frequencyMultiplier ?? 1,
    );
    if (isAddNewTaskOnTop) {
      currentTaskList.tasks.insert(0, task);
    } else {
      currentTaskList.tasks.add(task);
    }
    TaskListDatabaseService.firebase().addMultipleTask(
      groupID: task.groupID,
      taskListID: task.taskListID,
      addTasks: [task],
    );
    notifyListeners();
  }

  void reorderTaskUp({required movedTask}) {
    int indexMovedTask = currentTaskList.tasks.indexOf(movedTask);
    int indexDestinyTask = 0;
    for (var i = indexMovedTask - 1; i >= 0; i--) {
      if (!currentTaskList.tasks[i].isCompleted) {
        indexDestinyTask = i;
        break;
      }
    }
    currentTaskList.tasks.swap(indexMovedTask, indexDestinyTask);
    notifyListeners();
  }

  void reorderTaskDown({required movedTask}) {
    int indexMovedTask = currentTaskList.tasks.indexOf(movedTask);
    int indexDestinyTask = 0;
    for (var i = indexMovedTask + 1; i < currentTaskList.tasks.length; i++) {
      if (!currentTaskList.tasks[i].isCompleted) {
        indexDestinyTask = i;
        break;
      }
    }
    currentTaskList.tasks.swap(indexMovedTask, indexDestinyTask);
    notifyListeners();
  }

  void getOnMyDayTask() async {
    List<Task> allTask = await TaskDatabaseService.firebase().getAllTask();
    List<Task> result = [];
    for (Task task in allTask) {
      if (task.isOnMyDay) result.add(task);
    }
    currentTaskList.tasks = result;
    notifyListeners();
  }

  Future<List<Task>> readRecentNotInMyDayTask() async {
    List<Task> allTask = await TaskDatabaseService.firebase().getAllTask();
    List<Task> result = [];
    for (var task in allTask) {
      DateTime createDate = DateTime(
        task.createDate.year,
        task.createDate.month,
        task.createDate.day,
      );
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      if ((createDate == today) && (!task.isOnMyDay)) {
        result.add(task);
      }
    }
    return result;
  }

  Future<List<Task>> readOlderNotInMyDayTask() async {
    List<Task> allTask = await TaskDatabaseService.firebase().getAllTask();
    List<Task> result = [];
    for (var pair in allTask) {
      DateTime createDate = DateTime(
        pair.createDate.year,
        pair.createDate.month,
        pair.createDate.day,
      );
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      if ((!pair.isOnMyDay) && (createDate.isBefore(today))) {
        result.add(pair);
      }
    }
    return result;
  }

  void getImportantTask() async {
    List<Task> allTask = await TaskDatabaseService.firebase().getAllTask();
    List<Task> result = [];

    for (Task task in allTask) {
      if (task.isImportant) result.add(task);
    }
    currentTaskList.tasks = result;
    notifyListeners();
  }

  void getPlannedTask() async {
    List<Task> allTask = await TaskDatabaseService.firebase().getAllTask();
    List<Task> result = [];

    for (Task task in allTask) {
      if (task.dueDate != null) result.add(task);
    }
    currentTaskList.tasks = result;
    notifyListeners();
  }

  List<Task> readPlannedOverdueTask() {
    List<Task> result = [];
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var task in currentTaskList.tasks) {
      if (task.dueDate != null) {
        Duration diffTime = task.dueDate!.difference(today);
        if (diffTime.inDays < 0) {
          result.add(task);
        }
      }
    }
    return result;
  }

  List<Task> readPlannedTodayTask() {
    List<Task> result = [];
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var task in currentTaskList.tasks) {
      if (task.dueDate != null) {
        Duration diffTime = task.dueDate!.difference(today);
        if (diffTime.inDays == 0) {
          result.add(task);
        }
      }
    }
    return result;
  }

  List<Task> readPlannedTomorrowTask() {
    List<Task> result = [];
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var task in currentTaskList.tasks) {
      if (task.dueDate != null) {
        Duration diffTime = task.dueDate!.difference(today);
        if (diffTime.inDays == 1) {
          result.add(task);
        }
      }
    }
    return result;
  }

  List<Task> readPlannedThisWeekTask() {
    List<Task> result = [];

    for (var task in currentTaskList.tasks) {
      if (task.dueDate != null) {
        if (GeneralUltility.isTheSameWeekAsToday(task.dueDate!)) {
          result.add(task);
        }
      }
    }
    return result;
  }

  List<Task> readPlannedLaterTask() {
    List<Task> result = [];
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var task in currentTaskList.tasks) {
      if (task.dueDate != null) {
        Duration diffTime = task.dueDate!.difference(today);
        if (!(GeneralUltility.isTheSameWeekAsToday(task.dueDate!)) &&
            (diffTime.inDays > 0)) {
          result.add(task);
        }
      }
    }
    return result;
  }

  void getAllTask() async {
    List<Task> allTask = await TaskDatabaseService.firebase().getAllTask();
    currentTaskList.tasks = allTask;
    notifyListeners();
  }

  List<Task> searchTaskByName({
    required String searchName,
    bool isHideCompleted = false,
  }) {
    searchName = searchName.toLowerCase();
    List<Task> result = [];
    if (searchName == '') return result;
    for (var task in currentTaskList.tasks) {
      if (isHideCompleted) {
        if ((task.title.toLowerCase().contains(searchName)) &&
            (!task.isCompleted)) {
          result.add(task);
        }
      } else {
        if (task.title.toLowerCase().contains(searchName)) result.add(task);
      }
    }
    return result;
  }

  void duplicateTaskList() {
    List<Task> newTasks = [];
    String newTaskListID = DateTime.now().millisecondsSinceEpoch.toString();
    for (Task task in currentTaskList.tasks) {
      Task newTask = task.copyWith(
        id: (DateTime.now().millisecondsSinceEpoch +
                currentTaskList.tasks.indexOf(task))
            .toString(),
        groupID: '1',
        taskListID: newTaskListID,
      );
      newTasks.add(newTask);
    }
    TaskList newTaskList = currentTaskList.copyWith(
        id: newTaskListID,
        title: '${currentTaskList.title} copy',
        tasks: newTasks,
        groupID: '1');
    GroupDatabaseService.firebase().addMultipleTaskListToGroup(
      groupID: '1',
      addedTaskLists: [newTaskList],
    );
  }

  void deleteTaskList() {
    TaskListDatabaseService.firebase().deleteTaskList(
      groupID: currentTaskList.groupID,
      taskListID: currentTaskList.id,
    );
  }
}
