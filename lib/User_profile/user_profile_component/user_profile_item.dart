import 'package:flutter/material.dart';

class UserProfileItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const UserProfileItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
