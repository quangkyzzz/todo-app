import 'dart:async';
import 'package:todo_app/model/entity/group.dart';
import 'package:todo_app/model/entity/task_list.dart';

//TODO: fix all interface to process all kind all database
abstract interface class GroupDatabaseAbstract {
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
