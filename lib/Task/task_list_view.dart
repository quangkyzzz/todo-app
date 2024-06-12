import 'package:flutter/material.dart';

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
    );
  }
}
