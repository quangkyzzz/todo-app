// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/components/item_icon.dart';
import 'package:todo_app/Theme/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatefulWidget {
  final TaskModel task;
  const TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi');
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
      margin: const EdgeInsets.only(bottom: 3),
      child: Material(
        child: InkWell(
          onTap: () {},
          splashColor: AppConfigs.whiteColor,
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
                  const SizedBox(height: 5),
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
                          ? ItemIcon(
                              text:
                                  '${DateFormat.MMMEd('en_US').format(dueDate)}')
                          : const SizedBox(),
                      (notiTime != null)
                          ? ItemIcon(
                              text:
                                  '${DateFormat.MMMEd('en_US').add_jm().format(notiTime)}')
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
        ),
      ),
    );
  }
}
