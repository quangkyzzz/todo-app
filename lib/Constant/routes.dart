import 'package:todo_app/Flagged_email/flagged_email_view.dart';
import 'package:todo_app/My_day/my_day_view.dart';
import 'package:todo_app/Planned/planned_view.dart';
import 'package:todo_app/Search/search_view.dart';
import 'package:todo_app/Task/task_list_view.dart';
import 'package:todo_app/User_profile/user_profile_view.dart';

const userProfileRoute = '/user-profile/';
const taskListRoute = '/task-list/';
const taskListImportantRoute = '/task-list-important/';
const searchRoute = '/search/';
const flaggedRoute = '/flagged/';
const plannedRoute = '/planned/';
const myDayRoute = '/my-day/';
var allRoute = {
  userProfileRoute: (context) => const UserProfileView(),
  taskListRoute: (context) => const TaskListView(),
  searchRoute: (context) => const SearchView(),
  taskListImportantRoute: (context) =>
      const TaskListView(haveCompletedList: false),
  flaggedRoute: (context) => const FlaggedEmailView(),
  plannedRoute: (context) => const PlannedView(),
  myDayRoute: (context) => const MyDayView(),
};
