import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/task/task_page/task_page_bottom_navigation.dart';
import '../../items/popup_item.dart';

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
  late bool isChecked;
  late bool isImportant;
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

  onTapRemindMe(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
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
              icon: const Icon(
                Icons.folder_outlined,
                color: MyTheme.greyColor,
              ),
              text: 'Device files',
              onTap: () {},
            ),
            TaskPageItem(
              icon: const Icon(
                Icons.photo_camera_outlined,
                color: MyTheme.greyColor,
              ),
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
    isChecked = widget.task.isCompleted;
    isImportant = widget.task.isImportant;
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
        'icon': (isOnMyDay)
            ? const Icon(
                Icons.wb_sunny_outlined,
                color: MyTheme.blueColor,
              )
            : const Icon(
                Icons.wb_sunny_outlined,
                color: MyTheme.greyColor,
              ),
        'text': 'Add to My Day',
        'textColor': (isOnMyDay) ? MyTheme.blueColor : MyTheme.greyColor,
        'onTap': onTapAddToMyDay,
      },
      {
        'icon': const Icon(
          Icons.notifications_outlined,
          color: MyTheme.greyColor,
        ),
        'text': 'Remind me',
        'onTap': onTapRemindMe,
      },
      {
        'icon': const Icon(
          Icons.calendar_today_outlined,
          color: MyTheme.greyColor,
        ),
        'text': 'Add due date',
        'onTap': onTapRemindMe,
      },
      {
        'icon': const Icon(
          Icons.repeat_outlined,
          color: MyTheme.greyColor,
        ),
        'key': key,
        'text': 'Repeat',
        'onTap': onTapRepeat,
      },
      {
        'icon': const Icon(
          Icons.attach_file_outlined,
          color: MyTheme.greyColor,
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Edit task row
            TaskEditRow(taskNameController: _taskNameController),
            const SizedBox(height: 8),
            //Add step row
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
                    icon: item['icon'],
                    text: item['text'],
                    textColor: item['textColor'] ?? MyTheme.greyColor,
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
      bottomNavigationBar: TaskPageBottomNavigation(task: widget.task),
    );
  }
}

class TaskPageItem extends StatelessWidget {
  final Color textColor;
  final Icon icon;
  final String text;
  final Function() onTap;
  const TaskPageItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor = MyTheme.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Transform.scale(
          scale: 1.3,
          child: icon,
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: MyTheme.itemGreyTextStyle,
          ),
        ),
      ],
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
