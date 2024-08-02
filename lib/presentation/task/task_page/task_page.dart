import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/notification_service.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/task/task_page/task_page_bottom_navigation.dart';
import 'package:todo_app/presentation/items/popup_item.dart';
import 'step_item.dart';
import 'task_edit_row.dart';
import 'task_page_item.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  final TaskModel task;
  final TaskListModel taskList;
  const TaskPage({
    super.key,
    required this.task,
    required this.taskList,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskListProvider taskListProvider;
  late GroupProvider groupProvider;
  GlobalKey key = GlobalKey();
  late String title;
  late bool isOnMyDay;
  late bool isCompleted;
  late bool isImportant;
  late List<StepModel>? steps;
  late DateTime? remindTime;
  late DateTime? dueDate;
  late String? repeatFrequency;
  late String? filePath;
  late final TextEditingController _stepController;
  late final TextEditingController _taskNameController;
  List<Map<String, dynamic>> listPopupItem = [
    {
      'text': 'Daily',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'text': 'Weekdays',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'text': 'Weekly',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'text': 'Monthly',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'text': 'Yearly',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'text': 'Custom',
      'icon': Icons.calendar_today_outlined,
    },
  ];

  onTapAddToMyDay(BuildContext context, {bool isDisable = false}) {
    setState(() {
      isOnMyDay = !isOnMyDay;
    });
  }

  onTapRemindMe(BuildContext context) async {
    Future<DateTime?> getRemindTime(BuildContext context) async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
      );
      if (selectedDate == null) return null;

      if (!context.mounted) return null;

      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime(2000, 2, 2, 9)),
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

    if (remindTime == null) {
      DateTime? tempRemindTime = await getRemindTime(context);
      if (tempRemindTime != null) {
        setState(() {
          remindTime = tempRemindTime;
        });
        NotificationService.setNotification(
          tempRemindTime,
          widget.taskList.listName,
          title,
          int.parse(widget.task.id),
        );
      }
    } else {
      setState(() {
        remindTime = null;
      });
      NotificationService.cancelNotification(
        int.parse(widget.task.id),
      );
    }
  }

  onTapAddDueDate(BuildContext context) async {
    if (dueDate == null) {
      DateTime? newDueDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2050),
      );
      if (newDueDate != null) {
        setState(() {
          dueDate = newDueDate;
        });
      }
    } else {
      setState(() {
        dueDate = null;
      });
    }
  }

  onTapRepeat(BuildContext context) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset possition = box.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        possition.dx,
        possition.dy,
        0,
        0,
      ),
      items: listPopupItem.map((item) {
        return PopupMenuItem(
          onTap: () {},
          child: PopupItem(
            text: item['text'],
            icon: item['icon'],
          ),
        );
      }).toList(),
    );
  }

  onTapAddFile(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      constraints: const BoxConstraints(
        maxHeight: 198,
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload from',
              style: MyTheme.itemTextStyle,
            ),
            const SizedBox(height: 8),
            TaskPageItem(
              task: widget.task,
              taskList: widget.taskList,
              isActive: false,
              icon: Icons.folder_outlined,
              text: 'Device files',
              activeText: 'active',
              onTap: () {},
            ),
            TaskPageItem(
              task: widget.task,
              taskList: widget.taskList,
              isActive: false,
              icon: Icons.photo_camera_outlined,
              text: 'Camera',
              activeText: 'active',
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  void callBackEditTask(bool setComplete, bool setImportant) {
    setState(() {
      isCompleted = setComplete;
      isImportant = setImportant;
    });
  }

  void callBackEditStep(
    StepModel newStep, {
    bool isDelete = false,
  }) {
    if (isDelete) {
      setState(() {
        steps!.remove(newStep);
        if (steps!.isEmpty) steps = null;
      });
    } else {
      setState(() {
        StepModel step =
            steps!.firstWhere((element) => (element.id == newStep.id));
        step.copyFrom(newStep: newStep);
      });
    }
  }

  @override
  void initState() {
    initializeDateFormatting();

    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    groupProvider = Provider.of<GroupProvider>(context, listen: false);
    title = widget.task.title;
    isOnMyDay = widget.task.isOnMyDay;
    isCompleted = widget.task.isCompleted;
    isImportant = widget.task.isImportant;
    remindTime = widget.task.remindTime;
    dueDate = widget.task.dueDate;
    steps = widget.task.stepList;
    repeatFrequency = widget.task.repeatFrequency;
    filePath = widget.task.filePath;
    _taskNameController = TextEditingController(text: widget.task.title);
    _stepController = TextEditingController();
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
    List<Map<String, dynamic>> listTaskItem = [
      {
        'isActive': isOnMyDay,
        'icon': Icons.wb_sunny_outlined,
        'text': 'Add to My Day',
        'activeText': 'Added to My Day',
        'onTap': onTapAddToMyDay,
      },
      {
        'isActive': (remindTime != null),
        'icon': Icons.notifications_outlined,
        'text': 'Remind me',
        'activeText':
            'Remind at ${DateFormat('h:mm a, MMM d').format(remindTime ?? DateTime(2000))}',
        'onTap': onTapRemindMe,
      },
      {
        'isActive': (dueDate != null),
        'icon': Icons.calendar_today_outlined,
        'text': 'Add due date',
        'activeText':
            'Due ${DateFormat('E, MMM d').format(dueDate ?? DateTime(2000))}',
        'onTap': onTapAddDueDate,
      },
      {
        'isActive': (repeatFrequency != null),
        'icon': Icons.repeat_outlined,
        'key': key,
        'text': 'Repeat',
        'activeText': 'active',
        'onTap': onTapRepeat,
      },
      {
        'isActive': false,
        'icon': Icons.attach_file_outlined,
        'text': 'Add file',
        'activeText': 'active',
        'onTap': onTapAddFile,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskList.listName,
          style: MyTheme.titleTextStyle,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          TaskModel newTask = TaskModel(
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
            filePath: filePath,
            note: widget.task.note,
          );
          taskListProvider.updateTask(
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
                  ? Column(
                      children: steps!.map(
                      (item) {
                        return StepItem(
                          taskList: widget.taskList,
                          step: item,
                          callBack: callBackEditStep,
                        );
                      },
                    ).toList())
                  : const SizedBox(),
              Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.add,
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
                      onSubmitted: (value) {
                        if (value != '') {
                          if (steps == null) {
                            setState(() {
                              steps = List<StepModel>.empty(growable: true);
                            });
                          }
                          setState(() {
                            StepModel newStep = StepModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              stepName: value,
                              isCompleted: false,
                            );
                            steps!.add(newStep);
                          });
                          _stepController.clear();
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              //////////////////////////////
              //List uniform task page item
              Column(
                children: listTaskItem.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TaskPageItem(
                      task: widget.task,
                      taskList: widget.taskList,
                      key: item['key'],
                      isActive: item['isActive'],
                      icon: item['icon'],
                      text: item['text'],
                      activeText: item['activeText'],
                      onTap: () {
                        item['onTap'](context);
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              //////////////////////////
              //Add and edit note button
              Consumer<TaskListProvider>(
                  builder: (context, taskListProvider, child) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: (widget.task.note != null)
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              noteEditRoute,
                              arguments: {
                                'task': widget.task,
                                'taskList': widget.taskList,
                              },
                            );
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 118,
                              maxWidth: double.infinity,
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                taskListProvider
                                    .getTask(
                                      taskListID: widget.taskList.id,
                                      taskID: widget.task.id,
                                    )
                                    .note!,
                                maxLines: null,
                                style: MyTheme.itemSmallTextStyle,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              noteEditRoute,
                              arguments: {
                                'task': widget.task,
                                'taskList': widget.taskList,
                              },
                            );
                          },
                          child: const Text(
                            'Add note',
                            style: MyTheme.itemSmallGreyTextStyle,
                          )),
                );
              })
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
