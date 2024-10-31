import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_step.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/ultility/general_ultility.dart';

class TaskListViewModel extends ChangeNotifier {
  TaskList currentTaskList;
  TaskListViewModel({
    required this.currentTaskList,
  });

  void renameList({
    required String newName,
  }) {
    currentTaskList.title = newName;
    notifyListeners();
  }

  TaskList getTaskListByID(String taskListID) {
    return TaskList(id: 'test', title: 'For test purposse task list');
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

  void getOnMyDayTask() {
    List<Task> result = [
      Task(
        id: '2',
        taskListID: '1',
        title: 'few day',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '66',
        taskListID: '1',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '3',
        taskListID: '222',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 7),
        note: 'Really long note, long long long'
            'long long long long long long',
      ),
      Task(
        id: '5',
        taskListID: '222',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      )
    ];

    currentTaskList.tasks = result;
  }

  List<Task> readRecentNotInMyDayTask() {
    List<Task> allTask = [
      Task(
        id: '2',
        title: 'few day',
        taskListID: '1',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '1',
        taskListID: '1',
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
      Task(
        id: '66',
        taskListID: '1',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '3',
        taskListID: '222',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 7),
        note: 'Really long note, long long long'
            'long long long long long long',
      ),
      Task(
        id: '4',
        taskListID: '222',
        title: 'recent',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      ),
      Task(
        id: '5',
        taskListID: '222',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ),
      Task(
        id: '6',
        taskListID: '333',
        title: 'due today',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now(),
      ),
      Task(
        id: '7',
        taskListID: '333',
        title: 'due tomorrow',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ),
      Task(
        id: '8',
        taskListID: '333',
        title: 'due next week',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
      ),
      Task(
        id: '9',
        taskListID: '444',
        title: 'due next month',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 31)),
      ),
      Task(
        id: '10',
        taskListID: '444',
        title: 'due next 2 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ),
      Task(
        id: '11',
        taskListID: '444',
        title: 'due next 3 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 3)),
      ),
      Task(
        id: '12',
        taskListID: '555',
        title: 'due next 4 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 4)),
      ),
    ];
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

  List<Task> readOlderNotInMyDayTask() {
    List<Task> allTask = [
      Task(
        id: '2',
        title: 'few day',
        taskListID: '1',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '1',
        taskListID: '1',
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
      Task(
        id: '66',
        taskListID: '1',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '3',
        taskListID: '222',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 7),
        note: 'Really long note, long long long'
            'long long long long long long',
      ),
      Task(
        id: '4',
        taskListID: '222',
        title: 'recent',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      ),
      Task(
        id: '5',
        taskListID: '222',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ),
      Task(
        id: '6',
        taskListID: '333',
        title: 'due today',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now(),
      ),
      Task(
        id: '7',
        taskListID: '333',
        title: 'due tomorrow',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ),
      Task(
        id: '8',
        taskListID: '333',
        title: 'due next week',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
      ),
      Task(
        id: '9',
        taskListID: '444',
        title: 'due next month',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 31)),
      ),
      Task(
        id: '10',
        taskListID: '444',
        title: 'due next 2 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ),
      Task(
        id: '11',
        taskListID: '444',
        title: 'due next 3 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 3)),
      ),
      Task(
        id: '12',
        taskListID: '555',
        title: 'due next 4 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 4)),
      ),
    ];
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

  void getImportantTask() {
    List<Task> result = [
      Task(
        id: '2',
        taskListID: '1',
        title: 'few day',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '5',
        taskListID: '222',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ),
      Task(
        id: '4',
        taskListID: '222',
        title: 'recent',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      )
    ];
    currentTaskList.tasks = result;
  }

  void getPlannedTask() {
    List<Task> result = [
      Task(
        id: '2',
        taskListID: '1',
        title: 'few day',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '66',
        taskListID: '1',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '6',
        taskListID: '333',
        title: 'due today',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now(),
      ),
      Task(
        id: '7',
        taskListID: '333',
        title: 'due tomorrow',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ),
      Task(
        id: '8',
        taskListID: '333',
        title: 'due next week',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
      ),
      Task(
        id: '9',
        taskListID: '444',
        title: 'due next month',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 31)),
      )
    ];
    currentTaskList.tasks = result;
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

  void getAllTask() {
    List<Task> allTask = [
      Task(
        id: '2',
        title: 'few day',
        taskListID: '1',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '1',
        taskListID: '1',
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
      Task(
        id: '66',
        taskListID: '1',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ),
      Task(
        id: '3',
        taskListID: '222',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 7),
        note: 'Really long note, long long long'
            'long long long long long long',
      ),
      Task(
        id: '4',
        taskListID: '222',
        title: 'recent',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      ),
      Task(
        id: '5',
        taskListID: '222',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ),
      Task(
        id: '6',
        taskListID: '333',
        title: 'due today',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now(),
      ),
      Task(
        id: '7',
        taskListID: '333',
        title: 'due tomorrow',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ),
      Task(
        id: '8',
        taskListID: '333',
        title: 'due next week',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
      ),
      Task(
        id: '9',
        taskListID: '444',
        title: 'due next month',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 31)),
      ),
      Task(
        id: '10',
        taskListID: '444',
        title: 'due next 2 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ),
      Task(
        id: '11',
        taskListID: '444',
        title: 'due next 3 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 3)),
      ),
      Task(
        id: '12',
        taskListID: '555',
        title: 'due next 4 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 4)),
      ),
    ];
    currentTaskList.tasks = allTask;
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

  void deleteTask() {}
}
