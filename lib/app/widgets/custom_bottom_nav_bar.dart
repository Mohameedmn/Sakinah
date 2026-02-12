import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../theme/theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final HomeController controller;

  const CustomBottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 92,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary, // left
              AppColors.secondary, // center
              AppColors.primary, // right
            ],
            stops: [0.0, 0.5, 1.0], // spread across entire width
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),

        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Let gradient show through
          elevation: 0,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTabIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 24),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined),
              label: 'Lectures',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.golf_course_outlined),
              label: 'Goal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
