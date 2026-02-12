import 'package:flutter/material.dart';

class ReadingCard extends StatelessWidget {
  final String surah;
  final String verse;
  final VoidCallback onPlay;

  const ReadingCard({
    super.key,
    required this.surah,
    required this.verse,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFBFD8AF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Currently Reading', style: TextStyle(color: Colors.white70)),
          Text(surah, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(verse, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 0.5, color: Colors.white, backgroundColor: Colors.white30),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onPlay,
              child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}
