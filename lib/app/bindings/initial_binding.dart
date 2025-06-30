import 'package:get/get.dart';
import 'package:sakinah/app/controllers/prayer_time_controller.dart';
import '../controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(PrayersController());

    // Add other controllers/services here
  }
}
