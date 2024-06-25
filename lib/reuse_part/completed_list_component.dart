import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/reuse_part/incomplete_list_component.dart';

class CompletedListComponent extends StatefulWidget {
  final List<Map<String, dynamic>> taskList;
  const CompletedListComponent({
    super.key,
    required this.taskList,
  });

  @override
  State<CompletedListComponent> createState() => _CompletedListComponentState();
}

class _CompletedListComponentState extends State<CompletedListComponent> {
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
        IncompleteListComponent(
          taskList: widget.taskList,
        ),
      ],
    );
  }
}
