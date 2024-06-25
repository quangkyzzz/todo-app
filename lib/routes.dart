import 'package:flutter/material.dart';
import 'package:todo_app/task/flagged_email/flagged_email_page.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/task/my_day/my_day_page.dart';
import 'package:todo_app/task/planned/planned_page.dart';
import 'package:todo_app/home/search/search_page.dart';
import 'package:todo_app/task/task_list/components/reorder_page.dart';
import 'package:todo_app/task/task_page/note_edit_page.dart';
import 'package:todo_app/task/task_list/task_list_page.dart';
import 'package:todo_app/task/task_page/task_page.dart';
import 'package:todo_app/home/user_profile/settings_page.dart';
import 'package:todo_app/home/user_profile/user_profile_page.dart';

const userProfileRoute = '/user_profile';
const taskListRoute = '/task_list';
const searchRoute = '/search';
const flaggedRoute = '/flagged';
const plannedRoute = '/planned';
const myDayRoute = '/my_day';
const settingsRoute = '/user_profile/settings';
const reorderRoute = '/task_list/reorder';
const taskRoute = '/task';
const noteEditRoute = '/task/note_edit';
var allRoute = {
  userProfileRoute: (context) => const UserProfilePage(),
  taskListRoute: (context) => TaskListPage(
        haveCompletedList:
            ((ModalRoute.of(context)?.settings.arguments) ?? true) as bool,
      ),
  searchRoute: (context) => const SearchPage(),
  flaggedRoute: (context) => const FlaggedEmailPage(),
  plannedRoute: (context) => const PlannedPage(),
  myDayRoute: (context) => const MyDayPage(),
  settingsRoute: (context) => const SettingsPage(),
  reorderRoute: (context) => const ReorderPage(),
  taskRoute: (context) => TaskPage(
        task: ModalRoute.of(context)!.settings.arguments as TaskModel,
      ),
  noteEditRoute: (context) => const NoteEditPage(),
};
