import 'package:get/get.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/app/controllers/home_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<HomeController>();
    Get.find<AuthController>();
     // Use the existing instance, do not create a new one
    // Add other dependencies if needed
  }
}