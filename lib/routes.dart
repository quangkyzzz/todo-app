import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/presentation/auth/signup_page.dart';
import 'package:todo_app/presentation/home/home_page.dart';
import 'package:todo_app/presentation/auth/login_page.dart';
import 'package:todo_app/models/task.dart';
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
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/view_models/user_view_model.dart';
import 'package:todo_app/view_models/group_view_model.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/view_models/task_view_model.dart';

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
    return Builder(
      builder: (context) {
        bool isLogin = context.watch<AuthProvider>().isLogin;
        return (isLogin)
            ? MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => UserViewModel(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => GroupViewModel(),
                  ),
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
    TaskList taskList =
        (ModalRoute.of(context)?.settings.arguments as TaskList).copyWith();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskListViewModel(currentTaskList: taskList),
        ),
      ],
      builder: (context, child) {
        return const TaskListPage();
      },
    );
  },
  loginRoute: (context) => const LoginPage(),
  signupRoute: (context) => const SignUpPage(),
  userProfileRoute: (context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
      ],
      builder: (context, child) => const UserProfilePage(),
    );
  },
  myDayRoute: (context) {
    TaskList taskList =
        (ModalRoute.of(context)?.settings.arguments as TaskList).copyWith();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TaskListViewModel(currentTaskList: taskList),
          ),
        ],
        builder: (context, child) {
          return const MyDayPage();
        });
  },
  importantRoute: (context) {
    TaskList taskList =
        (ModalRoute.of(context)?.settings.arguments as TaskList).copyWith();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskListViewModel(currentTaskList: taskList),
        ),
      ],
      builder: (context, child) {
        return const ImportantPage();
      },
    );
  },
  plannedRoute: (context) {
    TaskList taskList =
        (ModalRoute.of(context)?.settings.arguments as TaskList).copyWith();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskListViewModel(currentTaskList: taskList),
        ),
      ],
      builder: (context, child) {
        return const PlannedPage();
      },
    );
  },
  searchRoute: (context) {
    TaskList taskList =
        (ModalRoute.of(context)?.settings.arguments as TaskList).copyWith();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskListViewModel(currentTaskList: taskList),
        ),
      ],
      builder: (context, child) {
        return const SearchPage();
      },
    );
  },
  settingsRoute: (context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
      ],
      builder: (context, child) => const SettingsPage(),
    );
  },
  reorderRoute: (context) {
    TaskList taskList =
        (ModalRoute.of(context)?.settings.arguments as TaskList).copyWith();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskListViewModel(currentTaskList: taskList),
        ),
      ],
      builder: (context, child) => const ReorderPage(),
    );
  },
  taskRoute: (context) {
    Map<String, dynamic> arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Task task = arg['task'].copyWith();
    String taskListName = arg['taskListName'];

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TaskViewModel(currentTask: task),
          ),
        ],
        builder: (context, child) {
          return TaskPage(
            currentTaskListName: taskListName,
          );
        });
  },
  noteEditRoute: (context) {
    Task task = (ModalRoute.of(context)?.settings.arguments as Task).copyWith();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskViewModel(currentTask: task),
        )
      ],
      builder: (context, child) => const NoteEditPage(),
    );
  },
};
