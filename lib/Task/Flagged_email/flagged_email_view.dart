import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Task/Task_list/components/incomplete_list.dart';
import 'package:todo_app/Task/Task_list/components/task_list_popup_menu.dart';

class FlaggedEmailView extends StatefulWidget {
  const FlaggedEmailView({super.key});

  @override
  State<FlaggedEmailView> createState() => _FlaggedEmailViewState();
}

class _FlaggedEmailViewState extends State<FlaggedEmailView> {
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
        title: const Text(
          'Flagged email',
          style: TextStyle(
            fontSize: 30,
            color: AppConfigs.orangeColor,
          ),
        ),
        actions: const [
          TaskListPopupMenu(
            toRemove: ['reorder', 'turn_on_suggestions'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ExpansionTile(
          initiallyExpanded: true,
          title: const Text(
            'Flagged this week',
            style: TextStyle(color: AppConfigs.orangeColor),
          ),
          children: [
            IncompleteList(taskList: incompleteTask),
          ],
        ),
      ),
    );
  }
}
