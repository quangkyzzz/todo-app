// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/data_source/group_data_source/group_database_provider.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';

class FirebaseGroupDatabase implements GroupDatabaseProvider {
  late DatabaseReference groupsRef;
  late DatabaseReference taskListsRef;
  FirebaseGroupDatabase() {
    final FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://demoz-6f2fd-default-rtdb.asia-southeast1.firebasedatabase.app",
    );
    groupsRef = database.ref('groups');
    taskListsRef = database.ref('taskLists');
  }

  @override
  Future<void> addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  }) async {
    for (TaskList taskList in addedTaskLists) {
      await groupsRef
          .child(groupID)
          .child('taskLists')
          .update({taskList.id: taskList.toMap()});
    }
  }

  @override
  void createGroup({required Group newGroup}) async {
    await groupsRef.child(newGroup.id).set(newGroup.toMap());
  }

  @override
  void deleteGroup({required String groupID}) async {
    await groupsRef.child(groupID).remove();
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
  Future<Group?> getGroupByID({required String groupID}) async {
    Group? result;
    Map<String, dynamic> resultMap = {};
    final DataSnapshot snapshot = await groupsRef.child(groupID).get();
    if (snapshot.exists) {
      var snapshotValue = snapshot.value! as Map;
      snapshotValue.forEach((key, value) {
        resultMap.addAll({
          key.toString(): value,
        });
      });
      result = Group.fromMap(resultMap);
    }
    return result;
  }

  @override
  void removeTaskListFromGroup({
    required String groupID,
    required List<String> removedTaskListsID,
  }) async {
    for (String taskListID in removedTaskListsID) {
      await groupsRef.child(groupID).child('taskLists/$taskListID').remove();
    }
  }

  @override
  void renameGroup({
    required String groupID,
    required String newName,
  }) async {
    await groupsRef.child(groupID).update({'groupName': newName});
  }
}
