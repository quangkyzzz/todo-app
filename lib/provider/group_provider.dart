// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/task_list.dart';
import 'task_list_provider.dart';

class GroupProvider extends ChangeNotifier {
  TaskListProvider taskListProvider;
  GroupProvider(this.taskListProvider);
  List<Group> groups = [
    Group(
      id: '111',
      groupName: 'my group 1',
      taskLists: [
        TaskList(
          id: '333',
          listName: 'group 1 list 1',
          groupID: '111',
        ),
        TaskList(
          id: '444',
          listName: 'group 1  list 2',
          groupID: '111',
        ),
      ],
    ),
    Group(
      id: '222',
      groupName: 'my group 2',
      taskLists: [
        TaskList(id: '555', listName: 'group 2 list 1', groupID: '222'),
        TaskList(id: '666', listName: 'group 2 list 2', groupID: '222'),
      ],
    ),
  ];

  //////////////
  //group method
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
    group.taskLists.forEach((element) {
      taskListProvider.moveFromGroup(id: element.id);
    });
    groups.remove(group);
    notifyListeners();
  }

  void renameGroup(String groupID, String newName) {
    groups.firstWhere((element) => (element.id == groupID)).groupName = newName;
    notifyListeners();
  }

  /////////////
  //Task method
  TaskList getTaskList({
    required String groupID,
    required String taskListID,
  }) {
    return taskListProvider.getTaskList(taskListID: taskListID);
  }

  void addTaskList(String groupID, List<TaskList> taskLists) {
    Group group = getGroup(groupID);

    for (var e in taskLists) {
      taskListProvider.moveToGroup(id: e.id, groupID: groupID);
      group.taskLists.add(taskListProvider.getTaskList(taskListID: e.id));
    }

    notifyListeners();
  }

  void deleteMultipleTaskList(String groupID, List<TaskList> taskLists) {
    Group group = getGroup(groupID);
    taskLists.forEach((element) {
      group.taskLists.remove(element);
      taskListProvider.moveFromGroup(id: element.id);
    });

    notifyListeners();
  }

  void deleteTaskListByID({
    required String groupID,
    required String taskListID,
  }) {
    Group group = getGroup(groupID);
    group.taskLists.removeWhere((element) => (element.id == taskListID));

    notifyListeners();
  }

  void renameTaskList({
    required String groupID,
    required taskListID,
    required newName,
  }) {
    TaskList taskList = getTaskList(
      groupID: groupID,
      taskListID: taskListID,
    );
    taskList.listName = newName;

    notifyListeners();
  }
}
