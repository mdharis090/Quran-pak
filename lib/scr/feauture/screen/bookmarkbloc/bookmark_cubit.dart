import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../database/database_helper.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final DatabaseHelper dbHelper;
  final AudioPlayer player = AudioPlayer();

  BookmarkCubit({required this.dbHelper}) : super(const BookmarkState()) {
    player.setReleaseMode(ReleaseMode.stop);
    loadBookmarks();

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

  Future<void> loadBookmarks() async {
    final bookmarks = await dbHelper.getBookmarks();
    emit(state.copyWith(bookmarks: bookmarks));
  }

  Future<void> deleteBookmark(int surahNumber, int ayahNumber) async {
    await dbHelper.removeBookmark(surahNumber, ayahNumber);
    await loadBookmarks();
  }

  Future<void> playPauseAudio(String url) async {
    if (state.playingUrl != url) {
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

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}
