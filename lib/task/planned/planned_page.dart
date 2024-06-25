import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/reuse_part/add_floating_button_component.dart';
import 'package:todo_app/reuse_part/incomplete_list.dart';
import 'package:todo_app/reuse_part/popup_menu_component.dart';

class PlannedPage extends StatefulWidget {
  const PlannedPage({super.key});

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planned',
          style: TextStyle(
            fontSize: 30,
            color: AppConfigs.redColor,
          ),
        ),
        actions: const [
          PopupMenuComponent(
            toRemove: ['reorder', 'turn_on_suggestions', 'duplicate_list'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            //popup menu
            PopupMenuButton(
              offset: const Offset(0, 50),
              itemBuilder: (BuildContext context) {
                return listPopupMennu.map((item) {
                  return PopupMenuItem(
                    child: PopupItem(
                      text: item['text'],
                      icon: item['icon'],
                      onTap: () {},
                    ),
                  );
                }).toList();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppConfigs.backgroundGreyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.list,
                      size: 30,
                      color: AppConfigs.redColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'All planned',
                      style:
                          TextStyle(fontSize: 20, color: AppConfigs.redColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            //task list
            IncompleteList(taskList: incompleteTask),
          ],
        ),
      ),
      floatingActionButton: AddFloatingButton(),
    );
  }
}
