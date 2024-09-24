import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../models/task_list.dart';
import '../../provider/settings_provider.dart';
import '../../view_models/task_list_view_model.dart';
import '../../view_models/task_map_view_model.dart';
import 'add_floating_button.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    unawaited(initializeDateFormatting());
    newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '',
      isCompleted: isChecked,
      isImportant: widget.isAddToImportant,
      isOnMyDay: widget.isAddToMyDay,
      createDate: DateTime.now(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String repeatActiveText = (newTask.repeatFrequency ?? '').toLowerCase();
    if (repeatActiveText.split(' ').first == '1') {
      var temp = repeatActiveText.split(' ')[1];
      repeatActiveText = temp.substring(0, temp.length - 1);
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  shape: const CircleBorder(),
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
                IconButton(
                  onPressed: () {
                    if (_controller.text == '') return;
                    if ((widget.isAddToMyDay) || (widget.isAddToImportant)) {
                      Provider.of<TaskMapViewModel>(
                        widget.mContext,
                        listen: false,
                      ).addNewTask(
                        settings:
                            widget.mContext.read<SettingsProvider>().settings,
                        taskList: widget.taskList,
                        taskName: _controller.text,
                        isCompleted: isChecked,
                        isImportant: widget.isAddToImportant,
                        isOnMyDay: widget.isAddToMyDay,
                        dueDate: newTask.dueDate,
                        remindTime: newTask.remindTime,
                        repeatFrequency: newTask.repeatFrequency,
                      );
                    } else {
                      Provider.of<TaskListViewModel>(
                        widget.mContext,
                        listen: false,
                      ).addNewTask(
                        settings:
                            widget.mContext.read<SettingsProvider>().settings,
                        taskName: _controller.text,
                        isCompleted: isChecked,
                        dueDate: newTask.dueDate,
                        isOnMyDay: newTask.isOnMyDay,
                        remindTime: newTask.remindTime,
                        repeatFrequency: newTask.repeatFrequency,
                      );
                    }
                    _controller.clear();
                    setState(() {
                      isChecked = false;
                      newTask = Task(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: '',
                        isCompleted: isChecked,
                        isImportant: widget.isAddToImportant,
                        isOnMyDay: widget.isAddToMyDay,
                        createDate: DateTime.now(),
                      );
                    });
                  },
                  icon: const Icon(Icons.arrow_upward),
                )
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 8),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomTaskButton(
                    highLightText: 'Due '
                        '${DateFormat('E, MMM d').format(newTask.dueDate ?? DateTime(2000))}',
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
                        if ((widget.mContext
                                .read<SettingsProvider>()
                                .settings
                                .isShowDueToday) &&
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
                    highLightText: 'Remind at '
                        '${DateFormat('h:mm a, MMM d').format(newTask.remindTime ?? DateTime(2000))}',
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
                    highLightText: 'Repeat every $repeatActiveText',
                    themeColor: widget.themeColor,
                    icon: Icons.repeat_outlined,
                    text: 'Repeat',
                    isHighLighted: (newTask.repeatFrequency != null),
                    onTap: () async {
                      String? result =
                          await showCustomRepeatTimeDialog(context);
                      if (result != null) {
                        setState(() {
                          newTask.repeatFrequency = result;
                          newTask.remindTime ??= DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            9,
                          );
                        });
                      }
                    },
                    onTapDisable: () {
                      setState(() {
                        newTask.repeatFrequency = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
