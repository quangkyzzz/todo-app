import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_configs.dart';
import 'package:todo_app/constant/routes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/task/task_list/components/task_list_popup_menu.dart';
import 'package:todo_app/task/task_page/components/task_page_bottom_navigation.dart';

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

  onTapAddToMyDay() {
    setState(() {
      isOnMyDay = !isOnMyDay;
    });
  }

  onTapRemindMe() {
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

  onTapRepeat() {
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
      items: [
        for (Map<String, dynamic> item in listPopupItem)
          PopupMenuItem(
            child: PopupItem(
              text: item['text'],
              icon: item['icon'],
              onTap: () {},
            ),
          )
      ],
    );
  }

  onTapAddFile() {
    showModalBottomSheet(
      showDragHandle: true,
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload from',
              style: AppConfigs.itemTextStyle,
            ),
            const SizedBox(height: 10),
            TaskViewItem(
              icon: const Icon(
                Icons.folder_outlined,
                color: AppConfigs.greyColor,
              ),
              text: 'Device files',
              onTap: () {},
            ),
            TaskViewItem(
              icon: const Icon(
                Icons.photo_camera_outlined,
                color: AppConfigs.greyColor,
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
                color: AppConfigs.blueColor,
              )
            : const Icon(
                Icons.wb_sunny_outlined,
                color: AppConfigs.greyColor,
              ),
        'text': 'Add to My Day',
        'textColor': (isOnMyDay) ? AppConfigs.blueColor : AppConfigs.greyColor,
        'onTap': onTapAddToMyDay,
      },
      {
        'icon': const Icon(
          Icons.notifications_outlined,
          color: AppConfigs.greyColor,
        ),
        'text': 'Remind me',
        'onTap': onTapRemindMe,
      },
      {
        'icon': const Icon(
          Icons.calendar_today_outlined,
          color: AppConfigs.greyColor,
        ),
        'text': 'Add due date',
        'onTap': onTapRemindMe,
      },
      {
        'icon': const Icon(
          Icons.repeat_outlined,
          color: AppConfigs.greyColor,
        ),
        'key': key,
        'text': 'Repeat',
        'onTap': onTapRepeat,
      },
      {
        'icon': const Icon(
          Icons.attach_file_outlined,
          color: AppConfigs.greyColor,
        ),
        'text': 'Add file',
        'onTap': onTapAddFile,
      },
    ];
    _taskNameController.text = widget.task.title;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: AppConfigs.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: isChecked,
                    shape: const CircleBorder(),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: AppConfigs.titleTextStyle,
                    controller: _taskNameController,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isImportant = !isImportant;
                    });
                  },
                  child: (isImportant)
                      ? Transform.scale(
                          scale: 1.3,
                          child: const Icon(
                            Icons.star,
                            color: AppConfigs.blueColor,
                          ),
                        )
                      : Transform.scale(
                          scale: 1.3,
                          child: const Icon(Icons.star_border_outlined)),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 15),
                Transform.scale(scale: 1.3, child: const Icon(Icons.add)),
                const SizedBox(width: 10),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add step',
                      border: InputBorder.none,
                    ),
                    style: AppConfigs.itemTextStyle,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            for (Map<String, dynamic> item in listTaskItem)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TaskViewItem(
                  key: item['key'],
                  icon: item['icon'],
                  text: item['text'],
                  textColor: item['textColor'] ?? AppConfigs.greyColor,
                  onTap: item['onTap'],
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(noteEditRoute);
                  },
                  child: const Text(
                    'Add note',
                    style: AppConfigs.itemGreyTextStyle,
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: TaskPageBottomNavigation(task: widget.task),
    );
  }
}

class TaskViewItem extends StatelessWidget {
  final Color textColor;
  final Icon icon;
  final String text;
  final Function() onTap;
  const TaskViewItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor = AppConfigs.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Transform.scale(
          scale: 1.3,
          child: icon,
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
