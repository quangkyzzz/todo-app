import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/task/task_page/task_page_bottom_navigation.dart';
import 'package:todo_app/presentation/items/popup_item.dart';
import 'task_page_item.dart';

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

  onTapAddToMyDay(BuildContext context) {
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
      if (selectedDate == null) return DateTime.now();

      if (!context.mounted) return selectedDate;

      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime(2000, 2, 2, 9)),
      );

      selectedTime ??= TimeOfDay.fromDateTime(DateTime(2000, 2, 2, 9));

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
      setState(() {
        remindTime = tempRemindTime;
      });
    } else {
      setState(() {
        remindTime = null;
      });
    }
  }

  onTapAddDueDate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
      },
    );
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
              onTap: () {},
            ),
            TaskPageItem(
              task: widget.task,
              taskList: widget.taskList,
              isActive: false,
              icon: Icons.photo_camera_outlined,
              text: 'Camera',
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    groupProvider = Provider.of<GroupProvider>(context, listen: false);
    title = widget.task.title;
    isOnMyDay = false;
    isCompleted = widget.task.isCompleted;
    isImportant = widget.task.isImportant;
    remindTime = widget.task.remindTime;
    dueDate = widget.task.dueDate;
    steps = widget.task.stepList;
    repeatFrequency = widget.task.repeatFrequency;
    filePath = widget.task.filePath;
    _taskNameController = TextEditingController();
    _taskNameController.text = widget.task.title;
    super.initState();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  void callBack(bool setComplete, bool setImportant) {
    setState(() {
      isCompleted = setComplete;
      isImportant = setImportant;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listTaskItem = [
      {
        'isActive': isOnMyDay,
        'icon': Icons.wb_sunny_outlined,
        'text': 'Add to My Day',
      },
      {
        'isActive': (remindTime != null),
        'icon': Icons.notifications_outlined,
        'text': 'Remind me',
        'onTap': onTapRemindMe,
        'value': remindTime,
      },
      {
        'isActive': (dueDate != null),
        'icon': Icons.calendar_today_outlined,
        'text': 'Add due date',
        'onTap': onTapAddDueDate,
        'value': dueDate,
      },
      {
        'isActive': (repeatFrequency != null),
        'icon': Icons.repeat_outlined,
        'key': key,
        'text': 'Repeat',
        'onTap': onTapRepeat,
        'value': repeatFrequency,
      },
      {
        'isActive': false,
        'icon': Icons.attach_file_outlined,
        'text': 'Add file',
        'onTap': onTapAddFile,
        'value': filePath,
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
            remindTime: remindTime,
            dueDate: dueDate,
            stepList: steps,
            repeatFrequency: repeatFrequency,
            filePath: filePath,
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
              //Edit task row
              TaskEditRow(
                taskNameController: _taskNameController,
                isChecked: isCompleted,
                isImportant: isImportant,
                callBack: callBack,
              ),
              const SizedBox(height: 8),
              //Add step row
              (steps != null)
                  ? Column(
                      children: steps!.map(
                      (item) {
                        return StepItem(
                          step: item,
                        );
                      },
                    ).toList())
                  : const SizedBox(),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Icon(
                    Icons.add,
                    color: MyTheme.greyColor,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add step',
                        border: InputBorder.none,
                      ),
                      style: MyTheme.itemSmallTextStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
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
                      onTap: () {
                        item['onTap'](context);
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              //Add and edit note button
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(noteEditRoute);
                    },
                    child: const Text(
                      'Add note',
                      style: MyTheme.itemSmallGreyTextStyle,
                    )),
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

class TaskEditRow extends StatefulWidget {
  final bool isChecked;
  final bool isImportant;
  final TextEditingController taskNameController;
  final Function callBack;
  const TaskEditRow({
    super.key,
    required this.isChecked,
    required this.isImportant,
    required this.taskNameController,
    required this.callBack,
  });

  @override
  State<TaskEditRow> createState() => _TaskEditRowState();
}

class _TaskEditRowState extends State<TaskEditRow> {
  late bool _isChecked;
  late bool _isImportant;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
    _isImportant = widget.isImportant;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: _isChecked,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
              });
              widget.callBack(_isChecked, _isImportant);
            },
          ),
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(border: InputBorder.none),
            style: MyTheme.titleTextStyle,
            controller: widget.taskNameController,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isImportant = !_isImportant;
            });
            widget.callBack(_isChecked, _isImportant);
          },
          child: (_isImportant)
              ? Transform.scale(
                  scale: 1.3,
                  child: const Icon(
                    Icons.star,
                    color: MyTheme.blueColor,
                  ),
                )
              : Transform.scale(
                  scale: 1.3, child: const Icon(Icons.star_border_outlined)),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class StepItem extends StatefulWidget {
  final StepModel step;
  const StepItem({
    super.key,
    required this.step,
  });

  @override
  State<StepItem> createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  late StepModel step;
  late bool isCompleted;
  late TextEditingController _controller;

  @override
  void initState() {
    step = widget.step;
    isCompleted = widget.step.isCompleted;
    _controller = TextEditingController();
    _controller.text = widget.step.stepName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          shape: const CircleBorder(),
          value: isCompleted,
          onChanged: (bool? value) {
            setState(() {
              isCompleted = value!;
            });
          },
        ),
        Expanded(
          child: TextField(
            controller: _controller,
          ),
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: () {},
              child: const PopupItem(
                text: 'Promote to task',
                icon: Icons.add_outlined,
              ),
            ),
            PopupMenuItem(
              onTap: () {},
              child: const PopupItem(
                text: 'Delete task',
                icon: Icons.delete_outline,
              ),
            ),
          ];
        })
      ],
    );
  }
}
