import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class AddFloatingButton extends StatelessWidget {
  final TaskListModel taskList;
  const AddFloatingButton({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return AddTaskItem(
              taskList: taskList,
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        size: 40,
        color: MyTheme.whiteColor,
      ),
    );
  }
}

// ignore: must_be_immutable
class AddTaskItem extends StatelessWidget {
  bool isChecked;
  TextEditingController controller = TextEditingController();
  final TaskListModel taskList;
  AddTaskItem({
    super.key,
    this.isChecked = false,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
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
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Add a task',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<TaskListProvider>(context, listen: false)
                      .createTask(
                    taskListID: taskList.id,
                    taskName: controller.text,
                    isCompleted: isChecked,
                  );
                  Navigator.pop(context);
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
