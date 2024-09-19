import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_list.dart';
import '../../models/task.dart';
import '../../provider/settings_provider.dart';
import '../../view_models/task_list_view_model.dart';
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
          taskList: taskList,
          themeColor: taskList.themeColor,
          onTapCheck: (bool? value) {
            Task newTask = task.copyWith(isCompleted: value);
            context.read<TaskListViewModel>().updateTaskListWith(
                  settings: context.read<SettingsProvider>().settings,
                  newTask: newTask,
                );
          },
          onTapStar: () {
            Task newTask = task.copyWith(isImportant: !task.isImportant);
            context.read<TaskListViewModel>().updateTaskListWith(
                  settings: context.read<SettingsProvider>().settings,
                  newTask: newTask,
                );
          },
        );
      },
    );
  }
}
