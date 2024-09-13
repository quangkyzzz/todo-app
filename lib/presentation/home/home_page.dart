// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/group.dart';
import '../../models/task_list.dart';
import '../../ultility/task_list_ultility.dart';
import '../../view_models/group_view_model.dart';
import '../../view_models/task_list_view_model.dart';
import '../../view_models/task_view_model_temporary.dart';
import 'home_appbar.dart';
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
        TaskListUltility(taskViewModel: context.read<TaskViewModel>());
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Column(
          children: [
            //////////////
            //default list
            HomeItem(
              taskList: context
                  .watch<TaskListViewModel>()
                  .readTaskList(taskListID: '2'),
              icon: Icons.wb_sunny_outlined,
              onTap: () {
                onTapMyDay(context);
              },
              endNumber: taskListUltility.countIncompletedMyDayTask(),
            ),
            HomeItem(
              taskList: context
                  .watch<TaskListViewModel>()
                  .readTaskList(taskListID: '3'),
              icon: Icons.star_border,
              onTap: () {
                onTapImportant(context);
              },
              endNumber: taskListUltility.countIncompletedImportantTask(),
            ),
            HomeItem(
              taskList: context
                  .watch<TaskListViewModel>()
                  .readTaskList(taskListID: '4'),
              icon: Icons.list_alt_outlined,
              onTap: () {
                onTapPlanned(context);
              },
              endNumber: taskListUltility.countIncompletedPlannedTask(),
            ),
            HomeItem(
              taskList: context
                  .watch<TaskListViewModel>()
                  .readTaskList(taskListID: '5'),
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
              taskList: context
                  .watch<TaskListViewModel>()
                  .readTaskList(taskListID: '6'),
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
              taskList: context
                  .watch<TaskListViewModel>()
                  .readTaskList(taskListID: '1'),
              icon: Icons.task_outlined,
              onTap: () {
                onTapTask(
                  context,
                  context.read<TaskListViewModel>().taskLists[0],
                );
              },
              endNumber: taskListUltility.countIncompletedTaskByID(
                taskList: context
                    .read<TaskListViewModel>()
                    .readTaskList(taskListID: '1'),
              ),
            ),
            MyTheme.dividerWhiteStyle,
            /////////////////////
            //personal task list
            Consumer<TaskListViewModel>(
                builder: (context, taskListViewModel, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: taskListViewModel.taskLists.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskList item = taskListViewModel.taskLists[index];
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
