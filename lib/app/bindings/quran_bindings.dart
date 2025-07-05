import 'package:get/get.dart';
import 'package:sakinah/app/controllers/home_controller.dart';
import 'package:sakinah/app/controllers/quran_controller.dart';

class QuranBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(QuranController());
    Get.put(HomeController());

    
  }
}
