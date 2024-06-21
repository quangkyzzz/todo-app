import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';

class HomeItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final int endNumber;
  final Function onTap;
  const HomeItem({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.endNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: AppConfigs.itemTextStyle,
            ),
            const Spacer(
              flex: 1,
            ),
            ((endNumber != 0)
                ? Text(
                    endNumber.toString(),
                    style: const TextStyle(color: AppConfigs.greyColor),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
