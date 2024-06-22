import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_configs.dart';
import 'package:todo_app/home/user_profile/components/settings_list.dart';

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
        style: AppConfigs.titleTextStyle,
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
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    radius: 35,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quang Nguyễn',
                        style: AppConfigs.itemTextStyle,
                      ),
                      const Text(
                        'quang.ndt@outlook.com',
                        style: AppConfigs.secondaryTitleGreyTextStyle,
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 120),
                          child: const Text(
                            'MANAGE ACCOUNT',
                            style: AppConfigs.itemTextStyle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 20, right: 200),
                          child: const Text(
                            'SIGN OUT',
                            style: TextStyle(
                                fontSize: 20, color: AppConfigs.redColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              AppConfigs.dividerWhiteStyle,
              const SizedBox(height: 10),
              const Text(
                'General',
                style: AppConfigs.itemGreyTextStyle,
              ),
              const SizedBox(height: 10),
              const SettingsList()
            ],
          ),
        ),
      ),
    );
  }
}
