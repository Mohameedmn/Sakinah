import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/widgets/build_card.dart';
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
              const Text("Sakinah - Your Quran companion", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),

              // Next Prayer
              BuildCard(
                title: 'Next Prayer',
                subtitle: 'Asr',
                time: '15:45',
                icon: Icons.settings,
              ),
              const SizedBox(height: 16),

              // Currently Reading
              ReadingCard(
                surah: 'Surah Al-Fatiha',
                verse: 'Verse 1-7',
              ),
              const SizedBox(height: 24),

              // Quick Access
              const Text("Quick Access", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  QuickAccessTile(icon :Icons.menu_book,title:  'Read Quran',subtitle:  'Continue reading',route:  AppRoute.choosemode),
                  QuickAccessTile(icon :Icons.auto_awesome,title:  'Duaa',subtitle:  'Daily prayers',route:  AppRoute.duaa),
                  QuickAccessTile(icon :Icons.access_time,title:  'Prayer Times',subtitle:  "Today's schedule",route:  AppRoute.prayerTimes),
                  QuickAccessTile(icon :Icons.explore,title:  'Qibla', subtitle: 'Find direction',route:  AppRoute.qibla),
                ],
              ),
              const SizedBox(height: 24),

              // Verse of the Day
              VerseCard(verse: '"And whoever relies upon Allah – then He is sufficient for him. Indeed, Allah will accomplish His purpose."', source: "Surah At-Talaq 65:3",),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),

    );
  }

} 
