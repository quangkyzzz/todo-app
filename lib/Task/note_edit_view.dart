import 'package:flutter/material.dart';

class NoteEditView extends StatefulWidget {
  const NoteEditView({super.key});

  @override
  State<NoteEditView> createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your note'),
      ),
      body: const TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
