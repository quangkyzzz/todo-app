import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../provider/settings_provider.dart';
import '../../../ultility/enum.dart';
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
                  sortType: readCurrentTaskList.sortByType!,
                  isAscending: !readCurrentTaskList.isAscending,
                );
            context.read<TaskListViewModel>().updateSortType(
                newSortType: readCurrentTaskList.sortByType,
                isAscending: !readCurrentTaskList.isAscending);
          },
          child: Row(
            children: [
              Text(
                'Sort by '
                '${watchCurrentTaskList.sortByType!.value}',
                style: TextStyle(color: watchCurrentTaskList.themeColor),
              ),
              (watchCurrentTaskList.isAscending)
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
                  sortType: SortType.createDate,
                  isAscending: (context
                          .read<SettingsProvider>()
                          .settings
                          .isAddNewTaskOnTop)
                      ? false
                      : true,
                );
            context.read<TaskListViewModel>().updateSortType(newSortType: null);
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
