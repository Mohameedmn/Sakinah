import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/quran_controller.dart';

class ReadQuranPage extends GetView<QuranController> {
  const ReadQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Quran"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.surahList.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final surah = controller.surahList[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade50,
                child: Text('${surah.number}'),
              ),
              title: Text(
                surah.englishName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                surah.name,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // ✅ This method automatically determines start and end pages
                controller.openSurahMushaf(surah.number);
              },
            );
          },
        );
      }),
    );
  }
}
