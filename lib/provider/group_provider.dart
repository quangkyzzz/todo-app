import 'package:flutter/material.dart';
import 'package:todo_app/models/group_model.dart';
import 'package:todo_app/models/task_list_model.dart';

class GroupProvider extends ChangeNotifier {
  List<GroupModel> groups = [
    GroupModel(
      id: '1',
      groupName: 'my group 1',
      taskLists: [
        TaskListModel(
          id: '1',
          listName: 'group 1 list 1',
        ),
        TaskListModel(
          id: '2',
          listName: 'group 1  list 2',
        ),
      ],
    ),
    GroupModel(
      id: '2',
      groupName: 'my group 2',
      taskLists: [
        TaskListModel(
          id: '1',
          listName: 'group 2 list 1',
        ),
        TaskListModel(
          id: '2',
          listName: 'group 2 list 2',
        ),
      ],
    ),
  ];

  void createGroup(String name) {
    groups.add(GroupModel(id: '-1', groupName: name));
    notifyListeners();
  }

  void deleteGroup(String groupID) {
    groups.removeWhere((element) => (element.id == groupID));
    notifyListeners();
  }

  void renameGroup(String groupID, String newName) {
    groups.firstWhere((element) => (element.id == groupID)).groupName = newName;
    notifyListeners();
  }

  void addTaskList(String groupID, List<TaskListModel> taskLists) {
    GroupModel group = groups.firstWhere((element) => (element.id == groupID));
    group.taskLists.addAll(taskLists);
    notifyListeners();
  }

  GroupModel getGroup(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
  }
}
