import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  bool isAddNewTask = true;
  bool isMoveToTop = true;
  bool isPlaySoundOnComplete = true;
  bool isConfirmBeforeDelete = true;
  bool isShowDueToday = true;
  bool isRecognizeDateAndTime = true;
  bool isRemoveDateTimeFromTasksTitle = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsItem(
          isActive: isAddNewTask,
          text: "Add new tasks on top",
          onChange: (bool val) {
            setState(() {
              isAddNewTask = val;
            });
          },
        ),
        SettingsItem(
          isActive: isMoveToTop,
          text: "Move starred tasks on top",
          onChange: (bool val) {
            setState(() {
              isMoveToTop = val;
            });
          },
        ),
        SettingsItem(
          isActive: isPlaySoundOnComplete,
          text: "Play completion sound",
          onChange: (bool val) {
            setState(() {
              isPlaySoundOnComplete = val;
            });
          },
        ),
        SettingsItem(
          isActive: isConfirmBeforeDelete,
          text: "Confirm before deleting",
          onChange: (bool val) {
            setState(() {
              isConfirmBeforeDelete = val;
            });
          },
        ),
        SettingsItem(
          isActive: isShowDueToday,
          text: "Show 'Due Today' tasks in My Day",
          onChange: (bool val) {
            setState(() {
              isShowDueToday = val;
            });
          },
        ),
        SettingsItem(
          isActive: isRecognizeDateAndTime,
          text: "Recognize dates and times in task titles",
          onChange: (bool val) {
            setState(() {
              isRecognizeDateAndTime = val;
            });
          },
        ),
        SettingsItem(
          isActive: isRemoveDateTimeFromTasksTitle,
          text: "Remove dates and times from tasks titles once recognized",
          onChange: (bool val) {
            setState(() {
              isRemoveDateTimeFromTasksTitle = val;
            });
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SettingsItem extends StatelessWidget {
  final bool isActive;
  final String text;
  final Function(bool) onChange;
  const SettingsItem({
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
