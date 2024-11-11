import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';
import 'package:todo_app/service/background_service.dart';
import 'package:todo_app/model/data/settings_shared_preference.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/model/entity/enum.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:flutter/material.dart';
import 'custom_task_button.dart';
import 'show_custom_repeat_time_dialog.dart';
import 'show_date_time_picker.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Color themeColor;
  final BuildContext mContext;
  final bool isAddToMyDay;
  final bool isAddToImportant;
  final TaskList taskList;
  const AddTaskBottomSheet({
    super.key,
    required this.taskList,
    required this.isAddToMyDay,
    required this.isAddToImportant,
    required this.mContext,
    required this.themeColor,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool isChecked = false;
  late Task newTask;
  late bool isPlaySoundOnComplete;
  late bool isAddNewTaskOnTop;
  late bool isShowDueToday;
  @override
  void initState() {
    unawaited(initializeDateFormatting());
    newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      groupID: widget.taskList.groupID,
      taskListID: widget.taskList.id,
      title: '',
      isCompleted: isChecked,
      isImportant: widget.isAddToImportant,
      isOnMyDay: widget.isAddToMyDay,
      createDate: DateTime.now(),
    );
    isPlaySoundOnComplete =
        SettingsSharedPreference.getInstance.getIsPlaySoundOnComplete();
    isAddNewTaskOnTop =
        SettingsSharedPreference.getInstance.getIsAddNewTaskOnTop();
    isShowDueToday = SettingsSharedPreference.getInstance.getIsShowDueToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dueDateHightLightText =
        DateFormat('E, MMM d').format(newTask.dueDate ?? DateTime(2000));
    String remindHightLightText = DateFormat('h:mm a, MMM d')
        .format(newTask.remindTime ?? DateTime(2000));
    String repeatHighLightText = '';
    switch (newTask.repeatFrequency) {
      case Frequency.day:
        repeatHighLightText = 'day';
      case Frequency.weekday:
        repeatHighLightText = 'weekday';
      case Frequency.week:
        repeatHighLightText = 'week';
      case Frequency.month:
        repeatHighLightText = 'month';
      case Frequency.year:
        repeatHighLightText = 'year';
      case null:
        repeatHighLightText = '';
    }
    if (newTask.frequencyMultiplier > 1) {
      repeatHighLightText = '${newTask.frequencyMultiplier} '
          '${repeatHighLightText}s';
    }
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  activeColor: widget.themeColor,
                  checkColor: (widget.themeColor == MyTheme.whiteColor)
                      ? MyTheme.blackColor
                      : MyTheme.whiteColor,
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Add a task',
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: MyTheme.dardGreyColor,
                  ),
                  height: 28,
                  width: 28,
                  margin: const EdgeInsets.all(8),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (_controller.text == '') return;
                        Provider.of<TaskListViewModel>(
                          widget.mContext,
                          listen: false,
                        ).createNewTask(
                          id: newTask.id,
                          isAddNewTaskOnTop: isAddNewTaskOnTop,
                          taskName: _controller.text,
                          isCompleted: isChecked,
                          dueDate: newTask.dueDate,
                          isOnMyDay: newTask.isOnMyDay,
                          isImportant: newTask.isImportant,
                          remindTime: newTask.remindTime,
                          repeatFrequency: newTask.repeatFrequency,
                          frequencyMultiplier: newTask.frequencyMultiplier,
                        );
                        if (newTask.remindTime != null) {
                          if (newTask.repeatFrequency == null) {
                            BackGroundService.executeScheduleBackGroundTask(
                              taskID: newTask.id,
                              taskTitle: _controller.text,
                              taskListTitle: widget.taskList.title,
                              isPlaySound: isPlaySoundOnComplete,
                              remindTime: newTask.remindTime!,
                            );
                          } else {
                            BackGroundService.executePeriodicBackGroundTask(
                              taskTitle: _controller.text,
                              taskID: newTask.id,
                              taskListTitle: widget.taskList.title,
                              remindTime: newTask.remindTime!,
                              frequency: newTask.repeatFrequency!,
                              frequencyMultiplier: newTask.frequencyMultiplier,
                              isPlaySound: isPlaySoundOnComplete,
                            );
                          }
                        }
                        _controller.clear();
                        setState(() {
                          isChecked = false;
                          newTask = Task(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            taskListID: widget.taskList.id,
                            groupID: widget.taskList.groupID,
                            title: '',
                            isCompleted: isChecked,
                            isImportant: widget.isAddToImportant,
                            isOnMyDay: widget.isAddToMyDay,
                            createDate: DateTime.now(),
                          );
                        });
                      },
                      icon: const Icon(Icons.arrow_upward),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Scrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomTaskButton(
                      highLightText: 'Due $dueDateHightLightText',
                      themeColor: widget.themeColor,
                      icon: Icons.today,
                      text: 'Set due date',
                      isHighLighted: (newTask.dueDate != null),
                      onTap: () async {
                        DateTime? newDueDate = await showDatePicker(
                          context: context,
                          initialDate: newTask.dueDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2050),
                        );
                        if (newDueDate != null) {
                          setState(() {
                            newTask.dueDate = newDueDate;
                          });
                          if (!context.mounted) return;
                          DateTime today = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                          );
                          if ((isShowDueToday) &&
                              (newTask.dueDate!.isAtSameMomentAs(today)) &&
                              (!newTask.isOnMyDay)) {
                            newTask.isOnMyDay = true;
                          }
                        }
                      },
                      onTapDisable: () {
                        setState(() {
                          newTask.dueDate = null;
                          newTask.isOnMyDay = false;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CustomTaskButton(
                      highLightText: 'Remind at $remindHightLightText',
                      themeColor: widget.themeColor,
                      icon: Icons.notifications_outlined,
                      text: 'Remind me',
                      isHighLighted: (newTask.remindTime != null),
                      onTap: () async {
                        DateTime? tempRemindTime = await showDateTimePicker(
                          context: context,
                          initialDate: newTask.remindTime,
                        );
                        if (tempRemindTime != null) {
                          setState(() {
                            newTask.remindTime = tempRemindTime;
                          });
                        }
                      },
                      onTapDisable: () {
                        setState(() {
                          newTask.remindTime = null;
                          if (newTask.repeatFrequency != null) {
                            newTask.repeatFrequency = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CustomTaskButton(
                      highLightText: 'Repeat every $repeatHighLightText',
                      themeColor: widget.themeColor,
                      icon: Icons.repeat_outlined,
                      text: 'Repeat',
                      isHighLighted: (newTask.repeatFrequency != null),
                      onTap: () async {
                        (int, Frequency)? result =
                            await showCustomRepeatTimeDialog(context);
                        if (result != null) {
                          setState(() {
                            newTask.frequencyMultiplier = result.$1;
                            newTask.repeatFrequency = result.$2;
                            newTask.remindTime ??= DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              DateTime.now().hour + 1,
                            );
                          });
                        }
                      },
                      onTapDisable: () {
                        setState(() {
                          newTask.repeatFrequency = null;
                          newTask.frequencyMultiplier = 1;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
