import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/data/group_data_source/group_database_provider.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';

class FirebaseGroupDatabase implements GroupDatabaseProvider {
  late DatabaseReference ref;
  FirebaseGroupDatabase() {
    final FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://demoz-6f2fd-default-rtdb.asia-southeast1.firebasedatabase.app",
    );
    ref = database.ref('groups');
  }

  @override
  Future<void> addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  }) async {
    for (TaskList taskList in addedTaskLists) {
      await ref.child(groupID).child('taskLists').set({taskList.id: true});
    }
  }

  @override
  void createGroup({required Group newGroup}) async {
    await ref.child(newGroup.id).set(newGroup.toMap());
  }

  @override
  void deleteGroup({required String groupID}) {
    // TODO: implement deleteGroup
  }

  @override
  List<Group>? getAllGroup() {
    // TODO: implement getAllGroup
    throw UnimplementedError();
  }

  @override
  Group? getGroupByID({required String groupID}) {
    // TODO: implement getGroupByID
    throw UnimplementedError();
  }

  @override
  void removeTaskListFromGroup({
    required String groupID,
    required List<TaskList> removedTaskLists,
  }) {
    // TODO: implement removeTaskListFromGroup
  }

  @override
  void renameGroup({
    required String groupID,
    required String newName,
  }) {
    // TODO: implement renameGroup
  }
}
