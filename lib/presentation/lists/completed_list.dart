import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/entity/task.dart';
import 'package:todo_app/model/entity/task_list.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';

class CompletedList extends StatefulWidget {
  final bool isReorderState;

  const CompletedList({
    super.key,
    required this.isReorderState,
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
      return IgnorePointer(
        ignoring: widget.isReorderState,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            maintainState: true,
            initiallyExpanded: isExpanded,
            onExpansionChanged: (bool expaned) {
              setState(() {
                isExpanded = expaned;
              });
            },
            title: Text(
              'Completed ${completedList.length}',
              style: TextStyle(
                fontSize: 18,
                color: watchCurrentTasklist.themeColor,
              ),
            ),
            trailing: Icon(
                isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: completedList.length,
                itemBuilder: (BuildContext _, int index) {
                  Task task = completedList[index];
                  return TaskListItem(
                    isReorderState: false,
                    task: task,
                    themeColor: watchCurrentTasklist.themeColor,
                  );
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
