import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
                  backgroundImage: AssetImage(AppConfigs.avatarImage),
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
                      color: MyTheme.greyColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Quang Nguyen',
              style: MyTheme.titleTextStyle,
            ),
            const Text(
              'quang.ndt@outlook.com',
              style: MyTheme.secondaryTitleGreyTextStyle,
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

class UserProfileItem extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;
  const UserProfileItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: MyTheme.itemTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
