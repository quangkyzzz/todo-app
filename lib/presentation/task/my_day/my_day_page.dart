// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../view_models/task_list_view_model.dart';
import '../../lists/completed_list.dart';
import '../../lists/incomplete_list.dart';
import 'my_day_floating_buttons.dart';
import '../../components/task_list_popup_menu.dart';

class MyDayPage extends StatefulWidget {
  const MyDayPage({super.key});

  @override
  State<MyDayPage> createState() => _MyDayPageState();
}

class _MyDayPageState extends State<MyDayPage> {
  late TaskList myDayTaskList;
  @override
  void initState() {
    context.read<TaskListViewModel>().getOnMyDayTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myDayTaskList = context.watch<TaskListViewModel>().currentTaskList;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (myDayTaskList.backgroundImage != null)
          (myDayTaskList.defaultImage == -1)
              ? Image.file(
                  File(myDayTaskList.backgroundImage!),
                  fit: BoxFit.fitHeight,
                )
              : Image.asset(
                  myDayTaskList.backgroundImage!,
                  fit: BoxFit.fitHeight,
                )
        else
          const SizedBox(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: myDayTaskList.themeColor),
            backgroundColor: Colors.transparent,
            title: RichText(
              text: TextSpan(
                  text: 'My Day',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: myDayTaskList.themeColor,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\n${DateFormat('EEEE, MMMM d').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: myDayTaskList.themeColor,
                      ),
                    )
                  ]),
            ),
            actions: const [
              TaskListPopupMenu(
                toRemove: [
                  'sort_by',
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
              IncompleteList(taskList: myDayTaskList),
              CompletedList(taskList: myDayTaskList),
            ]),
          ),
          floatingActionButton: MyDayFloatingButtons(
            taskList: myDayTaskList,
            themeColor: myDayTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
