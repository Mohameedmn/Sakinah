import 'package:get/get.dart';
import 'package:sakinah/app/controllers/quran_controller.dart';
import '../controllers/home_controller.dart';

class QuranBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(QuranController());
    
  }
}
