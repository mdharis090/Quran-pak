import 'package:quranpak/core/data/datasource/database_helper.dart';
import 'package:quranpak/core/data/model/surah_model.dart';

class SurahRepositoryImpl implements SurahRepository {
  final DatabaseHelper db;

  SurahRepositoryImpl(this.db);

  @override
  Future<List<Surah>> getLast10Surahs() async {
    final data = await db.getLast10Surahs();
    return data.map((e) => Surah.fromMap(e)).toList();
  }

  @override
  Future<Surah?> getLastRead() async {
    final data = await db.getLastRead();
    if (data == null) return null;
    return Surah.fromMap(data);
  }
}
///////abstrcted 
abstract class SurahRepository {
  Future<List<Surah>> getLast10Surahs();
  Future<Surah?> getLastRead();
}