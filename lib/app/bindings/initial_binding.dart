import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    // Add other controllers/services here
  }
}
