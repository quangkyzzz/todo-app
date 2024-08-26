import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class AddFloatingButton extends StatelessWidget {
  final Color themeColor;
  final TaskListModel taskList;
  final bool isAddToImportant;
  final bool isAddToMyDay;

  const AddFloatingButton({
    super.key,
    required this.taskList,
    required this.themeColor,
    this.isAddToMyDay = false,
    this.isAddToImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeColor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return AddTaskItem(
              taskList: taskList,
              isAddToMyDay: isAddToMyDay,
              isAddToImportant: isAddToImportant,
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        size: 40,
        color: (themeColor == MyTheme.whiteColor)
            ? MyTheme.blackColor
            : MyTheme.whiteColor,
      ),
    );
  }
}

class AddTaskItem extends StatelessWidget {
  final bool isAddToMyDay;
  final bool isAddToImportant;
  final TextEditingController _controller = TextEditingController();
  final TaskListModel taskList;
  AddTaskItem(
      {super.key,
      required this.taskList,
      required this.isAddToMyDay,
      required this.isAddToImportant});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                shape: const CircleBorder(),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Add a task',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (isAddToMyDay) {
                    Provider.of<TaskListProvider>(context, listen: false)
                        .createTask(
                      taskListID: taskList.id,
                      taskName: _controller.text,
                      isCompleted: isChecked,
                      isOnMyDay: true,
                    );
                  } else if (isAddToImportant) {
                    Provider.of<TaskListProvider>(context, listen: false)
                        .createTask(
                      taskListID: taskList.id,
                      taskName: _controller.text,
                      isCompleted: isChecked,
                      isImportant: true,
                    );
                  } else {
                    Provider.of<TaskListProvider>(context, listen: false)
                        .createTask(
                      taskListID: taskList.id,
                      taskName: _controller.text,
                      isCompleted: isChecked,
                    );
                  }
                  setState(() {
                    isChecked = false;
                  });
                  _controller.clear();
                },
                icon: const Icon(Icons.arrow_upward),
              )
            ],
          ),
        );
      },
    );
  }
}
