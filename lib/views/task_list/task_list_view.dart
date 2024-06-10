import 'package:flutter/material.dart';

class TaskListView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => TaskListView(),
      );
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
