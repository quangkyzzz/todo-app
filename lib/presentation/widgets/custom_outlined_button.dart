import '../../themes.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final bool isHighLighted;
  final Function() onTap;
  final String? highLightText;
  const CustomOutlinedButton({
    super.key,
    required this.isHighLighted,
    required this.onTap,
    required this.text,
    this.highLightText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(width: 1, color: MyTheme.whiteColor),
        backgroundColor: (isHighLighted) ? MyTheme.lightGreyColor : null,
      ),
      child: Row(
        children: [
          (icon != null) ? Icon(icon) : const SizedBox(),
          (isHighLighted)
              ? Text(
                  highLightText ?? text,
                  style: MyTheme.itemSmallTextStyle,
                )
              : Text(
                  text,
                  style: MyTheme.itemSmallTextStyle,
                ),
        ],
      ),
    );
  }
}
