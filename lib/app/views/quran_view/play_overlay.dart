import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/views/quran_view/mini_player_bar.dart';
import 'package:sakinah/app/views/quran_view/now_playing_view.dart';

class PlayerOverlay extends GetView<AudioController> {
  const PlayerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.ayahList.isEmpty) return const SizedBox.shrink();

      if (controller.isExpanded.value) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.15,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent <= 0.2) {
                  controller.collapsePlayer();
                }
                return true;
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  controller: scrollController,
                  children: const [NowPlayingView()],
                ),
              ),
            );
          },
        );
      }

      return const Align(
        alignment: Alignment.bottomCenter,
        child: MiniPlayerBar(),
      );
    });
  }
}