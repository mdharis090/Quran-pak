import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quranpak/core/data/datasource/database_helper.dart';
import 'package:quranpak/core/data/repository/surah_repository_impl.dart';

final databaseProvider = Provider((ref) => DatabaseHelper());

final surahRepoProvider = Provider<SurahRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return SurahRepositoryImpl(db);
});

final last10SurahsProvider = FutureProvider((ref) {
  final repo = ref.watch(surahRepoProvider);
  return repo.getLast10Surahs();
});

final lastReadProvider = FutureProvider((ref) {
  final repo = ref.watch(surahRepoProvider);
  return repo.getLastRead();
});