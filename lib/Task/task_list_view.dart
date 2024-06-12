import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/components/task_list_item.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  List<Map<String, dynamic>> incompleteTask = [
    {
      'taskID': '1',
      'title': 'task 1',
      'isCompleted': false,
    },
    {
      'taskID': '2',
      'title': 'task 2',
      'isCompleted': false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 'menu',
                child: Text('menu'),
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
        itemCount: incompleteTask.length,
        itemBuilder: (BuildContext context, int index) {
          TaskModel task = TaskModel.fromMap(incompleteTask[index]);
          return TaskListItem(
            task: task,
          );
        },
      ),
    );
  }
}
