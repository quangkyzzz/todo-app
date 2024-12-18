import 'package:flutter/material.dart';
import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';

abstract class TaskListDataTemplate {
  Future<TaskList> getTaskListByID({
    required String groupID,
    required String taskListID,
  });

  Future<List<Task>> getAllTask();

  void updateTaskListToDatabase({
    required String groupID,
    required TaskList updatedTaskList,
  });

  void deleteTaskList({
    required String groupID,
    required String taskListID,
  });

  void renameTaskList({
    required String groupID,
    required String taskListID,
    required String newName,
  });

  void updateSortType({
    required String taskListID,
    required String groupID,
    required SortType? newSortType,
    bool isAscending = true,
  });

  void updateBackGroundImage({
    required String groupID,
    required String taskListID,
    required String? backGroundImage,
    required int defaultImage,
  });

  void updateThemeColor({
    required String groupID,
    required String taskListID,
    required Color themeColor,
  });

  void addMultipleTask({
    required String groupID,
    required String taskListID,
    required List<Task> addTasks,
  });

  void deleteMultipleTask({
    required String groupID,
    required String taskListID,
    required List<String> deleteTaskIDs,
  });
}
