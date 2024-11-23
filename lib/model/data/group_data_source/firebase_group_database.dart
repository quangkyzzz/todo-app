// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/model/data/firebase_reference.dart';
import 'package:todo_app/model/data/group_data_source/group_data_template.dart';
import 'package:todo_app/exception/data_exception.dart';
import 'package:todo_app/model/entity/group.dart';
import 'package:todo_app/model/entity/task_list.dart';

class FirebaseGroupDatabase implements GroupDataTemplate {
  DatabaseReference groupsRef = FirebaseReference.getInstance.ref;

  @override
  Future<void> addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  }) async {
    for (TaskList taskList in addedTaskLists) {
      await groupsRef
          .child('id$groupID')
          .child('taskLists')
          .update({'id${taskList.id}': taskList.toMap()});
    }
  }

  @override
  void createGroup({required Group newGroup}) async {
    await groupsRef.child('id${newGroup.id}').set(newGroup.toMap());
  }

  @override
  void deleteGroup({required String groupID}) async {
    await groupsRef.child('id$groupID').remove();
  }

  @override
  void listenAllGroup({
    required Function onGroupUpdate,
    required Function onBeginUpdate,
  }) {
    groupsRef.onValue.listen(
      (DatabaseEvent event) {
        onBeginUpdate();
        List<Group> updateData = [];
        final dataMap = event.snapshot.value as Map;
        dataMap.values.forEach((element) {
          updateData.add(Group.fromMap(element));
        });
        onGroupUpdate(updateData);
      },
    );
  }

  @override
  Future<Group> getGroupByID({required String groupID}) async {
    Group result;
    Map<String, dynamic> resultMap = {};
    final DataSnapshot snapshot = await groupsRef.child('id$groupID').get();
    if (snapshot.exists) {
      var snapshotValue = snapshot.value! as Map;
      snapshotValue.forEach((key, value) {
        resultMap.addAll({
          key.toString(): value,
        });
      });
      result = Group.fromMap(resultMap);
      return result;
    } else {
      throw DataDoesNotExist();
    }
  }

  @override
  void removeTaskListFromGroup({
    required String groupID,
    required List<String> removedTaskListsID,
  }) async {
    for (String taskListID in removedTaskListsID) {
      await groupsRef
          .child('id$groupID')
          .child('taskLists/id$taskListID')
          .remove();
    }
  }

  @override
  void renameGroup({
    required String groupID,
    required String newName,
  }) async {
    await groupsRef.child('id$groupID').update({'groupName': newName});
  }
}
