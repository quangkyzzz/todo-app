import 'package:flutter/material.dart';
import '../../models/task_list.dart';
import '../../models/task.dart';
import '../items/task_list_item.dart';

class IncompleteList extends StatelessWidget {
  final TaskList taskList;
  const IncompleteList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    List<Task> incompleteList =
        taskList.tasks.where((element) => (!element.isCompleted)).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: incompleteList.length,
      itemBuilder: (BuildContext _, int index) {
        Task task = incompleteList[index];
        return TaskListItem(
          mContext: context,
          task: task,
          themeColor: taskList.themeColor,
        );
      },
    );
  }
}
