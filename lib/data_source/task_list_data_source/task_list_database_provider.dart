import 'package:flutter/material.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/task_list.dart';

abstract class TaskListDatabaseProvider {
  void renameTaskList({
    required String groupID,
    required String taskListID,
    required String newName,
  });

  Future<TaskList> getTaskListByID({required String taskListID});

  void updateSortType({
    required String taskListID,
    required String groupID,
    required SortType? newSortType,
    bool isAscending = true,
  });

  void updateIsCompleted({
    required String groupID,
    required String taskListID,
    required bool isCompleted,
  });

  void updateIsImportant({
    required String groupID,
    required String taskListID,
    required bool isImportant,
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
}
