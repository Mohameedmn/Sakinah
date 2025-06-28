import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  const BuildCard({super.key, required this.title, required this.subtitle, required this.time, required this.icon});
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              Text(subtitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Icon(icon, color: Colors.green),
        ],
      ),
    );
  }
}