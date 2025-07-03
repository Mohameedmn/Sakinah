import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/verify_email_controller.dart';

class VerifyEmailView extends StatelessWidget {
  final VerifyEmailController controller = Get.put(VerifyEmailController());

  VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email_outlined, size: 64, color: Colors.blueAccent),
              const SizedBox(height: 24),
              const Text(
                "Check Your Email",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "We've sent a verification link to your email address. "
                "Please check your inbox and click the link to verify your account.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 32),
              const Text(
                "Waiting for verification...",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: controller.resendVerificationEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Resend Verification Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Optional: implement contact support
                },
                child: const Text(
                  "Didn't receive the email? Check your spam folder or contact support",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
