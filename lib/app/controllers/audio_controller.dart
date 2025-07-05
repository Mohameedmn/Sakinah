import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sakinah/app/controllers/auth_controller.dart';
import 'package:sakinah/app/models/ayah_audio_model.dart';

class AudioController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  var playerState = PlayerState(false, ProcessingState.idle).obs;

  final AuthController authcontroller = Get.find<AuthController>();

  var buffered = Duration.zero.obs;
  var isExpanded = false.obs;

  void expandPlayer() => isExpanded.value = true;
  void collapsePlayer() => isExpanded.value = false;

  var ayahList = <AyahAudio>[];
  var currentAyahIndex = 0.obs;
  var currentAyah = Rxn<AyahAudio>();

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

  var isPlaying = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration(seconds: 1).obs;

  var autoScroll = true.obs;

  int get currentReciterId => reciterIds[currentReciter.value] ?? 7;

  @override
  void onInit() {
    super.onInit();

    // ✅ Attach listeners ONCE here
    player.positionStream.listen((pos) => position.value = pos);
    player.durationStream.listen(
      (dur) => duration.value = dur ?? Duration.zero,
    );
    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing; // still used elsewhere
      playerState.value = state; // NEW: store full state
    });

    player.currentIndexStream.listen((index) {
      if (index != null && index < ayahList.length) {
        currentAyahIndex.value = index;
        currentAyah.value = ayahList[index];
        _saveLastRead();
      }
    });
  }

  void playAyahs(
    List<AyahAudio> ayahs,
    String surahName, {
    int startIndex = 0,
  }) async {
    try {
      if (ayahs.isEmpty) {
        print("No ayahs to play.");
        return;
      }

      ayahList = ayahs;
      currentSurahName.value = surahName;

      final sources = ayahs
          .where((a) => a.url.isNotEmpty)
          .map(
            (a) => AudioSource.uri(
              Uri.parse(a.url),
              tag: MediaItem(
                id: a.verseKey,
                title: 'Ayah ${a.verseKey}',
                album: currentSurahName.value,
                artist: currentReciter.value,
              ),
            ),
          )
          .toList();

      final playlist = ConcatenatingAudioSource(children: sources);

      await player.setAudioSource(playlist, initialIndex: startIndex);
      await player.play();

      isPlaying.value = true;
    } catch (e) {
      print('Error playing ayahs: $e');
    }
  }

  void _saveLastRead() async {
    final current = currentAyah.value;
    if (current == null) return;

    final uid = authcontroller.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'last_read': {
        'surah': currentSurahName.value,
        'verse_key': current.verseKey,
        'timestamp': FieldValue.serverTimestamp(),
      },
    });
  }

  // Playback Controls
  void togglePlayPause() {
  final state = player.playerState;

  if (state.playing) {
    player.pause();
  } else {
    if (state.processingState == ProcessingState.completed) {
      player.seek(Duration.zero, index: 0); 
    }
    player.play();
  }
}

  void playNext() => player.seekToNext();
  void playPrevious() => player.seekToPrevious();
  void seekTo(double seconds) =>
      player.seek(Duration(seconds: seconds.toInt()));

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return "$m:$s";
  }

  void setAutoScroll(bool value) => autoScroll.value = value;

  void changeReciter(String name) => currentReciter.value = name;

  Future<Map<String, dynamic>?> getLastRead() async {
    final uid = AuthController.instance.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists && doc.data()!.containsKey('last_read')) {
      return doc['last_read'] as Map<String, dynamic>;
    }
    return null;
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
