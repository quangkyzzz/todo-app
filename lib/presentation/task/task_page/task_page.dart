// ignore_for_file: sized_box_for_whitespace
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/background_service.dart';
import '../../../models/task_step.dart';
import '../../../models/task_list.dart';
import '../../../view_models/task_view_model.dart';
import '../../components/show_custom_repeat_time_dialog.dart';
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
  final Task task;
  final TaskList taskList;
  const TaskPage({
    super.key,
    required this.task,
    required this.taskList,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskViewModel taskViewModel;
  late SettingsProvider settingsProvider;
  late bool isLoading;
  GlobalKey key = GlobalKey();
  late String title;
  late bool isOnMyDay;
  late bool isCompleted;
  late bool isImportant;
  late List<TaskStep>? steps;
  late DateTime? remindTime;
  late DateTime? dueDate;
  late String? repeatFrequency;
  late List<String>? filePaths;
  late final TextEditingController _stepController;
  late final TextEditingController _taskNameController;
  late List<Map<String, dynamic>> listRepeatPopupItem;

  void onTapAddToMyDay(BuildContext context, {bool isDisable = false}) {
    setState(() {
      isOnMyDay = !isOnMyDay;
    });
  }

  void onTapRemindMe(BuildContext context, {bool isDisable = false}) async {
    Future<DateTime?> getRemindTime({
      required BuildContext context,
      required DateTime initialDate,
    }) async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );
      if (selectedDate == null) return null;

      if (!context.mounted) return null;

      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (selectedTime == null) return null;

      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    }

    if (!isDisable) {
      DateTime? tempRemindTime = await getRemindTime(
        context: context,
        initialDate: remindTime ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              9,
            ),
      );
      if (tempRemindTime != null) {
        if (remindTime != null) {
          BackGroundService.cancelTaskByID(id: widget.task.id);
        }
        setState(() {
          remindTime = tempRemindTime;
        });

        BackGroundService.executeScheduleBackGroundTask(
          task: widget.task,
          taskList: widget.taskList,
          isPlaySound: settingsProvider.settings.isPlaySoundOnComplete,
          remindTime: remindTime!,
        );
      }
    } else {
      setState(() {
        remindTime = null;
        if (repeatFrequency != null) {
          repeatFrequency = null;
        }
      });
      BackGroundService.cancelTaskByID(id: widget.task.id);
    }
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
        items: listRepeatPopupItem.map((item) {
          return PopupMenuItem(
            onTap: () {
              item['onTap'](context);
            },
            child: CustomPopupItem(
              text: item['text'],
              icon: item['icon'],
            ),
          );
        }).toList(),
      );
    } else {
      setState(() {
        repeatFrequency = null;
      });
      BackGroundService.cancelTaskByID(id: widget.task.id);
      BackGroundService.executeScheduleBackGroundTask(
        task: widget.task,
        taskList: widget.taskList,
        isPlaySound: settingsProvider.settings.isPlaySoundOnComplete,
        remindTime: remindTime!,
      );
    }
  }

  void onCompleteSetRepeat(String frequency) {
    setState(() {
      repeatFrequency = frequency;
      remindTime ??= DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        9,
      );
    });
    BackGroundService.cancelTaskByID(id: widget.task.id);
    BackGroundService.executePeriodicBackGroundTask(
      task: widget.task,
      taskList: widget.taskList,
      remindTime: remindTime!,
      frequency: frequency,
      isPlaySound: settingsProvider.settings.isPlaySoundOnComplete,
    );
  }

  void onTapAddDueDate(BuildContext context, {bool isDisable = false}) async {
    if (!isDisable) {
      DateTime? newDueDate = await showDatePicker(
        context: context,
        initialDate: dueDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
      );
      if (newDueDate != null) {
        setState(() {
          dueDate = newDueDate;
        });
        if (!context.mounted) return;
        DateTime today = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );
        if ((settingsProvider.settings.isShowDueToday) &&
            (dueDate!.isAtSameMomentAs(today)) &&
            (!isOnMyDay)) {
          onTapAddToMyDay(context);
        }
      }
    } else {
      setState(() {
        dueDate = null;
      });
    }
  }

  void onTapAddFile(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        if (filePaths == null) {
          filePaths = [];
          filePaths!.addAll(
            result.files.map((file) => file.path!).toList(),
          );
        } else {
          filePaths!.addAll(
            result.files.map((file) => file.path!).toList(),
          );
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void callBackEditTask(bool setComplete, bool setImportant) {
    setState(() {
      isCompleted = setComplete;
      isImportant = setImportant;
    });
  }

  void callBackEditStepItem(
    TaskStep newStep, {
    bool isDelete = false,
  }) {
    if (isDelete) {
      setState(() {
        steps!.remove(newStep);
        if (steps!.isEmpty) steps = null;
      });
    } else {
      setState(() {
        TaskStep step =
            steps!.firstWhere((element) => (element.id == newStep.id));
        step.copyFrom(newStep: newStep);
      });
    }
  }

  void onSubmittedAddStep(String value) {
    if (value != '') {
      if (steps == null) {
        setState(() {
          steps = List<TaskStep>.empty(growable: true);
        });
      }
      setState(() {
        TaskStep newStep = TaskStep(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          stepName: value,
          isCompleted: false,
        );
        steps!.add(newStep);
      });
      _stepController.clear();
    }
  }

  @override
  void initState() {
    unawaited(initializeDateFormatting());
    isLoading = false;
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    title = widget.task.title;
    isOnMyDay = widget.task.isOnMyDay;
    isCompleted = widget.task.isCompleted;
    isImportant = widget.task.isImportant;
    remindTime = widget.task.remindTime;
    dueDate = widget.task.dueDate;
    steps = widget.task.stepList;
    repeatFrequency = widget.task.repeatFrequency;
    filePaths = widget.task.filePath;
    _taskNameController = TextEditingController(text: widget.task.title);
    _stepController = TextEditingController();
    listRepeatPopupItem = [
      {
        'text': 'Daily',
        'icon': Icons.calendar_today_outlined,
        'onTap': (BuildContext context) {
          onCompleteSetRepeat('1 Days');
        },
      },
      {
        'text': 'Weekdays',
        'icon': Icons.calendar_today_outlined,
        'onTap': (BuildContext context) {
          onCompleteSetRepeat('1 Weekdays');
        },
      },
      {
        'text': 'Weekly',
        'icon': Icons.calendar_today_outlined,
        'onTap': (BuildContext context) {
          onCompleteSetRepeat('1 Weeks');
        },
      },
      {
        'text': 'Monthly',
        'icon': Icons.calendar_today_outlined,
        'onTap': (BuildContext context) {
          onCompleteSetRepeat('1 Months');
        }
      },
      {
        'text': 'Yearly',
        'icon': Icons.calendar_today_outlined,
        'onTap': (BuildContext context) {
          onCompleteSetRepeat('1 Years');
        },
      },
      {
        'text': 'Custom',
        'icon': Icons.calendar_today_outlined,
        'onTap': (BuildContext context) async {
          String? result = await showCustomRepeatTimeDialog(context);
          if (result != null) {
            onCompleteSetRepeat(result);
          }
        },
      },
    ];
    super.initState();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String repeatActiveText = (repeatFrequency ?? '').toLowerCase();
    if (repeatActiveText.split(' ').first == '1') {
      var temp = repeatActiveText.split(' ')[1];
      repeatActiveText = temp.substring(0, temp.length - 1);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskList.listName,
          style: MyTheme.titleTextStyle,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Task newTask = Task(
            id: widget.task.id,
            createDate: widget.task.createDate,
            title: _taskNameController.text,
            isCompleted: isCompleted,
            isImportant: isImportant,
            isOnMyDay: isOnMyDay,
            remindTime: remindTime,
            dueDate: dueDate,
            stepList: steps,
            repeatFrequency: repeatFrequency,
            filePath: filePaths,
            note: widget.task.note,
          );
          await taskViewModel.updateTask(
            taskListID: widget.taskList.id,
            taskID: widget.task.id,
            newTask: newTask,
          );
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////
              //Edit task row
              TaskEditRow(
                taskNameController: _taskNameController,
                isChecked: isCompleted,
                isImportant: isImportant,
                callBack: callBackEditTask,
              ),
              const SizedBox(height: 8),
              ////////////////
              //Step edit row
              (steps != null)
                  ? ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: steps!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StepItem(
                          step: steps![index],
                          callBack: callBackEditStepItem,
                          taskList: widget.taskList,
                        );
                      },
                    )
                  : const SizedBox(),
              Row(
                children: [
                  const SizedBox(width: 6),
                  IconButton(
                    onPressed: () {
                      onSubmittedAddStep(_stepController.text);
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
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
                      onSubmitted: onSubmittedAddStep,
                    ),
                  )
                ],
              ),
              //////////////////////////////
              //List uniform task page item
              const SizedBox(height: 6),
              TaskPageItem(
                isActive: isOnMyDay,
                icon: Icons.wb_sunny_outlined,
                text: 'Add to My Day',
                onTap: ({bool isDisable = false}) {
                  onTapAddToMyDay(context, isDisable: isDisable);
                },
                task: widget.task,
                activeText: 'Added to My Day',
              ),
              TaskPageItem(
                isActive: (remindTime != null),
                icon: Icons.notifications_outlined,
                text: 'Remind me',
                onTap: ({bool isDisable = false}) {
                  onTapRemindMe(context, isDisable: isDisable);
                },
                task: widget.task,
                activeText: 'Remind at'
                    ' ${DateFormat('h:mm a, MMM d').format(remindTime ?? DateTime(2000))}',
              ),
              TaskPageItem(
                isActive: (dueDate != null),
                icon: Icons.calendar_today_outlined,
                text: 'Add due date',
                onTap: ({bool isDisable = false}) {
                  onTapAddDueDate(context, isDisable: isDisable);
                },
                task: widget.task,
                activeText: 'Due '
                    '${DateFormat('E, MMM d').format(dueDate ?? DateTime(2000))}',
              ),
              TaskPageItem(
                isActive: (repeatFrequency != null),
                icon: Icons.repeat_outlined,
                key: key,
                text: 'Repeat',
                onTap: ({bool isDisable = false}) async {
                  onTapRepeat(context, isDisable: isDisable);
                },
                task: widget.task,
                activeText: 'Repeat every $repeatActiveText',
              ),
              const SizedBox(height: 6),
              //////////////////////////
              //Add and edit file button
              (filePaths != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: filePaths!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String path = filePaths![index];
                        return FileItem(
                          filePath: path,
                          onTap: () async {
                            await OpenFilex.open(path);
                          },
                          onClose: () {
                            setState(() {
                              filePaths!.remove(path);
                            });
                            if (filePaths!.isEmpty) {
                              filePaths = null;
                            }
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
                onTap: ({bool isDisable = false}) {
                  onTapAddFile(context);
                },
                task: widget.task,
                activeText: 'active',
              ),

              //////////////////////////
              //Add and edit note button
              AddAndEditNoteButton(
                task: widget.task,
                taskList: widget.taskList,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: TaskPageBottomNavigation(
        task: widget.task,
        taskList: widget.taskList,
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
    required this.taskList,
  });

  final Task task;
  final TaskList taskList;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: (task.note != null)
          ? InkWell(
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  noteEditRoute,
                  arguments: {
                    'task': task,
                    'taskList': taskList,
                  },
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
                      context.watch<TaskViewModel>().currentTask.note!,
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
                  arguments: {
                    'task': task,
                    'taskList': taskList,
                  },
                );
              },
              child: const Text(
                'Add note',
                style: MyTheme.itemSmallGreyTextStyle,
              )),
    );
  }
}
