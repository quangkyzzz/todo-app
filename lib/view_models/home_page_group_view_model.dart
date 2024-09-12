import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/group_model.dart';
import '../models/task_list_model.dart';
import '../models/task_model.dart';
import 'home_page_task_list_view_model.dart';

class HomePageGroupViewModel extends ChangeNotifier {
  BuildContext context;
  HomePageGroupViewModel(this.context);
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
      context
          .read<HomePageTaskListViewModel>()
          .addTaskList(addTaskLists: [taskList]);
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

    for (var taskList in movedTaskLists) {
      context
          .read<HomePageTaskListViewModel>()
          .cutTaskList(taskListID: taskList.id);
      group.taskLists.add(taskList);
    }

    notifyListeners();
  }

  void deleteMultipleTaskListFromGroup(
    String groupID,
    List<TaskListModel> removedTaskLists,
  ) {
    GroupModel group = getGroup(groupID);
    for (var taskList in removedTaskLists) {
      group.taskLists.remove(taskList);
      context
          .read<HomePageTaskListViewModel>()
          .addTaskList(addTaskLists: [taskList]);
    }

    notifyListeners();
  }
}
