import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickAccessTile extends StatelessWidget {
  const QuickAccessTile({super.key , required this.icon, required this.title, required this.subtitle, required this.route});

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: Colors.black87),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
    
  }
}