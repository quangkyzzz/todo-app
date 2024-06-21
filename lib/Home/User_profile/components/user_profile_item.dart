import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';

class UserProfileItem extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;
  UserProfileItem({
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
              style: AppConfigs.itemTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
