import 'package:flutter/material.dart';
import 'package:todo_app/Task/components/incomplete_list.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorder tasks'),
      ),
      body: IncompleteList(taskList: incompleteTask),
    );
  }
}
