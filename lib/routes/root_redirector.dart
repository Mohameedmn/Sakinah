import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sakinah/routes/app_route.dart';

class RootRedirector extends StatelessWidget {
  const RootRedirector({super.key});

  @override
  Widget build(BuildContext context) {
    // Use microtask to allow navigation after build
    Future.microtask(() {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.offAllNamed(AppRoute.login); 
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
