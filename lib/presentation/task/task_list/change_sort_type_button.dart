import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../provider/settings_provider.dart';
import '../../../view_models/task_list_view_model.dart';

class ChangeSortTypeButton extends StatelessWidget {
  const ChangeSortTypeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TaskList watchCurrentTaskList =
        context.watch<TaskListViewModel>().currentTaskList;
    return Row(
      children: [
        TextButton(
          onPressed: () {
            TaskList readCurrentTaskList =
                context.read<TaskListViewModel>().currentTaskList;
            context.read<TaskListViewModel>().sortTaskListBy(
                  sortType: readCurrentTaskList.sortByType!['sortType'],
                  isAscending: !readCurrentTaskList.sortByType!['asc'],
                );
            TaskList updatedTaskList = readCurrentTaskList.copyWith(
              sortByType: {
                'sortType': readCurrentTaskList.sortByType!['sortType'],
                'asc': !readCurrentTaskList.sortByType!['asc'],
              },
            );
            context
                .read<TaskListViewModel>()
                .updateTaskList(updatedTaskList: updatedTaskList);
          },
          child: Row(
            children: [
              Text(
                'Sort by '
                '${watchCurrentTaskList.sortByType!['sortType']}',
                style: TextStyle(color: watchCurrentTaskList.themeColor),
              ),
              (watchCurrentTaskList.sortByType!['asc'])
                  ? Icon(Icons.expand_more,
                      color: watchCurrentTaskList.themeColor)
                  : Icon(Icons.keyboard_arrow_up_outlined,
                      color: watchCurrentTaskList.themeColor),
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
            TaskList updatedTaskList =
                context.read<TaskListViewModel>().currentTaskList;
            updatedTaskList.sortByType = null;
            context
                .read<TaskListViewModel>()
                .updateTaskList(updatedTaskList: updatedTaskList);
          },
          icon: Icon(
            Icons.close_outlined,
            size: 16,
            color: watchCurrentTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
