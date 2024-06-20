import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/Models/task_model.dart';

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
  late bool isChecked;
  late bool isImportant;
  late final TextEditingController _taskNameController;

  @override
  void initState() {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
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
            icon: Icons.wb_sunny_outlined,
            text: 'Add to My Day',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          TaskViewItem(
            icon: Icons.notifications_outlined,
            text: 'Remind me',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          TaskViewItem(
            icon: Icons.calendar_today_outlined,
            text: 'Add due date',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          TaskViewItem(
            icon: Icons.repeat_outlined,
            text: 'Repeat',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          TaskViewItem(
            icon: Icons.attach_file_outlined,
            text: 'Add file',
            onTap: () {},
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
              onPressed: () {},
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
  final IconData icon;
  final String text;
  final Function() onTap;
  const TaskViewItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Transform.scale(
            scale: 1.3,
            child: Icon(
              icon,
              color: AppConfigs.greyColor,
            )),
        const SizedBox(width: 10),
        TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(color: AppConfigs.greyColor, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
