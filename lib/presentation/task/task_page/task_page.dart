// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/settings.dart';
import '../../../provider/settings_provider.dart';
import '../../../service/background_service.dart';
import '../../../models/enum.dart';
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
    DateTime defaultDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
    );
    DateTime? currentRemindTime =
        context.read<TaskViewModel>().currentTask.remindTime;
    RenderBox box = popupKey.currentContext!.findRenderObject() as RenderBox;
    Offset possition = box.localToGlobal(Offset.zero);
    if (!isDisable) {
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(possition.dx, possition.dy, 0, 0),
        items: [
          PopupMenuItem(
            onTap: () {
              if (currentRemindTime == null) {
                context.read<TaskViewModel>().updateRemindTime(
                      newRemindTime: defaultDay,
                    );
              }
              context.read<TaskViewModel>().updateRepeatFrequency(
                    newRepeatFrequency: Frequency.day,
                  );
              context.read<TaskViewModel>().updateFrequencyMultiplier(
                    newFrequencyMultiplier: 1,
                  );
            },
            child: const CustomPopupItem(
              text: 'Daily',
              icon: Icons.calendar_today_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              if (currentRemindTime == null) {
                context.read<TaskViewModel>().updateRemindTime(
                      newRemindTime: defaultDay,
                    );
              }
              context.read<TaskViewModel>().updateRepeatFrequency(
                    newRepeatFrequency: Frequency.weekday,
                  );
              context.read<TaskViewModel>().updateFrequencyMultiplier(
                    newFrequencyMultiplier: 1,
                  );
            },
            child: const CustomPopupItem(
              text: 'Weekdays',
              icon: Icons.today_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              if (currentRemindTime == null) {
                context.read<TaskViewModel>().updateRemindTime(
                      newRemindTime: defaultDay,
                    );
              }
              context.read<TaskViewModel>().updateRepeatFrequency(
                    newRepeatFrequency: Frequency.week,
                  );
              context.read<TaskViewModel>().updateFrequencyMultiplier(
                    newFrequencyMultiplier: 1,
                  );
            },
            child: const CustomPopupItem(
              text: 'Weekly',
              icon: Icons.date_range_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              if (currentRemindTime == null) {
                context.read<TaskViewModel>().updateRemindTime(
                      newRemindTime: defaultDay,
                    );
              }
              context.read<TaskViewModel>().updateRepeatFrequency(
                    newRepeatFrequency: Frequency.month,
                  );
              context.read<TaskViewModel>().updateFrequencyMultiplier(
                    newFrequencyMultiplier: 1,
                  );
            },
            child: const CustomPopupItem(
              text: 'Monthly',
              icon: Icons.calendar_month_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () {
              if (currentRemindTime == null) {
                context.read<TaskViewModel>().updateRemindTime(
                      newRemindTime: defaultDay,
                    );
              }
              context.read<TaskViewModel>().updateRepeatFrequency(
                    newRepeatFrequency: Frequency.year,
                  );
              context.read<TaskViewModel>().updateFrequencyMultiplier(
                    newFrequencyMultiplier: 1,
                  );
            },
            child: const CustomPopupItem(
              text: 'Yearly',
              icon: Icons.calendar_view_month_outlined,
            ),
          ),
          PopupMenuItem(
            onTap: () async {
              (int, Frequency)? result =
                  await showCustomRepeatTimeDialog(context);
              if (!context.mounted) return;
              if (result != null) {
                if (context.read<TaskViewModel>().currentTask.remindTime ==
                    null) {
                  context.read<TaskViewModel>().updateRemindTime(
                        newRemindTime: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          9,
                        ),
                      );
                }
                context.read<TaskViewModel>().updateRepeatFrequency(
                      newRepeatFrequency: result.$2,
                    );
                context.read<TaskViewModel>().updateFrequencyMultiplier(
                      newFrequencyMultiplier: result.$1,
                    );
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
      context
          .read<TaskViewModel>()
          .updateRepeatFrequency(newRepeatFrequency: null);
      context
          .read<TaskViewModel>()
          .updateFrequencyMultiplier(newFrequencyMultiplier: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    unawaited(initializeDateFormatting());
    Task watchCurrentTask = context.watch<TaskViewModel>().currentTask;
    TaskViewModel readTaskViewModel = context.read<TaskViewModel>();

    return WillPopScope(
      onWillPop: () async {
        Settings settings = context.read<SettingsProvider>().settings;
        Task currentTask = context.read<TaskViewModel>().currentTask;
        BackGroundService.cancelTaskByID(id: currentTask.id);
        if (currentTask.remindTime != null) {
          if (currentTask.repeatFrequency != null) {
            BackGroundService.executePeriodicBackGroundTask(
              taskTitle: currentTask.title,
              taskID: currentTask.id,
              taskListTitle: currentTaskListName,
              remindTime: currentTask.remindTime!,
              frequency: currentTask.repeatFrequency!,
              frequencyMultiplier: currentTask.frequencyMultiplier,
              isPlaySound: settings.isPlaySoundOnComplete,
            );
          } else {
            BackGroundService.executeScheduleBackGroundTask(
              taskTitle: currentTask.title,
              taskID: currentTask.id,
              taskListTitle: currentTaskListName,
              isPlaySound: settings.isPlaySoundOnComplete,
              remindTime: currentTask.remindTime!,
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
                        readTaskViewModel.addStep(
                          stepName: _stepController.text,
                          isCompleted: false,
                        );
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
                          readTaskViewModel.addStep(
                            stepName: value,
                            isCompleted: false,
                          );
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
                  Task currentTask = context.read<TaskViewModel>().currentTask;
                  readTaskViewModel.updateIsOnMyDay(
                      isOnMyDay: !currentTask.isOnMyDay);
                },
                activeText: 'Added to My Day',
              ),
              //////////////
              //Remind item
              Builder(builder: (context) {
                String remindActiveText = DateFormat('h:mm a, MMM d')
                    .format(watchCurrentTask.remindTime ?? DateTime(2000));
                return TaskPageItem(
                  isActive: (watchCurrentTask.remindTime != null),
                  icon: Icons.notifications_outlined,
                  text: 'Remind me',
                  onTap: ({bool isDisable = false}) async {
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
                        readTaskViewModel.updateRemindTime(
                          newRemindTime: tempRemindTime,
                        );
                      }
                    } else {
                      readTaskViewModel.updateRemindTime(newRemindTime: null);
                      readTaskViewModel.updateRepeatFrequency(
                        newRepeatFrequency: null,
                      );
                      readTaskViewModel.updateFrequencyMultiplier(
                        newFrequencyMultiplier: 1,
                      );
                    }
                  },
                  activeText: 'Remind at $remindActiveText',
                );
              }),
              ////////////////
              //Due date item
              Builder(builder: (context) {
                String dueActiveText = DateFormat('E, MMM d')
                    .format(watchCurrentTask.dueDate ?? DateTime(2000));
                return TaskPageItem(
                  isActive: (watchCurrentTask.dueDate != null),
                  icon: Icons.calendar_today_outlined,
                  text: 'Add due date',
                  onTap: ({bool isDisable = false}) async {
                    Settings settings =
                        context.read<SettingsProvider>().settings;
                    if (!isDisable) {
                      DateTime? newDueDate = await showDatePicker(
                        context: context,
                        initialDate: watchCurrentTask.dueDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2050),
                      );
                      if (newDueDate != null) {
                        readTaskViewModel.updateDueDate(newDueDate: newDueDate);
                        DateTime today = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        );
                        if ((newDueDate.isAtSameMomentAs(today)) &&
                            (settings.isShowDueToday)) {
                          readTaskViewModel.updateIsOnMyDay(isOnMyDay: true);
                        }
                      }
                    } else {
                      readTaskViewModel.updateDueDate(newDueDate: null);
                    }
                  },
                  activeText: 'Due $dueActiveText',
                );
              }),
              //////////////
              //Repeat item
              Builder(builder: (context) {
                String repeatActiveText =
                    (watchCurrentTask.repeatFrequency ?? Frequency.day)
                        .name
                        .toLowerCase();
                if (watchCurrentTask.frequencyMultiplier > 1) {
                  repeatActiveText =
                      '${watchCurrentTask.frequencyMultiplier} ${repeatActiveText}s';
                }
                return TaskPageItem(
                  isActive: (watchCurrentTask.repeatFrequency != null),
                  icon: Icons.repeat_outlined,
                  key: popupKey,
                  text: 'Repeat',
                  onTap: ({bool isDisable = false}) async {
                    onTapRepeat(context, isDisable: isDisable);
                  },
                  activeText: 'Repeat every $repeatActiveText',
                );
              }),
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
                            readTaskViewModel.removeFile(removeFile: path);
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
                  readTaskViewModel.changeLoadingFileStatus(isLoading: true);
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                  );
                  if (result != null) {
                    readTaskViewModel.addFile(
                      filePath: result.files.map((file) => file.path!).toList(),
                    );
                  }
                  readTaskViewModel.changeLoadingFileStatus(isLoading: false);
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
