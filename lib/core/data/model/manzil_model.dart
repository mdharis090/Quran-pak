import 'package:quranpak/core/data/model/surah_model.dart';

class Manzil {
  final String number;
  final String name;
  final List<Surah> surahs;

  Manzil({
    required this.number,
    required this.name,
    required this.surahs,
  });
  Manzil copyWtih({
    String? number,
    String? name,
    List<Surah>? surahs,
  })
  {
    return Manzil(
      number: number?? this.number,
      name: name?? this.name,
      surahs: surahs??this.surahs
    );
  }
}