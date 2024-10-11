import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/components/add_task_floating_button.dart';
import 'package:todo_app/presentation/lists/completed_list.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/task_list_popup_menu.dart';
import 'package:todo_app/presentation/task/task_list/change_sort_type_button.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TaskList currentTaskList =
        context.watch<TaskListViewModel>().currentTaskList;
    return Stack(
      fit: StackFit.expand,
      children: [
        if ((currentTaskList.backgroundImage != null))
          if (currentTaskList.defaultImage == -1)
            Image.file(
              File(currentTaskList.backgroundImage!),
              fit: BoxFit.fitHeight,
            )
          else
            Image.asset(
              currentTaskList.backgroundImage!,
              fit: BoxFit.fitHeight,
            )
        else
          const SizedBox(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
                color: context
                    .watch<TaskListViewModel>()
                    .currentTaskList
                    .themeColor),
            title: Consumer<TaskListViewModel>(
                builder: (context, taskListViewModel, child) {
              return Text(
                taskListViewModel.currentTaskList.title,
                style: TextStyle(
                  fontSize: 24,
                  color: taskListViewModel.currentTaskList.themeColor,
                ),
              );
            }),
            actions: [
              TaskListPopupMenu(
                toRemove: (currentTaskList.id == '1')
                    ? (['rename_list', 'hide_completed_tasks', 'delete_list'])
                    : (['hide_completed_tasks']),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<TaskListViewModel>(
              builder: (context, taskListViewModel, child) {
                TaskList taskList = taskListViewModel.currentTaskList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (taskList.sortByType != null)
                        ? const ChangeSortTypeButton()
                        : const SizedBox(),
                    const IncompleteList(),
                    const CompletedList()
                  ],
                );
              },
            ),
          ),
          floatingActionButton: AddTaskFloatingButton(
            taskList: currentTaskList,
            themeColor: currentTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
