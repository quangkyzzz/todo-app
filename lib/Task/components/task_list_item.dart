import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Theme/theme.dart';

class TaskListItem extends StatefulWidget {
  final TaskModel task;
  const TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    bool isImportant = false;
    bool isChecked = false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppConfigs.backgroundGreyColor,
      ),
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Checkbox(
            tristate: false,
            shape: const CircleBorder(),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                print(value);
                isChecked = value!;
              });
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: const TextStyle(
                  color: AppConfigs.whiteColor,
                  fontSize: 25,
                ),
              ),
              const Text(
                'due date',
                style: TextStyle(color: AppConfigs.greyColor),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              print('tap');
              setState(() {
                isImportant = !isImportant;
              });
            },
            child: const Icon(Icons.star_border_outlined),
          )
        ],
      ),
    );
  }
}
