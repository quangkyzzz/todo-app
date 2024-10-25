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
          .set({taskList.id: taskList.toMap()});
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

  //TODO: test this
  @override
  List<Group> listenAllGroup({required Function onGroupUpdate}) {
    List<Group> data = [];
    groupsRef.onValue.listen((DatabaseEvent event) {
      final dataMap = event.snapshot.value as Map<String, dynamic>;
      data.add(Group.fromMap(dataMap));
      onGroupUpdate(data);
    });
    return data;
  }

  @override
  Future<Group?> getGroupByID({required String groupID}) async {
    Group? result;
    Map<String, dynamic> resultMap;
    final DataSnapshot snapshot = await groupsRef.child(groupID).get();
    if (snapshot.exists) {
      resultMap = snapshot.value as Map<String, dynamic>;
      result = Group.fromMap(resultMap);
    }
    return result;
  }

  @override
  void removeTaskListFromGroup({
    required String groupID,
    required List<TaskList> removedTaskLists,
  }) async {
    for (TaskList taskList in removedTaskLists) {
      await groupsRef.child(groupID).child('taskLists/${taskList.id}').remove();
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
