import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sakinah/app/bindings/initial_binding.dart';
import 'package:sakinah/app/services/notification_services.dart';
import 'package:sakinah/routes/app_route.dart';
import 'package:sakinah/routes/app_pages.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iOSInit = DarwinInitializationSettings();

  const InitializationSettings initSettings = InitializationSettings(
    android: androidInit,
    iOS: iOSInit,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
  tz.initializeTimeZones(); // Required for scheduling
}


  tz.initializeTimeZones();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sakinah - Quran App',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(), // binds controllers/services
      initialRoute: AppRoute.home, // or login if using auth
      getPages: AppPages.pages, // route management
      theme: ThemeData.light(), // or your custom theme
    );
  }
}
