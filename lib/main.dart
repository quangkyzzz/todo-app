import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/service/background_service.dart';
import 'package:todo_app/service/notification_service.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await NotificationService.initNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.theme,
          initialRoute: initialRoute,
          routes: allRoute,
        );
      },
    );
  }
}
