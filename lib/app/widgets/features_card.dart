import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:sakinah/app/theme/theme.dart';
import 'package:sakinah/app/views/Ramadhan_routine_view.dart';
import 'package:sakinah/routes/app_route.dart';

import 'single_feature_card.dart';

class FeaturesCard extends StatelessWidget {
  const FeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 165,
        padding: EdgeInsets.only(right: 20, left: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleFeatureCard(
                  icon: Icons.watch_later_outlined,
                  ontap: () => {},
                  title: "Last Read",
                ),
                SingleFeatureCard(
                  icon: FontAwesomeIcons.bookOpen,
                  ontap: () {
                    print("Navigating to Ramadan Routine");
                    Get.toNamed(AppRoute.ramadhanRoutine);
                  },

                  title: "Quran",
                ),
                SingleFeatureCard(
                  icon: FontAwesomeIcons.compass,
                  ontap: () => {},
                  title: "Qibla",
                ),
                SingleFeatureCard(
                  icon: Icons.monetization_on_rounded,
                  ontap: () => {},
                  title: "Zakat",
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleFeatureCard(
                  icon: Icons.notifications_outlined,
                  ontap: () => {},
                  title: "Reminder",
                ),
                SingleFeatureCard(
                  icon: Icons.all_inclusive,
                  ontap: () => {},
                  title: "Tasbih",
                ),
                SingleFeatureCard(
                  icon: FontAwesomeIcons.pray,
                  ontap: () => {},
                  title: "Dua",
                ),
                SingleFeatureCard(
                  icon: FontAwesomeIcons.mosque,
                  ontap: () => {},
                  title: "Umra",
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 1.5),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Explore All Features",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.grayFont,
                  ),
                ),
                SizedBox(height: 5),
                Icon(Icons.arrow_forward_ios_rounded, size: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
