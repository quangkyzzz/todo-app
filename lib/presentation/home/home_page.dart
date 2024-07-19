// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/home/home_appbar.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/presentation/home/home_group.dart';
import 'package:todo_app/presentation/home/home_item.dart';
import 'home_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  onTapMyDay(BuildContext context, TaskListModel taskList) {
    Navigator.of(context).pushNamed(myDayRoute);
  }

  onTapImportant(BuildContext context, TaskListModel taskList) {
    Navigator.of(context).pushNamed(
      taskListRoute,
      arguments: {
        'haveCompletedList': false,
        'taskList': taskList,
      },
    );
  }

  onTapPlanned(BuildContext context, TaskListModel taskList) {
    Navigator.of(context).pushNamed(plannedRoute);
  }

  onTapAssignToMe(BuildContext context, TaskListModel taskList) {
    Navigator.of(context).pushNamed(taskListRoute, arguments: {
      'haveCompletedList': true,
      'taskList': taskList,
    });
  }

  onTapFlaggedEmail(BuildContext context, TaskListModel taskList) {
    Navigator.of(context).pushNamed(flaggedRoute);
  }

  onTapTask(BuildContext context, TaskListModel taskList) {
    Navigator.of(context).pushNamed(
      taskListRoute,
      arguments: {
        'haveCompletedList': true,
        'taskList': taskList,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listHomeItem = [
      {
        'text': 'My Day',
        'ontap': onTapMyDay,
        'icon': Icons.wb_sunny_outlined,
        'iconColor': MyTheme.greyColor,
        'endNumber': 0
      },
      {
        'text': 'Important',
        'ontap': onTapImportant,
        'icon': Icons.star_border,
        'iconColor': MyTheme.pinkColor,
        'endNumber': 1,
      },
      {
        'text': 'Planned',
        'ontap': onTapPlanned,
        'icon': Icons.list_alt_outlined,
        'iconColor': MyTheme.redColor,
        'endNumber': 1,
      },
      {
        'text': 'Assign to me',
        'ontap': onTapAssignToMe,
        'icon': Icons.person_outline,
        'iconColor': MyTheme.greenColor,
        'endNumber': 1,
      },
      {
        'text': 'Flagged email',
        'ontap': onTapFlaggedEmail,
        'icon': Icons.flag_outlined,
        'iconColor': MyTheme.orangeColor,
        'endNumber': 0,
      },
      {
        'text': 'Tasks',
        'ontap': onTapTask,
        'icon': Icons.task_outlined,
        'iconColor': MyTheme.blueColor,
        'endNumber': 1,
      },
    ];
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Column(
          children: [
            //default list
            Consumer<TaskListProvider>(
                builder: (context, taskListProvider, child) {
              return Column(
                children: listHomeItem.map((item) {
                  return HomeItem(
                    text: item['text'],
                    icon: item['icon'],
                    iconColor: item['iconColor'],
                    endNumber: item['endNumber'],
                    onTap: () {
                      item['ontap'](
                        context,
                        taskListProvider.taskLists[0],
                      );
                    },
                  );
                }).toList(),
              );
            }),
            MyTheme.dividerWhiteStyle,
            //personal list
            Consumer<TaskListProvider>(
                builder: (context, taskListProvider, child) {
              return Column(
                children: taskListProvider.taskLists.map((item) {
                  return HomeItem(
                    text: item.listName,
                    icon: Icons.list_outlined,
                    iconColor: MyTheme.blueColor,
                    endNumber: 1,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        taskListRoute,
                        arguments: {
                          'haveCompletedList': true,
                          'taskList': item,
                        },
                      );
                    },
                  );
                }).toList(),
              );
            }),
            //personal group
            Consumer<GroupProvider>(builder: (context, groupProvider, child) {
              return Column(
                children: groupProvider.groups.map((item) {
                  return HomeGroup(group: item);
                }).toList(),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: HomePageBottomNavigationBar(),
    );
  }
}
