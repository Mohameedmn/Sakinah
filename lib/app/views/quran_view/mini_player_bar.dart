import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';

class MiniPlayerBar extends GetView<AudioController> {
  const MiniPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.ayahList.isEmpty) return const SizedBox();

      return GestureDetector(
        onTap: controller.expandPlayer,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -1),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.currentSurahName.value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: controller.togglePlayPause,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: controller.playNext,
              ),
            ],
          ),
        ),
      );
    });
  }
}