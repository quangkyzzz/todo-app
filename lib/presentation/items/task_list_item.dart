// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart' hide Step;
import 'package:provider/provider.dart';
import '../../models/task_step.dart';
import '../../models/task_list.dart';
import '../../themes.dart';
import '../../routes.dart';
import '../../models/task.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../view_models/task_list_view_model.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final TaskList taskList;
  final Color themeColor;
  final bool havePlusIcon;
  final Function()? onTapPlus;

  const TaskListItem({
    super.key,
    required this.task,
    required this.taskList,
    required this.themeColor,
    this.havePlusIcon = false,
    this.onTapPlus,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstIcon = true;
    String myTitle = task.title;
    bool isImportant = task.isImportant;
    bool isOnMyDay = task.isOnMyDay;
    bool isChecked = task.isCompleted;
    List<TaskStep>? steps = task.stepList;
    DateTime? dueDate = task.dueDate;
    DateTime? remindTime = task.remindTime;
    String? repeatFrequency = task.repeatFrequency;
    List<String>? filePath = task.filePath;
    String? note = task.note;
    int countCompletedStep = 0;
    if (steps != null) {
      for (var step in steps) {
        if (step.isCompleted) countCompletedStep++;
      }
    }
    TaskListViewModel taskListViewModel = context.watch<TaskListViewModel>();
    initializeDateFormatting('vi');
    double screenWidth = MediaQuery.of(context).size.width;
    bool isAllBottomIconNull = ((!isOnMyDay) &&
        (steps == null) &&
        (dueDate == null) &&
        (remindTime == null) &&
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
        onTap: () async {
          await Navigator.of(context).pushNamed(
            taskRoute,
            arguments: {
              'task': task,
              'taskList': taskList,
            },
          );
        },
        child: Row(
          children: [
            Checkbox(
              checkColor: (themeColor == MyTheme.whiteColor)
                  ? MyTheme.blackColor
                  : null,
              activeColor: themeColor,
              tristate: false,
              shape: const CircleBorder(),
              value: isChecked,
              onChanged: (bool? value) async {
                await taskListViewModel.updateTask(
                  taskListID: taskList.id,
                  taskID: task.id,
                  newTask: task.copyWith(isCompleted: value),
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
                      SizedBox(
                        width: screenWidth * 0.65,
                        child: Text(
                          myTitle,
                          overflow: TextOverflow.ellipsis,
                          style: MyTheme.itemTextStyle,
                        ),
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
                                text:
                                    ((dueDate == null) || (remindTime == null))
                                        ? 'My Day'
                                        : '',
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
                                    '$countCompletedStep of ${steps.length.toString()}',
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
                              (dueDate.isBefore(today))
                                  ? isOverDue = true
                                  : isOverDue = false;
                              isFirstIcon = false;

                              return ItemBottomIcon(
                                textIcon: Icons.calendar_today_outlined,
                                text:
                                    '${DateFormat('E, MMM d').format(dueDate)}',
                                isFirstIcon: tempFirstIcon,
                                isOverdue: isOverDue,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (remindTime != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.notifications_outlined,
                                text: ((dueDate == null) && (!isOnMyDay))
                                    ? '${DateFormat('E, MMM d').format(remindTime)}'
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
              child: (!havePlusIcon)
                  ? IconButton(
                      onPressed: () async {
                        await taskListViewModel.updateTask(
                          taskListID: taskList.id,
                          taskID: task.id,
                          newTask: task.copyWith(isImportant: !isImportant),
                        );
                      },
                      icon: (isImportant)
                          ? Icon(
                              Icons.star,
                              color: themeColor,
                            )
                          : const Icon(
                              Icons.star_border_outlined,
                              color: MyTheme.greyColor,
                            ),
                    )
                  : IconButton(
                      onPressed: onTapPlus,
                      icon: const Icon(Icons.add),
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
