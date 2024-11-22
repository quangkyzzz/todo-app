import 'package:flutter/material.dart';
import 'package:todo_app/model/data/group_data_source/group_data_interface.dart';
import 'package:todo_app/model/entity/group.dart';
import 'package:todo_app/model/entity/task_list.dart';

class GroupViewModel extends ChangeNotifier {
  List<Group> groups = [];
  bool isGroupsLoading = true;

  void startListenData() {
    GroupDataInterface.firebase().listenAllGroup(
      onGroupUpdate: (var data) {
        groups = data;
        isGroupsLoading = false;
        notifyListeners();
      },
      onBeginUpdate: () {
        isGroupsLoading = true;
        notifyListeners();
      },
    );
  }

  Group readGroupByID(String groupID) {
    return groups.firstWhere((element) => (element.id == groupID));
  }

  void createGroup(String name) {
    Group newGroup = Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupName: name,
    );
    GroupDataInterface.firebase().createGroup(newGroup: newGroup);
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
    GroupDataInterface.firebase().addMultipleTaskListToGroup(
      groupID: '1',
      addedTaskLists: [newTaskList],
    );
    notifyListeners();
  }

  void deleteGroup(Group group) {
    deleteMultipleTaskListFromGroup(group, group.taskLists);
    GroupDataInterface.firebase().deleteGroup(groupID: group.id);
    notifyListeners();
  }

  void renameGroup(Group group, String newName) {
    GroupDataInterface.firebase().renameGroup(
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
      taskList.groupID = group.id;
      for (var task in taskList.tasks) {
        task.groupID = group.id;
      }
      movedTaskListsID.add(taskList.id);
    }
    GroupDataInterface.firebase().addMultipleTaskListToGroup(
      groupID: group.id,
      addedTaskLists: movedTaskLists,
    );
    GroupDataInterface.firebase().removeTaskListFromGroup(
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
      taskList.groupID = '1';
      for (var task in taskList.tasks) {
        task.groupID = '1';
      }
      removedTaskListsID.add(taskList.id);
    }
    GroupDataInterface.firebase().addMultipleTaskListToGroup(
      groupID: '1',
      addedTaskLists: removedTaskLists,
    );
    GroupDataInterface.firebase().removeTaskListFromGroup(
      groupID: group.id,
      removedTaskListsID: removedTaskListsID,
    );

    notifyListeners();
  }
}
