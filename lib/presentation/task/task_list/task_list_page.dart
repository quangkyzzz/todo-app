import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.haveCompletedList)
            ? Text(
                widget.taskList.listName,
                style: const TextStyle(
                  fontSize: 24,
                  color: MyTheme.blueColor,
                ),
              )
            : const Text(
                'Important',
                style: TextStyle(
                  fontSize: 24,
                  color: MyTheme.pinkColor,
                ),
              ),
        actions: const [
          PopupMenu(
            toRemove: ['hide_completed_tasks'],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          IncompleteList(taskList: widget.taskList),
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
                      taskList: widget.taskList,
                    ),
                  ],
                )
              : const SizedBox()
        ]),
      ),
      floatingActionButton: const AddFloatingButton(),
    );
  }
}
