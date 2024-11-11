// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/entity/group.dart';
import 'package:todo_app/model/entity/task_list.dart';
import 'package:todo_app/ultility/task_list_ultility.dart';
import 'package:todo_app/view_models/group_view_model.dart';
import 'package:todo_app/presentation/home/home_appbar.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/presentation/home/home_group.dart';
import 'package:todo_app/presentation/home/home_item.dart';
import 'package:todo_app/presentation/home/home_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return context.watch<GroupViewModel>().isGroupsLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: HomeAppBar(context: context).appBar(),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 8, right: 6),
              child: Column(
                children: [
                  //////////////
                  //default list
                  HomeItem(
                    taskList: context
                        .watch<GroupViewModel>()
                        .groups
                        .firstWhere((element) => element.id == "1")
                        .taskLists
                        .firstWhere((element) => element.id == '2'),
                    icon: Icons.wb_sunny_outlined,
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        myDayRoute,
                        arguments: context
                            .read<GroupViewModel>()
                            .groups
                            .firstWhere((element) => element.id == '1')
                            .taskLists
                            .firstWhere((element) => element.id == '2'),
                      );
                    },
                    endNumber: TaskListUltility.countIncompletedTaskByID(
                      taskList: context
                          .read<GroupViewModel>()
                          .groups
                          .firstWhere((element) => element.id == "1")
                          .taskLists
                          .firstWhere((element) => element.id == '2'),
                    ),
                  ),
                  HomeItem(
                    taskList: context
                        .watch<GroupViewModel>()
                        .groups
                        .firstWhere((element) => element.id == "1")
                        .taskLists
                        .firstWhere((element) => element.id == '3'),
                    icon: Icons.star_border,
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        importantRoute,
                        arguments: context
                            .read<GroupViewModel>()
                            .groups
                            .firstWhere((element) => element.id == "1")
                            .taskLists
                            .firstWhere((element) => element.id == '3'),
                      );
                    },
                    endNumber: TaskListUltility.countIncompletedTaskByID(
                      taskList: context
                          .read<GroupViewModel>()
                          .groups
                          .firstWhere((element) => element.id == "1")
                          .taskLists
                          .firstWhere((element) => element.id == '3'),
                    ),
                  ),
                  HomeItem(
                    taskList: context
                        .watch<GroupViewModel>()
                        .groups
                        .firstWhere((element) => element.id == "1")
                        .taskLists
                        .firstWhere((element) => element.id == '4'),
                    icon: Icons.list_alt_outlined,
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        plannedRoute,
                        arguments: context
                            .read<GroupViewModel>()
                            .groups
                            .firstWhere((element) => element.id == "1")
                            .taskLists
                            .firstWhere((element) => element.id == '4'),
                      );
                    },
                    endNumber: TaskListUltility.countIncompletedTaskByID(
                      taskList: context
                          .read<GroupViewModel>()
                          .groups
                          .firstWhere((element) => element.id == "1")
                          .taskLists
                          .firstWhere((element) => element.id == '4'),
                    ),
                  ),
                  HomeItem(
                    taskList: context
                        .watch<GroupViewModel>()
                        .groups
                        .firstWhere((element) => element.id == "1")
                        .taskLists
                        .firstWhere((element) => element.id == '1'),
                    icon: Icons.task_outlined,
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                        taskListRoute,
                        arguments: context
                            .read<GroupViewModel>()
                            .groups
                            .firstWhere((element) => element.id == "1")
                            .taskLists
                            .firstWhere((element) => element.id == '1'),
                      );
                    },
                    endNumber: TaskListUltility.countIncompletedTaskByID(
                      taskList: context
                          .watch<GroupViewModel>()
                          .groups
                          .firstWhere((element) => element.id == "1")
                          .taskLists
                          .firstWhere((element) => element.id == '1'),
                    ),
                  ),
                  MyTheme.dividerWhiteStyle,
                  /////////////////////
                  //Default group
                  Consumer<GroupViewModel>(
                      builder: (context, groupViewModel, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: groupViewModel.groups
                          .firstWhere((element) => element.id == "1")
                          .taskLists
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        TaskList item = groupViewModel.groups
                            .firstWhere((element) => element.id == "1")
                            .taskLists[index];
                        if (int.parse(item.id) > 10) {
                          int endNumber =
                              TaskListUltility.countIncompletedTaskByID(
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
                  Consumer<GroupViewModel>(
                      builder: (context, groupViewModel, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: groupViewModel.groups.length,
                      itemBuilder: (BuildContext context, int index) {
                        Group item = groupViewModel.groups[index];
                        if (groupViewModel.groups[index].id != '1') {
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
