class SurahBasic {
  final int number;
  final String name;
  final String englishName;
  final int numberOfAyahs;
  final String revelationType;

  SurahBasic({
    required this.number,
    required this.name,
    required this.englishName,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahBasic.fromJson(Map<String, dynamic> json) {
    return SurahBasic(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      ayahs: (json['ayahs'] as List).map((a) => Ayah.fromJson(a)).toList(),
    );
  }
}

class Ayah {
  final int number;
  final String text;

  Ayah({required this.number, required this.text});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['numberInSurah'], // specific to AlQuran Cloud
      text: json['text'],
    );
  }
}
