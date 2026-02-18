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
import '../../api/ayah_repository.dart';
import '../../database/database_helper.dart';
import 'ayah_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      emit(this.state.copyWith(isPlaying: false, position: Duration.zero, playingUrl: null));
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

  Future<void> playPauseAudio(String url) async {
    if (state.playingUrl != url) {
      // Different ayah clicked
      await player.stop();
      await player.play(UrlSource(url));
      emit(state.copyWith(playingUrl: url, isPlaying: true));
    } else {
      if (state.isPlaying) {
        await player.pause();
        emit(state.copyWith(isPlaying: false));
      } else {
        await player.resume();
        emit(state.copyWith(isPlaying: true));
      }
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

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final arabicSize = prefs.getDouble('arabicFontSize') ?? 26.0;
    final translationSize = prefs.getDouble('translationFontSize') ?? 16.0;
    emit(state.copyWith(
      arabicFontSize: arabicSize,
      translationFontSize: translationSize,
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
