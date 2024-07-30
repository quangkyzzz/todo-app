import 'package:flutter/material.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class StepItem extends StatefulWidget {
  final StepModel step;
  final Function callBack;
  const StepItem({
    super.key,
    required this.step,
    required this.callBack,
  });

  @override
  State<StepItem> createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  late StepModel step;
  late TextEditingController _controller;

  @override
  void initState() {
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
              onTap: () {},
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
