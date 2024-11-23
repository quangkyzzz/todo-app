import 'dart:async';
import 'package:todo_app/model/data/group_data_source/firebase_group_database.dart';
import 'package:todo_app/model/data/group_data_source/group_data_template.dart';
import 'package:todo_app/model/entity/group.dart';
import 'package:todo_app/model/entity/task_list.dart';

class GroupDataRepository {
  GroupDataTemplate dataSource;
  GroupDataRepository._internalConstructor(this.dataSource);
  factory GroupDataRepository.initDataSource() {
    return GroupDataRepository._internalConstructor(FirebaseGroupDatabase());
  }
  void addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  }) {
    dataSource.addMultipleTaskListToGroup(
      groupID: groupID,
      addedTaskLists: addedTaskLists,
    );
  }

  void createGroup({required Group newGroup}) {
    dataSource.createGroup(newGroup: newGroup);
  }

  void deleteGroup({required String groupID}) {
    dataSource.deleteGroup(groupID: groupID);
  }

  void listenAllGroup({
    required Function onGroupUpdate,
    required Function onBeginUpdate,
  }) {
    dataSource.listenAllGroup(
      onGroupUpdate: onGroupUpdate,
      onBeginUpdate: onBeginUpdate,
    );
  }

  Future<Group> getGroupByID({required String groupID}) async {
    return dataSource.getGroupByID(groupID: groupID);
  }

  void removeTaskListFromGroup({
    required String groupID,
    required List<String> removedTaskListsID,
  }) {
    dataSource.removeTaskListFromGroup(
      groupID: groupID,
      removedTaskListsID: removedTaskListsID,
    );
  }

  void renameGroup({required String groupID, required String newName}) {
    dataSource.renameGroup(
      groupID: groupID,
      newName: newName,
    );
  }
}
