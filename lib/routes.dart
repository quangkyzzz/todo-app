import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_list.dart';
import 'presentation/auth/signup_page.dart';
import 'presentation/home/home_page.dart';
import 'presentation/auth/login_page.dart';
import 'presentation/task/flagged_email/flagged_email_page.dart';
import 'models/task.dart';
import 'presentation/task/important/important_page.dart';
import 'presentation/task/my_day/my_day_page.dart';
import 'presentation/task/planned/planned_page.dart';
import 'presentation/search/search_page.dart';
import 'presentation/task/task_list/reorder_page.dart';
import 'presentation/task/task_page/note_edit_page.dart';
import 'presentation/task/task_list/task_list_page.dart';
import 'presentation/task/task_page/task_page.dart';
import 'presentation/settings/settings_page.dart';
import 'presentation/user_profile/user_profile_page.dart';
import 'view_models/auth_view_model.dart';
import 'view_models/group_view_model.dart';
import 'view_models/task_list_view_model.dart';
import 'view_models/task_view_model.dart';

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
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      builder: (context, child) {
        bool isLogin = context.watch<AuthViewModel>().isLogin;
        return (isLogin)
            ? MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => GroupViewModel(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => TaskViewModel(),
                  )
                ],
                builder: (context, child) {
                  return const HomePage();
                },
              )
            : const LoginPage();
      },
    );
  },
  taskListRoute: (context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map;
    bool havecompletedList = arg['haveCompletedList'] ?? true;
    TaskList taskList = arg['taskList'];
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskListViewModel(currentTaskList: taskList),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskViewModel(),
        ),
      ],
      builder: (context, child) {
        return TaskListPage(
          haveCompletedList: havecompletedList,
        );
      },
    );
  },
  loginRoute: (context) => const LoginPage(),
  signupRoute: (context) => const SignUpPage(),
  userProfileRoute: (context) => const UserProfilePage(),
  importantRoute: (context) => const ImportantPage(),
  searchRoute: (context) => const SearchPage(),
  flaggedRoute: (context) => const FlaggedEmailPage(),
  plannedRoute: (context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GroupViewModel()),
        ChangeNotifierProvider(create: (context) => TaskViewModel()),
        ChangeNotifierProvider(create: (context) => TaskListViewModel()),
      ],
      builder: (context, child) {
        return const PlannedPage();
      },
    );
  },
  myDayRoute: (context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskListViewModel()),
          ChangeNotifierProvider(create: (context) => TaskViewModel()),
          ChangeNotifierProvider(create: (context) => GroupViewModel()),
        ],
        builder: (context, child) {
          return const MyDayPage();
        });
  },
  settingsRoute: (context) => const SettingsPage(),
  reorderRoute: (context) => ReorderPage(
        taskList: ModalRoute.of(context)?.settings.arguments as TaskList,
      ),
  taskRoute: (context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map;
    Task task = arg['task'];
    TaskList taskList = arg['taskList'];
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskViewModel()),
          ChangeNotifierProvider(create: (context) => TaskListViewModel()),
        ],
        builder: (context, child) {
          return TaskPage(
            task: task,
            taskList: taskList,
          );
        });
  },
  noteEditRoute: (context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map;
    Task task = arg['task'];
    TaskList taskList = arg['taskList'];
    return NoteEditPage(
      task: task,
      taskList: taskList,
    );
  },
};
