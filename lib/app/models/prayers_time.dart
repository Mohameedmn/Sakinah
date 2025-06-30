class PrayersTime {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String sunrise;
  final String sunset;

  PrayersTime({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.sunrise,
    required this.sunset,
  });

  factory PrayersTime.fromJson(Map<String, dynamic> json) {
    return PrayersTime(
      fajr: json['Fajr'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      sunrise: json['Sunrise'],
      sunset: json['Sunset'],
    );
  }

  Map<String, String> toMap() {
    return {
      'Fajr': fajr,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Isha': isha,
      'Sunrise': sunrise,
      'Sunset': sunset,
    };
  }
}
