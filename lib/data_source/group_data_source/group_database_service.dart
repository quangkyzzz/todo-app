import 'package:todo_app/data_source/group_data_source/firebase_group_database.dart';
import 'package:todo_app/data_source/group_data_source/group_database_provider.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';

class GroupDatabaseService implements GroupDatabaseProvider {
  final GroupDatabaseProvider provider;
  GroupDatabaseService(this.provider);
  factory GroupDatabaseService.firebase() {
    return GroupDatabaseService(FirebaseGroupDatabase());
  }

  @override
  Future<void> addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  }) async {
    await provider.addMultipleTaskListToGroup(
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
  List<Group> listenAllGroup({required Function onGroupUpdate}) {
    return provider.listenAllGroup(onGroupUpdate: onGroupUpdate);
  }

  @override
  Future<Group?> getGroupByID({required String groupID}) async {
    return provider.getGroupByID(groupID: groupID);
  }

  @override
  void removeTaskListFromGroup({
    required String groupID,
    required List<TaskList> removedTaskLists,
  }) {
    provider.removeTaskListFromGroup(
      groupID: groupID,
      removedTaskLists: removedTaskLists,
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
