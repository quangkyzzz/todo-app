// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_step.dart';
import '../../../view_models/task_view_model.dart';
import '../../components/show_custom_repeat_time_dialog.dart';
import '../../components/show_date_time_picker.dart';
import 'file_item.dart';
import '../../../provider/settings_provider.dart';
import '../../../themes.dart';
import '../../../routes.dart';
import '../../../models/task.dart';
import 'task_page_bottom_navigation.dart';
import '../../items/popup_item.dart';
import 'step_item.dart';
import 'task_edit_row.dart';
import 'task_page_item.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class TaskPage extends StatefulWidget {
  final String currentTaskListName;
  const TaskPage({
    super.key,
    required this.currentTaskListName,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

//TODO: exercute background after pop
//TODO: move isLoading to model
class _TaskPageState extends State<TaskPage> {
  late TaskViewModel taskViewModel;
  late SettingsProvider settingsProvider;

  late bool isLoading;
  GlobalKey key = GlobalKey();
  late final TextEditingController _stepController;
  late final TextEditingController _taskNameController;

  @override
  void initState() {
    unawaited(initializeDateFormatting());
    isLoading = false;
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    _taskNameController =
        TextEditingController(text: taskViewModel.currentTask.title);
    _stepController = TextEditingController();
    super.initState();
  }

  Future<void> onTapRepeat(BuildContext context,
      {bool isDisable = false}) async {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset possition = box.localToGlobal(Offset.zero);
    if (!isDisable) {
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          possition.dx,
          possition.dy,
          0,
          0,
        ),
        items: [
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat('1 Days');
            },
            child: const CustomPopupItem(
              text: 'Daily',
              icon: Icons.calendar_today_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat('1 Weekdays');
            },
            child: const CustomPopupItem(
              text: 'Weekdays',
              icon: Icons.today_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat('1 Weeks');
            },
            child: const CustomPopupItem(
              text: 'Weekly',
              icon: Icons.date_range_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat('1 Months');
            },
            child: const CustomPopupItem(
              text: 'Monthly',
              icon: Icons.calendar_month_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat('1 Years');
            },
            child: const CustomPopupItem(
              text: 'Yearly',
              icon: Icons.calendar_view_month_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () async {
              String? result = await showCustomRepeatTimeDialog(context);
              if (result != null) {
                onCompleteSetRepeat(result);
              }
            },
            child: const CustomPopupItem(
              text: 'Custom',
              icon: Icons.edit_calendar_outlined,
            ),
          ),
        ],
      );
    } else {
      Task updatedTask = context.read<TaskViewModel>().currentTask;
      updatedTask.repeatFrequency = '';
      taskViewModel.updateTask(updatedTask: updatedTask);
    }
  }

  void onCompleteSetRepeat(String frequency) {
    Task updatedTask = context.read<TaskViewModel>().currentTask;
    updatedTask.repeatFrequency = frequency;
    updatedTask.remindTime ??= DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
    );
    taskViewModel.updateTask(updatedTask: updatedTask);
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Task task = context.watch<TaskViewModel>().currentTask;
    String repeatActiveText = (task.repeatFrequency).toLowerCase();
    if (repeatActiveText.split(' ').first == '1') {
      var temp = repeatActiveText.split(' ')[1];
      repeatActiveText = temp.substring(0, temp.length - 1);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.currentTaskListName,
          style: MyTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////////////////
            //Edit task row
            TaskEditRow(
              taskNameController: _taskNameController,
              isChecked: task.isCompleted,
              isImportant: task.isImportant,
              callBack: (bool setCompleted, bool setImportant) {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                updatedTask.isCompleted = setCompleted;
                updatedTask.isImportant = setImportant;
                taskViewModel.updateTask(updatedTask: updatedTask);
              },
            ),
            const SizedBox(height: 8),
            ////////////////
            //Step edit row
            (task.stepList.isNotEmpty)
                ? ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: task.stepList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StepItem(
                        step: task.stepList[index],
                      );
                    },
                  )
                : const SizedBox(),
            Row(
              children: [
                const SizedBox(width: 6),
                IconButton(
                  onPressed: () {
                    if (_stepController.text != '') {
                      TaskStep newStep = TaskStep(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        stepName: _stepController.text,
                        isCompleted: false,
                      );
                      Task updatedTask =
                          context.read<TaskViewModel>().currentTask;
                      updatedTask.stepList.add(newStep);
                      taskViewModel.updateTask(updatedTask: updatedTask);
                      _stepController.clear();
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  icon: const Icon(Icons.add),
                  color: MyTheme.greyColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _stepController,
                    decoration: const InputDecoration(
                      hintText: 'Add step',
                      border: InputBorder.none,
                    ),
                    style: MyTheme.itemSmallTextStyle,
                    onSubmitted: (String value) {
                      if (value != '') {
                        TaskStep newStep = TaskStep(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          stepName: value,
                          isCompleted: false,
                        );
                        Task updatedTask =
                            context.read<TaskViewModel>().currentTask;
                        updatedTask.stepList.add(newStep);
                        taskViewModel.updateTask(updatedTask: updatedTask);
                        _stepController.clear();
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                )
              ],
            ),
            //////////////////////////////
            //List uniform task page item
            const SizedBox(height: 6),
            TaskPageItem(
              isActive: task.isOnMyDay,
              icon: Icons.wb_sunny_outlined,
              text: 'Add to My Day',
              onTap: ({bool isDisable = false}) {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                updatedTask.isOnMyDay = !updatedTask.isOnMyDay;
                taskViewModel.updateTask(updatedTask: updatedTask);
              },
              task: task,
              activeText: 'Added to My Day',
            ),
            TaskPageItem(
              isActive: (task.remindTime != null),
              icon: Icons.notifications_outlined,
              text: 'Remind me',
              onTap: ({bool isDisable = false}) async {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                if (!isDisable) {
                  DateTime? tempRemindTime = await showDateTimePicker(
                    context: context,
                    initialDate: task.remindTime ??
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          9,
                        ),
                  );
                  if (!context.mounted) return;

                  if (tempRemindTime != null) {
                    updatedTask.remindTime = tempRemindTime;
                    taskViewModel.updateTask(updatedTask: updatedTask);
                  }
                } else {
                  updatedTask.remindTime = null;
                  taskViewModel.updateTask(updatedTask: updatedTask);
                }
              },
              task: task,
              activeText: 'Remind at '
                  '${DateFormat('h:mm a, MMM d').format(task.remindTime ?? DateTime(2000))}',
            ),
            TaskPageItem(
              isActive: (task.dueDate != null),
              icon: Icons.calendar_today_outlined,
              text: 'Add due date',
              onTap: ({bool isDisable = false}) async {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                if (!isDisable) {
                  DateTime? newDueDate = await showDatePicker(
                    context: context,
                    initialDate: task.dueDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2050),
                  );
                  if (newDueDate != null) {
                    updatedTask.dueDate = newDueDate;
                    taskViewModel.updateTask(updatedTask: updatedTask);
                  }
                } else {
                  updatedTask.dueDate = null;
                  taskViewModel.updateTask(updatedTask: updatedTask);
                }
              },
              task: task,
              activeText: 'Due '
                  '${DateFormat('E, MMM d').format(task.dueDate ?? DateTime(2000))}',
            ),
            TaskPageItem(
              isActive: (task.repeatFrequency != ''),
              icon: Icons.repeat_outlined,
              key: key,
              text: 'Repeat',
              onTap: ({bool isDisable = false}) async {
                onTapRepeat(context, isDisable: isDisable);
              },
              task: task,
              activeText: 'Repeat every $repeatActiveText',
            ),
            const SizedBox(height: 6),
            //////////////////////////
            //Add and edit file button
            (task.filePath.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: task.filePath.length,
                    itemBuilder: (BuildContext context, int index) {
                      String path = task.filePath[index];
                      return FileItem(
                        filePath: path,
                        onTap: () async {
                          await OpenFilex.open(path);
                        },
                        onClose: () {
                          Task updatedTask =
                              context.read<TaskViewModel>().currentTask;
                          updatedTask.filePath.remove(path);
                          taskViewModel.updateTask(updatedTask: updatedTask);
                        },
                      );
                    },
                  )
                : const SizedBox(),
            (isLoading)
                ? const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: LoadingWidget(),
                  )
                : const SizedBox(),
            TaskPageItem(
              isActive: false,
              icon: Icons.attach_file_outlined,
              text: 'Add file',
              onTap: ({bool isDisable = false}) async {
                Task updatedTask = context.read<TaskViewModel>().currentTask;
                setState(() {
                  isLoading = true;
                });
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                );
                if (result != null) {
                  updatedTask.filePath
                      .addAll(result.files.map((file) => file.path!));
                  taskViewModel.updateTask(updatedTask: updatedTask);
                }
                setState(() {
                  isLoading = false;
                });
              },
              task: task,
              activeText: 'active',
            ),

            //////////////////////////
            //Add and edit note button
            AddAndEditNoteButton(
              task: task,
            )
          ],
        ),
      ),
      bottomNavigationBar: TaskPageBottomNavigation(
        task: task,
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 8),
      child: Row(
        children: [
          const Text(
            'Loading file',
            style: MyTheme.itemSmallTextStyle,
          ),
          Transform.scale(scale: 0.5, child: const CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class AddAndEditNoteButton extends StatelessWidget {
  const AddAndEditNoteButton({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: (task.note != '')
          ? InkWell(
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  noteEditRoute,
                  arguments: task,
                );
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 118,
                  maxWidth: double.infinity,
                ),
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      context.watch<TaskViewModel>().currentTask.note,
                      maxLines: null,
                      style: MyTheme.itemSmallTextStyle,
                    ),
                  ),
                ),
              ),
            )
          : TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                  noteEditRoute,
                  arguments: task,
                );
              },
              child: const Text(
                'Add note',
                style: MyTheme.itemSmallGreyTextStyle,
              )),
    );
  }
}
