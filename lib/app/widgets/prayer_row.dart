import 'package:flutter/material.dart';

class PrayerRow extends StatelessWidget {
  final String name;
  final String time;

  const PrayerRow({
    super.key,
    required this.name,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          time,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
