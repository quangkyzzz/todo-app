import 'package:flutter/material.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class StepItem extends StatefulWidget {
  final StepModel step;
  const StepItem({
    super.key,
    required this.step,
  });

  @override
  State<StepItem> createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  late StepModel step;
  late bool isCompleted;
  late TextEditingController _controller;

  @override
  void initState() {
    step = widget.step;
    isCompleted = widget.step.isCompleted;
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
          value: isCompleted,
          onChanged: (bool? value) {
            setState(() {
              isCompleted = value!;
            });
          },
        ),
        Expanded(
          child: TextField(
            controller: _controller,
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
              onTap: () {},
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
