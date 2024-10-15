import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/service/settings_service.dart';
import 'package:todo_app/themes.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  SharedPreferencesWithCache pref = SettingsService.pref;
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
        pref.setBool('isAddNewTaskOnTop', changeValue);
      },
    },
    {
      'text': 'Move starred tasks on top',
      'isActive': isMoveStarTaskToTop,
      'onChange': (bool changeValue) {
        setState(() {
          isMoveStarTaskToTop = changeValue;
        });
        pref.setBool('isMoveStarTaskToTop', changeValue);
      },
    },
    {
      'text': "Play completion sound",
      'isActive': isPlaySoundOnComplete,
      'onChange': (bool changeValue) {
        setState(() {
          isPlaySoundOnComplete = changeValue;
        });
        pref.setBool('isPlaySoundOnComplete', changeValue);
      },
    },
    {
      'text': 'Confirm before deleting',
      'isActive': isConfirmBeforeDelete,
      'onChange': (bool changeValue) {
        setState(() {
          isConfirmBeforeDelete = changeValue;
        });
        pref.setBool('isConfirmBeforeDelete', changeValue);
      },
    },
    {
      'text': "Show 'Due Today' tasks in My Day",
      'isActive': isShowDueToday,
      'onChange': (bool changeValue) {
        setState(() {
          isShowDueToday = changeValue;
        });
        pref.setBool('isShowDueToday', changeValue);
      },
    },
  ];

  @override
  void initState() {
    isAddNewTaskOnTop = pref.getBool('isAddNewTaskOnTop') ?? true;
    isMoveStarTaskToTop = pref.getBool('isMoveStarTaskToTop') ?? true;
    isPlaySoundOnComplete = pref.getBool('isPlaySoundOnComplete') ?? true;
    isConfirmBeforeDelete = pref.getBool('isConfirmBeforeDelete') ?? true;
    isShowDueToday = pref.getBool('isShowDueToday') ?? true;
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
