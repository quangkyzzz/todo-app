import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/components/item_icon.dart';
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
    List<String>? step = widget.task.step;
    DateTime? dueDate = widget.task.dueDate;
    DateTime? notiTime = widget.task.notiTime;
    String? filePath = widget.task.filePath;
    String? note = widget.task.note;
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
              Row(
                children: [
                  (step != null)
                      ? ItemIcon(text: step.toString())
                      : const SizedBox(),
                  (dueDate != null)
                      ? ItemIcon(text: dueDate.toString())
                      : const SizedBox(),
                  (notiTime != null)
                      ? ItemIcon(text: notiTime.toString())
                      : const SizedBox(),
                  (filePath != null)
                      ? const ItemIcon(icon: Icons.attach_file_outlined)
                      : const SizedBox(),
                  (note != null)
                      ? const ItemIcon(icon: Icons.note_outlined)
                      : const SizedBox(),
                ],
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              print('tap');
              setState(() {
                print(isImportant);
                isImportant = !isImportant;
              });
            },
            child: (isImportant)
                ? const Icon(
                    Icons.star,
                    color: AppConfigs.blueColor,
                  )
                : const Icon(Icons.star_border_outlined),
          )
        ],
      ),
    );
  }
}
