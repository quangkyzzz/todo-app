import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
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
  bool isImportant = false;
  late final TextEditingController _taskNameController;

  @override
  void initState() {
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
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                shape: const CircleBorder(),
                onChanged: (bool? value) {},
              ),
              Expanded(
                child: TextField(
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
                    ? const Icon(
                        Icons.star,
                        color: AppConfigs.blueColor,
                      )
                    : const Icon(Icons.star_border_outlined),
              )
            ],
          )
        ],
      ),
    );
  }
}
