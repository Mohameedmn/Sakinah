import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/controllers/quran_controller.dart';
import 'package:sakinah/app/theme/theme.dart';

class ReadQuranPage extends GetView<QuranController> {
  const ReadQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Quran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Colors.white),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 8),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primary,
                    ),
                    child: Text(
                      "Sura",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 15),

                  Container(
                    padding: EdgeInsets.all(5),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Juz",
                      style: TextStyle(
                        color: AppColors.grayFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 15),

                  Container(
                    padding: EdgeInsets.all(5),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Story",
                      style: TextStyle(
                        color: AppColors.grayFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 15),

                  Container(
                    padding: EdgeInsets.all(5),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Fact",
                      style: TextStyle(
                        color: AppColors.grayFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 15),

                  Container(
                    padding: EdgeInsets.all(5),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Bookmark",
                      style: TextStyle(
                        color: AppColors.grayFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Last Read",
              style: TextStyle(
                color: AppColors.grayFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left text block
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "البقرة",
                              style: TextStyle(
                                fontFamily: 'Scheherazade',
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Verse 12",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: Divider(
                                thickness: 0.6,
                                color: Colors.white,
                              ),
                            ),

                            Row(
                              children: [
                                Text(
                                  "Continue to read",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 8,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 120), // space for the image
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: -30,
                  right: -2,
                  top: -20,
                  child: Container(
                    width: 200,
                    height: 160,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/images/quran_illustration.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(top: 12, right: 2, left: 2),
                  itemCount: controller.surahList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final surah = controller.surahList[index];

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      leading: ClipPolygon(
                        sides: 4,
                        borderRadius: 5.0, // smooth corners
                        rotate: 90, // upright hexagon
                        boxShadows: [
                          PolygonBoxShadow(
                            color: Colors.grey.shade300,
                            elevation: 2.0,
                          ),
                        ],
                        child: Container(
                          width: 40,
                          height: 40,
                          color: AppColors.secondary,
                          alignment: Alignment.center,
                          child: Text(
                            '${surah.number}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),

                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surah.englishName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${surah.numberOfAyahs} Verses',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          // Right side: Arabic
                          Text(
                            surah.name,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: 'Scheherazade',
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => controller.openSurahMushaf(surah.number),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
