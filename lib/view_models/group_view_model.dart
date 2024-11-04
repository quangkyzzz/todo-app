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
    Group newGroup = Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: name,
    );
    //groups.add(newGroup);
    GroupDatabaseService.firebase().createGroup(newGroup: newGroup);
    notifyListeners();
  }

  void createNewTaskListToDefaultGroup({
    required String name,
  }) {
    TaskList newTaskList = TaskList(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupID: '1',
      title: name,
    );
    GroupDatabaseService.firebase().addMultipleTaskListToGroup(
      groupID: '1',
      addedTaskLists: [newTaskList],
    );
    notifyListeners();
  }

  void deleteGroup(Group group) {
    deleteMultipleTaskListFromGroup(group, group.taskLists);
    GroupDatabaseService.firebase().deleteGroup(groupID: group.id);
    notifyListeners();
  }

  void renameGroup(Group group, String newName) {
    GroupDatabaseService.firebase().renameGroup(
      groupID: group.id,
      newName: newName,
    );
    notifyListeners();
  }

  void addMultipleTaskListToGroup({
    required Group group,
    required List<TaskList> movedTaskLists,
  }) {
    List<String> movedTaskListsID = [];
    for (var taskList in movedTaskLists) {
      //readGroupByID(group.id).taskLists.add(taskList);
      //readGroupByID('1').taskLists.remove(taskList);
      taskList.groupID = group.id;
      for (var task in taskList.tasks) {
        task.groupID = group.id;
      }
      movedTaskListsID.add(taskList.id);
    }
    GroupDatabaseService.firebase().addMultipleTaskListToGroup(
      groupID: group.id,
      addedTaskLists: movedTaskLists,
    );
    GroupDatabaseService.firebase().removeTaskListFromGroup(
      groupID: '1',
      removedTaskListsID: movedTaskListsID,
    );

    notifyListeners();
  }

  void deleteMultipleTaskListFromGroup(
    Group group,
    List<TaskList> removedTaskLists,
  ) {
    List<String> removedTaskListsID = [];
    for (var taskList in removedTaskLists) {
      // readGroupByID(group.id).taskLists.remove(taskList);
      // readGroupByID('1').taskLists.add(taskList);
      taskList.groupID = '1';
      for (var task in taskList.tasks) {
        task.groupID = '1';
      }
      removedTaskListsID.add(taskList.id);
    }
    GroupDatabaseService.firebase().addMultipleTaskListToGroup(
      groupID: '1',
      addedTaskLists: removedTaskLists,
    );
    GroupDatabaseService.firebase().removeTaskListFromGroup(
      groupID: group.id,
      removedTaskListsID: removedTaskListsID,
    );

    notifyListeners();
  }
}
