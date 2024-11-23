import 'dart:ui';
import 'package:todo_app/model/data/task_list_data_source/firebase_task_list_database.dart';
import 'package:todo_app/model/data/task_list_data_source/task_list_data_template.dart';
import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';

class TaskListDataRepository implements TaskListDataTemplate {
  final TaskListDataTemplate dataSource;
  TaskListDataRepository._internalConstructor(this.dataSource);
  factory TaskListDataRepository.initDataSource() {
    return TaskListDataRepository._internalConstructor(
      FirebaseTaskListDatabase(),
    );
  }

  @override
  Future<TaskList> getTaskListByID({
    required String groupID,
    required String taskListID,
  }) async {
    return await dataSource.getTaskListByID(
      taskListID: taskListID,
      groupID: groupID,
    );
  }

  @override
  void updateTaskListToDatabase({
    required String groupID,
    required TaskList updatedTaskList,
  }) {
    dataSource.updateTaskListToDatabase(
      groupID: groupID,
      updatedTaskList: updatedTaskList,
    );
  }

  @override
  void deleteTaskList({required String groupID, required String taskListID}) {
    dataSource.deleteTaskList(groupID: groupID, taskListID: taskListID);
  }

  @override
  void addMultipleTask({
    required String groupID,
    required String taskListID,
    required List<Task> addTasks,
  }) {
    dataSource.addMultipleTask(
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
    dataSource.deleteMultipleTask(
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
    dataSource.renameTaskList(
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
    dataSource.updateBackGroundImage(
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
    dataSource.updateSortType(
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
    dataSource.updateThemeColor(
      groupID: groupID,
      taskListID: taskListID,
      themeColor: themeColor,
    );
  }
}
