import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';

class QuranPlayerBottomSheet extends StatelessWidget {
  const QuranPlayerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController controller = Get.find();

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Obx(() {
            final surahName = controller.currentSurahName.value;
            final reciter = controller.currentReciter.value;
            final progress = controller.position.value.inSeconds;
            final total = controller.duration.value.inSeconds;

            return ListView(
              controller: scrollController,
              children: [
                Text(surahName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(reciter, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Text(controller.formatTime(controller.position.value)),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: total.toDouble(),
                        value: progress.toDouble().clamp(0, total.toDouble()),
                        onChanged: controller.seekTo,
                      ),
                    ),
                    Text(controller.formatTime(controller.duration.value)),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: const Icon(Icons.skip_previous), onPressed: controller.playPrevious),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFFB8F2C9),
                      child: IconButton(
                        icon: Icon(controller.isPlaying.value ? Icons.pause : Icons.play_arrow),
                        onPressed: controller.togglePlayPause,
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.skip_next), onPressed: controller.playNext),
                  ],
                ),

                const SizedBox(height: 16),

                const Text("Reciters", style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 12,
                  children: controller.reciters.map((r) {
                    final isSelected = r == controller.currentReciter.value;
                    return ChoiceChip(
                      label: Text(r),
                      selected: isSelected,
                      onSelected: (_) => controller.changeReciter(r),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const Text("Options", style: TextStyle(fontWeight: FontWeight.bold)),
                SwitchListTile(
                  value: controller.autoScroll.value,
                  onChanged: controller.setAutoScroll,
                  title: const Text("Auto Scroll"),
                ),
                // Add repeat options, playback speed etc...
              ],
            );
          }),
        );
      },
    );
  }
}
