import 'dart:async';
import 'package:todo_app/model/data/group_data_source/firebase_group_database.dart';
import 'package:todo_app/model/data/group_data_source/group_database_abstract.dart';
import 'package:todo_app/model/entity/group.dart';
import 'package:todo_app/model/entity/task_list.dart';

class GroupDataInterface implements GroupDatabaseAbstract {
  final GroupDatabaseAbstract provider;
  GroupDataInterface(this.provider);
  factory GroupDataInterface.firebase() {
    return GroupDataInterface(FirebaseGroupDatabase());
  }

  @override
  void addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  }) {
    provider.addMultipleTaskListToGroup(
      groupID: groupID,
      addedTaskLists: addedTaskLists,
    );
  }

  @override
  void createGroup({required Group newGroup}) {
    provider.createGroup(newGroup: newGroup);
  }

  @override
  void deleteGroup({required String groupID}) {
    provider.deleteGroup(groupID: groupID);
  }

  @override
  void listenAllGroup({
    required Function onGroupUpdate,
    required Function onBeginUpdate,
  }) {
    provider.listenAllGroup(
      onGroupUpdate: onGroupUpdate,
      onBeginUpdate: onBeginUpdate,
    );
  }

  @override
  Future<Group> getGroupByID({required String groupID}) async {
    return provider.getGroupByID(groupID: groupID);
  }

  @override
  void removeTaskListFromGroup({
    required String groupID,
    required List<String> removedTaskListsID,
  }) {
    provider.removeTaskListFromGroup(
      groupID: groupID,
      removedTaskListsID: removedTaskListsID,
    );
  }

  @override
  void renameGroup({required String groupID, required String newName}) {
    provider.renameGroup(
      groupID: groupID,
      newName: newName,
    );
  }
}