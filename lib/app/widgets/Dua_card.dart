import 'package:flutter/material.dart';


class DuaCard extends StatelessWidget {
  const DuaCard({
    super.key,
    required this.duaNumber,
    required this.title,
    required this.duaText,
    required this.translation,
  });

  final int duaNumber;
  final String title;
  final String duaText;
  final String translation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(31, 151, 151, 151), width: 1),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Text(
                "$duaNumber. ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Arabic dua text
          Text(
            duaText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Scheherazade',
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),

          // Translation
          Text(
            translation,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
    
  }
}
