import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/components/task_list_item.dart';

class ReOrderView extends StatefulWidget {
  const ReOrderView({super.key});

  @override
  State<ReOrderView> createState() => _ReOrderViewState();
}

class _ReOrderViewState extends State<ReOrderView> {
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
        title: const Text('Reorder tasks'),
      ),
      body: ReorderableListView(
          header: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tap and hold to reorder task',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
