import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/services/location_services.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/widgets/prayer_row.dart';

class PrayerTimeView extends StatelessWidget {
  PrayerTimeView({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "Prayer Times",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          FutureBuilder<String>(
            future: getProvinceAndCountry(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Getting location...");
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text(
                  snapshot.data ?? "Location not found",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                );
              }
            },
          ),
          const SizedBox(height: 4),
          Text(
            "Current Time: ${now.format(context)}",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // 🧾 Card content
          Card(
            color: const Color(0xFFBFD8AF),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Next Prayer: Asr",
                      style: TextStyle(
                        
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Countdown: 00:15:37",
                      style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0) , fontWeight: FontWeight.w500) ,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📆 Prayer times
                  PrayerRow(name: "Fajr", time: "05:15 AM"),
                  const Divider(),
                  PrayerRow(name: "Dhuhr", time: "12:30 PM"),
                  const Divider(),
                  PrayerRow(name: "Asr", time: "04:00 PM"),
                  const Divider(),
                  PrayerRow(name: "Maghrib", time: "06:45 PM"),
                  const Divider(),
                  PrayerRow(name: "Isha", time: "08:15 PM"),
                  const Divider(),

                  // 🔔 Notifications switch
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch(
                        value: true,
                        activeColor: Colors.green[400],
                        inactiveTrackColor: Colors.grey[300],
                        onChanged: (value) {
                          // handle toggle
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}
