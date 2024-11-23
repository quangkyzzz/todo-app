import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/view_models/task_view_model.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({
    super.key,
  });

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  @override
  void initState() {
    context.read<TaskViewModel>().initCurrentTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<TaskViewModel>().isLoadingTask) {
      return const Center(child: CircularProgressIndicator());
    } else {
      TextEditingController controller = TextEditingController(
          text: context.read<TaskViewModel>().currentTask.note);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            context.read<TaskViewModel>().currentTask.title,
            style: MyTheme.titleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                context
                    .read<TaskViewModel>()
                    .updateNote(newNote: controller.text);
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
            autofocus: true,
            controller: controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
      );
    }
  }
}
