import 'package:flutter/material.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';

class TaskListProvider extends ChangeNotifier {
  List<TaskListModel> taskLists = [
    TaskListModel(
      id: '1',
      listName: 'Tasks',
      tasks: [
        TaskModel(
          id: '1',
          title: 'Tasks',
          isCompleted: false,
          isImportant: false,
          createDate: DateTime(2024, 6, 9),
          stepList: [
            StepModel(
              id: '1',
              stepName: 'step 1',
              isCompleted: false,
            ),
            StepModel(
              id: '2',
              stepName: 'step 2',
              isCompleted: true,
            ),
          ],
        ),
        TaskModel(
          id: '2',
          title: 'few day',
          isCompleted: false,
          isImportant: false,
          createDate: DateTime(2024, 6, 2),
          dueDate: DateTime(2024, 6, 2),
          repeatFrequency: 'gg',
        ),
      ],
    ),
    TaskListModel(
      id: '2',
      listName: 'personal list 1',
      tasks: [
        TaskModel(
          id: '3',
          title: 'few hour',
          isCompleted: false,
          isImportant: false,
          createDate: DateTime(2024, 7, 2, 7),
        ),
        TaskModel(
          id: '4',
          title: 'recent',
          isCompleted: false,
          isImportant: false,
          createDate: DateTime(2024, 7, 2, 9, 38),
        ),
        TaskModel(
          id: '5',
          title: 'few minute',
          isCompleted: false,
          isImportant: false,
          createDate: DateTime(2024, 7, 2, 9, 30),
        ),
      ],
    ),
  ];

  void createTaskList(String name) {
    TaskListModel newTaskList = TaskListModel(id: '-1', listName: name);
    taskLists.add(newTaskList);
    notifyListeners();
  }

  void deleteTaskList(String id) {
    taskLists.removeWhere((element) => (element.id == id));
    notifyListeners();
  }

  void renameList(String id, String newName) {
    taskLists.firstWhere((element) => (element.id == id)).listName = newName;
    notifyListeners();
  }
}
