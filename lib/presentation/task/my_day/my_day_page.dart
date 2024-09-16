// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../ultility/type_def.dart';
import '../../../view_models/group_view_model.dart';
import '../../../view_models/task_map_view_model.dart';
import '../../items/task_list_item.dart';
import 'my_day_floating_buttons.dart';
import '../../components/popup_menu.dart';

class MyDayPage extends StatefulWidget {
  const MyDayPage({super.key});

  @override
  State<MyDayPage> createState() => _MyDayPageState();
}

class _MyDayPageState extends State<MyDayPage> {
  late TaskList addTaskDestinationTaskList;
  late TaskList myDayTaskList;
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    addTaskDestinationTaskList =
        context.read<GroupViewModel>().readGroupByID('1').taskLists[0];
    myDayTaskList =
        context.watch<GroupViewModel>().readGroupByID('1').taskLists[1];
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
            actions: [
              PopupMenu(
                taskList: myDayTaskList,
                toRemove: const [
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
            child: Consumer<TaskMapViewModel>(
              builder: (context, taskListProvider, child) {
                TaskMapList myDayList = taskListProvider.getOnMyDayTask();
                TaskMapList inCompleteList = myDayList
                    .where((element) => (!element.keys.first.isCompleted))
                    .toList();
                TaskMapList completedlist = myDayList
                    .where((element) => (element.keys.first.isCompleted))
                    .toList();
                return Column(children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: inCompleteList.length,
                    itemBuilder: (BuildContext _, int index) {
                      return TaskListItem(
                        mContext: context,
                        task: inCompleteList[index].keys.first,
                        taskList: inCompleteList[index].values.first,
                        themeColor: myDayTaskList.themeColor,
                      );
                    },
                  ),
                  (completedlist.isNotEmpty)
                      ? ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Completed ${completedlist.length}',
                            style: TextStyle(
                              fontSize: 18,
                              color: myDayTaskList.themeColor,
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
                              itemBuilder: (BuildContext _, int index) {
                                return TaskListItem(
                                  mContext: context,
                                  task: completedlist[index].keys.first,
                                  taskList: completedlist[index].values.first,
                                  themeColor: myDayTaskList.themeColor,
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
          floatingActionButton: MyDayFloatingButtons(
            taskList: addTaskDestinationTaskList,
            themeColor: myDayTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
