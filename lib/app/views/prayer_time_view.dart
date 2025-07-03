import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/controllers/prayer_time_controller.dart';
import 'package:sakinah/app/theme/theme.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/widgets/prayer_row.dart';

class PrayerTimeView extends StatelessWidget {
  PrayerTimeView({super.key});
  final PrayersController controller = Get.find<PrayersController>();
  final HomeController homecontroller = Get.find<HomeController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Obx(() {
        if (controller.isLoading.value ||
            controller.timings.value == null ||
            controller.date.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final date = controller.date.value!;
        final prayerTimes = controller.getPrayerTimesMap();

        return Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Prayer Times",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              controller.location.value,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              "Today: ${date.readableDate}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // 🧾 Card
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Next Prayer: ${controller.nextPrayerName.value}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Countdown: ${controller.countdown.value}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Rows
                    ...prayerTimes.entries.map((entry) {
                      return Column(
                        children: [
                          PrayerRow(name: entry.key, time: entry.value),
                          if (entry.key != "Isha") const Divider(),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔔 Notification toggle
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Notifications", style: TextStyle(fontSize: 16)),
                    Obx(
                            () => Switch(
                              value: homecontroller.notificationsEnabled.value,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                homecontroller.toggleNotifications(value);
                                Get.snackbar(
                                  'Notifications',
                                  value ? 'Enabled' : 'Disabled',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: CustomBottomNavBar(controller: Get.find()),
    );
  }
}
