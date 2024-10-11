import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../models/task_list.dart';
import '../../view_models/task_list_view_model.dart';
import '../items/task_list_item.dart';

class CompletedList extends StatefulWidget {
  const CompletedList({
    super.key,
  });

  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    TaskList watchCurrentTasklist =
        context.watch<TaskListViewModel>().currentTaskList;
    List<Task> completedList = watchCurrentTasklist.tasks
        .where((element) => (element.isCompleted))
        .toList();
    if (completedList.isEmpty) {
      return const SizedBox();
    } else {
      return ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          'Completed ${completedList.length}',
          style: TextStyle(
            fontSize: 18,
            color: watchCurrentTasklist.themeColor,
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
                themeColor: watchCurrentTasklist.themeColor,
              );
            },
          )
        ],
      );
    }
  }
}
