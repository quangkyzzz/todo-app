import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';

import '../../../themes.dart';
import '../../../view_models/task_view_model.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({
    super.key,
  });

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<TaskViewModel>().currentTask.note);
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
          context.watch<TaskViewModel>().currentTask.title,
          style: MyTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Task updatedTask = context.read<TaskViewModel>().currentTask;
              updatedTask.note = _controller.text;
              context.read<TaskViewModel>().updateTask(
                    updatedTask: updatedTask,
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
