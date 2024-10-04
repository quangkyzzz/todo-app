// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/settings.dart';
import '../../../models/task_step.dart';
import '../../../provider/settings_provider.dart';
import '../../../service/background_service.dart';
import '../../../view_models/task_view_model.dart';
import '../../components/show_custom_repeat_time_dialog.dart';
import '../../components/show_date_time_picker.dart';
import 'file_item.dart';
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

class TaskPage extends StatelessWidget {
  final String currentTaskListName;
  final GlobalKey popupKey = GlobalKey();
  final TextEditingController _stepController = TextEditingController();
  TaskPage({
    super.key,
    required this.currentTaskListName,
  });

  Future<void> onTapRepeat(BuildContext context,
      {bool isDisable = false}) async {
    RenderBox box = popupKey.currentContext!.findRenderObject() as RenderBox;
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
              onCompleteSetRepeat(context, '1 Days');
            },
            child: const CustomPopupItem(
              text: 'Daily',
              icon: Icons.calendar_today_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat(context, '1 Weekdays');
            },
            child: const CustomPopupItem(
              text: 'Weekdays',
              icon: Icons.today_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat(context, '1 Weeks');
            },
            child: const CustomPopupItem(
              text: 'Weekly',
              icon: Icons.date_range_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat(context, '1 Months');
            },
            child: const CustomPopupItem(
              text: 'Monthly',
              icon: Icons.calendar_month_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              onCompleteSetRepeat(context, '1 Years');
            },
            child: const CustomPopupItem(
              text: 'Yearly',
              icon: Icons.calendar_view_month_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () async {
              String? result = await showCustomRepeatTimeDialog(context);
              if (!context.mounted) return;
              if (result != null) {
                onCompleteSetRepeat(context, result);
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
      context.read<TaskViewModel>().updateTask(updatedTask: updatedTask);
    }
  }

  void onCompleteSetRepeat(BuildContext context, String frequency) {
    Task updatedTask = context.read<TaskViewModel>().currentTask;
    updatedTask.repeatFrequency = frequency;
    updatedTask.remindTime ??= DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
    );
    context.read<TaskViewModel>().updateTask(updatedTask: updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    unawaited(initializeDateFormatting());
    Task watchCurrentTask = context.watch<TaskViewModel>().currentTask;
    TaskViewModel readTaskViewModel = context.read<TaskViewModel>();
    String repeatActiveText = (watchCurrentTask.repeatFrequency).toLowerCase();
    if (repeatActiveText.split(' ').first == '1') {
      var temp = repeatActiveText.split(' ')[1];
      repeatActiveText = temp.substring(0, temp.length - 1);
    }
    String remindActiveText = DateFormat('h:mm a, MMM d')
        .format(watchCurrentTask.remindTime ?? DateTime(2000));
    String dueActiveText = DateFormat('E, MMM d')
        .format(watchCurrentTask.dueDate ?? DateTime(2000));
    return WillPopScope(
      onWillPop: () async {
        Settings settings = context.read<SettingsProvider>().settings;
        Task currentTask = context.read<TaskViewModel>().currentTask;
        BackGroundService.cancelTaskByID(id: currentTask.id);
        if (currentTask.remindTime != null) {
          if (currentTask.repeatFrequency == '') {
            BackGroundService.executeScheduleBackGroundTask(
              taskTitle: currentTask.title,
              taskID: currentTask.id,
              taskListTitle: currentTaskListName,
              isPlaySound: settings.isPlaySoundOnComplete,
              remindTime: currentTask.remindTime!,
            );
          } else {
            BackGroundService.executePeriodicBackGroundTask(
              taskTitle: currentTask.title,
              taskID: currentTask.id,
              taskListTitle: currentTaskListName,
              remindTime: currentTask.remindTime!,
              frequency: currentTask.repeatFrequency,
              isPlaySound: settings.isPlaySoundOnComplete,
            );
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currentTaskListName,
            style: MyTheme.titleTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////
              //Edit task row
              const TaskEditRow(),
              const SizedBox(height: 8),
              ////////////////
              //Step edit row
              (watchCurrentTask.stepList.isNotEmpty)
                  ? ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: watchCurrentTask.stepList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StepItem(
                          step: watchCurrentTask.stepList[index],
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
                        readTaskViewModel.updateTask(updatedTask: updatedTask);
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
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            stepName: value,
                            isCompleted: false,
                          );
                          Task updatedTask =
                              context.read<TaskViewModel>().currentTask;
                          updatedTask.stepList.add(newStep);
                          readTaskViewModel.updateTask(
                              updatedTask: updatedTask);
                          _stepController.clear();
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  )
                ],
              ),
              //////////////
              //My Day item
              const SizedBox(height: 6),
              TaskPageItem(
                isActive: watchCurrentTask.isOnMyDay,
                icon: Icons.wb_sunny_outlined,
                text: 'Add to My Day',
                onTap: ({bool isDisable = false}) {
                  Task updatedTask = context.read<TaskViewModel>().currentTask;
                  updatedTask.isOnMyDay = !updatedTask.isOnMyDay;
                  readTaskViewModel.updateTask(updatedTask: updatedTask);
                },
                activeText: 'Added to My Day',
              ),
              //////////////
              //Remind item
              TaskPageItem(
                isActive: (watchCurrentTask.remindTime != null),
                icon: Icons.notifications_outlined,
                text: 'Remind me',
                onTap: ({bool isDisable = false}) async {
                  Task updatedTask = context.read<TaskViewModel>().currentTask;
                  if (!isDisable) {
                    DateTime? tempRemindTime = await showDateTimePicker(
                      context: context,
                      initialDate: watchCurrentTask.remindTime ??
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
                      readTaskViewModel.updateTask(updatedTask: updatedTask);
                    }
                  } else {
                    updatedTask.remindTime = null;
                    updatedTask.repeatFrequency = '';
                    readTaskViewModel.updateTask(updatedTask: updatedTask);
                  }
                },
                activeText: 'Remind at $remindActiveText',
              ),
              ////////////////
              //Due date item
              TaskPageItem(
                isActive: (watchCurrentTask.dueDate != null),
                icon: Icons.calendar_today_outlined,
                text: 'Add due date',
                onTap: ({bool isDisable = false}) async {
                  Settings settings = context.read<SettingsProvider>().settings;
                  Task updatedTask = context.read<TaskViewModel>().currentTask;
                  if (!isDisable) {
                    DateTime? newDueDate = await showDatePicker(
                      context: context,
                      initialDate: watchCurrentTask.dueDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2050),
                    );
                    if (newDueDate != null) {
                      updatedTask.dueDate = newDueDate;
                      DateTime today = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                      );
                      if ((newDueDate.isAtSameMomentAs(today)) &&
                          (settings.isShowDueToday)) {
                        updatedTask.isOnMyDay = true;
                      }
                    }
                  } else {
                    updatedTask.dueDate = null;
                  }
                  readTaskViewModel.updateTask(updatedTask: updatedTask);
                },
                activeText: 'Due $dueActiveText',
              ),
              //////////////
              //Repeat item
              TaskPageItem(
                isActive: (watchCurrentTask.repeatFrequency != ''),
                icon: Icons.repeat_outlined,
                key: popupKey,
                text: 'Repeat',
                onTap: ({bool isDisable = false}) async {
                  onTapRepeat(context, isDisable: isDisable);
                },
                activeText: 'Repeat every $repeatActiveText',
              ),
              const SizedBox(height: 6),
              //////////////////////////
              //Add and edit file button
              (watchCurrentTask.filePath.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: watchCurrentTask.filePath.length,
                      itemBuilder: (BuildContext context, int index) {
                        String path = watchCurrentTask.filePath[index];
                        return FileItem(
                          filePath: path,
                          onTap: () async {
                            await OpenFilex.open(path);
                          },
                          onClose: () {
                            Task updatedTask =
                                context.read<TaskViewModel>().currentTask;
                            updatedTask.filePath.remove(path);
                            readTaskViewModel.updateTask(
                                updatedTask: updatedTask);
                          },
                        );
                      },
                    )
                  : const SizedBox(),
              (context.watch<TaskViewModel>().isLoadingFile)
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
                  readTaskViewModel.changeLoadingFileStatusToTrue();
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                  );
                  if (result != null) {
                    updatedTask.filePath
                        .addAll(result.files.map((file) => file.path!));
                    readTaskViewModel.updateTask(updatedTask: updatedTask);
                  }
                  readTaskViewModel.changeLoadingFileStatusToFalse();
                },
                activeText: 'active',
              ),

              //////////////////////////
              //Add and edit note button
              AddAndEditNoteButton(
                task: watchCurrentTask,
              )
            ],
          ),
        ),
        bottomNavigationBar: TaskPageBottomNavigation(
          task: watchCurrentTask,
        ),
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
