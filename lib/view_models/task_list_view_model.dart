import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/task_step.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import '../service/background_service.dart';
import '../themes.dart';

class TaskListViewModel extends ChangeNotifier {
  List<TaskList> taskLists = [
    TaskList(
      id: '1',
      listName: 'Tasks',
      tasks: [
        Task(
          id: '2',
          title: 'few day',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: true,
          createDate: DateTime(2024, 6, 2),
          dueDate: DateTime(2024, 6, 2),
        ),
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
        ),
        Task(
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
    TaskList(
      id: '2',
      listName: 'My Day',
      themeColor: MyTheme.whiteColor,
      backgroundImage: 'assets/backgrounds/bg_my_day.jpg',
      defaultImage: 0,
    ),
    TaskList(id: '3', listName: 'Important', themeColor: MyTheme.pinkColor),
    TaskList(id: '4', listName: 'Planned', themeColor: MyTheme.redColor),
    TaskList(
        id: '5', listName: 'Assigned to me', themeColor: MyTheme.greenColor),
    TaskList(
        id: '6', listName: 'Flagged email', themeColor: MyTheme.orangeColor),
    TaskList(
      id: '222',
      listName: 'personal list 1',
      backgroundImage: '/data/user/0/com.example.todo_app/cache/'
          'file_picker/1723799643254/1000000837.jpg',
      tasks: [
        Task(
            id: '3',
            title: 'few hour',
            isCompleted: false,
            isImportant: false,
            isOnMyDay: true,
            createDate: DateTime(2024, 7, 2, 7),
            note: 'Really long note, long long long'
                'long long long long long long'),
        Task(
          id: '4',
          title: 'recent',
          isCompleted: false,
          isImportant: true,
          isOnMyDay: false,
          createDate: DateTime(2024, 7, 2, 9, 38),
        ),
        Task(
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
  TaskList? currentTaskList;
  TaskListViewModel({this.currentTaskList});
  TaskList readTaskList({
    required String taskListID,
  }) {
    return taskLists.firstWhere((element) => (element.id == taskListID));
  }

  TaskList readTaskListFromGroup({
    required String taskListID,
    required Group group,
  }) {
    return group.taskLists.firstWhere((element) => (element.id == taskListID));
  }

  void createTaskList({
    required String name,
  }) {
    TaskList newTaskList = TaskList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      listName: name,
    );
    taskLists.add(newTaskList);
    notifyListeners();
  }

  void addMultipleTaskList({
    required List<TaskList> addTaskLists,
  }) {
    taskLists.addAll(addTaskLists);
    notifyListeners();
  }

  void deleteTaskList({
    required String taskListID,
  }) {
    TaskList taskList = readTaskList(taskListID: taskListID);
    for (Task task in taskList.tasks) {
      // ignore: unawaited_futures
      BackGroundService.cancelTaskByID(id: task.id);
    }

    taskLists.remove(taskList);
    notifyListeners();
  }

  void deleteMultipleTaskList({
    required List<TaskList> deleteTaskLists,
  }) {
    for (var taskList in deleteTaskLists) {
      deleteTaskList(taskListID: taskList.id);
    }
    notifyListeners();
  }

  void cutTaskList({required String taskListID}) {
    taskLists.removeWhere((element) => (element.id == taskListID));
    notifyListeners();
  }

  void cutMultipleTaskList({required List<TaskList> cutTaskLists}) {
    taskLists.removeWhere((element) => (cutTaskLists.contains(element)));
    notifyListeners();
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
    required TaskList newTaskList,
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
    List<Task>? tasks,
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
    required Task newTask,
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
