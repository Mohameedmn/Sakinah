import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:sakinah/app/models/ayah_audio_model.dart';

class AudioController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  // Ayah Playlist
  var ayahList = <AyahAudio>[];
  var currentAyahIndex = 0.obs;
  var currentAyah = Rxn<AyahAudio>();

  // Surah & Reciter
  var currentSurahName = ''.obs;
  var currentReciter = 'Saad Al Ghamidi'.obs;

  var reciters = [
    'Saad Al Ghamidi',
    'Mishary Rashid',
    'Abdur Rahman As-Sudais',
  ].obs;

  final Map<String, int> reciterIds = {
    'Saad Al Ghamidi': 7,
    'Mishary Rashid': 4,
    'Abdur Rahman As-Sudais': 2,
  };

  // Playback
  var isPlaying = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration(seconds: 1).obs;

  var autoScroll = true.obs;

  int get currentReciterId => reciterIds[currentReciter.value] ?? 7;

  /// Play full ayah list
  void playAyahs(List<AyahAudio> ayahs, String surahName) async {
    try {
      if (ayahs.isEmpty) {
        print("No ayahs to play.");
        return;
      }

      ayahList = ayahs;
      currentSurahName.value = surahName;

      final sources = ayahs
          .where((a) => a.url.isNotEmpty)
          .map((a) => AudioSource.uri(Uri.parse(a.url)))
          .toList();

      final playlist = ConcatenatingAudioSource(children: sources);

      await player.setAudioSource(playlist);
      player.play();

      isPlaying.value = true;

      // Listen to playback changes
      player.positionStream.listen((pos) => position.value = pos);
      player.durationStream.listen((dur) => duration.value = dur ?? Duration.zero);
      player.playerStateStream.listen((state) => isPlaying.value = state.playing);

      player.currentIndexStream.listen((index) {
        if (index != null && index < ayahList.length) {
          currentAyahIndex.value = index;
          currentAyah.value = ayahList[index];
        }
      });
    } catch (e) {
      print('Error playing ayahs: $e');
    }
  }

  /// Playback Controls
  void togglePlayPause() => isPlaying.value ? player.pause() : player.play();
  void playNext() => player.seekToNext();
  void playPrevious() => player.seekToPrevious();
  void seekTo(double seconds) => player.seek(Duration(seconds: seconds.toInt()));

  /// Time Formatter (mm:ss)
  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return "$m:$s";
  }

  void setAutoScroll(bool value) => autoScroll.value = value;

  /// Reciter Switch
  void changeReciter(String name) {
    currentReciter.value = name;
    // Optionally reload audio here with new reciter
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
