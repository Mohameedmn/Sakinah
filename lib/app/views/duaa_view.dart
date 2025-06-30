import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/duaa_controller.dart';
import 'package:sakinah/app/models/duaa_model.dart';

class DuaaView extends StatelessWidget {
  const DuaaView({super.key});

  @override
  Widget build(BuildContext context) {
    final DuaaController controller = Get.find<DuaaController>();

    return DefaultTabController(
      length: controller.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Duaa'),
          bottom: TabBar(
            isScrollable: true,
            onTap: (index) {
              controller.selectCategory(controller.categories[index]);
            },
            tabs: controller.categories
                .map((cat) => Tab(text: cat))
                .toList(),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.filteredDuaas.isEmpty) {
            return const Center(child: Text("No Duaa found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.filteredDuaas.length,
            itemBuilder: (context, index) {
              final Duaa duaa = controller.filteredDuaas[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        duaa.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        duaa.arabic,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Amiri',
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        duaa.translation,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      ...[
                      const SizedBox(height: 8),
                      Text(
                        "📘 ${duaa.source}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ]
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
