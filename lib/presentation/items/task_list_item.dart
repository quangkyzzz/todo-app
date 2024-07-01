// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
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

    List<StepModel>? step = widget.task.stepList;
    DateTime? dueDate = widget.task.dueDate;
    DateTime? notiTime = widget.task.notiTime;
    String? filePath = widget.task.filePath;
    String? note = widget.task.note;
    bool isAllBottomIconNull = ((step == null) &&
        (dueDate == null) &&
        (notiTime == null) &&
        (filePath == null) &&
        (note == null));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyTheme.backgroundGreyColor,
      ),
      height: 60,
      margin: const EdgeInsets.only(bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
            (isAllBottomIconNull)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.task.title,
                        style: MyTheme.itemTextStyle,
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        widget.task.title,
                        style: MyTheme.itemTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          (step != null)
                              ? ItemBottomIcon(
                                  text: '0 of ${step.length.toString()}')
                              : const SizedBox(),
                          const SizedBox(width: 6),
                          (dueDate != null)
                              ? ItemBottomIcon(
                                  textIcon: Icons.calendar_today_outlined,
                                  text:
                                      '${DateFormat.MMMEd('en_US').format(dueDate)}')
                              : const SizedBox(),
                          const SizedBox(width: 6),
                          (notiTime != null)
                              ? ItemBottomIcon(
                                  textIcon: Icons.notifications_outlined,
                                  text:
                                      '${DateFormat.MMMEd('en_US').format(notiTime)}')
                              : const SizedBox(),
                          const SizedBox(width: 6),
                          (filePath != null)
                              ? const ItemBottomIcon(
                                  icon: Icons.attach_file_outlined)
                              : const SizedBox(),
                          const SizedBox(width: 6),
                          (note != null)
                              ? const ItemBottomIcon(icon: Icons.note_outlined)
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
                      color: MyTheme.blueColor,
                    )
                  : const Icon(
                      Icons.star_border_outlined,
                      color: MyTheme.greyColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemBottomIcon extends StatelessWidget {
  final IconData? textIcon;
  final String? text;
  final IconData? icon;
  const ItemBottomIcon({
    super.key,
    this.text,
    this.icon,
    this.textIcon,
  });

  @override
  Widget build(BuildContext context) {
    return (text != null)
        ? Row(
            children: [
              (textIcon != null)
                  ? Icon(
                      textIcon,
                      size: 12,
                      color: MyTheme.greyColor,
                    )
                  : const SizedBox(),
              Text(
                text!,
                style: MyTheme.itemExtraSmallGreyTextStyle,
              ),
            ],
          )
        : Icon(
            icon,
            size: 16,
            color: MyTheme.greyColor,
          );
  }
}
