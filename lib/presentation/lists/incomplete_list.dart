import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../view_models/task_list_view_model.dart';
import '../items/task_list_item.dart';

class IncompleteList extends StatelessWidget {
  const IncompleteList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> incompleteList = context
        .watch<TaskListViewModel>()
        .currentTaskList
        .tasks
        .where((element) => (!element.isCompleted))
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: incompleteList.length,
      itemBuilder: (BuildContext _, int index) {
        Task task = incompleteList[index];
        return TaskListItem(
          mContext: context,
          task: task,
          themeColor:
              context.watch<TaskListViewModel>().currentTaskList.themeColor,
        );
      },
    );
  }
}
