import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => UserProfileView(),
      );
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
