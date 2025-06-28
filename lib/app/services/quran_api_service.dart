import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sakinah/app/models/ayah_audio_model.dart';
import 'package:sakinah/app/models/surah_model.dart';

class QuranApi {
  final baseUrl = 'https://api.alquran.cloud/v1';

  Future<Surah> fetchSurah(int surahNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/surah/$surahNumber'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Surah.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load surah');
    }
  }

  Future<List<SurahBasic>> getSurahList() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> surahList = jsonData['data'];
      return surahList.map((e) => SurahBasic.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load surah list');
    }
  }

  Future<List<AyahAudio>> getSurahAudio(int surahNumber) async {
    final url = 'https://api.alquran.cloud/v1/surah/$surahNumber/ar.alafasy';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body)['data']['ayahs'] as List;
      return data
          .map(
            (a) => AyahAudio(
              verseKey: a['numberInSurah'].toString(),
              url: a['audio'] as String,
            ),
          )
          .toList();
    } else {
      throw Exception('Failed to load audio from API');
    }
  }
}
