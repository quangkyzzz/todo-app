// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatefulWidget {
  final TaskModel task;
  final TaskListModel taskList;
  final Color themeColor;
  const TaskListItem({
    super.key,
    required this.task,
    required this.taskList,
    required this.themeColor,
  });

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late bool isFirstIcon;
  late TaskListProvider taskListProvider;
  late String myTitle;
  late bool isImportant;
  late bool isOnMyDay;
  late bool isChecked;
  late List<StepModel>? steps;
  late DateTime? dueDate;
  late DateTime? notiTime;
  late String? repeatFrequency;
  late List<String>? filePath;
  late String? note;
  late int countCompletedStep;

  @override
  void initState() {
    isFirstIcon = true;
    myTitle = widget.task.title;
    isImportant = widget.task.isImportant;
    isOnMyDay = widget.task.isOnMyDay;
    isChecked = widget.task.isCompleted;
    steps = widget.task.stepList;
    dueDate = widget.task.dueDate;
    notiTime = widget.task.remindTime;
    repeatFrequency = widget.task.repeatFrequency;
    filePath = widget.task.filePath;
    note = widget.task.note;
    countCompletedStep = 0;
    if (steps != null) {
      for (var element in steps!) {
        if (element.isCompleted) countCompletedStep++;
      }
    }
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskListItem oldWidget) {
    isFirstIcon = true;
    myTitle = widget.task.title;
    isImportant = widget.task.isImportant;
    isOnMyDay = widget.task.isOnMyDay;
    isChecked = widget.task.isCompleted;
    steps = widget.task.stepList;
    dueDate = widget.task.dueDate;
    notiTime = widget.task.remindTime;
    repeatFrequency = widget.task.repeatFrequency;
    filePath = widget.task.filePath;
    note = widget.task.note;
    countCompletedStep = 0;
    if (steps != null) {
      for (var element in steps!) {
        if (element.isCompleted) countCompletedStep++;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi');

    bool isAllBottomIconNull = ((!isOnMyDay) &&
        (steps == null) &&
        (dueDate == null) &&
        (notiTime == null) &&
        (repeatFrequency == null) &&
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
            arguments: {
              'task': widget.task,
              'taskList': widget.taskList,
            },
          );
        },
        child: Row(
          children: [
            Checkbox(
              checkColor: (widget.themeColor == MyTheme.whiteColor)
                  ? MyTheme.blackColor
                  : null,
              activeColor: widget.themeColor,
              tristate: false,
              shape: const CircleBorder(),
              value: isChecked,
              onChanged: (bool? value) {
                taskListProvider.updateTask(
                  taskListID: widget.taskList.id,
                  taskID: widget.task.id,
                  newTask: widget.task.copyWith(isCompleted: value),
                );
              },
            ),
            (isAllBottomIconNull)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        myTitle,
                        style: MyTheme.itemTextStyle,
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        myTitle,
                        style: MyTheme.itemTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Builder(builder: (context) {
                            if (isOnMyDay) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.wb_sunny_outlined,
                                text: 'My Day',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (steps != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                text:
                                    '$countCompletedStep of ${steps!.length.toString()}',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (dueDate != null) {
                              bool tempFirstIcon = isFirstIcon;
                              bool isOverDue = false;
                              DateTime today = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              );
                              (dueDate!.isBefore(today))
                                  ? isOverDue = true
                                  : isOverDue = false;
                              isFirstIcon = false;

                              return ItemBottomIcon(
                                textIcon: Icons.calendar_today_outlined,
                                text:
                                    '${DateFormat('E, MMM d').format(dueDate!)}',
                                isFirstIcon: tempFirstIcon,
                                isOverdue: isOverDue,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (notiTime != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.notifications_outlined,
                                text: ((dueDate == null) && (!isOnMyDay))
                                    ? '${DateFormat('E, MMM d').format(notiTime!)}'
                                    : '',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (repeatFrequency != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.repeat_outlined,
                                text: '',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (filePath != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                icon: Icons.attach_file_outlined,
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (note != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                icon: Icons.note_outlined,
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
            const Spacer(),
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: () {
                  taskListProvider.updateTask(
                    taskListID: widget.taskList.id,
                    taskID: widget.task.id,
                    newTask: widget.task.copyWith(isImportant: !isImportant),
                  );
                },
                icon: (isImportant)
                    ? Icon(
                        Icons.star,
                        color: widget.themeColor,
                      )
                    : const Icon(
                        Icons.star_border_outlined,
                        color: MyTheme.greyColor,
                      ),
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
  final bool isOverdue;
  final bool isFirstIcon;
  const ItemBottomIcon({
    required this.isFirstIcon,
    super.key,
    this.text,
    this.icon,
    this.textIcon,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    return (text != null)
        ? Row(
            children: [
              (!isFirstIcon)
                  ? Transform.scale(
                      scale: 0.3,
                      child: const Icon(
                        Icons.star,
                        size: 12,
                      ),
                    )
                  : const SizedBox(),
              (textIcon != null)
                  ? Icon(
                      textIcon,
                      size: 12,
                      color: (isOverdue) ? MyTheme.redColor : MyTheme.greyColor,
                    )
                  : const SizedBox(),
              const SizedBox(width: 2),
              Text(
                text!,
                style: (isOverdue)
                    ? MyTheme.itemExtraSmallRedTextStyle
                    : MyTheme.itemExtraSmallGreyTextStyle,
              ),
            ],
          )
        : Row(
            children: [
              (!isFirstIcon)
                  ? Transform.scale(
                      scale: 0.3,
                      child: const Icon(
                        Icons.star,
                        size: 12,
                      ),
                    )
                  : const SizedBox(),
              Icon(
                icon,
                size: 16,
                color: MyTheme.greyColor,
              ),
            ],
          );
  }
}
