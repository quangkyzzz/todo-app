// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/group.dart';
import '../../models/task_list.dart';
import '../../ultility/task_list_ultility.dart';
import '../../view_models/group_view_model.dart';
import 'home_appbar.dart';
import '../../themes.dart';
import '../../routes.dart';
import 'home_group.dart';
import 'home_item.dart';
import 'home_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[1],
              icon: Icons.wb_sunny_outlined,
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  myDayRoute,
                  arguments:
                      context.read<GroupViewModel>().groups[0].taskLists[1],
                );
              },
              endNumber: TaskListUltility.countIncompletedTaskByID(
                taskList: context.read<GroupViewModel>().groups[0].taskLists[1],
              ),
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[2],
              icon: Icons.star_border,
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  importantRoute,
                  arguments:
                      context.read<GroupViewModel>().groups[0].taskLists[2],
                );
              },
              endNumber: TaskListUltility.countIncompletedTaskByID(
                taskList: context.read<GroupViewModel>().groups[0].taskLists[2],
              ),
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[3],
              icon: Icons.list_alt_outlined,
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  plannedRoute,
                  arguments:
                      context.read<GroupViewModel>().groups[0].taskLists[3],
                );
              },
              endNumber: TaskListUltility.countIncompletedTaskByID(
                taskList: context.read<GroupViewModel>().groups[0].taskLists[3],
              ),
            ),
            HomeItem(
              taskList: context.watch<GroupViewModel>().groups[0].taskLists[0],
              icon: Icons.task_outlined,
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  taskListRoute,
                  arguments:
                      context.read<GroupViewModel>().groups[0].taskLists[0],
                );
              },
              endNumber: TaskListUltility.countIncompletedTaskByID(
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
                    int endNumber = TaskListUltility.countIncompletedTaskByID(
                      taskList: item,
                    );
                    return HomeItem(
                      taskList: item,
                      icon: Icons.list_outlined,
                      endNumber: endNumber,
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          taskListRoute,
                          arguments: item,
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
