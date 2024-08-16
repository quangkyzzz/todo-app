import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class PlannedPage extends StatefulWidget {
  const PlannedPage({super.key});

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
  late List<Map<String, dynamic>> listPopupMennu;
  int plannedState = 5;
  late TaskListModel plannedTaskList;

  void onPlannedStateChange(int value) {
    setState(() {
      plannedState = value;
    });
  }

  @override
  void initState() {
    listPopupMennu = [
      {
        'text': 'Overdue',
        'icon': Icons.event_busy_outlined,
        'onTap': () {
          onPlannedStateChange(0);
        }
      },
      {
        'text': 'Today',
        'icon': Icons.today_outlined,
        'onTap': () {
          onPlannedStateChange(1);
        }
      },
      {
        'text': 'Tomorrow',
        'icon': Icons.event_outlined,
        'onTap': () {
          onPlannedStateChange(2);
        }
      },
      {
        'text': 'This week',
        'icon': Icons.date_range_outlined,
        'onTap': () {
          onPlannedStateChange(3);
        }
      },
      {
        'text': 'Later',
        'icon': Icons.calendar_month_outlined,
        'onTap': () {
          onPlannedStateChange(4);
        }
      },
      {
        'text': 'All planned',
        'icon': Icons.event_note_outlined,
        'onTap': () {
          onPlannedStateChange(5);
        }
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    plannedTaskList = Provider.of<TaskListProvider>(context, listen: true)
        .getTaskList(taskListID: '4');
    return Stack(
      fit: StackFit.expand,
      children: [
        if (plannedTaskList.backgroundImage != null)
          (plannedTaskList.isDefaultImage == -1)
              ? Image.file(
                  File(plannedTaskList.backgroundImage!),
                  fit: BoxFit.fitHeight,
                )
              : Image.asset(
                  plannedTaskList.backgroundImage!,
                  fit: BoxFit.fitHeight,
                )
        else
          const SizedBox(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: plannedTaskList.themeColor),
            title: Text(
              'Planned',
              style: TextStyle(
                fontSize: 24,
                color: plannedTaskList.themeColor,
              ),
            ),
            actions: [
              PopupMenu(
                taskList: plannedTaskList,
                toRemove: const [
                  'sort_by',
                  'reorder',
                  'turn_on_suggestions',
                  'duplicate_list',
                  'delete_list',
                  'rename_list',
                  'hide_completed_tasks'
                ],
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
                        onTap: item['onTap'],
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.list,
                          size: 32,
                          color: plannedTaskList.themeColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          listPopupMennu[plannedState]['text'],
                          style: TextStyle(
                              fontSize: 18, color: plannedTaskList.themeColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                //task list
                Consumer<TaskListProvider>(
                  builder: (context, taskListProvider, child) {
                    ListTaskMap plannedTasks = [];
                    switch (plannedState) {
                      case 0:
                        plannedTasks = taskListProvider.getPlannedOverdueTask();
                      case 1:
                        plannedTasks = taskListProvider.getPlannedTodayTask();
                      case 2:
                        plannedTasks =
                            taskListProvider.getPlannedTomorrowTask();
                      case 3:
                        plannedTasks =
                            taskListProvider.getPlannedThisWeekTask();
                      case 4:
                        plannedTasks = taskListProvider.getPlannedLaterTask();
                      case 5:
                        plannedTasks = taskListProvider.getPlannedTask();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: plannedTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskListItem(
                          task: plannedTasks[index].keys.first,
                          taskList: plannedTasks[index].values.first,
                          themeColor: plannedTaskList.themeColor,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
