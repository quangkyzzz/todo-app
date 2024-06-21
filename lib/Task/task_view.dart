import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/Task_list/components/task_list_popup_menu.dart';

class TaskView extends StatefulWidget {
  final TaskModel task;
  const TaskView({
    super.key,
    required this.task,
  });

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late bool isOnMyDay;
  late bool isChecked;
  late bool isImportant;
  late final TextEditingController _taskNameController;

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
    _taskNameController.text = widget.task.title;
    GlobalKey key = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontSize: 30),
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
                    style: const TextStyle(fontSize: 30),
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
                )
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
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            TaskViewItem(
              icon: (isOnMyDay)
                  ? const Icon(
                      Icons.wb_sunny_outlined,
                      color: AppConfigs.blueColor,
                    )
                  : const Icon(
                      Icons.wb_sunny_outlined,
                      color: AppConfigs.greyColor,
                    ),
              text: 'Add to My Day',
              textColor:
                  (isOnMyDay) ? AppConfigs.blueColor : AppConfigs.greyColor,
              onTap: () {
                setState(() {
                  isOnMyDay = !isOnMyDay;
                });
              },
            ),
            const SizedBox(height: 20),
            TaskViewItem(
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppConfigs.greyColor,
              ),
              text: 'Remind me',
              onTap: () {
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
              },
            ),
            const SizedBox(height: 20),
            TaskViewItem(
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: AppConfigs.greyColor,
              ),
              text: 'Add due date',
              onTap: () {
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
              },
            ),
            const SizedBox(height: 20),
            TaskViewItem(
              key: key,
              icon: const Icon(
                Icons.repeat_outlined,
                color: AppConfigs.greyColor,
              ),
              text: 'Repeat',
              onTap: () {
                RenderBox box =
                    key.currentContext!.findRenderObject() as RenderBox;
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
                    PopupMenuItem(
                      child: PopupItem(
                        text: 'Daily',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                    ),
                    PopupMenuItem(
                      child: PopupItem(
                        text: 'Weekdays',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                    ),
                    PopupMenuItem(
                      child: PopupItem(
                        text: 'Weekly',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                    ),
                    PopupMenuItem(
                      child: PopupItem(
                        text: 'Monthly',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                    ),
                    PopupMenuItem(
                      child: PopupItem(
                        text: 'Yearly',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                    ),
                    PopupMenuItem(
                      child: PopupItem(
                        text: 'Custom',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            TaskViewItem(
              icon: const Icon(
                Icons.attach_file_outlined,
                color: AppConfigs.greyColor,
              ),
              text: 'Add file',
              onTap: () {
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
                            style: TextStyle(fontSize: 20),
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
                    });
              },
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
                    style: TextStyle(
                      fontSize: 20,
                      color: AppConfigs.greyColor,
                    ),
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppConfigs.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          children: [
            const Text(
              'Create 1 hour ago',
              style: TextStyle(
                color: AppConfigs.greyColor,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Are you sure?',
                        style: TextStyle(fontSize: 20),
                      ),
                      content: Text(
                          ' "${widget.task.title}" will be permanently deleted'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: AppConfigs.redColor),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete_outline,
                color: AppConfigs.greyColor,
              ),
            )
          ],
        ),
      ),
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
