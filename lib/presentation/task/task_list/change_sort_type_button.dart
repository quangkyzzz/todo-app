import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';

class ChangeSortTypeButton extends StatefulWidget {
  final TaskListModel taskList;
  const ChangeSortTypeButton({
    super.key,
    required this.taskList,
  });

  @override
  State<ChangeSortTypeButton> createState() => _ChangeSortTypeButtonState();
}

class _ChangeSortTypeButtonState extends State<ChangeSortTypeButton> {
  late TaskListProvider taskListProvider;
  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            taskListProvider.sortTaskListBy(
              taskListID: widget.taskList.id,
              sortType: widget.taskList.sortByType!['sortType'],
              isAscending: !widget.taskList.sortByType!['asc'],
            );
            taskListProvider.updateTaskListWith(
              taskListID: widget.taskList.id,
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
            taskListProvider.sortTaskListBy(
              taskListID: widget.taskList.id,
              sortType: 'create date',
              isAscending: true,
            );
            TaskListModel newTaskList = widget.taskList.copyWith();
            newTaskList.sortByType = null;
            taskListProvider.updateTaskList(
              taskListID: widget.taskList.id,
              newTaskList: newTaskList,
            );
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
