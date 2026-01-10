import 'package:equatable/equatable.dart';

class AyahState extends Equatable {
  final bool loading;
  final List ayahs;
  final Set<String> bookmarks;
  final String error;

  const AyahState({
    this.loading = true,
    this.ayahs = const [],
    this.bookmarks = const {},
    this.error = '',
  });

  AyahState copyWith({
    bool? loading,
    List? ayahs,
    Set<String>? bookmarks,
    String? error,
  }) {
    return AyahState(
      loading: loading ?? this.loading,
      ayahs: ayahs ?? this.ayahs,
      bookmarks: bookmarks ?? this.bookmarks,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loading, ayahs, bookmarks, error];
}
