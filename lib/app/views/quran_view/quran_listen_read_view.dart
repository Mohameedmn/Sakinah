import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/widgets/custom_bottom_nav_bar.dart';

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
              _buildOptionCard(
                icon: Icons.menu_book_rounded,
                title: 'Read Quran',
                subtitle: 'Explore Surahs with translation',
                onTap: () => Get.toNamed('/read-quran'),
              ),
              const SizedBox(height: 20),
              _buildOptionCard(
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

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF2D1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: Colors.green),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Text(title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    Text(subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        )),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}
