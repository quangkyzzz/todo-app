// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ultility/enum.dart';
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
                    sortType: SortType.important,
                    isAscending: false,
                  );

              context.read<TaskListViewModel>().updateSortType(
                    newSortType: SortType.important,
                    isAscending: false,
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
                    sortType: SortType.dueDate,
                    isAscending: true,
                  );

              context
                  .read<TaskListViewModel>()
                  .updateSortType(newSortType: SortType.dueDate);

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
                    sortType: SortType.myDay,
                    isAscending: false,
                  );

              context.read<TaskListViewModel>().updateSortType(
                    newSortType: SortType.myDay,
                    isAscending: false,
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
                    sortType: SortType.alphabetically,
                    isAscending: true,
                  );

              context.read<TaskListViewModel>().updateSortType(
                    newSortType: SortType.alphabetically,
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
                    sortType: SortType.createDate,
                    isAscending: true,
                  );

              context.read<TaskListViewModel>().updateSortType(
                    newSortType: SortType.createDate,
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
