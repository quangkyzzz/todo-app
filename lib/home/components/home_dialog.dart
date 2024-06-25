import 'package:flutter/material.dart';

class HomeDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String positiveButton;
  const HomeDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.positiveButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: Text(positiveButton),
        )
      ],
    );
  }
}
