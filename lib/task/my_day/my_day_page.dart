// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/task/my_day/my_day_floating_buttons.dart';
import 'package:todo_app/reuse_part/completed_list_component.dart';
import 'package:todo_app/reuse_part/incomplete_list_component.dart';
import 'package:todo_app/reuse_part/popup_menu_component.dart';

class MyDayPage extends StatefulWidget {
  const MyDayPage({super.key});

  @override
  State<MyDayPage> createState() => _MyDayPageState();
}

class _MyDayPageState extends State<MyDayPage> {
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppConfigs.backGroundImage,
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Container(
              height: 50,
              width: 300,
              child: RichText(
                text: TextSpan(
                    text: 'My Day',
                    style: AppConfigs.titleTextStyle,
                    children: [
                      TextSpan(
                        text:
                            '\n${DateFormat.MMMMEEEEd('en_US').format(DateTime.now())}',
                        style: AppConfigs.secondaryTitleTextStyle,
                      )
                    ]),
              ),
            ),
            actions: const [
              PopupMenuComponent(
                toRemove: [
                  'reorder',
                  'turn_on_suggestions',
                  'duplicate_list',
                  'hide_completed_tasks',
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              IncompleteListComponent(taskList: incompleteTask),
              CompletedListComponent(taskList: incompleteTask),
            ]),
          ),
          floatingActionButton: const MyDayFloatingButtons(),
        ),
      ],
    );
  }
}
