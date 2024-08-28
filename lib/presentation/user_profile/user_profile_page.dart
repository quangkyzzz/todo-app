import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_configs.dart';
import '../../provider/user_provider.dart';
import '../../themes.dart';
import '../../routes.dart';

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
        padding: const EdgeInsets.only(left: 8, top: 42, right: 8),
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(AppConfigs.avatarImage),
                    radius: 32,
                  ),
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    height: 48,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: MyTheme.greyColor,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                userProvider.currentUser.userName,
                style: MyTheme.titleTextStyle,
              ),
              Text(
                userProvider.currentUser.userEmail,
                style: MyTheme.secondaryTitleGreyTextStyle,
              ),
              MyTheme.dividerGreyStyle,
              UserProfileItem(
                text: 'Manage account',
                icon: Icons.person_outline,
                onTap: () {},
              ),
              MyTheme.dividerGreyStyle,
              UserProfileItem(
                text: 'Settings',
                icon: Icons.settings_outlined,
                onTap: () async {
                  await Navigator.of(context).pushNamed(settingsRoute);
                },
              )
            ],
          );
        }),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(width: 8),
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
