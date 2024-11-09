import 'dart:async';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';

abstract class GroupDatabaseInterface {
  void listenAllGroup({
    required Function onGroupUpdate,
    required Function onBeginUpdate,
  });
  Future<Group> getGroupByID({required String groupID});
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
