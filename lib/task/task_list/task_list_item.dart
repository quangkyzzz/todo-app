// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/task/task_list/components/task_list_item_bottom_icon.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatefulWidget {
  final TaskModel task;
  const TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late bool isImportant;
  late bool isChecked;

  @override
  void initState() {
    isImportant = widget.task.isImportant;
    isChecked = widget.task.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi');
    List<String>? step = widget.task.step;
    DateTime? dueDate = widget.task.dueDate;
    DateTime? notiTime = widget.task.notiTime;
    String? filePath = widget.task.filePath;
    String? note = widget.task.note;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppConfigs.backgroundGreyColor,
      ),
      height: 60,
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            taskRoute,
            arguments: widget.task,
          );
        },
        child: Row(
          children: [
            Checkbox(
              tristate: false,
              shape: const CircleBorder(),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.task.title,
                  style: AppConfigs.itemTextStyle,
                ),
                Row(
                  children: [
                    (step != null)
                        ? ItemIcon(text: step.toString())
                        : const SizedBox(),
                    const SizedBox(width: 5),
                    (dueDate != null)
                        ? ItemIcon(
                            text:
                                '${DateFormat.MMMEd('en_US').format(dueDate)}')
                        : const SizedBox(),
                    const SizedBox(width: 5),
                    (notiTime != null)
                        ? ItemIcon(
                            text:
                                '${DateFormat.MMMEd('en_US').add_jm().format(notiTime)}')
                        : const SizedBox(),
                    const SizedBox(width: 5),
                    (filePath != null)
                        ? const ItemIcon(icon: Icons.attach_file_outlined)
                        : const SizedBox(),
                    const SizedBox(width: 5),
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
                setState(() {
                  isImportant = !isImportant;
                });
              },
              child: (isImportant)
                  ? const Icon(
                      Icons.star,
                      color: AppConfigs.blueColor,
                    )
                  : const Icon(Icons.star_border_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
