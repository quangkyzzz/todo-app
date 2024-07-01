import 'package:flutter/material.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/task/task_page/task_page_bottom_navigation.dart';
import 'package:todo_app/presentation/items/popup_item.dart';
import 'task_page_item.dart';

class TaskPage extends StatefulWidget {
  final TaskModel task;
  const TaskPage({
    super.key,
    required this.task,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  GlobalKey key = GlobalKey();
  late bool isOnMyDay;
  late bool isCompleted;
  late bool isImportant;
  late List<StepModel>? steps;
  late DateTime? notiDate;
  late DateTime? dueDate;
  late String? notiFrequency;
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

  Future<DateTime?> onTapRemindMe(BuildContext context) async {
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
      initialTime: TimeOfDay.now(),
    );

    selectedTime ??= TimeOfDay.now();

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
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
              isActive: false,
              icon: Icons.folder_outlined,
              text: 'Device files',
              onTap: () {},
            ),
            TaskPageItem(
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
    isOnMyDay = false;
    isCompleted = widget.task.isCompleted;
    isImportant = widget.task.isImportant;
    notiDate = widget.task.notiTime;
    dueDate = widget.task.dueDate;
    steps = widget.task.stepList;
    notiFrequency = widget.task.notiFrequency;
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

  @override
  Widget build(BuildContext context) {
    late List<Map<String, dynamic>> listTaskItem = [
      {
        'isActive': isOnMyDay,
        'icon': Icons.wb_sunny_outlined,
        'text': 'Add to My Day',
      },
      {
        'isActive': (notiDate != null),
        'icon': Icons.notifications_outlined,
        'text': 'Remind me',
        'onTap': onTapRemindMe,
      },
      {
        'isActive': (dueDate != null),
        'icon': Icons.calendar_today_outlined,
        'text': 'Add due date',
        'onTap': onTapAddDueDate,
      },
      {
        'isActive': (notiFrequency != null),
        'icon': Icons.repeat_outlined,
        'key': key,
        'text': 'Repeat',
        'onTap': onTapRepeat,
      },
      {
        'isActive': false,
        'icon': Icons.attach_file_outlined,
        'text': 'Add file',
        'onTap': onTapAddFile,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: MyTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Edit task row
              TaskEditRow(taskNameController: _taskNameController),
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
              Row(
                children: [
                  const SizedBox(width: 16),
                  Transform.scale(
                    scale: 1.3,
                    child: const Icon(
                      Icons.add,
                      color: MyTheme.greyColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add step',
                        border: InputBorder.none,
                      ),
                      style: MyTheme.itemTextStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 18),
              //List uniform task page item
              Column(
                children: listTaskItem.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: TaskPageItem(
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
                      style: MyTheme.itemGreyTextStyle,
                    )),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: TaskPageBottomNavigation(task: widget.task),
    );
  }
}

class TaskEditRow extends StatefulWidget {
  final bool isChecked;
  final bool isImportant;
  final TextEditingController taskNameController;
  const TaskEditRow({
    super.key,
    this.isChecked = false,
    this.isImportant = false,
    required this.taskNameController,
  });

  @override
  State<TaskEditRow> createState() => _TaskEditRowState();
}

class _TaskEditRowState extends State<TaskEditRow> {
  bool _isChecked = false;
  bool _isImportant = false;

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
