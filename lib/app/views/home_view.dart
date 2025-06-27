import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import '../controllers/home_controller.dart';
import '../widgets/prayer_time_widget.dart';
import '../widgets/quran_card.dart';
import '../widgets/feature_button.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Info Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Obx(
                  () => PrayerTimeWidget(
                    nextprayertime: controller.nextPrayerTime.value,
                    hijriDate: controller.hijriDate.value,
                    prayerName: 'maghrib',
                    time: '04:45 AM',
                    icon: Icons.wb_twilight,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),

            // Feature Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FeatureButton(
                    icon: Icons.menu_book,
                    label: 'Quran',
                    onTap: controller.goToQuran,
                  ),
                  FeatureButton(
                    icon: Icons.headphones,
                    label: 'Listen',
                    onTap: controller.goToQuran,
                  ),
                  FeatureButton(
                    icon: Icons.calendar_today,
                    label: 'Prayer time',
                    onTap: controller.goToPrayerTime,
                  ),
                  FeatureButton(
                    icon: Icons.auto_awesome,
                    label: 'Dua',
                    onTap: controller.goToDuaa,
                  ),
                ],
              ),
            ),

            // Main Banner or Dua Section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  QuranCard(
                    title: 'This Dua Will Change Your Life',
                    imagePath: 'assets/images/quran_icon.png',
                    onTap: controller.goToDuaa,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}
