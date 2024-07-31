// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/provider/task_list_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    TaskListModel myDayTaskList = TaskListModel(
      id: '-1',
      listName: 'My Day',
    );
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
            actions: [
              PopupMenu(
                taskList: myDayTaskList,
                toRemove: const [
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
            child: Consumer<TaskListProvider>(
              builder: (context, taskListProvider, child) {
                List<Map<TaskModel, TaskListModel>> myDayList =
                    taskListProvider.getOnMyDayTask();

                List<Map<TaskModel, TaskListModel>> inCompleteList = myDayList
                    .where((element) => (!element.keys.first.isCompleted))
                    .toList();
                List<Map<TaskModel, TaskListModel>> completedlist = myDayList
                    .where((element) => (element.keys.first.isCompleted))
                    .toList();
                return Column(children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: inCompleteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskListItem(
                        task: inCompleteList[index].keys.first,
                        taskList: inCompleteList[index].values.first,
                      );
                    },
                  ),
                  (completedlist.isNotEmpty)
                      ? ExpansionTile(
                          initiallyExpanded: true,
                          title: const Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 18,
                              color: MyTheme.blueColor,
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
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: completedlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TaskListItem(
                                  task: completedlist[index].keys.first,
                                  taskList: completedlist[index].values.first,
                                );
                              },
                            )
                          ],
                        )
                      : const SizedBox(),
                ]);
              },
            ),
          ),
          floatingActionButton: const MyDayFloatingButtons(),
        ),
      ],
    );
  }
}
