import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Home/User_profile/user_profile_component/settings_list.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isAddNewTask = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Settings',
        style: TextStyle(fontSize: 30),
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
                        style: TextStyle(fontSize: 20),
                      ),
                      const Text(
                        'quang.ndt@outlook.com',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppConfigs.greyColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 120),
                          child: const Text(
                            'MANAGE ACCOUNT',
                            style: TextStyle(fontSize: 18),
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
                                fontSize: 18, color: AppConfigs.redColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(thickness: 0.5, color: AppConfigs.greyColor),
              const SizedBox(height: 10),
              const Text(
                'General',
                style: TextStyle(
                  fontSize: 18,
                  color: AppConfigs.greyColor,
                  fontWeight: FontWeight.bold,
                ),
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
