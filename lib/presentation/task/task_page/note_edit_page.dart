import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';

import '../../../themes.dart';
import '../../../view_models/task_view_model.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
        text: context.read<TaskViewModel>().currentTask.note);
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
              updatedTask.note = controller.text;
              context.read<TaskViewModel>().updateTask(
                    updatedTask: updatedTask,
                  );
              if (context.mounted) {
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
          controller: controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
