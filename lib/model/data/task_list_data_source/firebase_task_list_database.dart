import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/model/data/firebase_reference.dart';
import 'package:todo_app/model/data/task_list_data_source/task_list_data_template.dart';
import 'package:todo_app/exception/data_exception.dart';
import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';

class FirebaseTaskListDatabase implements TaskListDataTemplate {
  DatabaseReference ref = FirebaseReference.getInstance.ref;

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
