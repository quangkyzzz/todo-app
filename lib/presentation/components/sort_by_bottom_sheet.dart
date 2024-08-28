// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_list_model.dart';
import '../items/popup_item.dart';
import '../../provider/task_list_provider.dart';
import '../../themes.dart';

class SortByBottomSheet extends StatelessWidget {
  final TaskListModel taskList;
  const SortByBottomSheet({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    TaskListProvider taskListProvider =
        Provider.of<TaskListProvider>(context, listen: false);
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
            onTap: () {
              taskListProvider.sortTaskListBy(
                taskListID: taskList.id,
                sortType: 'important',
                isAscending: false,
              );
              taskListProvider.updateTaskListWith(
                taskListID: taskList.id,
                sortByType: {
                  'sortType': 'important',
                  'asc': false,
                },
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
              taskListProvider.sortTaskListBy(
                taskListID: taskList.id,
                sortType: 'due date',
                isAscending: true,
              );
              taskListProvider.updateTaskListWith(
                taskListID: taskList.id,
                sortByType: {
                  'sortType': 'due date',
                  'asc': true,
                },
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
              taskListProvider.sortTaskListBy(
                taskListID: taskList.id,
                sortType: 'my day',
                isAscending: false,
              );
              taskListProvider.updateTaskListWith(
                taskListID: taskList.id,
                sortByType: {
                  'sortType': 'my day',
                  'asc': false,
                },
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
              taskListProvider.sortTaskListBy(
                taskListID: taskList.id,
                sortType: 'alphabetically',
                isAscending: true,
              );
              taskListProvider.updateTaskListWith(
                taskListID: taskList.id,
                sortByType: {
                  'sortType': 'alphabetically',
                  'asc': true,
                },
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
              taskListProvider.sortTaskListBy(
                taskListID: taskList.id,
                sortType: 'create date',
                isAscending: true,
              );
              taskListProvider.updateTaskListWith(
                taskListID: taskList.id,
                sortByType: {
                  'sortType': 'create date',
                  'asc': true,
                },
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
