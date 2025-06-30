import 'package:get/get.dart';
import 'package:sakinah/app/controllers/duaa_controller.dart';

class DuaaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DuaaController());
    
  }
}
