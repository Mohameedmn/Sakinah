import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/app/services/quran_api_service.dart';
import 'package:sakinah/app/views/quran_view/Quran_Player_Bottom_Sheet.dart';
import 'package:sakinah/routes/app_route.dart';

class HomeController extends GetxController {
  // Rx values
  var hijriDate = ''.obs;
  var currentIndex = 0.obs;
  var nextPrayerTime = ''.obs;

  var lastSurah = ''.obs;
  var lastVerse = ''.obs;

  // RxBool for notifications
  RxBool notificationsEnabled = true.obs;
  final _firestore = FirebaseFirestore.instance;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchHijriDate();
    fetchNotificationSetting();
    fetchLastRead();
  }

  void fetchHijriDate() {
    // For demo purposes, using a static hijri date
    // In production, use a Hijri date package or API
    hijriDate.value = '29 Dhou Al-Hijja 1446 AH';
  }

  String fetchNextPrayerTime() {
    // For demo purposes, using a static next prayer time
    // In production, use an API or package to get actual prayer times
    var now = DateTime.now();
    var nextPrayerTime = DateTime(
      now.year,
      now.month,
      now.day,
      5,
      0,
    ); // Example: Fajr at 5:00 AM
    var formattedTime = DateFormat('hh:mm a').format(nextPrayerTime);
    return formattedTime;
  }

  // Navigation methods
  void goToQuran() {
    Get.toNamed(AppRoute.choosemode);
  }

  void goToQibla() {
    Get.toNamed(AppRoute.qibla);
  }

  void goToPrayerTime() {
    Get.toNamed(AppRoute.prayerTimes);
  }

  void goToDuaa() {
    //   Get.toNamed(AppRoute.duaa);
  }

  void goToHome() {
    Get.toNamed(AppRoute.home);
  }

  void goToProfile() {
    Get.toNamed(AppRoute.profile);
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
    onTabSelected(index);
  }

  void onTabSelected(int index) {
    switch (index) {
      case 0:
        goToHome();
        break;
      case 1:
        goToQuran();
        break;
      case 2:
        goToPrayerTime();
        break;
      case 3:
        goToQibla();
        break;
      case 4:
        goToProfile();
        break;
      default:
        break;
    }
  }

  Future<void> fetchNotificationSetting() async {
    final uid = authController.uid;
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data()!.containsKey('notifications_enabled')) {
      notificationsEnabled.value = doc['notifications_enabled'];
    } else {
      // Default value if not set in Firestore
      notificationsEnabled.value = true;
    }
  }
  Future<void> fetchLastRead() async {
  final uid = authController.uid;
  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = doc.data()?['last_read'];
  if (data != null) {
    lastSurah.value = data['surah'] ?? '';
    lastVerse.value = data['verse_key'] ?? '';
  } else {
    lastSurah.value = '';
    lastVerse.value = '';
  }
}

  Future<void> toggleNotifications(bool value) async {
    final uid = authController.uid;
    await _firestore.collection('users').doc(uid).update({
      'notifications_enabled': value,
    });
    notificationsEnabled.value = value;
  }
  Future<void> resumeLastRead() async {
  final uid = authController.uid;
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
  final last = doc.data()?['last_read'];

  if (last == null) {
    Get.snackbar("No Last Read", "You haven't listened to any surah yet.");
    return;
  }

  final verseKey = last['verse_key'];
  final surahName = last['surah'];

  if (verseKey == null || verseKey is! String || !verseKey.contains(':')) {
    Get.snackbar("Invalid Verse Key", "Verse key is missing or malformed.");
    return;
  }

  final parts = verseKey.split(':');
  if (parts.length != 2) {
    Get.snackbar("Invalid Format", "Verse key must be in format surah:ayah.");
    return;
  }

  final surahNumber = int.tryParse(parts[0]);
  final ayahNumber = int.tryParse(parts[1]);

  if (surahNumber == null || ayahNumber == null) {
    Get.snackbar("Parse Error", "Cannot parse surah or ayah number.");
    return;
  }

  final quranApi = QuranApi(); // Use your actual API service
  final ayahs = await quranApi.getSurahAudio(surahNumber);

  if (ayahs.isEmpty) {
    Get.snackbar("Surah Not Found", "No ayahs found for this surah.");
    return;
  }

  final index = ayahs.indexWhere((a) => a.verseKey == verseKey);
  if (index == -1) {
    Get.snackbar("Ayah Not Found", "Unable to locate the last ayah.");
    return;
  }

  final audioController = Get.find<AudioController>();
  audioController.playAyahs(ayahs, surahName, startIndex: index);

  Get.bottomSheet(
    const QuranPlayerBottomSheet(),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}


}
