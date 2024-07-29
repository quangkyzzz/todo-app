import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class NoteEditPage extends StatefulWidget {
  final TaskModel task;
  final TaskListModel taskList;
  const NoteEditPage({
    super.key,
    required this.task,
    required this.taskList,
  });

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TaskListProvider taskListProvider;
  late TextEditingController _controller;

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    _controller = TextEditingController(text: widget.task.note);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task.title,
          style: MyTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              TaskModel newTask = widget.task.copyWith(note: _controller.text);
              taskListProvider.updateTask(
                taskListID: widget.taskList.id,
                taskID: widget.task.id,
                newTask: newTask,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: MyTheme.backgroundGreyColor,
                  content: Text(
                    'Note saved!',
                    style: MyTheme.itemSmallTextStyle,
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Transform.scale(
              scale: 1.3,
              child: const Icon(Icons.save_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
