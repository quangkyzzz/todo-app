import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';

class ReorderPage extends StatefulWidget {
  final TaskListModel taskList;
  const ReorderPage({
    super.key,
    required this.taskList,
  });

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  late TaskListProvider taskListProvider;

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        taskListProvider.updateTaskList(
          taskListID: widget.taskList.id,
          newTaskList: widget.taskList,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reorder tasks',
            style: MyTheme.titleTextStyle,
          ),
        ),
        body: ReorderableListView(
            header: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tap and hold to reorder task',
                style: MyTheme.itemTextStyle,
              ),
            ),
            children: widget.taskList.tasks.map((item) {
              return TaskListItem(
                key: Key(item.id),
                task: item,
                taskList: widget.taskList,
              );
            }).toList(),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = widget.taskList.tasks.removeAt(oldIndex);
                widget.taskList.tasks.insert(newIndex, item);
              });
            }),
      ),
    );
  }
}
