import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sakinah/app/models/duaa_model.dart';

class DuaaService {
  final baseRawUrl = 'https://raw.githubusercontent.com/fitrahive/dua-dhikr/main/data/dua-dhikr';

  List<Duaa> _parseDuaaList(String jsonStr, String category) {
    final List data = json.decode(jsonStr);
    return data.map((e) => Duaa.fromJson(e, category: category)).toList();
  }

  Future<List<Duaa>> fetchCategory(String folderName, String label) async {
    final url = Uri.parse('$baseRawUrl/$folderName/en.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return _parseDuaaList(response.body, label);
    } else {
      throw Exception('Failed to load $label duaa');
    }
  }

  Future<List<Duaa>> getDailyDuaa() => fetchCategory('daily-dua', 'Daily');
  Future<List<Duaa>> getMorningDuaa() => fetchCategory('morning-dhikr', 'Morning');
  Future<List<Duaa>> getEveningDuaa() => fetchCategory('evening-dhikr', 'Evening');
  Future<List<Duaa>> getAfterSalahDuaa() => fetchCategory('dhikr-after-salah', 'After Salah');
}
