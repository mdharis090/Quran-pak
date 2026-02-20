// import 'package:bloc/bloc.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// import '../../api/ayah_repository.dart';
// import '../../database/database_helper.dart';
// import 'ayah_state.dart';
//
//
// class AyahCubit extends Cubit<AyahState> {
//   final int surahNumber;
//   final DatabaseHelper dbHelper;
//   final AyahRepository repository;
//   final AudioPlayer player = AudioPlayer();
//
//   AyahCubit({
//     required this.surahNumber,
//     required this.dbHelper,
//     required this.repository,
//   }) : super(const AyahState()) {
//     player.setReleaseMode(ReleaseMode.stop);
//     fetchAyahs();
//     loadBookmarks();
//   }
//
//   Future<void> fetchAyahs() async {
//     try {
//       final ayahs = await repository.fetchAyahs(surahNumber);
//       emit(state.copyWith(ayahs: ayahs, loading: false));
//     } catch (e) {
//       emit(state.copyWith(loading: false, error: e.toString()));
//     }
//   }
//
//   Future<void> playAudio(String url) async {
//     try {
//       await player.stop();
//       await player.play(UrlSource(url));
//     } catch (e) {
//       // Error
//     }
//   }
//
//   Future<void> loadBookmarks() async {
//     final allBookmarks = await dbHelper.getBookmarks();
//     final keys =
//     allBookmarks.map((b) => '${b['surahNumber']}:${b['ayahNumber']}').toSet();
//     emit(state.copyWith(bookmarks: keys));
//   }
//
//   Future<void> toggleBookmark(Map<String, dynamic> ayah) async {
//     final key = '${surahNumber}:${ayah['numberInSurah']}';
//     final isBookmarked = state.bookmarks.contains(key);
//
//     final newBookmarks = Set<String>.from(state.bookmarks);
//
//     if (isBookmarked) {
//       await dbHelper.removeBookmark(surahNumber, ayah['numberInSurah']);
//       newBookmarks.remove(key);
//     } else {
//       await dbHelper.addBookmark({
//         'surahNumber': surahNumber,
//         'ayahNumber': ayah['numberInSurah'],
//         'ayahText': ayah['text'],
//         'audioUrl': ayah['audio'],
//       });
//       newBookmarks.add(key);
//     }
//
//     emit(state.copyWith(bookmarks: newBookmarks));
//   }
//
//   @override
//   Future<void> close() {
//     player.dispose();
//     return super.close();
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import '../../api/ayah_repository.dart';
import '../../database/database_helper.dart';
import 'ayah_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';


class AyahCubit extends Cubit<AyahState> {
  final int surahNumber;
  final String surahName;
  final DatabaseHelper dbHelper;
  final AyahRepository repository;
  final AudioPlayer player = AudioPlayer();

  AyahCubit({
    required this.surahNumber,
    required this.surahName,
    required this.dbHelper,
    required this.repository,
  }) : super(const AyahState()) {
    player.setReleaseMode(ReleaseMode.stop);
    fetchAyahs();
    loadBookmarks();
    saveLastRead(); // Save position when opened
    loadSettings(); // Load font preferences

    // Listen to audio events
    player.onPlayerStateChanged.listen((state) {
      emit(this.state.copyWith(isPlaying: state == PlayerState.playing));
    });

    player.onDurationChanged.listen((duration) {
      emit(this.state.copyWith(duration: duration));
    });

    player.onPositionChanged.listen((position) {
      emit(this.state.copyWith(position: position));
    });

    player.onPlayerComplete.listen((event) {
      emit(this.state.copyWith(
        isPlaying: false,
        position: Duration.zero,
        playingKey: null,
        playingUrl: null,
      ));
    });
  }

