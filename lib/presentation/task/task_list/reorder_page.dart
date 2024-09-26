import 'package:flutter/material.dart';
import '../../../models/task_list.dart';
import '../../../themes.dart';
import '../../items/task_list_item.dart';

class ReorderPage extends StatefulWidget {
  final TaskList taskList;
  const ReorderPage({
    super.key,
    required this.taskList,
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
            children: widget.taskList.tasks.map((item) {
              return TaskListItem(
                mContext: context,
                key: Key(item.id),
                task: item,
                themeColor: widget.taskList.themeColor,
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
