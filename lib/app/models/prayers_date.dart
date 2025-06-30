class PrayersDate {
  final String readableDate;
  final String hijriDate;
  final String gregorianDate;

  PrayersDate({
    required this.readableDate,
    required this.hijriDate,
    required this.gregorianDate,
  });

  factory PrayersDate.fromJson(Map<String, dynamic> json) {
    return PrayersDate(
      readableDate: json['readable'],
      hijriDate: json['hijri']['date'],
      gregorianDate: json['gregorian']['date'],
    );
  }
}
