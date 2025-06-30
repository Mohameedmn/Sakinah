import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';
import 'package:sakinah/app/widgets/option_card.dart';

class ChooseModeView extends StatelessWidget {
  ChooseModeView({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F9),
      appBar: AppBar(
        title: const Text('Choose Mode'),
        centerTitle: true,
        backgroundColor: Color(0xFFDDF2D1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Quran Companion',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'What would you like to do?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              OptionCard(
                icon: Icons.menu_book_rounded,
                title: 'Read Quran',
                subtitle: 'Explore Surahs with translation',
                onTap: () => Get.toNamed('/read-quran'),
              ),
              const SizedBox(height: 20),
              OptionCard(
                icon: Icons.headphones_rounded,
                title: 'Listen to Surahs',
                subtitle: 'Stream beautiful recitations',
                onTap: () => Get.toNamed('/listen-quran'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(controller: controller),
    );
  }
}
