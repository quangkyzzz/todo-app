import 'package:flutter/material.dart';
import 'package:todo_app/Task/Flagged_email/flagged_email_view.dart';
import 'package:todo_app/Models/task_model.dart';
import 'package:todo_app/Task/My_day/my_day_view.dart';
import 'package:todo_app/Task/Planned/planned_view.dart';
import 'package:todo_app/Home/Search/search_view.dart';
import 'package:todo_app/Task/Task_list/components/re_order_view.dart';
import 'package:todo_app/Task/note_edit_view.dart';
import 'package:todo_app/Task/Task_list/task_list_view.dart';
import 'package:todo_app/Task/task_view.dart';
import 'package:todo_app/Home/User_profile/settings_view.dart';
import 'package:todo_app/Home/User_profile/user_profile_view.dart';

const userProfileRoute = '/user-profile/';
const taskListRoute = '/task-list/';
const searchRoute = '/search/';
const flaggedRoute = '/flagged/';
const plannedRoute = '/planned/';
const myDayRoute = '/my-day/';
const settingsRoute = '/user-profile/settings/';
const reOrderRoute = '/task-list/re-order/';
const taskRoute = '/task/';
const noteEditRoute = '/task/note-edit/';
var allRoute = {
  userProfileRoute: (context) => const UserProfileView(),
  taskListRoute: (context) => TaskListView(
        haveCompletedList:
            ((ModalRoute.of(context)?.settings.arguments) ?? true) as bool,
      ),
  searchRoute: (context) => const SearchView(),
  flaggedRoute: (context) => const FlaggedEmailView(),
  plannedRoute: (context) => const PlannedView(),
  myDayRoute: (context) => const MyDayView(),
  settingsRoute: (context) => const SettingsView(),
  reOrderRoute: (context) => const ReOrderView(),
  taskRoute: (context) => TaskView(
        task: ModalRoute.of(context)!.settings.arguments as TaskModel,
      ),
  noteEditRoute: (context) => const NoteEditView(),
};
