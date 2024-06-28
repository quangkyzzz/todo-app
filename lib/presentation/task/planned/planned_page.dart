import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class PlannedPage extends StatefulWidget {
  const PlannedPage({super.key});

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
  TaskListModel incompleteTask = TaskListModel(
    listID: '1',
    listName: 'list1',
    taskList: [
      TaskModel(
        taskID: '1',
        title: 'task 1',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
      TaskModel(
        taskID: '2',
        title: 'task 2',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
    ],
  );
  List<Map<String, dynamic>> listPopupMennu = [
    {
      'text': 'Overdue',
      'icon': Icons.event_busy_outlined,
    },
    {
      'text': 'Today',
      'icon': Icons.today_outlined,
    },
    {
      'text': 'Tomorrow',
      'icon': Icons.event_outlined,
    },
    {
      'text': 'This week',
      'icon': Icons.date_range_outlined,
    },
    {
      'text': 'Later',
      'icon': Icons.calendar_month_outlined,
    },
    {
      'text': 'All planned',
      'icon': Icons.event_note_outlined,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planned',
          style: TextStyle(
            fontSize: 24,
            color: MyTheme.redColor,
          ),
        ),
        actions: const [
          PopupMenu(
            toRemove: ['reorder', 'turn_on_suggestions', 'duplicate_list'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            //popup menu
            PopupMenuButton(
              offset: const Offset(0, 48),
              itemBuilder: (BuildContext context) {
                return listPopupMennu.map((item) {
                  return PopupMenuItem(
                    child: PopupItem(
                      text: item['text'],
                      icon: item['icon'],
                    ),
                  );
                }).toList();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyTheme.backgroundGreyColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.list,
                      size: 32,
                      color: MyTheme.redColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'All planned',
                      style: TextStyle(fontSize: 18, color: MyTheme.redColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            //task list
            IncompleteList(taskList: incompleteTask),
          ],
        ),
      ),
      floatingActionButton: const AddFloatingButton(),
    );
  }
}
