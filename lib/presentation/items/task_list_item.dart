// ignore_for_file: unnecessary_string_interpolations
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/settings_shared_preference.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Color themeColor;
  final bool havePlusIcon;
  final Function()? onTapPlus;
  final bool isReorderState;
  final bool isFirstItem;
  final bool isLastItem;

  const TaskListItem({
    super.key,
    required this.task,
    required this.themeColor,
    this.havePlusIcon = false,
    this.onTapPlus,
    required this.isReorderState,
    this.isFirstItem = false,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstIcon = true;
    unawaited(initializeDateFormatting('vi'));
    double screenWidth = MediaQuery.of(context).size.width;
    bool isAllBottomIconNull = ((!task.isOnMyDay) &&
        (task.stepList.isEmpty) &&
        (task.dueDate == null) &&
        (task.remindTime == null) &&
        (task.repeatFrequency == null) &&
        (task.filePath.isEmpty) &&
        (task.note == ''));
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
              'taskListName': context
                  .read<TaskListViewModel>()
                  .getTaskListByID(task.taskListID)
                  .title,
            },
          );
        },
        child: Row(
          children: [
            isReorderState
                ? Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          color: isLastItem
                              ? MyTheme.greyColor
                              : MyTheme.whiteColor,
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          onPressed: () {
                            if (isLastItem) return;
                            context
                                .read<TaskListViewModel>()
                                .reorderTaskDown(movedTask: task);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          color: isFirstItem
                              ? MyTheme.greyColor
                              : MyTheme.whiteColor,
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          onPressed: () {
                            if (isFirstItem) return;
                            context
                                .read<TaskListViewModel>()
                                .reorderTaskUp(movedTask: task);
                          },
                          icon: const Icon(Icons.keyboard_arrow_up_outlined),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  )
                : Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      checkColor: (themeColor == MyTheme.whiteColor)
                          ? MyTheme.blackColor
                          : null,
                      activeColor: themeColor,
                      tristate: false,
                      shape: const CircleBorder(),
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        context
                            .read<TaskListViewModel>()
                            .updateIsCompleted(task: task, isCompleted: value!);
                      },
                    ),
                  ),
            (isAllBottomIconNull)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.title,
                        style: (task.isCompleted)
                            ? MyTheme.itemDeleteTextStyle
                            : MyTheme.itemTextStyle,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      SizedBox(
                        width: screenWidth * 0.65,
                        child: Text(
                          task.title,
                          overflow: TextOverflow.ellipsis,
                          style: (task.isCompleted)
                              ? MyTheme.itemDeleteTextStyle
                              : MyTheme.itemTextStyle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Builder(builder: (context) {
                            if (task.isOnMyDay) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.wb_sunny_outlined,
                                text: ((task.dueDate == null) ||
                                        (task.remindTime == null))
                                    ? 'My Day'
                                    : '',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (task.stepList.isNotEmpty) {
                              int countCompletedStep = 0;
                              bool tempFirstIcon = isFirstIcon;
                              for (var step in task.stepList) {
                                if (step.isCompleted) countCompletedStep++;
                              }
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                text: '$countCompletedStep'
                                    ' of '
                                    '${task.stepList.length.toString()}',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (task.dueDate != null) {
                              bool tempFirstIcon = isFirstIcon;
                              bool isOverDue = false;
                              DateTime today = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              );
                              (task.dueDate!.isBefore(today))
                                  ? isOverDue = true
                                  : isOverDue = false;
                              isFirstIcon = false;

                              return ItemBottomIcon(
                                textIcon: Icons.calendar_today_outlined,
                                text:
                                    '${DateFormat('E, MMM d').format(task.dueDate!)}',
                                isFirstIcon: tempFirstIcon,
                                isOverdue: isOverDue,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (task.remindTime != null) {
                              bool tempFirstIcon = isFirstIcon;
                              isFirstIcon = false;
                              return ItemBottomIcon(
                                textIcon: Icons.notifications_outlined,
                                text: ((task.dueDate == null) &&
                                        (!task.isOnMyDay))
                                    ? '${DateFormat('E, MMM d').format(task.remindTime!)}'
                                    : '',
                                isFirstIcon: tempFirstIcon,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          Builder(builder: (context) {
                            if (task.repeatFrequency != null) {
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
                            if (task.filePath.isNotEmpty) {
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
                            if (task.note != '') {
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
                      iconSize: 32,
                      onPressed: () {
                        context.read<TaskListViewModel>().updateIsImportant(
                              task: task,
                              isImportant: !task.isImportant,
                              isMoveStarTaskToTop: SettingsSharedPreference
                                  .getInstance
                                  .getIsMoveStarTaskToTop(),
                            );
                      },
                      icon: (task.isImportant)
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
