import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../provider/settings_provider.dart';
import '../../../view_models/task_list_view_model.dart';

class ChangeSortTypeButton extends StatelessWidget {
  final TaskList taskList;
  const ChangeSortTypeButton({
    super.key,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            context.read<TaskListViewModel>().sortTaskListBy(
                  sortType: taskList.sortByType!['sortType'],
                  isAscending: !taskList.sortByType!['asc'],
                );
            TaskList updatedTaskList =
                context.read<TaskListViewModel>().currentTaskList.copyWith(
              sortByType: {
                'sortType': taskList.sortByType!['sortType'],
                'asc': !taskList.sortByType!['asc'],
              },
            );
            context
                .read<TaskListViewModel>()
                .updateTaskList(updatedTaskList: updatedTaskList);
          },
          child: Row(
            children: [
              Text(
                'Sort by ${taskList.sortByType!['sortType']}',
                style: TextStyle(color: taskList.themeColor),
              ),
              (taskList.sortByType!['asc'])
                  ? Icon(Icons.expand_more, color: taskList.themeColor)
                  : Icon(Icons.keyboard_arrow_up_outlined,
                      color: taskList.themeColor),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.read<TaskListViewModel>().sortTaskListBy(
                  sortType: 'create date',
                  isAscending: (context
                          .read<SettingsProvider>()
                          .settings
                          .isAddNewTaskOnTop)
                      ? false
                      : true,
                );
            context
                .read<TaskListViewModel>()
                .updateTaskListWithNull(setSortByType: true);
          },
          icon: Icon(
            Icons.close_outlined,
            size: 16,
            color: taskList.themeColor,
          ),
        ),
      ],
    );
  }
}
