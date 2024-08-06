import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/auth/signup_page.dart';
import 'package:todo_app/presentation/home/home_page.dart';
import 'package:todo_app/presentation/auth/login_page.dart';
import 'package:todo_app/presentation/task/flagged_email/flagged_email_page.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/task/important/important_page.dart';
import 'package:todo_app/presentation/task/my_day/my_day_page.dart';
import 'package:todo_app/presentation/task/planned/planned_page.dart';
import 'package:todo_app/presentation/search/search_page.dart';
import 'package:todo_app/presentation/task/task_list/reorder_page.dart';
import 'package:todo_app/presentation/task/task_page/note_edit_page.dart';
import 'package:todo_app/presentation/task/task_list/task_list_page.dart';
import 'package:todo_app/presentation/task/task_page/task_page.dart';
import 'package:todo_app/presentation/settings/settings_page.dart';
import 'package:todo_app/presentation/user_profile/user_profile_page.dart';
import 'package:todo_app/provider/user_provider.dart';

const initialRoute = '/home';
const loginRoute = '/login';
const signupRoute = '/signup';
const userProfileRoute = '/home/user_profile';
const taskListRoute = '/home/task_list';
const searchRoute = '/home/search';
const flaggedRoute = '/home/flagged';
const plannedRoute = '/home/planned';
const myDayRoute = '/home/my_day';
const importantRoute = '/home/important';
const settingsRoute = '/home/user_profile/settings';
const reorderRoute = '/home/task_list/reorder';
const taskRoute = '/task_list/task';
const noteEditRoute = '/task/note_edit';

var allRoute = {
  initialRoute: (context) {
    bool isLogin =
        Provider.of<UserProvider>(context, listen: true).getIsLoginStatus();
    if (isLogin) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  },
  loginRoute: (context) => const LoginPage(),
  signupRoute: (context) => const SignUpPage(),
  userProfileRoute: (context) => const UserProfilePage(),
  taskListRoute: (context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map;
    bool havecompletedList = arg['haveCompletedList'] ?? true;
    TaskListModel taskList = arg['taskList'];
    return TaskListPage(
      haveCompletedList: havecompletedList,
      taskList: taskList,
    );
  },
  importantRoute: (context) => const ImportantPage(),
  searchRoute: (context) => const SearchPage(),
  flaggedRoute: (context) => const FlaggedEmailPage(),
  plannedRoute: (context) => const PlannedPage(),
  myDayRoute: (context) => const MyDayPage(),
  settingsRoute: (context) => const SettingsPage(),
  reorderRoute: (context) => ReorderPage(
        taskList: ModalRoute.of(context)?.settings.arguments as TaskListModel,
      ),
  taskRoute: (context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map;
    TaskModel task = arg['task'];
    TaskListModel taskList = arg['taskList'];
    return TaskPage(
      task: task,
      taskList: taskList,
    );
  },
  noteEditRoute: (context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map;
    TaskModel task = arg['task'];
    TaskListModel taskList = arg['taskList'];
    return NoteEditPage(
      task: task,
      taskList: taskList,
    );
  },
};
