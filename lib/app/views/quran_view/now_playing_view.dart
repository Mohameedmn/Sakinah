import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/theme/theme.dart';
import 'package:sakinah/app/widgets/progress_bar.dart';

class NowPlayingView extends GetView<HomeController> {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = Get.find<AudioController>();

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          audioController.collapsePlayer();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "NOW PLAYING",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        controller.lastSurah.value,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      )),
                  const SizedBox(height: 2),
                  Obx(() => Text(
                        "Verse: ${controller.lastVerse.value}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )),
                ],
              ),
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/quran_icon.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
              Material(child: CustomProgressBar()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, color: AppColors.accent),
                    onPressed: () => audioController.playPrevious(),
                  ),
                  Obx(() {
                    final isBuffering = audioController.playerState.value
                            .processingState ==
                        ProcessingState.buffering;
                    final isPlaying = audioController.playerState.value.playing;

                    return RawMaterialButton(
                      onPressed: audioController.togglePlayPause,
                      elevation: 4,
                      shape: const CircleBorder(),
                      fillColor: AppColors.accent,
                      padding: const EdgeInsets.all(16),
                      child: isBuffering
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: AppColors.accent),
                    onPressed: () => audioController.playNext(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}