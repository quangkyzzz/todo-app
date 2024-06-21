// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Task/Task_list/components/incomplete_list.dart';
import 'package:todo_app/Task/Task_list/components/task_list_popup_menu.dart';

class MyDayView extends StatefulWidget {
  const MyDayView({super.key});

  @override
  State<MyDayView> createState() => _MyDayViewState();
}

class _MyDayViewState extends State<MyDayView> {
  bool ischecked = false;
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
          'assets/images/backGroundImage.jpg',
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
              TaskListPopupMenu(
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
              IncompleteList(taskList: incompleteTask),
              ExpansionTile(
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
                trailing: Icon(
                    isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
                children: [
                  IncompleteList(
                    taskList: incompleteTask,
                  ),
                ],
              )
            ]),
          ),
          floatingActionButton: Row(
            children: [
              const Spacer(flex: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: AppConfigs.blueColor,
                ),
                child: InkWell(
                  splashColor: AppConfigs.blackColor,
                  customBorder: const CircleBorder(),
                  onTap: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      constraints: const BoxConstraints(maxHeight: 200),
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'From earlier',
                                style: AppConfigs.itemTextStyle,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    shape: const CircleBorder(),
                                    value: ischecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischecked = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Task 1',
                                    style: AppConfigs.itemTextStyle,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_outlined),
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                      },
                    );
                  },
                  child: Ink(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Text(
                      'Suggestions',
                      style: AppConfigs.itemBlackTextStyle,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConfigs.blueColor,
                ),
                child: InkWell(
                  splashColor: AppConfigs.blackColor,
                  customBorder: const CircleBorder(),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            color: AppConfigs.backgroundGreyColor,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  shape: const CircleBorder(),
                                  value: ischecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      ischecked = value!;
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add a task',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_upward),
                                )
                              ],
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: Ink(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    height: 60,
                    width: 60,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: AppConfigs.blackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
