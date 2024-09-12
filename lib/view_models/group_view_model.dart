import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/task_list.dart';
import '../models/task.dart';
import 'task_list_view_model.dart';

class GroupViewModel extends ChangeNotifier {
  TaskListViewModel taskListViewModel;
  GroupViewModel({required this.taskListViewModel});
  List<Group> groups = [
    Group(
      id: '111',
      groupName: 'my group 1',
      taskLists: [
        TaskList(
          id: '333',
          listName: 'group 1 list 1',
          groupID: '111',
          tasks: [
            Task(
              id: '6',
              title: 'due today',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now(),
            ),
            Task(
              id: '7',
              title: 'due tomorrow',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 1)),
            ),
            Task(
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
        TaskList(
          id: '444',
          listName: 'group 1 list 2',
          groupID: '111',
          tasks: [
            Task(
              id: '9',
              title: 'due next month',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 31)),
            ),
            Task(
              id: '10',
              title: 'due next 2 day',
              isCompleted: false,
              isImportant: false,
              isOnMyDay: false,
              createDate: DateTime.now(),
              dueDate: DateTime.now().add(const Duration(days: 2)),
            ),
            Task(
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
    Group(
      id: '222',
      groupName: 'my group 2',
      taskLists: [
        TaskList(
          id: '555',
          listName: 'group 2 list 1',
          groupID: '222',
          tasks: [
            Task(
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
        TaskList(
          id: '666',
          listName: 'group 2 list 2',
          groupID: '222',
        ),
      ],
    ),
  ];

  Group getGroup(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
  }

  void createGroup(String name) {
    groups.add(Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: name,
    ));
    notifyListeners();
  }

  void deleteGroup(String groupID) {
    Group group = getGroup(groupID);
    for (TaskList taskList in group.taskLists) {
      taskListViewModel.addTaskList(addTaskLists: [taskList]);
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
    required List<TaskList> movedTaskLists,
  }) {
    Group group = getGroup(groupID);

    for (var taskList in movedTaskLists) {
      taskListViewModel.cutTaskList(taskListID: taskList.id);
      group.taskLists.add(taskList);
    }

    notifyListeners();
  }

  void deleteMultipleTaskListFromGroup(
    String groupID,
    List<TaskList> removedTaskLists,
  ) {
    Group group = getGroup(groupID);
    for (var taskList in removedTaskLists) {
      group.taskLists.remove(taskList);
      taskListViewModel.addTaskList(addTaskLists: [taskList]);
    }

    notifyListeners();
  }
}
