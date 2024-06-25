import 'package:flutter/material.dart';
import 'package:todo_app/reuse_part/add_floating_button_component.dart';
import 'package:todo_app/reuse_part/incomplete_list.dart';
import 'package:todo_app/reuse_part/popup_menu_component.dart';
import 'package:todo_app/app_configs.dart';

class TaskListPage extends StatefulWidget {
  final bool haveCompletedList;
  const TaskListPage({super.key, this.haveCompletedList = true});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isChecked = false;
  bool isExpanded = true;
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
        title: (widget.haveCompletedList)
            ? const Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 25,
                  color: AppConfigs.blueColor,
                ),
              )
            : const Text(
                'Important',
                style: TextStyle(
                  fontSize: 25,
                  color: AppConfigs.pinkColor,
                ),
              ),
        actions: const [
          PopupMenuComponent(
            toRemove: ['hide_completed_tasks'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          IncompleteList(taskList: incompleteTask),
          (widget.haveCompletedList)
              ? ExpansionTile(
                  initiallyExpanded: true,
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
                  trailing: Icon(isExpanded
                      ? Icons.expand_more
                      : Icons.keyboard_arrow_left),
                  children: [
                    IncompleteList(
                      taskList: incompleteTask,
                    ),
                  ],
                )
              : const SizedBox()
        ]),
      ),
      floatingActionButton: AddFloatingButton(),
    );
  }
}
