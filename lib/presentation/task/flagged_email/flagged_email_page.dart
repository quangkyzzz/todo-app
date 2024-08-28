import 'package:flutter/material.dart';
import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../themes.dart';
import '../../lists/incomplete_list.dart';
import '../../components/popup_menu.dart';

class FlaggedEmailPage extends StatefulWidget {
  const FlaggedEmailPage({super.key});

  @override
  State<FlaggedEmailPage> createState() => _FlaggedEmailPageState();
}

class _FlaggedEmailPageState extends State<FlaggedEmailPage> {
  TaskListModel incompleteTask = TaskListModel(
    id: '1',
    listName: 'list1',
    tasks: [
      TaskModel(
        id: '1',
        title: 'task 1',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
      ),
      TaskModel(
        id: '2',
        title: 'task 2',
        isCompleted: false,
        isImportant: false,
        isOnMyDay: false,
        createDate: DateTime.now(),
      ),
    ],
  );
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
        actions: [
          PopupMenu(
            taskList: incompleteTask,
            toRemove: const [
              'rename_list',
              'reorder',
              'turn_on_suggestions',
              'delete_list',
            ],
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
