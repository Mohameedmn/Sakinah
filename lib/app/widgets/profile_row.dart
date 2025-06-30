import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final String name;
  final String value;
  final IconData icon;

  const ProfileRow({
    super.key,
    required this.name,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 12),
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
