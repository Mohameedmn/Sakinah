import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';

class CustomProgressBar extends StatelessWidget {
  CustomProgressBar({super.key});

  final AudioController controller = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Obx(() {
      final position = controller.position.value;
      final duration = controller.duration.value;

      final positionSeconds = position.inSeconds.toDouble();
      final durationSeconds = duration.inSeconds.toDouble();
      final safeDuration = durationSeconds < 1.0 ? 1.0 : durationSeconds;

      return Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: color,
              inactiveTrackColor: color.withOpacity(0.3),
              thumbColor: color,
              overlayColor: color.withOpacity(0.1),
            ),
            child: Slider(
              value: positionSeconds.clamp(0.0, safeDuration).toDouble(),
              min: 0.0,
              max: safeDuration,
              onChanged: (value) {
                controller.seekTo(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.formatTime(position),
                  style: TextStyle(color: color.withOpacity(0.7), fontSize: 12),
                ),
                Text(
                  controller.formatTime(duration),
                  style: TextStyle(color: color.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
