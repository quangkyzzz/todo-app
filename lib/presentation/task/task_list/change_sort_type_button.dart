import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../provider/settings_provider.dart';
import '../../../view_models/task_list_view_model.dart';

class ChangeSortTypeButton extends StatefulWidget {
  final TaskList taskList;
  const ChangeSortTypeButton({
    super.key,
    required this.taskList,
  });

  @override
  State<ChangeSortTypeButton> createState() => _ChangeSortTypeButtonState();
}

class _ChangeSortTypeButtonState extends State<ChangeSortTypeButton> {
  late TaskListViewModel taskListViewModel;
  late SettingsProvider settingsProvider;
  @override
  void initState() {
    taskListViewModel = context.read<TaskListViewModel>();
    settingsProvider = context.read<SettingsProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            taskListViewModel.sortTaskListBy(
              sortType: widget.taskList.sortByType!['sortType'],
              isAscending: !widget.taskList.sortByType!['asc'],
            );
            taskListViewModel.updateTaskListWith(
              settings: context.read<SettingsProvider>().settings,
              sortByType: {
                'sortType': widget.taskList.sortByType!['sortType'],
                'asc': !widget.taskList.sortByType!['asc'],
              },
            );
          },
          child: Row(
            children: [
              Text(
                'Sort by ${widget.taskList.sortByType!['sortType']}',
                style: TextStyle(color: widget.taskList.themeColor),
              ),
              (widget.taskList.sortByType!['asc'])
                  ? Icon(Icons.expand_more, color: widget.taskList.themeColor)
                  : Icon(Icons.keyboard_arrow_up_outlined,
                      color: widget.taskList.themeColor),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            taskListViewModel.sortTaskListBy(
              sortType: 'create date',
              isAscending:
                  (settingsProvider.settings.isAddNewTaskOnTop) ? false : true,
            );
            taskListViewModel.updateTaskListWithNull(setSortByType: true);
          },
          icon: Icon(
            Icons.close_outlined,
            size: 16,
            color: widget.taskList.themeColor,
          ),
        ),
      ],
    );
  }
}
