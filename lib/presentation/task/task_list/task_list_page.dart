import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../view_models/temp_task_list_view_model_will_delete.dart';
import '../../components/add_floating_button.dart';
import '../../lists/completed_list.dart';
import '../../lists/incomplete_list.dart';
import '../../components/popup_menu.dart';

import 'change_sort_type_button.dart';

class TaskListPage extends StatefulWidget {
  final bool haveCompletedList;
  const TaskListPage({
    super.key,
    this.haveCompletedList = true,
  });

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TempTaskListViewModel taskListViewModel =
        context.watch<TempTaskListViewModel>();
    return Stack(
      fit: StackFit.expand,
      children: [
        if ((taskListViewModel.taskList.backgroundImage != null))
          if (taskListViewModel.taskList.defaultImage == -1)
            Image.file(
              File(taskListViewModel.taskList.backgroundImage!),
              fit: BoxFit.fitHeight,
            )
          else
            Image.asset(
              taskListViewModel.taskList.backgroundImage!,
              fit: BoxFit.fitHeight,
            )
        else
          const SizedBox(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
                color:
                    context.watch<TempTaskListViewModel>().taskList.themeColor),
            title: Consumer<TempTaskListViewModel>(
                builder: (context, taskListViewModel, child) {
              return Text(
                taskListViewModel.taskList.listName,
                style: TextStyle(
                  fontSize: 24,
                  color: taskListViewModel.taskList.themeColor,
                ),
              );
            }),
            actions: [
              PopupMenu(
                taskList: taskListViewModel.taskList,
                toRemove: (taskListViewModel.taskList.id == '1')
                    ? (['rename_list', 'hide_completed_tasks', 'delete_list'])
                    : (['hide_completed_tasks']),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<TempTaskListViewModel>(
              builder: (context, taskListViewModel, child) {
                TaskList taskList = taskListViewModel.taskList;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (taskList.sortByType != null)
                          ? ChangeSortTypeButton(taskList: taskList)
                          : const SizedBox(),
                      IncompleteList(taskList: taskList),
                      (widget.haveCompletedList)
                          ? CompletedList(taskList: taskList)
                          : const SizedBox()
                    ]);
              },
            ),
          ),
          floatingActionButton: AddFloatingButton(
            taskList: taskListViewModel.taskList,
            themeColor: taskListViewModel.taskList.themeColor,
          ),
        ),
      ],
    );
  }
}
