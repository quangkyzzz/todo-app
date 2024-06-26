import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/settings/settings_list.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isAddNewTask = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Settings',
        style: MyTheme.titleTextStyle,
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              //account settings
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(AppConfigs.avatarImage),
                    radius: 35,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quang Nguyễn',
                        style: MyTheme.itemTextStyle,
                      ),
                      const Text(
                        'quang.ndt@outlook.com',
                        style: MyTheme.secondaryTitleGreyTextStyle,
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: const Text(
                            'MANAGE ACCOUNT',
                            style: MyTheme.itemTextStyle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: const Text(
                            'SIGN OUT',
                            style: TextStyle(
                                fontSize: 20, color: MyTheme.redColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              MyTheme.dividerWhiteStyle,
              const SizedBox(height: 10),
              const Text(
                'General',
                style: MyTheme.itemGreyTextStyle,
              ),
              const SettingsList()
            ],
          ),
        ),
      ),
    );
  }
}
