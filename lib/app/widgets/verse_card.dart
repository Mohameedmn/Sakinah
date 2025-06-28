import 'package:flutter/material.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({super.key , required this.source, required this.verse});

  final String source;
  final String verse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Verse of the Day', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          // ignore: unnecessary_string_interpolations
          Text("$verse", style: const TextStyle(fontStyle: FontStyle.italic)),
          const SizedBox(height: 4),
          // ignore: unnecessary_string_interpolations
          Text('$source', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}