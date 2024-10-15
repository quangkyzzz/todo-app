import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/models/enum.dart';
import 'package:todo_app/models/settings_shared_preference.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';

class ChangeSortTypeButton extends StatelessWidget {
  const ChangeSortTypeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TaskList watchCurrentTaskList =
        context.watch<TaskListViewModel>().currentTaskList;
    String sortByText = '';
    switch (watchCurrentTaskList.sortByType) {
      case SortType.important:
        sortByText = 'important';
      case SortType.dueDate:
        sortByText = 'due date';
      case SortType.myDay:
        sortByText = 'my day';
      case SortType.alphabetically:
        sortByText = 'alphabetically';
      case SortType.createDate:
        sortByText = 'create date';
      case null:
        sortByText = '';
    }
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
                'Sort by $sortByText',
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
                  isAscending:
                      (!SettingsSharedPreference.getIsAddNewTaskOnTop()),
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
