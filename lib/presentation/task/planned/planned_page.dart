import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/components/task_list_popup_menu.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class PlannedPage extends StatefulWidget {
  const PlannedPage({super.key});

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
  late List<Map<String, dynamic>> listPopupMennu;
  int plannedState = 5;
  late List<Task> displayList;

  @override
  void initState() {
    listPopupMennu = [
      {
        'text': 'Overdue',
        'icon': Icons.event_busy_outlined,
        'onTap': () {
          setState(() {
            plannedState = 0;
          });
        }
      },
      {
        'text': 'Today',
        'icon': Icons.today_outlined,
        'onTap': () {
          setState(() {
            plannedState = 1;
          });
        }
      },
      {
        'text': 'Tomorrow',
        'icon': Icons.event_outlined,
        'onTap': () {
          setState(() {
            plannedState = 2;
          });
        }
      },
      {
        'text': 'This week',
        'icon': Icons.date_range_outlined,
        'onTap': () {
          setState(() {
            plannedState = 3;
          });
        }
      },
      {
        'text': 'Later',
        'icon': Icons.calendar_month_outlined,
        'onTap': () {
          setState(() {
            plannedState = 4;
          });
        }
      },
      {
        'text': 'All planned',
        'icon': Icons.event_note_outlined,
        'onTap': () {
          setState(() {
            plannedState = 5;
          });
        }
      },
    ];
    context.read<TaskListViewModel>().getPlannedTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<TaskListViewModel>().isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      TaskList plannedTaskList =
          context.watch<TaskListViewModel>().currentTaskList;
      switch (plannedState) {
        case 0:
          displayList =
              context.watch<TaskListViewModel>().readPlannedOverdueTask();
        case 1:
          displayList =
              context.watch<TaskListViewModel>().readPlannedTodayTask();
        case 2:
          displayList =
              context.watch<TaskListViewModel>().readPlannedTomorrowTask();
        case 3:
          displayList =
              context.watch<TaskListViewModel>().readPlannedThisWeekTask();
        case 4:
          displayList =
              context.watch<TaskListViewModel>().readPlannedLaterTask();
        case 5:
          displayList =
              context.watch<TaskListViewModel>().currentTaskList.tasks;
      }
      return Stack(
        fit: StackFit.expand,
        children: [
          if (plannedTaskList.backgroundImage != null)
            (plannedTaskList.defaultImage == -1)
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
              actions: const [
                TaskListPopupMenu(
                  toRemove: [
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
                  /////////////
                  //popup menu
                  PopupMenuButton(
                    offset: const Offset(0, 48),
                    itemBuilder: (BuildContext context) {
                      return listPopupMennu.map((item) {
                        return PopupMenuItem(
                          onTap: item['onTap'],
                          child: CustomPopupItem(
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
                            listPopupMennu[plannedState]['icon'],
                            size: 32,
                            color: plannedTaskList.themeColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            listPopupMennu[plannedState]['text'],
                            style: TextStyle(
                                fontSize: 18,
                                color: plannedTaskList.themeColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  //task list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: displayList.length,
                    itemBuilder: (BuildContext _, int index) {
                      return TaskListItem(
                        isReorderState: false,
                        task: displayList[index],
                        themeColor: plannedTaskList.themeColor,
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
}
