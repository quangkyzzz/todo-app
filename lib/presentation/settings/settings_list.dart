import 'package:flutter/material.dart';
import 'package:todo_app/models/settings_shared_preference.dart';
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
  late List<Map<String, dynamic>> listSettingItem = [
    {
      'text': 'Add new tasks on top',
      'isActive': isAddNewTaskOnTop,
      'onChange': (bool changeValue) {
        setState(() {
          isAddNewTaskOnTop = changeValue;
        });
        SettingsSharedPreference.setIsAddNewTaskOnTop(changeValue);
      },
    },
    {
      'text': 'Move starred tasks on top',
      'isActive': isMoveStarTaskToTop,
      'onChange': (bool changeValue) {
        setState(() {
          isMoveStarTaskToTop = changeValue;
        });
        SettingsSharedPreference.setIsMoveStarTaskToTop(changeValue);
      },
    },
    {
      'text': "Play completion sound",
      'isActive': isPlaySoundOnComplete,
      'onChange': (bool changeValue) {
        setState(() {
          isPlaySoundOnComplete = changeValue;
        });
        SettingsSharedPreference.setIsPlaySoundOnComplete(changeValue);
      },
    },
    {
      'text': 'Confirm before deleting',
      'isActive': isConfirmBeforeDelete,
      'onChange': (bool changeValue) {
        setState(() {
          isConfirmBeforeDelete = changeValue;
        });
        SettingsSharedPreference.setIsConfirmBeforeDelete(changeValue);
      },
    },
    {
      'text': "Show 'Due Today' tasks in My Day",
      'isActive': isShowDueToday,
      'onChange': (bool changeValue) {
        setState(() {
          isShowDueToday = changeValue;
        });
        SettingsSharedPreference.setIsShowDueToday(changeValue);
      },
    },
  ];

  @override
  void initState() {
    isAddNewTaskOnTop = SettingsSharedPreference.getIsAddNewTaskOnTop();
    isMoveStarTaskToTop = SettingsSharedPreference.getIsMoveStarTaskToTop();
    isPlaySoundOnComplete = SettingsSharedPreference.getIsPlaySoundOnComplete();
    isConfirmBeforeDelete = SettingsSharedPreference.getIsConfirmBeforeDelete();
    isShowDueToday = SettingsSharedPreference.getIsShowDueToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: listSettingItem.map((item) {
          return SettingsItem(
            isActive: item['isActive'],
            text: item['text'],
            onChange: (bool changeValue) {
              setState(() {
                item['isActive'] = changeValue;
              });
              item['onChange'](changeValue);
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
