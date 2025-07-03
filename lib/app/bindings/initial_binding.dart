import 'package:get/get.dart';
import 'package:sakinah/app/controllers/audio_controller.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/app/controllers/prayer_time_controller.dart';
import '../controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(PrayersController(), permanent: true);
    Get.put(AudioController(), permanent: true); // Uncomment if needed

    // Add other controllers/services here
  }
}
