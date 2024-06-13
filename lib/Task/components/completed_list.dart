import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/components/task_list_item.dart';

class CompletedList extends StatelessWidget {
  final List<Map<String, dynamic>> taskList;
  const CompletedList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: taskList.length,
      itemBuilder: (BuildContext context, int index) {
        TaskModel task = TaskModel.fromMap(taskList[index]);
        return TaskListItem(
          task: task,
        );
      },
    );
  }
}