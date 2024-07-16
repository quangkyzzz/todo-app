import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';

class TaskListProvider extends ChangeNotifier {
  List<TaskListModel> taskLists = [
    TaskListModel(id: '1', listName: 'personal list 1'),
    TaskListModel(id: '2', listName: 'personal list 2'),
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
