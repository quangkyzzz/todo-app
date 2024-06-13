import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/components/incomplete_list.dart';
import 'package:todo_app/Task/components/task_list_item.dart';
import 'package:todo_app/constant/app_configs.dart';

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
      'note': 'xdd',
      'filePath': 'xdd'
    },
    {
      'taskID': '2',
      'title': 'task 2',
      'isCompleted': false,
      'dueDate': DateTime.now(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isExpanded = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 40,
            color: AppConfigs.blueColor,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: IncompleteList(taskList: incompleteTask),
          ),
          ExpansionTile(
            title: const Text(
              'Completed',
              style: TextStyle(
                fontSize: 20,
                color: AppConfigs.blueColor,
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                isExpanded = expanded;
              });
            },
            trailing: Icon(
                isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
            children: [
              IncompleteList(
                taskList: incompleteTask,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
