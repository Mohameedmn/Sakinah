import 'package:get/get.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());

    // Add other controllers/services here
  }
}
