import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller (or retrieve if already registered elsewhere)
    final AudioController c = Get.put(AudioController(), permanent: false);

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.keyboard_arrow_down),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
        actions: const [Icon(Icons.more_vert)],
      ),

      body: Obx(() {
        final ayah = c.currentAyah.value;
        return Column(
          children: [
            const SizedBox(height: 8),
            // Artwork placeholder ------------------------------------------------
            Expanded(
              child: Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.auto_stories_outlined, size: 56),
                      SizedBox(height: 8),
                      Text('Surah Artwork'),
                    ],
                  ),
                ),
              ),
            ),
            // Arabic text --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                ayah?.verseKey ?? '…',   // adjust field name if different
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontFamily: 'Amiri'),
              ),
            ),
            const SizedBox(height: 12),
            // Translation --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Reciter: ${c.currentReciter.value} ?? ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            // Progress slider ----------------------------------------------------
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
            // Controls -----------------------------------------------------------
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
                      child: Icon(c.isPlaying.value ? Icons.pause : Icons.play_arrow),
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
        );
      }),
    );
  }

  // Utility: duration → mm:ss
  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}';
  }
}