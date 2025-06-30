class Duaa {
  final String title;
  final String arabic;
  final String latin;
  final String translation;
  final String? notes;
  final String fawaid;
  final String source;
  String category;
  int readcount;

  Duaa({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
    this.notes,
    required this.fawaid,
    required this.source,
    required this.category,
    this.readcount = 1,
  });

  factory Duaa.fromJson(Map<String, dynamic> json, {required String category}) {
    return Duaa(
      title: json['title'] ?? '',
      arabic: json['arabic'] ?? '',
      latin: json['latin'] ?? '',
      translation: json['translation'] ?? '',
      notes: json['notes'],
      fawaid: json['fawaid'] ?? '',
      source: json['source'] ?? '',
      category: category,
    );
  }
}
