import 'package:flutter/material.dart';
import '../../models/task_list_model.dart';
import '../../models/task_model.dart';
import '../items/task_list_item.dart';

class IncompleteList extends StatelessWidget {
  final TaskListModel taskList;
  const IncompleteList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> incompleteList =
        taskList.tasks.where((element) => (!element.isCompleted)).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: incompleteList.length,
      itemBuilder: (BuildContext context, int index) {
        TaskModel task = incompleteList[index];
        return TaskListItem(
          task: task,
          taskList: taskList,
          themeColor: taskList.themeColor,
        );
      },
    );
  }
}
