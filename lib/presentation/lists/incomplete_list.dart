import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';

class IncompleteList extends StatelessWidget {
  final bool isReorderState;
  const IncompleteList({super.key, required this.isReorderState});

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
          isReorderState: isReorderState,
          task: task,
          themeColor:
              context.watch<TaskListViewModel>().currentTaskList.themeColor,
        );
      },
    );
  }
}
