import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/settings.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'package:todo_app/themes.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  late SettingsProvider settingsProvider;
  late Settings settings;
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
      },
    },
    {
      'text': 'Move starred tasks on top',
      'isActive': isMoveStarTaskToTop,
      'onChange': (bool changeValue) {
        setState(() {
          isMoveStarTaskToTop = changeValue;
        });
      },
    },
    {
      'text': "Play completion sound",
      'isActive': isPlaySoundOnComplete,
      'onChange': (bool changeValue) {
        setState(() {
          isPlaySoundOnComplete = changeValue;
        });
      },
    },
    {
      'text': 'Confirm before deleting',
      'isActive': isConfirmBeforeDelete,
      'onChange': (bool changeValue) {
        setState(() {
          isConfirmBeforeDelete = changeValue;
        });
      },
    },
    {
      'text': "Show 'Due Today' tasks in My Day",
      'isActive': isShowDueToday,
      'onChange': (bool changeValue) {
        setState(() {
          isShowDueToday = changeValue;
        });
      },
    },
  ];

  @override
  void initState() {
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    settings = settingsProvider.settings;
    isAddNewTaskOnTop = settings.isAddNewTaskOnTop;
    isMoveStarTaskToTop = settings.isMoveStarTaskToTop;
    isPlaySoundOnComplete = settings.isPlaySoundOnComplete;
    isConfirmBeforeDelete = settings.isConfirmBeforeDelete;
    isShowDueToday = settings.isShowDueToday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        settingsProvider.updateSettingWith(
          isAddNewTaskOnTop: isAddNewTaskOnTop,
          isMoveStarTaskToTop: isMoveStarTaskToTop,
          isPlaySoundOnComplete: isPlaySoundOnComplete,
          isConfirmBeforeDelete: isConfirmBeforeDelete,
          isShowDueToday: isShowDueToday,
        );
        return true;
      },
      child: Padding(
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
