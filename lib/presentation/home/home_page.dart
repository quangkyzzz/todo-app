// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/group_model.dart';
import '../../models/task_list_model.dart';
import '../../view_models/group_view_model.dart';
import '../../view_models/home_page_task_list_view_model.dart';
import 'home_appbar.dart';
//import '../../provider/group_provider.dart';
//import '../../provider/task_list_provider.dart';
import '../../themes.dart';
import '../../routes.dart';
import 'home_group.dart';
import 'home_item.dart';
import 'home_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  onTapMyDay(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(myDayRoute);
  }

  onTapImportant(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(importantRoute);
  }

  onTapPlanned(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(plannedRoute);
  }

  onTapAssignToMe(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(taskListRoute, arguments: {
      'haveCompletedList': true,
      'taskList': taskList,
    });
  }

  onTapFlaggedEmail(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(flaggedRoute);
  }

  onTapTask(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(
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
        'ID': '2',
        'text': 'My Day',
        'ontap': onTapMyDay,
        'icon': Icons.wb_sunny_outlined,
        'iconColor': MyTheme.greyColor,
        'endNumber': context
            .watch<HomePageTaskListViewModel>()
            .countIncompletedMyDayTask(),
      },
      {
        'ID': '3',
        'text': 'Important',
        'ontap': onTapImportant,
        'icon': Icons.star_border,
        'iconColor': MyTheme.pinkColor,
        'endNumber': context
            .watch<HomePageTaskListViewModel>()
            .countIncompletedImportantTask(),
      },
      {
        'ID': '4',
        'text': 'Planned',
        'ontap': onTapPlanned,
        'icon': Icons.list_alt_outlined,
        'iconColor': MyTheme.redColor,
        'endNumber': context
            .watch<HomePageTaskListViewModel>()
            .countIncompletedPlannedTask(),
      },
      {
        'ID': '1',
        'text': 'Assign to me',
        'ontap': onTapAssignToMe,
        'icon': Icons.person_outline,
        'iconColor': MyTheme.greenColor,
        'endNumber': 0,
      },
      {
        'ID': '1',
        'text': 'Flagged email',
        'ontap': onTapFlaggedEmail,
        'icon': Icons.flag_outlined,
        'iconColor': MyTheme.orangeColor,
        'endNumber': 0,
      },
      {
        'ID': '1',
        'text': 'Tasks',
        'ontap': onTapTask,
        'icon': Icons.task_outlined,
        'iconColor': MyTheme.blueColor,
        'endNumber': context
            .watch<HomePageTaskListViewModel>()
            .countIncompletedTaskByID(taskListID: '1'),
      },
    ];
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Column(
          children: [
            //////////////
            //default list
            Consumer<HomePageTaskListViewModel>(
                builder: (context, homePageViewModel, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: listHomeItem.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> item = listHomeItem[index];
                  return HomeItem(
                    text: item['text'],
                    icon: item['icon'],
                    iconColor: homePageViewModel
                        .getTaskList(taskListID: item['ID'])
                        .themeColor,
                    endNumber: item['endNumber'],
                    onTap: () {
                      item['ontap'](
                        context,
                        homePageViewModel.taskLists[0],
                      );
                    },
                  );
                },
              );
            }),
            MyTheme.dividerWhiteStyle,
            /////////////////////
            //personal task list
            Consumer<HomePageTaskListViewModel>(
                builder: (context, homePageTaskListViewModel, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: homePageTaskListViewModel.taskLists.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskListModel item =
                      homePageTaskListViewModel.taskLists[index];
                  if (int.parse(item.id) > 10) {
                    int endNumber =
                        homePageTaskListViewModel.countIncompletedTaskByID(
                      taskListID: item.id,
                    );
                    return HomeItem(
                      text: item.listName,
                      icon: Icons.list_outlined,
                      iconColor: item.themeColor,
                      endNumber: endNumber,
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          taskListRoute,
                          arguments: {
                            'haveCompletedList': true,
                            'taskList': item,
                          },
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              );
            }),
            /////////////////
            //personal group
            Consumer<GroupViewModel>(builder: (context, groupViewModel, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: groupViewModel.groups.length,
                itemBuilder: (BuildContext context, int index) {
                  GroupModel item = groupViewModel.groups[index];
                  return HomeGroup(group: item);
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: HomePageBottomNavigationBar(),
    );
  }
}
