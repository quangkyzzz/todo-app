import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

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

  late List<Map<String, dynamic>> listSettingItem = [
    {
      'text': 'Add new tasks on top',
      'isActive': isAddNewTask,
    },
    {
      'text': 'Move starred tasks on top',
      'isActive': isMoveToTop,
    },
    {
      'text': "Play completion sound",
      'isActive': isPlaySoundOnComplete,
    },
    {
      'text': 'Confirm before deleting',
      'isActive': isConfirmBeforeDelete,
    },
    {
      'text': "Show 'Due Today' tasks in My Day",
      'isActive': isShowDueToday,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: listSettingItem.map((item) {
          return SettingsItem(
            isActive: item['isActive'],
            text: item['text'],
            onChange: (bool val) {
              setState(() {
                item['isActive'] = val;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: MyTheme.itemTextStyle,
            ),
          ),
          Switch(
            value: isActive,
            onChanged: onChange,
            activeColor: MyTheme.blueColor,
          ),
        ],
      ),
    );
  }
}
