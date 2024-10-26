// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_source/group_data_source/group_database_service.dart';
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
                      stepList: [
                        TaskStep(
                            id: 'id2', stepName: 'test', isCompleted: true),
                        TaskStep(
                          id: 'id3',
                          stepName: 'test2',
                          isCompleted: false,
                        ),
                        TaskStep(
                            id: 'id4', stepName: 'test3', isCompleted: true),
                      ]),
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
          var result = await GroupDatabaseService.firebase()
              .getGroupByID(groupID: '111');
          print(result);
          //GroupDatabaseService.firebase().createGroup(newGroup: groupInput);
        },
        child: Icon(Icons.abc),
      ),
      bottomNavigationBar: HomePageBottomNavigationBar(),
    );
  }
}
