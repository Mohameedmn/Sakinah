import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sakinah/app/bindings/initial_binding.dart';
import 'package:sakinah/routes/app_route.dart';
import 'package:sakinah/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
