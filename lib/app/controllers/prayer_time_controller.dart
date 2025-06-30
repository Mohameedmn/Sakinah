import 'dart:async';
import 'package:get/get.dart';
import 'package:sakinah/app/models/prayers_date.dart';
import 'package:sakinah/app/models/prayers_time.dart';
import 'package:sakinah/app/services/location_services.dart';
import 'package:sakinah/app/services/notification_services.dart';
import 'package:sakinah/app/services/prayer_api_services.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayersController extends GetxController {
  final prayersService = PrayersService();

  var timings = Rxn<PrayersTime>();
  var date = Rxn<PrayersDate>();
  var isLoading = true.obs;
  var location = ''.obs;

  var nextPrayerName = ''.obs;
  var countdown = ''.obs;

  Timer? _countdownTimer;

  get flutterLocalNotificationsPlugin => null;

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    isLoading.value = true;
    try {
      final locationData = await getCityAndCountry();
      final city = locationData['city'];
      final country = locationData['country'];

      if (city == null || country == null) {
        throw Exception("City or country not found.");
      }

      location.value = "$city, $country"; // ✅ Set location here

      final data = await prayersService.fetchPrayerData(city, country);
      timings.value = data['timings'];
      date.value = data['date'];

      updateNextPrayer();
      startCountdownUpdates();
    } catch (e) {
      print("❌ Error fetching prayer times: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateNextPrayer() {
    if (timings.value == null) return;

    final now = DateTime.now();
    final prayers = {
      "Fajr": timings.value!.fajr,
      "Dhuhr": timings.value!.dhuhr,
      "Asr": timings.value!.asr,
      "Maghrib": timings.value!.maghrib,
      "Isha": timings.value!.isha,
    };

    for (final entry in prayers.entries) {
      final prayerTime = _parseTime(entry.value);
      if (prayerTime.isAfter(now)) {
        nextPrayerName.value = entry.key;
        return;
      }
    }

    // All prayers passed? Set next to tomorrow's Fajr
    nextPrayerName.value = "Fajr";
  }

  void startCountdownUpdates() {
    _countdownTimer?.cancel(); // clear old timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = getCountdownToNextPrayer();
      countdown.value = formatDuration(remaining);
    });
  }

  Duration getCountdownToNextPrayer() {
    if (timings.value == null || nextPrayerName.value.isEmpty) {
      return Duration.zero;
    }

    final nextTime = timings.value!.toMap()[nextPrayerName.value];
    if (nextTime == null) return Duration.zero;

    final nextDateTime = _parseTime(nextTime);
    return nextDateTime.difference(DateTime.now());
  }

  DateTime _parseTime(String timeStr) {
    final parts = timeStr.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String formatDuration(Duration duration) {
    if (duration.isNegative) return "00:00:00";
    final h = duration.inHours.toString().padLeft(2, '0');
    final m = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final s = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  Map<String, String> getPrayerTimesMap() {
    final t = timings.value;
    if (t == null) return {};

    return {
      'Fajr': t.fajr,
      'Dhuhr': t.dhuhr,
      'Asr': t.asr,
      'Maghrib': t.maghrib,
      'Isha': t.isha,
    };
  }

  void schedulePrayerNotifications() {
    final times = timings.value;
    if (times == null) return;

    final now = DateTime.now();

    final prayers = {
      'Fajr': times.fajr,
      'Dhuhr': times.dhuhr,
      'Asr': times.asr,
      'Maghrib': times.maghrib,
      'Isha': times.isha,
    };

    int id = 0;
    prayers.forEach((name, timeString) {
      final timeParts = timeString.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      final scheduled = DateTime(now.year, now.month, now.day, hour, minute);

      // If already passed today, schedule for tomorrow
      final scheduledTime = scheduled.isBefore(now)
          ? scheduled.add(const Duration(days: 1))
          : scheduled;

      final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

      NotificationService.schedulePrayerNotification(
        id: id++,
        title: 'Time for $name prayer',
        body: 'Prepare for your $name prayer',
        scheduledTime: tzTime,
      );
    });
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }
}
