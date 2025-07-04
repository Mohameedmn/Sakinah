import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/theme/theme.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController c = Get.find<AudioController>(); // ✅ Fix controller

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('NOW PLAYING', style: Theme.of(context).textTheme.labelSmall),
            Obx(() => Text(
                  c.currentSurahName.value.isEmpty
                      ? '…'
                      : c.currentSurahName.value,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )),
            Obx(() {
              final ayah = c.currentAyah.value;
              return Expanded( 
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Image.asset(
                            'assets/images/quran_listen_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        ayah?.verseKey ?? '…',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, fontFamily: 'Amiri'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Reciter: ${c.currentReciter.value}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Slider(
                          value: c.position.value.inSeconds
                              .clamp(0, c.duration.value.inSeconds)
                              .toDouble(),
                          max: (c.duration.value.inSeconds + 0.1).toDouble(),
                          onChanged: (v) => c.seekTo(v),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fmt(c.position.value)),
                              Text(_fmt(c.duration.value)),
                            ],
                          )),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          iconSize: 28,
                          onPressed: c.playPrevious,
                        ),
                        Obx(() => FloatingActionButton(
                              heroTag: 'playpause',
                              shape: const CircleBorder(),
                              onPressed: c.togglePlayPause,
                              child: Icon(c.isPlaying.value
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            )),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          iconSize: 28,
                          onPressed: c.playNext,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}';
  }
}
