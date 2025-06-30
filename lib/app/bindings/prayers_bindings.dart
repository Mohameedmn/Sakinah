import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/controllers/prayer_time_controller.dart';

class PrayersBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrayersController());
    Get.put(HomeController());

    // Add other controllers/services here
  }
}
