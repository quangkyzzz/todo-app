import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: (widget.haveCompletedList)
            ? Consumer<TaskListProvider>(
                builder: (context, taskListProvider, child) {
                return Text(
                  taskListProvider.taskLists
                      .firstWhere((element) => element.id == id)
                      .listName,
                  style: const TextStyle(
                    fontSize: 24,
                    color: MyTheme.blueColor,
                  ),
                );
              })
            : const Text(
                'Important',
                style: TextStyle(
                  fontSize: 24,
                  color: MyTheme.pinkColor,
                ),
              ),
        actions: [
          PopupMenu(
            taskList: widget.taskList,
            toRemove: const ['hide_completed_tasks'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<TaskListProvider>(
          builder: (context, taskListProvider, child) {
            TaskListModel taskList = taskListProvider.taskLists
                .firstWhere((element) => (element.id == widget.taskList.id));
            return Column(children: [
              IncompleteList(taskList: taskList),
              (widget.haveCompletedList)
                  ? ExpansionTile(
                      initiallyExpanded: true,
                      title: const Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 18,
                          color: MyTheme.blueColor,
                        ),
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          isExpanded = expanded;
                        });
                      },
                      trailing: Icon(isExpanded
                          ? Icons.expand_more
                          : Icons.keyboard_arrow_left),
                      children: [
                        IncompleteList(
                          taskList: taskList,
                        ),
                      ],
                    )
                  : const SizedBox()
            ]);
          },
        ),
      ),
      floatingActionButton: AddFloatingButton(
        taskList: widget.taskList,
      ),
    );
  }
}
