// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/group.dart';
import '../../models/task_list.dart';
import '../../ultility/task_list_ultility.dart';
import '../../view_models/group_view_model.dart';
import '../../view_models/task_map_view_model.dart';
import 'home_appbar.dart';
import '../../themes.dart';
import '../../routes.dart';
import 'home_group.dart';
import 'home_item.dart';
import 'home_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  onTapMyDay(BuildContext context, TaskList taskList) async {
    await Navigator.of(context).pushNamed(myDayRoute, arguments: taskList);
  }

  onTapImportant(BuildContext context, TaskList taskList) async {
    await Navigator.of(context).pushNamed(importantRoute, arguments: taskList);
  }

  onTapPlanned(BuildContext context, TaskList taskList) async {
    await Navigator.of(context).pushNamed(plannedRoute, arguments: taskList);
  }

  onTapAssignToMe(BuildContext context, TaskList taskList) async {
    await Navigator.of(context).pushNamed(taskListRoute, arguments: {
      'haveCompletedList': true,
      'taskList': taskList,
    });
  }

  onTapFlaggedEmail(BuildContext context, TaskList taskList) async {
    await Navigator.of(context).pushNamed(taskListRoute, arguments: {
      'haveCompletedList': true,
      'taskList': taskList,
    });
  }

  onTapTask(BuildContext context, TaskList taskList) async {
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
    final TaskListUltility taskListUltility =
        TaskListUltility(taskViewModel: context.read<TaskMapViewModel>());
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Column(
          children: [
            //////////////
            //default list
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[1],
              icon: Icons.wb_sunny_outlined,
              onTap: () {
                onTapMyDay(
                  context,
                  context.read<GroupViewModel>().groups[0].taskLists[1],
                );
              },
              endNumber: taskListUltility.countIncompletedMyDayTask(),
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[2],
              icon: Icons.star_border,
              onTap: () {
                onTapImportant(
                  context,
                  context.read<GroupViewModel>().groups[0].taskLists[2],
                );
              },
              endNumber: taskListUltility.countIncompletedImportantTask(),
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[3],
              icon: Icons.list_alt_outlined,
              onTap: () {
                onTapPlanned(
                  context,
                  context.read<GroupViewModel>().groups[0].taskLists[3],
                );
              },
              endNumber: taskListUltility.countIncompletedPlannedTask(),
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[4],
              icon: Icons.person_outline,
              onTap: () {
                onTapAssignToMe(
                  context,
                  context.read<GroupViewModel>().groups[0].taskLists[0],
                );
              },
              endNumber: 0,
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[5],
              icon: Icons.flag_outlined,
              onTap: () {
                onTapFlaggedEmail(
                  context,
                  context.read<GroupViewModel>().groups[0].taskLists[0],
                );
              },
              endNumber: 0,
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[0],
              icon: Icons.task_outlined,
              onTap: () {
                onTapTask(
                  context,
                  context.read<GroupViewModel>().groups[0].taskLists[0],
                );
              },
              endNumber: taskListUltility.countIncompletedTaskByID(
                taskList:
                    context.watch<GroupViewModel>().groups[0].taskLists[0],
              ),
            ),
            MyTheme.dividerWhiteStyle,
            /////////////////////
            //Default group
            Consumer<GroupViewModel>(builder: (context, groupViewModel, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: groupViewModel.groups[0].taskLists.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskList item = groupViewModel.groups[0].taskLists[index];
                  if (int.parse(item.id) > 10) {
                    int endNumber = taskListUltility.countIncompletedTaskByID(
                      taskList: item,
                    );
                    return HomeItem(
                      taskList: item,
                      icon: Icons.list_outlined,
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
                  Group item = groupViewModel.groups[index];
                  if (index != 0) {
                    return HomeGroup(group: item);
                  } else {
                    return SizedBox();
                  }
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
