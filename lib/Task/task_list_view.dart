import 'package:flutter/material.dart';
import 'package:todo_app/Task/components/task_list_item.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 'menu',
                child: Text('menu'),
              ),
            ];
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return const TaskListItem();
              },
            )
          ],
        ),
      ),
    );
  }
}
