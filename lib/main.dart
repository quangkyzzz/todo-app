import 'package:flutter/material.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/Flagged_email/flagged_email_view.dart';
import 'package:todo_app/Planned/planned_view.dart';
import 'package:todo_app/Task/task_list_view.dart';
import 'package:todo_app/Theme/theme.dart';
import 'package:todo_app/Home/home_view.dart';
import 'package:todo_app/search/search_view.dart';
import 'package:todo_app/user_profile/user_profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeView(),
      routes: {
        userProfileRoute: (context) => const UserProfileView(),
        taskListRoute: (context) => const TaskListView(),
        searchRoute: (context) => const SearchView(),
        taskListImportantRoute: (context) =>
            const TaskListView(haveCompletedList: false),
        flaggedRoute: (context) => const FlaggedEmailView(),
        plannedRoute: (context) => const PlannedView(),
      },
    );
  }
}
