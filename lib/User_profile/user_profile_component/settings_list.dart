import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  bool isAddNewTask = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsItem(
          text: "Add new tasks on top",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          text: "Move starred tasks on top",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          text: "Play completion sound",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          text: "Confirm before deleting",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          text: "Show 'Due Today' tasks in My Day",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          text: "Recognize dates an times in task titles",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          text: "Remove dates and times from tasks titles once recognized",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  bool isActive;
  final String text;
  final Function(bool) onChange;
  SettingsItem({
    super.key,
    required this.text,
    required this.onChange,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Switch(
            value: isActive,
            onChanged: onChange,
            activeColor: AppConfigs.blueColor,
          ),
        ],
      ),
    );
  }
}
