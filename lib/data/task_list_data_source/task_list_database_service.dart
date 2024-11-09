import 'dart:ui';

import 'package:todo_app/data/task_list_data_source/firebase_task_list_database.dart';
import 'package:todo_app/data/task_list_data_source/task_list_database_provider.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_list.dart';

class TaskListDatabaseService implements TaskListDatabaseInterface {
  final TaskListDatabaseInterface provider;
  TaskListDatabaseService(this.provider);
  factory TaskListDatabaseService.firebase() {
    return TaskListDatabaseService(FirebaseTaskListDatabase.initRef());
  }

  @override
  Future<TaskList> getTaskListByID({
    required String groupID,
    required String taskListID,
  }) async {
    return await provider.getTaskListByID(
      taskListID: taskListID,
      groupID: groupID,
    );
  }

  @override
  void updateTaskListToDatabase({
    required String groupID,
    required TaskList updatedTaskList,
  }) {
    provider.updateTaskListToDatabase(
      groupID: groupID,
      updatedTaskList: updatedTaskList,
    );
  }

  @override
  void deleteTaskList({required String groupID, required String taskListID}) {
    provider.deleteTaskList(groupID: groupID, taskListID: taskListID);
  }

  @override
  void addMultipleTask({
    required String groupID,
    required String taskListID,
    required List<Task> addTasks,
  }) {
    provider.addMultipleTask(
      groupID: groupID,
      taskListID: taskListID,
      addTasks: addTasks,
    );
  }

  @override
  void deleteMultipleTask({
    required String groupID,
    required String taskListID,
    required List<String> deleteTaskIDs,
  }) {
    provider.deleteMultipleTask(
      groupID: groupID,
      taskListID: taskListID,
      deleteTaskIDs: deleteTaskIDs,
    );
  }

  @override
  void renameTaskList({
    required String groupID,
    required String taskListID,
    required String newName,
  }) {
    provider.renameTaskList(
      groupID: groupID,
      taskListID: taskListID,
      newName: newName,
    );
  }

  @override
  void updateBackGroundImage({
    required String groupID,
    required String taskListID,
    required String? backGroundImage,
    required int defaultImage,
  }) {
    provider.updateBackGroundImage(
      groupID: groupID,
      taskListID: taskListID,
      backGroundImage: backGroundImage,
      defaultImage: defaultImage,
    );
  }

  @override
  void updateSortType({
    required String taskListID,
    required String groupID,
    required SortType? newSortType,
    bool isAscending = true,
  }) {
    provider.updateSortType(
      taskListID: taskListID,
      groupID: groupID,
      newSortType: newSortType,
    );
  }

  @override
  void updateThemeColor({
    required String groupID,
    required String taskListID,
    required Color themeColor,
  }) {
    provider.updateThemeColor(
      groupID: groupID,
      taskListID: taskListID,
      themeColor: themeColor,
    );
  }
}
