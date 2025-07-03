import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/controllers/prayer_time_controller.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/widgets/quick_acces_tile.dart';
import 'package:sakinah/app/widgets/reading_card.dart';
import 'package:sakinah/app/widgets/verse_card.dart';
import 'package:sakinah/routes/app_route.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final HomeController controller = Get.find<HomeController>();
  final PrayersController prayersController = Get.find<PrayersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2E9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sakinah - Your Quran companion",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              Obx(() {
                final name = prayersController.nextPrayerName.value;
                final time =
                    prayersController.getPrayerTimesMap()[name] ?? '--:--';
                final bgImage = getBackgroundImageForPrayer(name);

                return Container(
                  width: double.infinity,
                  height: 140, // slightly reduced height
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ), // removed horizontal margin
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(bgImage, fit: BoxFit.cover),
                        Container(color: Colors.black.withOpacity(0.25)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ), // 👈 smaller padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Next Prayer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                time,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              FutureBuilder(
                future: Get.find<AudioController>().getLastRead(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const ReadingCard(
                      surah: "You haven't played any surah",
                      verse: "Start listening to resume later",
                      showPlay: false,
                    );
                  }

                  final lastRead = snapshot.data!;
                  return GestureDetector(
                    onTap: () => controller.resumeLastRead(),
                    child: ReadingCard(
                      surah: lastRead['surah'] ?? '',
                      verse:
                          'Verse: ${lastRead['verse_key']?.split(":").last ?? ''}',
                      showPlay: true,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Quick Access
              const Text(
                "Quick Access",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  QuickAccessTile(
                    icon: Icons.menu_book,
                    title: 'Read Quran',
                    subtitle: 'Continue reading',
                    route: AppRoute.choosemode,
                  ),
                  QuickAccessTile(
                    icon: Icons.auto_awesome,
                    title: 'Duaa',
                    subtitle: 'Daily prayers',
                    route: AppRoute.duaa,
                  ),
                  QuickAccessTile(
                    icon: Icons.access_time,
                    title: 'Prayer Times',
                    subtitle: "Today's schedule",
                    route: AppRoute.prayerTimes,
                  ),
                  QuickAccessTile(
                    icon: Icons.explore,
                    title: 'Qibla',
                    subtitle: 'Find direction',
                    route: AppRoute.qibla,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Verse of the Day
              VerseCard(
                verse:
                    '"And whoever relies upon Allah – then He is sufficient for him. Indeed, Allah will accomplish His purpose."',
                source: "Surah At-Talaq 65:3",
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}

String getBackgroundImageForPrayer(String prayer) {
  switch (prayer.toLowerCase()) {
    case 'fajr':
      return 'assets/images/fajr_image.jpg';
    case 'dhuhr':
      return 'assets/images/duhr_image.jpg';
    case 'asr':
      return 'assets/images/asr_image.jpg';
    case 'maghrib':
      return 'assets/images/maghrib_image.jpg';
    case 'isha':
      return 'assets/images/ishaa_image.jpg';
    default:
      return 'assets/images/fajr_image.jpg';
  }
}
