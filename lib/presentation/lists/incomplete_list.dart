import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';

class IncompleteList extends StatelessWidget {
  final TaskListModel taskList;
  const IncompleteList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: taskList.tasks.length,
      itemBuilder: (BuildContext context, int index) {
        TaskModel task = taskList.tasks[index];
        return TaskListItem(
          task: task,
        );
      },
    );
  }
}
