import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quranpak/core/data/model/manzil_model.dart';
import 'package:quranpak/core/data/model/surah_model.dart';

final manzilProvider = Provider<List<Manzil>>((ref) {
  return [
    Manzil(
      number: '1',
      name: 'Al-Fatiha to Al-Baqarah 2:141',
      surahs: [
        Surah(number: 1, name: 'Al-Fatiha'),
        Surah(number: 2, name: 'Al-Baqarah'),
      ],
    ),
    Manzil(
      number: '2',
      name: 'Al-Baqarah 2:142 to 2:252',
      surahs: [
        Surah(number: 2, name: 'Al-Baqarah'),
      ],
    ),
    // 👉 baqi same pattern copy paste kar do
  ];
});