import 'package:flutter/material.dart';
import '../models/settings.dart';
import '../models/task.dart';
import '../models/task_list.dart';
import '../models/task_step.dart';

import '../service/background_service.dart';
import '../ultility/general_ultility.dart';
import '../ultility/type_def.dart';

class TaskMapViewModel extends ChangeNotifier {
  TaskMapList allTask = [
    {
      Task(
        id: '2',
        title: 'few day',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ): TaskList(
        id: '1',
        listName: 'Tasks',
      )
    },
    {
      Task(
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
      ): TaskList(
        id: '1',
        listName: 'Tasks',
      )
    },
    {
      Task(
        id: '66',
        title: 'No step',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        remindTime: DateTime(2024, 9, 1),
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
      ): TaskList(
        id: '1',
        listName: 'Tasks',
      )
    },
    {
      Task(
        id: '3',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 7),
        note: 'Really long note, long long long'
            'long long long long long long',
      ): TaskList(
        id: '222',
        listName: 'personal list 1',
        backgroundImage: '/data/user/0/com.example.todo_app/cache/'
            'file_picker/1723799643254/1000000837.jpg',
      )
    },
    {
      Task(
        id: '4',
        title: 'recent',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      ): TaskList(
        id: '222',
        listName: 'personal list 1',
        backgroundImage: '/data/user/0/com.example.todo_app/cache/'
            'file_picker/1723799643254/1000000837.jpg',
      )
    },
    {
      Task(
        id: '5',
        title: 'few minute',
        isCompleted: false,
        isImportant: true,
        isOnMyDay: true,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ): TaskList(
        id: '222',
        listName: 'personal list 1',
        backgroundImage: '/data/user/0/com.example.todo_app/cache/'
            'file_picker/1723799643254/1000000837.jpg',
      )
    },
    {
      Task(
        id: '6',
        title: 'due today',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now(),
      ): TaskList(
        id: '333',
        listName: 'group 1 list 1',
        groupID: '111',
      )
    },
    {
      Task(
        id: '7',
        title: 'due tomorrow',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ): TaskList(
        id: '333',
        listName: 'group 1 list 1',
        groupID: '111',
      )
    },
    {
      Task(
        id: '8',
        title: 'due next week',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
      ): TaskList(
        id: '333',
        listName: 'group 1 list 1',
        groupID: '111',
      )
    },
    {
      Task(
        id: '9',
        title: 'due next month',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 31)),
      ): TaskList(
        id: '444',
        listName: 'group 1 list 2',
        groupID: '111',
      )
    },
    {
      Task(
        id: '10',
        title: 'due next 2 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ): TaskList(
        id: '444',
        listName: 'group 1 list 2',
        groupID: '111',
      )
    },
    {
      Task(
        id: '11',
        title: 'due next 3 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 3)),
      ): TaskList(
        id: '444',
        listName: 'group 1 list 2',
        groupID: '111',
      )
    },
    {
      Task(
        id: '12',
        title: 'due next 4 day',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 4)),
      ): TaskList(
        id: '555',
        listName: 'group 2 list 1',
        groupID: '222',
      )
    },
  ];
  Task readTask({required String taskID}) {
    return allTask
        .firstWhere((element) => (element.keys.first.id == taskID))
        .keys
        .first;
  }

  Map<Task, TaskList> readPair({required String taskID}) {
    return allTask.firstWhere((element) => (element.keys.first.id == taskID));
  }

  void addNewTask({
    required Settings settings,
    required TaskList taskList,
    required String taskName,
    required bool isCompleted,
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
    final pair = {task: taskList};
    if (settings.isAddNewTaskOnTop) {
      allTask.insert(0, pair);
    } else {
      allTask.add(pair);
    }
    if (task.remindTime != null) {
      if (task.repeatFrequency == null) {
        BackGroundService.executeScheduleBackGroundTask(
          task: task,
          taskList: taskList,
          isPlaySound: settings.isPlaySoundOnComplete,
          remindTime: task.remindTime!,
        );
      } else {
        BackGroundService.executePeriodicBackGroundTask(
          task: task,
          taskList: taskList,
          remindTime: task.remindTime!,
          frequency: task.repeatFrequency!,
          isPlaySound: settings.isPlaySoundOnComplete,
        );
      }
    }
    notifyListeners();
  }

  Future<void> updateTask({
    required String taskID,
    required Task newTask,
  }) async {
    Task task = readTask(taskID: taskID);

    task.copyFrom(copyTask: newTask);
    if (task.note == '') task.note = null;

    notifyListeners();
  }

  void updateTaskWith({
    required String taskID,
    required Settings settings,
    String? title,
    bool? isCompleted,
    bool? isImportant,
    bool? isOnMyDay,
    DateTime? createDate,
    List<TaskStep>? stepList,
    DateTime? dueDate,
    DateTime? remindTime,
    String? repeatFrequency,
    List<String>? filePath,
    String? note,
  }) {
    Task task = readTask(taskID: taskID);
    if (note == '') {
      note = null;
    }
    Map<Task, TaskList> pair = readPair(taskID: taskID);

    task.title = title ?? task.title;
    task.isCompleted = isCompleted ?? task.isCompleted;
    task.isImportant = isImportant ?? task.isImportant;
    task.isOnMyDay = isOnMyDay ?? task.isOnMyDay;
    task.stepList = stepList ?? task.stepList;
    task.dueDate = dueDate ?? task.dueDate;
    task.remindTime = remindTime ?? task.remindTime;
    task.repeatFrequency = repeatFrequency ?? task.repeatFrequency;
    task.filePath = filePath ?? task.filePath;
    task.note = note ?? task.note;
    if (settings.isMoveStarTaskToTop) {
      if ((isImportant != null) && (isImportant)) {
        allTask.remove(pair);
        allTask.insert(0, pair);
      }
    }

    notifyListeners();
  }

  TaskMapList readOnMyDayTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.isOnMyDay) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readImportantTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.isImportant) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readPlannedTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.dueDate != null) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readRecentNotInMyDayTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      DateTime createDate = DateTime(
        pair.keys.first.createDate.year,
        pair.keys.first.createDate.month,
        pair.keys.first.createDate.day,
      );
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      if ((createDate == today) && (!pair.keys.first.isOnMyDay)) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readOlderNotInMyDayTask() {
    TaskMapList result = [];
    for (var pair in allTask) {
      DateTime createDate = DateTime(
        pair.keys.first.createDate.year,
        pair.keys.first.createDate.month,
        pair.keys.first.createDate.day,
      );
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      if ((!pair.keys.first.isOnMyDay) && (createDate.isBefore(today))) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readPlannedOverdueTask() {
    TaskMapList result = [];
    TaskMapList plannedTask = readPlannedTask();
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var pair in plannedTask) {
      Duration diffTime = pair.keys.first.dueDate!.difference(today);
      if (diffTime.inDays < 0) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readPlannedTodayTask() {
    TaskMapList result = [];
    TaskMapList plannedTask = readPlannedTask();
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var pair in plannedTask) {
      Duration diffTime = pair.keys.first.dueDate!.difference(today);
      if (diffTime.inDays == 0) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readPlannedTomorrowTask() {
    TaskMapList result = [];
    TaskMapList plannedTask = readPlannedTask();
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var pair in plannedTask) {
      Duration diffTime = pair.keys.first.dueDate!.difference(today);
      if (diffTime.inDays == 1) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readPlannedThisWeekTask() {
    TaskMapList result = [];
    TaskMapList plannedTask = readPlannedTask();

    for (var pair in plannedTask) {
      if (GeneralUltility.isTheSameWeekAsToday(pair.keys.first.dueDate!)) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList readPlannedLaterTask() {
    TaskMapList result = [];
    TaskMapList plannedTask = readPlannedTask();
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    for (var pair in plannedTask) {
      Duration diffTime = pair.keys.first.dueDate!.difference(today);
      if (!(GeneralUltility.isTheSameWeekAsToday(pair.keys.first.dueDate!)) &&
          (diffTime.inDays > 0)) {
        result.add(pair);
      }
    }
    return result;
  }

  TaskMapList searchTaskByName({
    required String searchName,
  }) {
    searchName = searchName.toLowerCase();
    TaskMapList result = [];
    for (var pair in allTask) {
      if (pair.keys.first.title.toLowerCase().contains(searchName)) {
        result.add(pair);
      }
    }
    return result;
  }
}
