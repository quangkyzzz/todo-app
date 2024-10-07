// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_list.dart';
import '../../view_models/task_list_view_model.dart';
import '../items/popup_item.dart';
import '../../themes.dart';

class SortByBottomSheet extends StatelessWidget {
  const SortByBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: MyTheme.itemTextStyle,
          ),
          const SizedBox(height: 8),
          InkWell(
            //fix sortByType to enum
            onTap: () {
              context.read<TaskListViewModel>().sortTaskListBy(
                    sortType: 'important',
                    isAscending: false,
                  );

              TaskList updatedTaskList =
                  context.read<TaskListViewModel>().currentTaskList;
              updatedTaskList.sortByType = {
                'sortType': 'important',
                'asc': false,
              };
              context.read<TaskListViewModel>().updateTaskList(
                    updatedTaskList: updatedTaskList,
                  );

              Navigator.pop(context);
            },
            child: const CustomPopupItem(
              text: 'Important',
              icon: Icons.star_border_outlined,
            ),
          ),
          InkWell(
            onTap: () {
              context.read<TaskListViewModel>().sortTaskListBy(
                    sortType: 'due date',
                    isAscending: true,
                  );

              TaskList updatedTaskList =
                  context.read<TaskListViewModel>().currentTaskList;
              updatedTaskList.sortByType = {
                'sortType': 'due date',
                'asc': true,
              };
              context.read<TaskListViewModel>().updateTaskList(
                    updatedTaskList: updatedTaskList,
                  );

              Navigator.pop(context);
            },
            child: const CustomPopupItem(
              text: 'Due date',
              icon: Icons.calendar_today_outlined,
            ),
          ),
          InkWell(
            onTap: () {
              context.read<TaskListViewModel>().sortTaskListBy(
                    sortType: 'my day',
                    isAscending: false,
                  );
              TaskList updatedTaskList =
                  context.read<TaskListViewModel>().currentTaskList;
              updatedTaskList.sortByType = {
                'sortType': 'my day',
                'asc': false,
              };
              context.read<TaskListViewModel>().updateTaskList(
                    updatedTaskList: updatedTaskList,
                  );
              Navigator.pop(context);
            },
            child: const CustomPopupItem(
              text: 'Added to My Day',
              icon: Icons.wb_sunny_outlined,
            ),
          ),
          InkWell(
            onTap: () {
              context.read<TaskListViewModel>().sortTaskListBy(
                    sortType: 'alphabetically',
                    isAscending: true,
                  );

              TaskList updatedTaskList =
                  context.read<TaskListViewModel>().currentTaskList;
              updatedTaskList.sortByType = {
                'sortType': 'alphabetically',
                'asc': true,
              };
              context.read<TaskListViewModel>().updateTaskList(
                    updatedTaskList: updatedTaskList,
                  );

              Navigator.pop(context);
            },
            child: const CustomPopupItem(
              text: 'Alphabetically',
              icon: Icons.import_export_outlined,
            ),
          ),
          InkWell(
            onTap: () {
              context.read<TaskListViewModel>().sortTaskListBy(
                    sortType: 'create date',
                    isAscending: true,
                  );

              TaskList updatedTaskList =
                  context.read<TaskListViewModel>().currentTaskList;
              updatedTaskList.sortByType = {
                'sortType': 'create date',
                'asc': true,
              };
              context.read<TaskListViewModel>().updateTaskList(
                    updatedTaskList: updatedTaskList,
                  );

              Navigator.pop(context);
            },
            child: const CustomPopupItem(
              text: 'Creation date',
              icon: Icons.more_time_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
