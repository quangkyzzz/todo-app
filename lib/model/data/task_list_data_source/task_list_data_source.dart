import 'dart:ui';
import 'package:todo_app/model/data/task_list_data_source/firebase_task_list_database.dart';
import 'package:todo_app/model/data/task_list_data_source/task_list_database_interface.dart';
import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';

class TaskListDataSource implements TaskListDatabaseInterface {
  final TaskListDatabaseInterface provider;
  TaskListDataSource(this.provider);
  factory TaskListDataSource.firebase() {
    return TaskListDataSource(FirebaseTaskListDatabase());
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
