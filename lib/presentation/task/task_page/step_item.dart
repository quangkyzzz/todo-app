import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/items/popup_item.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class StepItem extends StatefulWidget {
  final StepModel step;
  final TaskListModel taskList;
  final Function callBack;
  const StepItem({
    super.key,
    required this.step,
    required this.callBack,
    required this.taskList,
  });

  @override
  State<StepItem> createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  late final TaskListProvider taskListProvider;
  late StepModel step;
  late TextEditingController _controller;

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    step = widget.step;
    _controller = TextEditingController();
    _controller.text = widget.step.stepName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: MyTheme.blueColor,
          shape: const CircleBorder(),
          value: step.isCompleted,
          onChanged: (bool? value) {
            setState(() {
              step.isCompleted = value!;
            });
            widget.callBack(step);
          },
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) {
              step.stepName = value;
              widget.callBack(step);
            },
          ),
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              onTap: () {
                widget.callBack(step, isDelete: true);
                taskListProvider.createTask(
                  taskListID: widget.taskList.id,
                  taskName: step.stepName,
                  isCompleted: step.isCompleted,
                );
              },
              child: const PopupItem(
                text: 'Promote to task',
                icon: Icons.add_outlined,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.callBack(step, isDelete: true);
              },
              child: const PopupItem(
                text: 'Delete step',
                icon: Icons.delete_outline,
              ),
            ),
          ];
        })
      ],
    );
  }
}
