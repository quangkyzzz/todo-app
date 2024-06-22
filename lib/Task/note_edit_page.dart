import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';

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
          style: AppConfigs.titleTextStyle,
        ),
      ),
      body: const TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
