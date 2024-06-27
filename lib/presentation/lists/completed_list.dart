import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';

class CompletedList extends StatefulWidget {
  final List<Map<String, dynamic>> taskList;
  const CompletedList({
    super.key,
    required this.taskList,
  });

  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text(
        'Completed',
        style: TextStyle(
          fontSize: 20,
          color: MyTheme.blueColor,
        ),
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      trailing:
          Icon(isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
      children: [
        IncompleteList(
          taskList: widget.taskList,
        ),
      ],
    );
  }
}
