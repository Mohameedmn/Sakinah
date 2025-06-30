import 'package:get/get.dart';
import 'package:sakinah/app/models/duaa_model.dart';
import 'package:sakinah/app/services/duaa_services.dart';

class DuaaController extends GetxController {
  var allDuaas = <Duaa>[].obs;
  var filteredDuaas = <Duaa>[].obs;
  var isLoading = false.obs;
  var selectedCategory = 'All'.obs;

  final categories = ['All', 'Morning', 'Evening', 'Daily', 'After Salah'].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllDuaas();
  }

  void fetchAllDuaas() async {
    isLoading.value = true;
    try {
      final morning = await DuaaService().getMorningDuaa();
      final evening = await DuaaService().getEveningDuaa();
      final daily = await DuaaService().getDailyDuaa();
      final salah = await DuaaService().getAfterSalahDuaa();

      // Tag each Duaa with its category
      for (var d in morning) {
        d.category = 'Morning';
      }
      for (var d in evening) {
        d.category = 'Evening';
      }
      for (var d in daily) {
        d.category = 'Daily';
      }
      for (var d in salah) {
        d.category = 'After Salah';
      }

      allDuaas.assignAll([
        ...morning,
        ...evening,
        ...daily,
        ...salah,
      ]);

      filterDuaas();
    } catch (e) {
      print("❌ Error fetching duaas: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    filterDuaas();
  }

  void filterDuaas() {
    if (selectedCategory.value == 'All') {
      filteredDuaas.assignAll(allDuaas);
    } else {
      filteredDuaas.assignAll(
        allDuaas.where((duaa) => duaa.category.toLowerCase() == selectedCategory.value.toLowerCase()),
      );
    }
  }
}
