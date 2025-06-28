import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/views/auth_views/login_view.dart';
import 'package:sakinah/app/views/home_view.dart';


class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Icon(Icons.menu_book, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 24),
              const Text(
                "Read & Listen to the\nQuran Easily",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Your daily spiritual companion with Quran, Duaa, Prayer Times & Qibla.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip
                      .antiAlias, // important to apply borderRadius clipping
                  child: Image.asset(
                    'assets/images/mosque_sunset.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Get.to(HomeView()),
                child: const Text(
                  "Get Started →",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(color: Colors.green),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Get.to(LoginView()),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
