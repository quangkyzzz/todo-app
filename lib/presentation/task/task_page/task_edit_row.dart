import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class TaskEditRow extends StatefulWidget {
  final bool isChecked;
  final bool isImportant;
  final TextEditingController taskNameController;
  final Function callBack;
  const TaskEditRow({
    super.key,
    required this.isChecked,
    required this.isImportant,
    required this.taskNameController,
    required this.callBack,
  });

  @override
  State<TaskEditRow> createState() => _TaskEditRowState();
}

class _TaskEditRowState extends State<TaskEditRow> {
  late bool _isChecked;
  late bool _isImportant;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
    _isImportant = widget.isImportant;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            activeColor: MyTheme.blueColor,
            value: _isChecked,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
              });
              widget.callBack(_isChecked, _isImportant);
            },
          ),
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(border: InputBorder.none),
            style: MyTheme.titleTextStyle,
            controller: widget.taskNameController,
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            setState(() {
              _isImportant = !_isImportant;
            });
            widget.callBack(_isChecked, _isImportant);
          },
          child: (_isImportant)
              ? Transform.scale(
                  scale: 1.3,
                  child: const Icon(
                    Icons.star,
                    color: MyTheme.blueColor,
                  ),
                )
              : Transform.scale(
                  scale: 1.3, child: const Icon(Icons.star_border_outlined)),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
