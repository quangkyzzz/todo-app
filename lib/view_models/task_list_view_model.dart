import 'package:flutter/material.dart';
import '../models/settings.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import '../models/task_step.dart';
import '../service/background_service.dart';
import '../ultility/general_ultility.dart';

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

  TaskList readTaskListByID(String taskListID) {
    return TaskList(id: 'test', listName: 'For test purposse task list');
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
      taskListID: currentTaskList.id,
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
    notifyListeners();
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

  void deleteTask({
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
