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
          listName: 'my list 1',
        ),
        TaskListModel(
          id: '2',
          listName: 'my list 2',
        ),
      ],
    ),
    GroupModel(
      id: '2',
      groupName: 'my group 2',
      taskLists: [
        TaskListModel(
          id: '1',
          listName: 'my list 1',
        ),
        TaskListModel(
          id: '2',
          listName: 'my list 2',
        ),
      ],
    ),
  ];

  void createGroup(String name) {
    groups.add(GroupModel(id: '-1', groupName: name));
    notifyListeners();
  }

  void deleteGroup(String id) {
    groups.removeWhere((element) => (element.id == id));
    notifyListeners();
  }
}
