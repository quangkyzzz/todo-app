// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/lists/completed_list.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/task/my_day/my_day_floating_buttons.dart';
import 'package:todo_app/presentation/components/task_list_popup_menu.dart';

class MyDayPage extends StatefulWidget {
  const MyDayPage({super.key});

  @override
  State<MyDayPage> createState() => _MyDayPageState();
}

class _MyDayPageState extends State<MyDayPage> {
  @override
  void initState() {
    context.read<TaskListViewModel>().getOnMyDayTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskList myDayTaskList = context.watch<TaskListViewModel>().currentTaskList;
    return context.watch<TaskListViewModel>().isLoading
        ? const Center(child: CircularProgressIndicator())
        : Stack(
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
                body: const SingleChildScrollView(
                  child: Column(children: [
                    IncompleteList(isReorderState: false),
                    CompletedList(
                      isReorderState: false,
                    ),
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
