// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/task/my_day/my_day_floating_buttons.dart';
import 'package:todo_app/presentation/lists/completed_list.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';

class MyDayPage extends StatefulWidget {
  const MyDayPage({super.key});

  @override
  State<MyDayPage> createState() => _MyDayPageState();
}

class _MyDayPageState extends State<MyDayPage> {
  bool isExpanded = true;
  TaskListModel incompleteTask = TaskListModel(
    id: '1',
    listName: 'list1',
    taskList: [
      TaskModel(
        id: '1',
        title: 'task 1',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
      TaskModel(
        id: '2',
        title: 'task 2',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
    ],
  );
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
              height: 48,
              width: 300,
              child: RichText(
                text: TextSpan(
                    text: 'My Day',
                    style: MyTheme.titleTextStyle,
                    children: [
                      TextSpan(
                        text:
                            '\n${DateFormat.MMMMEEEEd('en_US').format(DateTime.now())}',
                        style: MyTheme.secondaryTitleTextStyle,
                      )
                    ]),
              ),
            ),
            actions: const [
              PopupMenu(
                toRemove: [
                  'rename_list',
                  'reorder',
                  'turn_on_suggestions',
                  'duplicate_list',
                  'hide_completed_tasks',
                  'delete_list'
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              IncompleteList(taskList: incompleteTask),
              CompletedList(taskList: incompleteTask),
            ]),
          ),
          floatingActionButton: const MyDayFloatingButtons(),
        ),
      ],
    );
  }
}
