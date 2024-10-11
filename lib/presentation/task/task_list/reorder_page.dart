import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../themes.dart';
import '../../../view_models/task_list_view_model.dart';
import '../../items/task_list_item.dart';

class ReorderPage extends StatefulWidget {
  const ReorderPage({
    super.key,
  });

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
            children: context
                .watch<TaskListViewModel>()
                .currentTaskList
                .tasks
                .map((item) {
              return TaskListItem(
                key: Key(item.id),
                task: item,
                themeColor: context
                    .read<TaskListViewModel>()
                    .currentTaskList
                    .themeColor,
              );
            }).toList(),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = context
                    .read<TaskListViewModel>()
                    .currentTaskList
                    .tasks
                    .removeAt(oldIndex);
                context
                    .read<TaskListViewModel>()
                    .currentTaskList
                    .tasks
                    .insert(newIndex, item);
              });
            }),
      ),
    );
  }
}
