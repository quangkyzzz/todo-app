import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';
import '../../../themes.dart';
import '../../../view_models/task_view_model.dart';

class NoteEditPage extends StatefulWidget {
  final Task task;

  const NoteEditPage({
    super.key,
    required this.task,
  });

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TaskViewModel taskViewModel;
  late TextEditingController _controller;

  @override
  void initState() {
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
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
            onPressed: () async {
              Task newTask = widget.task.copyWith(note: _controller.text);
              await taskViewModel.updateTask(
                taskID: widget.task.id,
                newTask: newTask,
              );
              if (mounted) {
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
              }
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
