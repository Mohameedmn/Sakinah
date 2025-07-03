import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/models/surah_model.dart';
import 'package:sakinah/app/services/quran_api_service.dart';
import 'package:sakinah/app/views/quran_view/quran_player_bottom_sheet.dart';

class ListenQuranPage extends StatelessWidget {
  final QuranApi api = QuranApi();
  final AudioController audioController = Get.find<AudioController>();

  ListenQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: const Text('Listen to Quran')),
      body: FutureBuilder<List<SurahBasic>>(
        future: api.getSurahList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final surahs = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: surahs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return GestureDetector(
                onTap: () async {
                  final ayahs = await api.getSurahAudio(surah.number);
                  if (ayahs.isNotEmpty) {
                    audioController.playAyahs(ayahs, surah.englishName);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const QuranPlayerBottomSheet(),
                    );
                  }
                },

                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        surah.englishName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
