import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/view_models/user_view_model.dart';
import 'package:todo_app/presentation/settings/settings_list.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

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
              const SizedBox(height: 18),
              //account settings
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(AppConfigs.avatarImage),
                    radius: 36,
                  ),
                  const SizedBox(width: 18),
                  Consumer<UserViewModel>(
                      builder: (context, authViewModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authViewModel.currentUser.userName,
                          style: MyTheme.itemTextStyle,
                        ),
                        Text(
                          authViewModel.currentUser.userEmail,
                          style: MyTheme.secondaryTitleGreyTextStyle,
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(top: 18, bottom: 18),
                            child: Row(
                              children: [
                                Text(
                                  'MANAGE ACCOUNT',
                                  style: MyTheme.itemTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Provider.of<AuthProvider>(context, listen: false)
                                .logout();
                            await Navigator.pushNamedAndRemoveUntil(
                                context, initialRoute, (route) => false);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 8, bottom: 18),
                            child: const Text(
                              'SIGN OUT',
                              style: TextStyle(
                                fontSize: 18,
                                color: MyTheme.redColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
              MyTheme.dividerWhiteStyle,
              const SizedBox(height: 8),
              //General settings
              const SettingsList()
            ],
          ),
        ),
      ),
    );
  }
}
