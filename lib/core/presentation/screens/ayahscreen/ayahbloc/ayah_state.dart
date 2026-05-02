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

  final String? playingKey;
  final String? playingUrl;
  final String? audioLoadingKey;
  final String? audioLoadingUrl;
  final String audioError;
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  // 🛠 Settings
  final double arabicFontSize;
  final double translationFontSize;
  final bool nightMode;

  const AyahState({
    this.loading = true,
    this.ayahs = const [],
    this.bookmarks = const {},
    this.error = '',
    this.playingKey,
    this.playingUrl,
    this.audioLoadingKey,
    this.audioLoadingUrl,
    this.audioError = '',
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.arabicFontSize = 26.0,
    this.translationFontSize = 16.0,
    this.nightMode = false,
  });

  AyahState copyWith({
    bool? loading,
    List? ayahs,
    Set<String>? bookmarks,
    String? error,
    String? playingKey,
    String? playingUrl,
    String? audioLoadingKey,
    String? audioLoadingUrl,
    String? audioError,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    double? arabicFontSize,
    double? translationFontSize,
    bool? nightMode,
  }) {
    return AyahState(
      loading: loading ?? this.loading,
      ayahs: ayahs ?? this.ayahs,
      bookmarks: bookmarks ?? this.bookmarks,
      error: error ?? this.error,
      playingKey: playingKey ?? this.playingKey,
      playingUrl: playingUrl ?? this.playingUrl,
      audioLoadingKey: audioLoadingKey ?? this.audioLoadingKey,
      audioLoadingUrl: audioLoadingUrl ?? this.audioLoadingUrl,
      audioError: audioError ?? this.audioError,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
      translationFontSize: translationFontSize ?? this.translationFontSize,
      nightMode: nightMode ?? this.nightMode,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        ayahs,
        bookmarks,
        error,
        playingKey,
        playingUrl,
        audioLoadingKey,
        audioLoadingUrl,
        audioError,
        position,
        duration,
        isPlaying,
        arabicFontSize,
        translationFontSize,
        nightMode,
      ];
}
