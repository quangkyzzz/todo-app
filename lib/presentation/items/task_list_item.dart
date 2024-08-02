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

//TODO: add my day icon
class TaskListItem extends StatefulWidget {
  final TaskModel task;
  final TaskListModel taskList;
  const TaskListItem({
    super.key,
    required this.task,
    required this.taskList,
  });

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late bool isFirstIcon;
  late TaskListProvider taskListProvider;
  late String myTitle;
  late bool isImportant;
  late bool isChecked;
  late List<StepModel>? steps;
  late DateTime? dueDate;
  late DateTime? notiTime;
  late String? filePath;
  late String? note;
  late int countCompletedStep;

  @override
  void initState() {
    isFirstIcon = true;
    myTitle = widget.task.title;
    isImportant = widget.task.isImportant;
    isChecked = widget.task.isCompleted;
    steps = widget.task.stepList;
    dueDate = widget.task.dueDate;
    notiTime = widget.task.remindTime;
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

  //TODO: fix seperate dot between 2 icon
  @override
  void didUpdateWidget(covariant TaskListItem oldWidget) {
    isFirstIcon = true;
    myTitle = widget.task.title;
    isImportant = widget.task.isImportant;
    isChecked = widget.task.isCompleted;
    steps = widget.task.stepList;
    dueDate = widget.task.dueDate;
    notiTime = widget.task.remindTime;
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

    bool isAllBottomIconNull = ((steps == null) &&
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
            arguments: {
              'task': widget.task,
              'taskList': widget.taskList,
            },
          );
        },
        child: Row(
          children: [
            Checkbox(
              activeColor: MyTheme.blueColor,
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
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.calendar_today_outlined,
                                text:
                                    '${DateFormat.MMMEd('en_US').format(dueDate!)}',
                                isFirstIcon: tempFirstIcon,
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
                                text:
                                    '${DateFormat.MMMEd('en_US').format(notiTime!)}',
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
                    ? const Icon(
                        Icons.star,
                        color: MyTheme.blueColor,
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
  final bool isFirstIcon;
  const ItemBottomIcon({
    super.key,
    this.text,
    this.icon,
    this.textIcon,
    required this.isFirstIcon,
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
                      color: MyTheme.greyColor,
                    )
                  : const SizedBox(),
              Text(
                text!,
                style: MyTheme.itemExtraSmallGreyTextStyle,
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
