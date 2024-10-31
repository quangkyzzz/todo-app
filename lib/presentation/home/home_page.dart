// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/models/task_step.dart';
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
                            .groups[0]
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
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                TaskList taskListInput = TaskList(
                  id: '1',
                  title: 'Tasks',
                  sortByType: SortType.createDate,
                  tasks: [
                    Task(
                      id: '2',
                      taskListID: '1',
                      title: 'few day',
                      isCompleted: false,
                      isImportant: true,
                      isOnMyDay: true,
                      createDate: DateTime(2024, 6, 2),
                      dueDate: DateTime(2024, 6, 2),
                    ),
                    Task(
                      id: '1',
                      taskListID: '1',
                      title: 'Tasks',
                      isCompleted: false,
                      isImportant: false,
                      isOnMyDay: false,
                      createDate: DateTime(2024, 6, 9),
                      stepList: [
                        TaskStep(
                          id: '1',
                          stepName: 'step 1',
                          isCompleted: false,
                        ),
                        TaskStep(
                          id: '2',
                          stepName: 'step 2',
                          isCompleted: true,
                        ),
                      ],
                      note: 'note',
                    ),
                    Task(
                      id: '66',
                      taskListID: '1',
                      title: 'No step',
                      isCompleted: false,
                      isImportant: false,
                      isOnMyDay: true,
                      remindTime: DateTime(2024, 9, 1),
                      createDate: DateTime(2024, 6, 2),
                      dueDate: DateTime(2024, 6, 2),
                    ),
                  ],
                );
                Task taskInput = Task(
                  id: '1',
                  taskListID: '1',
                  title: 'Tasks',
                  remindTime: DateTime.now(),
                  repeatFrequency: Frequency.month,
                  isCompleted: false,
                  isImportant: false,
                  isOnMyDay: false,
                  createDate: DateTime(2024, 6, 9),
                  stepList: [
                    TaskStep(
                      id: '1',
                      stepName: 'step 1',
                      isCompleted: false,
                    ),
                    TaskStep(
                      id: '2',
                      stepName: 'step 2',
                      isCompleted: true,
                    ),
                  ],
                  note: 'note',
                );
                Group groupInput = Group(
                  id: '1',
                  groupName: 'default group',
                  taskLists: [
                    TaskList(
                      id: '1',
                      title: 'Tasks',
                      tasks: [
                        Task(
                          id: '2',
                          taskListID: '1',
                          title: 'few day',
                          isCompleted: false,
                          isImportant: true,
                          isOnMyDay: true,
                          createDate: DateTime(2024, 6, 2),
                          dueDate: DateTime(2024, 6, 2),
                        ),
                        Task(
                          id: '1',
                          taskListID: '1',
                          title: 'Tasks',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime(2024, 6, 9),
                          stepList: [
                            TaskStep(
                              id: '1',
                              stepName: 'step 1',
                              isCompleted: false,
                            ),
                            TaskStep(
                              id: '2',
                              stepName: 'step 2',
                              isCompleted: true,
                            ),
                          ],
                          note: 'note',
                        ),
                        Task(
                          id: '66',
                          taskListID: '1',
                          title: 'No step',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: true,
                          remindTime: DateTime(2024, 9, 1),
                          createDate: DateTime(2024, 6, 2),
                          dueDate: DateTime(2024, 6, 2),
                        ),
                      ],
                    ),
                    TaskList(
                      id: '2',
                      title: 'My Day',
                      themeColor: MyTheme.whiteColor,
                      backgroundImage: 'assets/backgrounds/bg_my_day.jpg',
                      defaultImage: 0,
                    ),
                    TaskList(
                        id: '3',
                        title: 'Important',
                        themeColor: MyTheme.pinkColor),
                    TaskList(
                        id: '4',
                        title: 'Planned',
                        themeColor: MyTheme.redColor),
                    TaskList(id: '5', title: 'Search task list'),
                    TaskList(
                      id: '222',
                      title: 'personal list 1',
                      tasks: [
                        Task(
                            id: 'id3',
                            taskListID: '222',
                            title: 'few hour',
                            isCompleted: false,
                            isImportant: false,
                            isOnMyDay: true,
                            createDate: DateTime.now()
                                .subtract(const Duration(hours: 2)),
                            note: 'Really long note, long long long'
                                'long long long long long long'),
                        Task(
                          id: 'id4',
                          taskListID: '222',
                          title: 'recent',
                          isCompleted: false,
                          isImportant: true,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                        ),
                        Task(
                          id: 'id5',
                          taskListID: '222',
                          title: 'few minute',
                          isCompleted: false,
                          isImportant: true,
                          isOnMyDay: true,
                          createDate: DateTime.now()
                              .subtract(const Duration(minutes: 12)),
                        ),
                      ],
                    ),
                  ],
                );
                Group groupInput2 = Group(
                  id: '111',
                  groupName: 'my group 1',
                  taskLists: [
                    TaskList(
                      id: '333',
                      title: 'group 1 list 1',
                      tasks: [
                        Task(
                          id: '6',
                          taskListID: '333',
                          title: 'due today',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                          dueDate: DateTime.now(),
                        ),
                        Task(
                          id: '7',
                          taskListID: '333',
                          title: 'due tomorrow',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                          dueDate: DateTime.now().add(const Duration(days: 1)),
                        ),
                        Task(
                          id: '8',
                          taskListID: '333',
                          title: 'due next week',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                          dueDate: DateTime.now().add(const Duration(days: 7)),
                        ),
                      ],
                    ),
                    TaskList(
                      id: '444',
                      title: 'group 1 list 2',
                      tasks: [
                        Task(
                          id: '9',
                          taskListID: '444',
                          title: 'due next month',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                          dueDate: DateTime.now().add(const Duration(days: 31)),
                        ),
                        Task(
                          id: '10',
                          taskListID: '444',
                          title: 'due next 2 day',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                          dueDate: DateTime.now().add(const Duration(days: 2)),
                        ),
                        Task(
                          id: '11',
                          taskListID: '444',
                          title: 'due next 3 day',
                          isCompleted: false,
                          isImportant: false,
                          isOnMyDay: false,
                          createDate: DateTime.now(),
                          dueDate: DateTime.now().add(const Duration(days: 3)),
                        ),
                      ],
                    ),
                  ],
                );
                // TaskList taskListOutput = TaskList.fromMap(taskListInput.toMap());
                // Task taskOutput = Task.fromMap(taskInput.toMap());
                // Group groupOutput = Group.fromMap(groupInput.toMap());

                //context.read<GroupViewModel>().initListenAllGroup();
              },
              child: Icon(Icons.abc),
            ),
            bottomNavigationBar: HomePageBottomNavigationBar(),
          );
  }
}