  Future<void> fetchAyahs() async {
    try {
      final ayahs = await repository.fetchAyahs(surahNumber);
      emit(state.copyWith(ayahs: ayahs, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  String _everyAyahFallbackUrl(int surahNumber, int ayahInSurah) {
    final s = surahNumber.toString().padLeft(3, '0');
    final a = ayahInSurah.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/Alafasy_128kbps/$s$a.mp3';
  }

  Future<File> _getOrDownloadAudioFile(String url, {String? fallbackUrl}) async {
    final normalizedUrl =
        url.replaceFirst('cdn.islmaic.network', 'cdn.islamic.network');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/quran_audio_${normalizedUrl.hashCode}.mp3');

    if (await file.exists() && await file.length() > 0) return file;

    final client = HttpClient();
    try {
      Exception? lastError;

      for (var attempt = 0; attempt < 3; attempt++) {
        try {
          final request = await client.getUrl(Uri.parse(normalizedUrl));
          request.headers.set(HttpHeaders.userAgentHeader, 'Mozilla/5.0');
          request.headers.set(HttpHeaders.acceptHeader, '*/*');
          request.headers.set(HttpHeaders.connectionHeader, 'keep-alive');

          final response = await request.close();
          if (response.statusCode != 200) {
            throw Exception('Audio download failed (${response.statusCode})');
          }

          final sink = file.openWrite();
          await response.pipe(sink);
          return file;
        } catch (e) {
          lastError = Exception(e.toString());
          // small retry delay (connection reset by peer is often transient)
          await Future<void>.delayed(Duration(milliseconds: 250 * (attempt + 1)));
        }
      }

      // Primary host failed. Try fallback host if provided.
      if (fallbackUrl != null && fallbackUrl.trim().isNotEmpty) {
        final fallbackFile =
            File('${tempDir.path}/quran_audio_${fallbackUrl.hashCode}.mp3');
        if (await fallbackFile.exists() && await fallbackFile.length() > 0) {
          return fallbackFile;
        }

        try {
          final request = await client.getUrl(Uri.parse(fallbackUrl));
          request.headers.set(HttpHeaders.userAgentHeader, 'Mozilla/5.0');
          request.headers.set(HttpHeaders.acceptHeader, '*/*');
          request.headers.set(HttpHeaders.connectionHeader, 'keep-alive');

          final response = await request.close();
          if (response.statusCode != 200) {
            throw Exception('Audio download failed (${response.statusCode})');
          }

          final sink = fallbackFile.openWrite();
          await response.pipe(sink);
          return fallbackFile;
        } catch (e) {
          throw Exception('${lastError ?? Exception("Audio download failed")}; fallback failed: $e');
        }
      }

      throw lastError ?? Exception('Audio download failed');
    } finally {
      client.close(force: true);
    }
  }

  Future<void> playPauseAudio(String url, int ayahInSurah) async {
    if (url.trim().isEmpty) return;
    final key = '$surahNumber:$ayahInSurah';
    if (state.audioLoadingKey == key) return; // already loading

    if (state.playingKey != key) {
      // Different ayah clicked: download (if needed) and play locally.
      emit(state.copyWith(
        audioError: '',
        audioLoadingKey: key,
        audioLoadingUrl: url,
        playingKey: key,
        playingUrl: url,
        isPlaying: false,
      ));

      try {
        await player.stop();
        final fallbackUrl = _everyAyahFallbackUrl(surahNumber, ayahInSurah);
        final file = await _getOrDownloadAudioFile(url, fallbackUrl: fallbackUrl);
        await player.play(DeviceFileSource(file.path));
        emit(state.copyWith(
          audioLoadingKey: null,
          audioLoadingUrl: null,
          isPlaying: true,
        ));
      } catch (e) {
        emit(state.copyWith(
          audioLoadingKey: null,
          audioLoadingUrl: null,
          isPlaying: false,
          audioError:
              'Audio could not be loaded. Please check your internet connection or try another network.',
        ));
      }
      return;
    }

    // Same ayah: toggle pause/resume
    try {
      emit(state.copyWith(audioError: ''));
      if (state.isPlaying) {
        await player.pause();
        emit(state.copyWith(isPlaying: false));
      } else {
        await player.resume();
        emit(state.copyWith(isPlaying: true));
      }
    } catch (e) {
      emit(state.copyWith(
        isPlaying: false,
        audioError:
            'Audio could not be loaded. Please check your internet connection or try another network.',
      ));
    }
  }

  Future<void> seekAudio(Duration position) async {
    await player.seek(position);
  }

  Future<void> updateArabicFontSize(double size) async {
    emit(state.copyWith(arabicFontSize: size));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('arabicFontSize', size);
  }

  Future<void> updateTranslationFontSize(double size) async {
    emit(state.copyWith(translationFontSize: size));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('translationFontSize', size);
  }

  Future<void> updateNightMode(bool enabled) async {
    emit(state.copyWith(nightMode: enabled));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('nightMode', enabled);
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final arabicSize = prefs.getDouble('arabicFontSize') ?? 26.0;
    final translationSize = prefs.getDouble('translationFontSize') ?? 16.0;
    final night = prefs.getBool('nightMode') ?? false;
    emit(state.copyWith(
      arabicFontSize: arabicSize,
      translationFontSize: translationSize,
      nightMode: night,
    ));
  }

  Future<void> loadBookmarks() async {
    final allBookmarks = await dbHelper.getBookmarks();
    final keys =
    allBookmarks.map((b) => '${b['surahNumber']}:${b['ayahNumber']}').toSet();
    emit(state.copyWith(bookmarks: keys));
  }

  Future<void> saveLastRead() async {
    // Defaulting to Ayah 1 when opening the Surah
    await dbHelper.saveLastRead(surahNumber, 1, surahName);
    await dbHelper.addReadingHistory(surahNumber, surahName);
  }

  Future<void> toggleBookmark(Map<String, dynamic> ayah) async {
    final key = '${surahNumber}:${ayah['numberInSurah']}';
    final isBookmarked = state.bookmarks.contains(key);

    final newBookmarks = Set<String>.from(state.bookmarks);

    if (isBookmarked) {
      await dbHelper.removeBookmark(surahNumber, ayah['numberInSurah']);
      newBookmarks.remove(key);
    } else {
      await dbHelper.addBookmark({
        'surahNumber': surahNumber,
        'ayahNumber': ayah['numberInSurah'],
        'ayahText': ayah['text'],
        'audioUrl': ayah['audio'],
      });
      newBookmarks.add(key);
    }

    emit(state.copyWith(bookmarks: newBookmarks));
  }

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}
