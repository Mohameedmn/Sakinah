import 'package:sakinah/app/models/prayers_date.dart';
import 'package:sakinah/app/models/prayers_time.dart';

class PrayerData {
  final PrayersTime timings;
  final PrayersDate date;

  PrayerData({
    required this.timings,
    required this.date,
  });

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      timings: PrayersTime.fromJson(json['timings']),
      date: PrayersDate.fromJson(json['date']),
    );
  }
}
