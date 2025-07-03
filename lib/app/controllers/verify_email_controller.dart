import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';

class VerifyEmailController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final AuthController authController = Get.find<AuthController>();

  RxBool isVerifying = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    // 🔁 Auto-check every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await checkEmailVerified();
      if (_auth.currentUser?.emailVerified == true) {
        timer.cancel(); // Stop the loop once verified
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cleanup when controller is disposed
    super.onClose();
  }

  Future<void> checkEmailVerified() async {
    isVerifying.value = true;
    await _auth.currentUser?.reload();
    final user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      // Save user data only once
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'user_id': user.uid,
          'email': user.email,
          'username': authController.nameController.text.trim(),
          'language': 'en',
          "notifications_enabled": true,
          'favorites': [],
          'last_read': {},
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Get.offAllNamed('/home');
    }

    isVerifying.value = false;
  }

  Future<void> resendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Get.snackbar("Email Sent", "A verification email has been resent.");
    }
  }
}
