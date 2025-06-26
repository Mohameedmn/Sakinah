import 'package:flutter/material.dart';

class ListenQuranPage extends StatelessWidget {
  final List<String> surahList = [
    'Surah Al-Baqarah',
    'Surah An-Nisa',
    'Surah Al-Maidah',
  ];

  ListenQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Quran Companion',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Text(
                    'Listen to Surahs',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Current Surah Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/quran_icon.png',
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Surah Al-Fatiha',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'Reciter: Mishary Alafasy',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('0:00', style: TextStyle(color: Colors.grey)),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: LinearProgressIndicator(
                              value: 0.4,
                              color: Color(0xFFB8F2C9),
                              backgroundColor: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                        Text('2:45', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFB8F2C9),
                      child: Icon(
                        Icons.play_arrow,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Surah List
              Expanded(
                child: ListView.separated(
                  itemCount: surahList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            surahList[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFFB8F2C9),
                            child: Icon(
                              Icons.play_arrow,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
