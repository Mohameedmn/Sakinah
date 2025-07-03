import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/routes/app_route.dart';


class HomeController extends GetxController {
  // Rx values
  var hijriDate = ''.obs;
  var currentIndex = 0.obs;
  var nextPrayerTime = ''.obs;

  // RxBool for notifications
  RxBool notificationsEnabled = true.obs;
  final _firestore = FirebaseFirestore.instance;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchHijriDate();
    fetchNotificationSetting();
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
    var nextPrayerTime = DateTime(now.year, now.month, now.day, 5, 0); // Example: Fajr at 5:00 AM
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

  Future<void> toggleNotifications(bool value) async {
    final uid = authController.uid;
    await _firestore.collection('users').doc(uid).update({
      'notifications_enabled': value,
    });
    notificationsEnabled.value = value;
  }


} 
