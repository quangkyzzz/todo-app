import 'package:flutter/material.dart';
import 'package:todo_app/model/data/settings_shared_preference.dart';
import 'package:todo_app/themes.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  late bool isAddNewTaskOnTop;
  late bool isMoveStarTaskToTop;
  late bool isPlaySoundOnComplete;
  late bool isConfirmBeforeDelete;
  late bool isShowDueToday;

  @override
  void initState() {
    isAddNewTaskOnTop =
        SettingsSharedPreference.getInstance.getIsAddNewTaskOnTop();
    isMoveStarTaskToTop =
        SettingsSharedPreference.getInstance.getIsMoveStarTaskToTop();
    isPlaySoundOnComplete =
        SettingsSharedPreference.getInstance.getIsPlaySoundOnComplete();
    isConfirmBeforeDelete =
        SettingsSharedPreference.getInstance.getIsConfirmBeforeDelete();
    isShowDueToday = SettingsSharedPreference.getInstance.getIsShowDueToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        SettingsItem(
          isActive: isAddNewTaskOnTop,
          text: 'Add new tasks on top',
          onChange: (bool changeValue) {
            setState(() {
              isAddNewTaskOnTop = changeValue;
            });
            SettingsSharedPreference.getInstance
                .setIsAddNewTaskOnTop(changeValue);
          },
        ),
        SettingsItem(
          isActive: isMoveStarTaskToTop,
          text: 'Move starred tasks on top',
          onChange: (bool changeValue) {
            setState(() {
              isMoveStarTaskToTop = changeValue;
            });
            SettingsSharedPreference.getInstance
                .setIsMoveStarTaskToTop(changeValue);
          },
        ),
        SettingsItem(
          isActive: isPlaySoundOnComplete,
          text: 'Play completion sound',
          onChange: (bool changeValue) {
            setState(() {
              isPlaySoundOnComplete = changeValue;
            });
            SettingsSharedPreference.getInstance
                .setIsPlaySoundOnComplete(changeValue);
          },
        ),
        SettingsItem(
          isActive: isConfirmBeforeDelete,
          text: 'Confirm before deleting',
          onChange: (bool changeValue) {
            setState(() {
              isConfirmBeforeDelete = changeValue;
            });
            SettingsSharedPreference.getInstance
                .setIsConfirmBeforeDelete(changeValue);
          },
        ),
        SettingsItem(
          isActive: isShowDueToday,
          text: "Show 'Due Today' tasks in My Day",
          onChange: (bool changeValue) {
            setState(() {
              isShowDueToday = changeValue;
            });
            SettingsSharedPreference.getInstance.setIsShowDueToday(changeValue);
          },
        ),
      ]),
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
