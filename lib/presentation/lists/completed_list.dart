import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/themes.dart';

class CompletedList extends StatefulWidget {
  final TaskListModel taskList;
  const CompletedList({
    super.key,
    required this.taskList,
  });

  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  bool isExpanded = true;
  late List<TaskModel> completedList;

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
          style: const TextStyle(
            fontSize: 18,
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
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: completedList.length,
            itemBuilder: (BuildContext context, int index) {
              TaskModel task = completedList[index];
              return TaskListItem(
                task: task,
                taskList: widget.taskList,
              );
            },
          )
        ],
      );
    }
  }
}
