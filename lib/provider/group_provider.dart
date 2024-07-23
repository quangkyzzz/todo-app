import 'package:flutter/material.dart';
import 'package:todo_app/models/group_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';

class GroupProvider extends ChangeNotifier {
  TaskListProvider taskListProvider;
  GroupProvider(this.taskListProvider);
  List<GroupModel> groups = [
    GroupModel(
      id: '111',
      groupName: 'my group 1',
      taskLists: [
        TaskListModel(
          id: 'group 1 list 1',
          listName: 'group 1 list 1',
          groupID: '111',
        ),
        TaskListModel(
          id: 'group 1 list 2',
          listName: 'group 1  list 2',
          groupID: '111',
        ),
      ],
    ),
    GroupModel(
      id: '222',
      groupName: 'my group 2',
      taskLists: [
        TaskListModel(
            id: 'group 2 list 1', listName: 'group 2 list 1', groupID: '111'),
        TaskListModel(
            id: 'group 2 list 2', listName: 'group 2 list 2', groupID: '111'),
      ],
    ),
  ];

  GroupModel getGroup(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
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

  void addTaskList(String groupID, List<TaskListModel> taskLists) {
    GroupModel group = getGroup(groupID);

    for (var e in taskLists) {
      taskListProvider.moveToGroup(id: e.id, groupID: groupID);
      group.taskLists.add(taskListProvider.getTaskList(taskListID: e.id));
    }

    notifyListeners();
  }

  void deleteTaskList(String groupID, List<TaskListModel> taskLists) {
    GroupModel group = getGroup(groupID);
    taskLists.forEach((element) {
      group.taskLists.remove(element);
      taskListProvider.moveFromGroup(id: element.id);
    });

    notifyListeners();
  }
}
