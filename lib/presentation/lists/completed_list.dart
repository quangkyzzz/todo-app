import 'package:flutter/material.dart';
import '../../models/task_list.dart';
import '../../models/task.dart';
import '../items/task_list_item.dart';

class CompletedList extends StatefulWidget {
  final TaskList taskList;
  const CompletedList({
    super.key,
    required this.taskList,
  });

  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  bool isExpanded = true;
  late List<Task> completedList;

  @override
  void initState() {
    completedList = widget.taskList.tasks
        .where((element) => (element.isCompleted))
        .toList();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CompletedList oldWidget) {
    completedList = widget.taskList.tasks
        .where((element) => (element.isCompleted))
        .toList();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (completedList.isEmpty) {
      return const SizedBox();
    } else {
      return ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          'Completed ${completedList.length}',
          style: TextStyle(
            fontSize: 18,
            color: widget.taskList.themeColor,
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
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: completedList.length,
            itemBuilder: (BuildContext _, int index) {
              Task task = completedList[index];
              return TaskListItem(
                mContext: context,
                task: task,
                themeColor: widget.taskList.themeColor,
              );
            },
          )
        ],
      );
    }
  }
}
