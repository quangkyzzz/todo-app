import 'package:flutter/material.dart';
import 'package:todo_app/data_source/group_data_source/group_database_service.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';

class GroupViewModel extends ChangeNotifier {
  List<Group> groups = [];
  bool isGroupsLoading = true;
  void onBeginUpdate() {
    isGroupsLoading = true;
    notifyListeners();
  }

  void onGroupUpdate(var data) async {
    groups = data;
    isGroupsLoading = false;
    notifyListeners();
  }

  GroupViewModel() {
    GroupDatabaseService.firebase().listenAllGroup(
      onGroupUpdate: onGroupUpdate,
      onBeginUpdate: onBeginUpdate,
    );
    notifyListeners();
  }

  Group readGroupByID(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
  }

  void createGroup(String name) {
    groups.add(Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: name,
    ));
    notifyListeners();
  }

  void addTaskListToDefaultGroup({
    required String name,
  }) {
    TaskList newTaskList = TaskList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: name,
    );
    groups[0].taskLists.add(newTaskList);
    notifyListeners();
  }

  void deleteGroup(Group group) {
    groups[0].taskLists.addAll(group.taskLists);
    groups.remove(group);
    notifyListeners();
  }

  void renameGroup(Group group, String newName) {
    groups.firstWhere((element) => (element.id == group.id)).groupName =
        newName;

    notifyListeners();
  }

  void addMultipleTaskListToGroup({
    required Group group,
    required List<TaskList> movedTaskLists,
  }) {
    for (var taskList in movedTaskLists) {
      readGroupByID(group.id).taskLists.add(taskList);
      readGroupByID('1').taskLists.remove(taskList);
    }

    notifyListeners();
  }

  void deleteMultipleTaskListFromGroup(
    Group group,
    List<TaskList> removedTaskLists,
  ) {
    for (var taskList in removedTaskLists) {
      readGroupByID(group.id).taskLists.remove(taskList);
      readGroupByID('1').taskLists.add(taskList);
    }

    notifyListeners();
  }
}
