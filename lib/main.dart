import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakinah/app/bindings/initial_binding.dart';
import 'package:sakinah/routes/app_pages.dart'; // Make sure this file exists and contains GetPage list
import 'package:sakinah/routes/root_redirector.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await initializeNotifications(); 
  tz.initializeTimeZones(); 

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.sakinah.audio',
    androidNotificationChannelName: 'Quran Playback',
    androidNotificationOngoing: true,
  );

  runApp(const MyApp());
}

Future<void> initializeNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iOSInit = DarwinInitializationSettings();

  const InitializationSettings initSettings = InitializationSettings(
    android: androidInit,
    iOS: iOSInit,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sakinah - Quran App',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      home: const RootRedirector(),
      getPages: AppPages.pages, 
      theme: ThemeData.light(),
    );
  }
}
