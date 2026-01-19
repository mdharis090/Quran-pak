part of 'bookmark_cubit.dart';

class BookmarkState extends Equatable {
  final List<Map<String, dynamic>> bookmarks;
  final String? playingUrl;
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  const BookmarkState({
    this.bookmarks = const [],
    this.playingUrl,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
  });

  BookmarkState copyWith({
    List<Map<String, dynamic>>? bookmarks,
    String? playingUrl,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      playingUrl: playingUrl ?? this.playingUrl,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [bookmarks, playingUrl, position, duration, isPlaying];
}
