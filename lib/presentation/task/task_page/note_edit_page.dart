import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit your note',
          style: MyTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Transform.scale(
              scale: 1.3,
              child: const Icon(Icons.save_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
