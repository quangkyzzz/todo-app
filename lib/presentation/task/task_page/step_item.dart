import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_step.dart';
import '../../../models/task_list.dart';
import '../../../view_models/task_view_model.dart';
import '../../items/popup_item.dart';
import '../../../themes.dart';

class StepItem extends StatefulWidget {
  final TaskStep step;
  final TaskList taskList;
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
  late final TaskViewModel taskViewModel;
  late TaskStep step;
  late TextEditingController _controller;

  @override
  void initState() {
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    step = widget.step;
    _controller = TextEditingController();
    _controller.text = widget.step.stepName;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StepItem oldWidget) {
    _controller.text = widget.step.stepName;
    step = widget.step;
    super.didUpdateWidget(oldWidget);
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
                taskViewModel.createTask(
                  taskListID: widget.taskList.id,
                  taskName: step.stepName,
                  isCompleted: step.isCompleted,
                );
              },
              child: const CustomPopupItem(
                text: 'Promote to task',
                icon: Icons.add_outlined,
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.callBack(step, isDelete: true);
              },
              child: const CustomPopupItem(
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
