import 'package:flutter/material.dart';
import 'package:todo_app/models/group_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';

class GroupProvider extends ChangeNotifier {
  TaskListProvider taskListProvider;
  GroupProvider(this.taskListProvider);
  List<GroupModel> groups = [
    GroupModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: 'my group 1',
      taskLists: [
        TaskListModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          listName: 'group 1 list 1',
        ),
        TaskListModel(
          id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          listName: 'group 1  list 2',
        ),
      ],
    ),
    GroupModel(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      groupName: 'my group 2',
      taskLists: [
        TaskListModel(
          id: (DateTime.now().millisecondsSinceEpoch + 2).toString(),
          listName: 'group 2 list 1',
        ),
        TaskListModel(
          id: (DateTime.now().millisecondsSinceEpoch + 3).toString(),
          listName: 'group 2 list 2',
        ),
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
    taskListProvider.addTaskList(addTaskLists: group.taskLists);
    groups.remove(group);
    notifyListeners();
  }

  void renameGroup(String groupID, String newName) {
    groups.firstWhere((element) => (element.id == groupID)).groupName = newName;
    notifyListeners();
  }

  void addTaskList(String groupID, List<TaskListModel> taskLists) {
    GroupModel group = getGroup(groupID);
    group.taskLists.addAll(taskLists);
    taskListProvider.deleteMultipleTaskList(deleteTaskLists: taskLists);
    notifyListeners();
  }

  void deleteTaskList(String groupID, List<TaskListModel> taskLists) {
    GroupModel group = getGroup(groupID);
    group.taskLists.removeWhere((element) => (taskLists.contains(element)));
    taskListProvider.addTaskList(addTaskLists: taskLists);
    notifyListeners();
  }
}
