import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/task/task_list/components/task_list_item.dart';

class ReorderPage extends StatefulWidget {
  const ReorderPage({super.key});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
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
    {
      'taskID': '3',
      'title': 'task 3',
      'isCompleted': false,
      'dueDate': DateTime.now(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reorder tasks',
          style: AppConfigs.titleTextStyle,
        ),
      ),
      body: ReorderableListView(
          header: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tap and hold to reorder task',
              style: AppConfigs.itemTextStyle,
            ),
          ),
          children: [
            for (int index = 0; index < incompleteTask.length; index++)
              TaskListItem(
                key: Key('$index'),
                task: TaskModel.fromMap(incompleteTask[index]),
              )
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = incompleteTask.removeAt(oldIndex);
              incompleteTask.insert(newIndex, item);
            });
          }),
    );
  }
}
