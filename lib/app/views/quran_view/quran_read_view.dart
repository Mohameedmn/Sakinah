import 'package:flutter/material.dart';

class ReadQuranPage extends StatefulWidget {
  const ReadQuranPage({super.key});

  @override
  State<ReadQuranPage> createState() => _ReadQuranPageState();
}

class _ReadQuranPageState extends State<ReadQuranPage> {
  bool showTranslation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Quran Companion',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Read Quran',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Bookmark
                      Row(
                        children: [
                          const Icon(Icons.menu_book, size: 18),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'Surah Al-Fatiha',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDAF5D7),
                              foregroundColor: Colors.green[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Bookmark'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Ayahs (Arabic)
                      const Text(
                        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
                        'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'ScheherazadeNew',
                          height: 2,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),

                      const SizedBox(height: 16),

                      // Translation
                      if (showTranslation)
                        const Text(
                          'In the name of Allah, the Most Gracious, the Most Merciful.\nPraise be to Allah, the Lord of all worlds.',
                          style: TextStyle(fontSize: 15),
                        ),


                      const SizedBox(height: 12),

                      // Navigation buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDDF2D1),
                              foregroundColor: Colors.green[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Previous'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDDF2D1),
                              foregroundColor: Colors.green[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
