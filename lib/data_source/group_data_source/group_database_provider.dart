import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';

abstract class GroupDatabaseProvider {
  List<Group> listenAllGroup({required Function onGroupUpdate});
  Future<Group?> getGroupByID({required String groupID});
  void createGroup({required Group newGroup});
  void deleteGroup({required String groupID});
  void renameGroup({
    required String groupID,
    required String newName,
  });
  void addMultipleTaskListToGroup({
    required String groupID,
    required List<TaskList> addedTaskLists,
  });
  void removeTaskListFromGroup({
    required String groupID,
    required List<String> removedTaskListsID,
  });
}
