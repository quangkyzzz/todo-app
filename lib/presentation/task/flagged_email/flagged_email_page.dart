import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/lists/incomplete_list.dart';
import 'package:todo_app/components/popup_menu.dart';

class FlaggedEmailPage extends StatefulWidget {
  const FlaggedEmailPage({super.key});

  @override
  State<FlaggedEmailPage> createState() => _FlaggedEmailPageState();
}

class _FlaggedEmailPageState extends State<FlaggedEmailPage> {
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
            fontSize: 24,
            color: MyTheme.orangeColor,
          ),
        ),
        actions: const [
          PopupMenu(
            toRemove: ['reorder', 'turn_on_suggestions'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ExpansionTile(
          initiallyExpanded: true,
          title: const Text(
            'Flagged this week',
            style: TextStyle(color: MyTheme.orangeColor),
          ),
          children: [
            IncompleteList(taskList: incompleteTask),
          ],
        ),
      ),
    );
  }
}
