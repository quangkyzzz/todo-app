// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/group.dart';
import '../../models/task_list.dart';
import '../../view_models/group_view_model.dart';
import '../../view_models/task_list_view_model.dart';
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

  onTapMyDay(BuildContext context) async {
    await Navigator.of(context).pushNamed(myDayRoute);
  }

  onTapImportant(BuildContext context) async {
    await Navigator.of(context).pushNamed(importantRoute);
  }

  onTapPlanned(BuildContext context) async {
    await Navigator.of(context).pushNamed(plannedRoute);
  }

  onTapAssignToMe(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(taskListRoute, arguments: {
      'haveCompletedList': true,
      'taskList': taskList,
    });
  }

  onTapFlaggedEmail(BuildContext context, TaskListModel taskList) async {
    await Navigator.of(context).pushNamed(taskListRoute, arguments: {
      'haveCompletedList': true,
      'taskList': taskList,
    });
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
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Column(
          children: [
            //////////////
            //default list
            HomeItem(
              taskListID: '2',
              icon: Icons.wb_sunny_outlined,
              onTap: () {
                onTapMyDay(context);
              },
              endNumber: context
                  .watch<TaskListViewModel>()
                  .countIncompletedMyDayTask(),
            ),
            HomeItem(
              taskListID: '3',
              icon: Icons.star_border,
              onTap: () {
                onTapImportant(context);
              },
              endNumber: context
                  .watch<TaskListViewModel>()
                  .countIncompletedImportantTask(),
            ),
            HomeItem(
              taskListID: '4',
              icon: Icons.list_alt_outlined,
              onTap: () {
                onTapPlanned(context);
              },
              endNumber: context
                  .watch<TaskListViewModel>()
                  .countIncompletedPlannedTask(),
            ),
            HomeItem(
              taskListID: '5',
              icon: Icons.person_outline,
              onTap: () {
                onTapAssignToMe(
                  context,
                  context.read<TaskListViewModel>().taskLists[0],
                );
              },
              endNumber: 0,
            ),
            HomeItem(
              taskListID: '6',
              icon: Icons.flag_outlined,
              onTap: () {
                onTapFlaggedEmail(
                  context,
                  context.read<TaskListViewModel>().taskLists[0],
                );
              },
              endNumber: 0,
            ),
            HomeItem(
              taskListID: '1',
              icon: Icons.task_outlined,
              onTap: () {
                onTapTask(
                  context,
                  context.read<TaskListViewModel>().taskLists[0],
                );
              },
              endNumber: context
                  .watch<TaskListViewModel>()
                  .countIncompletedTaskByID(taskListID: '1'),
            ),
            MyTheme.dividerWhiteStyle,
            /////////////////////
            //personal task list
            Consumer<TaskListViewModel>(
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
                      taskListID: item.id,
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
            Consumer<GroupViewModel>(
                builder: (context, homePageGroupViewModel, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: homePageGroupViewModel.groups.length,
                itemBuilder: (BuildContext context, int index) {
                  Group item = homePageGroupViewModel.groups[index];
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
