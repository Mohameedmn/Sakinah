import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prayers_date.dart';
import '../models/prayers_time.dart';

class PrayersService {
  Future<Map<String, dynamic>> fetchPrayerData(String city, String country) async {
    final url = Uri.parse(
      'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=2',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timings = PrayersTime.fromJson(data['data']['timings']);
      final date = PrayersDate(
        readableDate: data['data']['date']['readable'],
        hijriDate: data['data']['date']['hijri']['date'],
        gregorianDate: data['data']['date']['gregorian']['date'],
      );
      return {'timings': timings, 'date': date};
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
} 