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


class AyahCubit extends Cubit<AyahState> {
  final int surahNumber;
  final DatabaseHelper dbHelper;
  final AyahRepository repository;
  final AudioPlayer player = AudioPlayer();

  AyahCubit({
    required this.surahNumber,
    required this.dbHelper,
    required this.repository,
  }) : super(const AyahState()) {
    player.setReleaseMode(ReleaseMode.stop);
    fetchAyahs();
    loadBookmarks();

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

  Future<void> loadBookmarks() async {
    final allBookmarks = await dbHelper.getBookmarks();
    final keys =
    allBookmarks.map((b) => '${b['surahNumber']}:${b['ayahNumber']}').toSet();
    emit(state.copyWith(bookmarks: keys));
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
