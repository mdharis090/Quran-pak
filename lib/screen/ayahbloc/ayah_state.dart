// import 'package:equatable/equatable.dart';
//
// class AyahState extends Equatable {
//   final bool loading;
//   final List ayahs;
//   final Set<String> bookmarks;
//   final String error;
//
//   const AyahState({
//     this.loading = true,
//     this.ayahs = const [],
//     this.bookmarks = const {},
//     this.error = '',
//   });
//
//   AyahState copyWith({
//     bool? loading,
//     List? ayahs,
//     Set<String>? bookmarks,
//     String? error,
//   }) {
//     return AyahState(
//       loading: loading ?? this.loading,
//       ayahs: ayahs ?? this.ayahs,
//       bookmarks: bookmarks ?? this.bookmarks,
//       error: error ?? this.error,
//     );
//   }
//
//   @override
//   List<Object?> get props => [loading, ayahs, bookmarks, error];
// }
import 'package:equatable/equatable.dart';

class AyahState extends Equatable {
  final bool loading;
  final List ayahs;
  final Set<String> bookmarks;
  final String error;

  final String? playingUrl;
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  const AyahState({
    this.loading = true,
    this.ayahs = const [],
    this.bookmarks = const {},
    this.error = '',
    this.playingUrl,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
  });

  AyahState copyWith({
    bool? loading,
    List? ayahs,
    Set<String>? bookmarks,
    String? error,
    String? playingUrl,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
  }) {
    return AyahState(
      loading: loading ?? this.loading,
      ayahs: ayahs ?? this.ayahs,
      bookmarks: bookmarks ?? this.bookmarks,
      error: error ?? this.error,
      playingUrl: playingUrl ?? this.playingUrl,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props =>
      [loading, ayahs, bookmarks, error, playingUrl, position, duration, isPlaying];
}
