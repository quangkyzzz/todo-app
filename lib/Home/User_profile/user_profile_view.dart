import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/Home/User_profile/components/user_profile_item.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  radius: 35,
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 50,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppConfigs.greyColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Quang Nguyen',
              style: AppConfigs.titleTextStyle,
            ),
            const Text(
              'quang.ndt@outlook.com',
              style: AppConfigs.secondaryTitleTextStyle,
            ),
            AppConfigs.dividerGreyStyle,
            UserProfileItem(
              text: 'Add account',
              icon: Icons.add,
              onTap: () {},
            ),
            AppConfigs.dividerGreyStyle,
            UserProfileItem(
              text: 'Manage account',
              icon: Icons.person_outline,
              onTap: () {},
            ),
            AppConfigs.dividerGreyStyle,
            UserProfileItem(
              text: 'Settings',
              icon: Icons.settings_outlined,
              onTap: () {
                Navigator.of(context).pushNamed(settingsRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
