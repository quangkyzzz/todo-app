import 'package:flutter/material.dart';
import '../models/group_model.dart';
import '../models/settings_model.dart';
import '../models/step_model.dart';
import '../models/task_list_model.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import '../service/background_service.dart';
import '../themes.dart';

typedef ListTaskMap = List<Map<TaskModel, TaskListModel>>;

class HomePageViewModel extends ChangeNotifier {
  bool isLogin = false;
  SettingsModel settings = SettingsModel(
    isAddNewTaskOnTop: true,
    isMoveStarTaskToTop: true,
    isPlaySoundOnComplete: true,
    isConfirmBeforeDelete: true,
    isShowDueToday: true,
  );
  UserModel currentUser = UserModel(
    id: '1',
    userName: 'Nguyễn Quang',
    userEmail: 'quang.ndt@outlook.com',
  );
  List<GroupModel> groups = [
    GroupModel(
      id: '111',
      groupName: 'my group 1',
      taskLists: [
        TaskListModel(
          id: '333',
          listName: 'group 1 list 1',
          groupID: '111',
          tasks: [
            TaskModel(
              id: '6',
              title: 'due today',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now(),
            ),
            TaskModel(
              id: '7',
              title: 'due tomorrow',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 1)),
            ),
            TaskModel(
              id: '8',
              title: 'due next week',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 7)),
            ),
          ],
        ),
        TaskListModel(
          id: '444',
          listName: 'group 1 list 2',
          groupID: '111',
          tasks: [
            TaskModel(
              id: '9',
              title: 'due next month',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 31)),
            ),
            TaskModel(
              id: '10',
              title: 'due next 2 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 2)),
            ),
            TaskModel(
              id: '11',
              title: 'due next 3 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 3)),
            ),
          ],
        ),
      ],
    ),
    GroupModel(
      id: '222',
      groupName: 'my group 2',
      taskLists: [
        TaskListModel(
          id: '555',
          listName: 'group 2 list 1',
          groupID: '222',
          tasks: [
            TaskModel(
              id: '12',
              title: 'due next 4 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 4)),
            ),
          ],
        ),
        TaskListModel(
          id: '666',
          listName: 'group 2 list 2',
          groupID: '222',
        ),
      ],
    ),
  ];
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

  /////////////
  //Auth method
  bool getIsLoginStatus() {
    return isLogin;
  }

  void updateUserName(String newName) {
    currentUser = currentUser.copyWith(userName: newName);
    notifyListeners();
  }

  void updateUserEmail(String newEmail) {
    currentUser = currentUser.copyWith(userEmail: newEmail);
    notifyListeners();
  }

  void login() {
    isLogin = true;
    notifyListeners();
  }

  void logout() {
    isLogin = false;
    notifyListeners();
  }

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
    required String id,
  }) {
    TaskListModel taskList = getTaskList(taskListID: id);
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

  ListTaskMap getAllTaskWithTaskList() {
    ListTaskMap result = [];
    for (TaskListModel taskList in taskLists) {
      for (TaskModel task in taskList.tasks) {
        result.add({task: taskList});
      }
    }
    return result;
  }

  ListTaskMap getOnMyDayTask() {
    ListTaskMap result = [];
    ListTaskMap allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.isOnMyDay) {
        result.add(pair);
      }
    }
    return result;
  }

  ListTaskMap getImportantTask() {
    ListTaskMap result = [];
    ListTaskMap allTask = getAllTaskWithTaskList();
    for (var pair in allTask) {
      if (pair.keys.first.isImportant) {
        result.add(pair);
      }
    }
    return result;
  }

  ListTaskMap getPlannedTask() {
    ListTaskMap result = [];
    ListTaskMap allTask = getAllTaskWithTaskList();
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
    ListTaskMap taskList = getOnMyDayTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedImportantTask() {
    int count = 0;
    ListTaskMap taskList = getImportantTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  int countIncompletedPlannedTask() {
    int count = 0;
    ListTaskMap taskList = getPlannedTask();
    for (var task in taskList) {
      if (!task.keys.first.isCompleted) count++;
    }
    return count;
  }

  //////////////
  //Group method
  GroupModel getGroup(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
  }

  TaskListModel getTaskListFromGroup(
      {required String taskListID, required String groupID}) {
    GroupModel group = getGroup(groupID);
    return group.taskLists.firstWhere((element) => (element.id == taskListID));
  }

  void createGroup(String name) {
    groups.add(GroupModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: name,
    ));
    notifyListeners();
  }

  void deleteGroup(String groupID) {
    GroupModel group = getGroup(groupID);
    for (TaskListModel taskList in group.taskLists) {
      taskLists.add(taskList);
    }
    groups.remove(group);
    notifyListeners();
  }

  void renameGroup(String groupID, String newName) {
    groups.firstWhere((element) => (element.id == groupID)).groupName = newName;
    notifyListeners();
  }

  void addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskListModel> movedTaskLists,
  }) {
    GroupModel group = getGroup(groupID);

    for (var e in movedTaskLists) {
      taskLists.remove(e);
      group.taskLists.add(e);
    }

    notifyListeners();
  }

  void deleteMultipleTaskListFromGroup(
    String groupID,
    List<TaskListModel> removedTaskLists,
  ) {
    GroupModel group = getGroup(groupID);
    for (var element in removedTaskLists) {
      group.taskLists.remove(element);
      taskLists.add(element);
    }

    notifyListeners();
  }
}
