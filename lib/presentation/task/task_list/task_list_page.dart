import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/lists/completed_list.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/provider/task_list_provider.dart';

class TaskListPage extends StatefulWidget {
  final bool haveCompletedList;
  final TaskListModel taskList;
  const TaskListPage({
    super.key,
    this.haveCompletedList = true,
    required this.taskList,
  });

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isExpanded = true;
  late final String id;

  @override
  void initState() {
    id = widget.taskList.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Consumer<TaskListProvider>(builder: (context, taskListProvider, child) {
          TaskListModel tasklist =
              taskListProvider.getTaskList(taskListID: widget.taskList.id);
          return (tasklist.backgroundImage != null)
              ? Image.file(
                  tasklist.backgroundImage!,
                  fit: BoxFit.fitHeight,
                )
              : const SizedBox();
        }),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
                color: context
                    .watch<TaskListProvider>()
                    .getTaskList(taskListID: id)
                    .themeColor),
            title: Consumer<TaskListProvider>(
                builder: (context, taskListProvider, child) {
              return Text(
                taskListProvider.getTaskList(taskListID: id).listName,
                style: TextStyle(
                  fontSize: 24,
                  color: widget.taskList.themeColor,
                ),
              );
            }),
            actions: [
              PopupMenu(
                taskList: widget.taskList,
                toRemove: (id == '1')
                    ? (['rename_list', 'hide_completed_tasks', 'delete_list'])
                    : (['hide_completed_tasks']),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<TaskListProvider>(
              builder: (context, taskListProvider, child) {
                TaskListModel taskList =
                    taskListProvider.getTaskList(taskListID: id);

                return Column(children: [
                  IncompleteList(taskList: taskList),
                  ((widget.haveCompletedList))
                      ? CompletedList(taskList: taskList)
                      : const SizedBox()
                ]);
              },
            ),
          ),
          floatingActionButton: AddFloatingButton(
            taskList: widget.taskList,
            themeColor: widget.taskList.themeColor,
          ),
        ),
      ],
    );
  }
}
