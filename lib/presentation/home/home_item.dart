import 'package:flutter/material.dart';
import '../../themes.dart';

class HomeItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final int endNumber;
  final Function() onTap;
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
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: MyTheme.itemTextStyle,
            ),
            const Spacer(
              flex: 1,
            ),
            ((endNumber != 0)
                ? Text(
                    endNumber.toString(),
                    style: const TextStyle(color: MyTheme.greyColor),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
