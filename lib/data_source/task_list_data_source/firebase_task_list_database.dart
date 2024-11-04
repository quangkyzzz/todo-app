import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/data_source/task_list_data_source/task_list_database_provider.dart';
import 'package:todo_app/exception/data_exception.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_list.dart';

class FirebaseTaskListDatabase implements TaskListDatabaseProvider {
  DatabaseReference ref;
  FirebaseTaskListDatabase(this.ref);
  factory FirebaseTaskListDatabase.initRef() {
    final FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://demoz-6f2fd-default-rtdb.asia-southeast1.firebasedatabase.app",
    );
    return FirebaseTaskListDatabase(database.ref('groups'));
  }

  @override
  Future<TaskList> getTaskListByID({
    required String groupID,
    required String taskListID,
  }) async {
    TaskList result;
    DataSnapshot snapshot =
        await ref.child('id$groupID/taskLists/id$taskListID').get();
    if (snapshot.exists) {
      Map resultMap = snapshot.value as Map;
      result = TaskList.fromMap(resultMap);
      return result;
    } else {
      throw DataDoesNotExist();
    }
  }

  @override
  void updateTaskListToDatabase({
    required String groupID,
    required TaskList updatedTaskList,
  }) async {
    await ref
        .child('id$groupID/taskLists/id${updatedTaskList.id}')
        .set(updatedTaskList.toMap());
  }

  @override
  void deleteTaskList({
    required String groupID,
    required String taskListID,
  }) async {
    await ref.child('id$groupID/taskLists/id$taskListID').remove();
  }

  @override
  void addMultipleTask({
    required String groupID,
    required String taskListID,
    required List<Task> addTasks,
  }) async {
    for (Task task in addTasks) {
      await ref
          .child('id$groupID/taskLists/id$taskListID/tasks/id${task.id}')
          .set(task.toMap());
    }
  }

  @override
  void deleteMultipleTask({
    required String groupID,
    required String taskListID,
    required List<String> deleteTaskIDs,
  }) async {
    for (String taskID in deleteTaskIDs) {
      await ref
          .child('id$groupID/taskLists/id$taskListID/tasks/id$taskID')
          .remove();
    }
  }

  @override
  void renameTaskList({
    required String groupID,
    required String taskListID,
    required String newName,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID')
        .update({'title': newName});
  }

  @override
  void updateBackGroundImage({
    required String groupID,
    required String taskListID,
    required String? backGroundImage,
    required int defaultImage,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID')
        .update({'backgroundImage': backGroundImage});
    await ref
        .child('id$groupID/taskLists/id$taskListID')
        .update({'defaultImage': defaultImage});
  }

  @override
  void updateSortType({
    required String taskListID,
    required String groupID,
    required SortType? newSortType,
    bool isAscending = true,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID')
        .update({'sortByType': newSortType});
    await ref
        .child('id$groupID/taskLists/id$taskListID')
        .update({'isAscending': isAscending});
  }

  @override
  void updateThemeColor({
    required String groupID,
    required String taskListID,
    required Color themeColor,
  }) async {
    await ref
        .child('id$groupID/taskLists/id$taskListID')
        .update({'themeColor': themeColor.value});
  }
}
