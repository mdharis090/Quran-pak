import 'dart:convert';
import 'package:http/http.dart' as http;

class AyahRepository {
  Future<List<Map<String, dynamic>>> fetchAyahs(int surahNumber) async {
    final res = await http.get(Uri.parse(
        'https://api.alquran.cloud/v1/surah/$surahNumber/editions/quran-uthmani,ar.alafasy'));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final arabicAyahs = data['data'][0]['ayahs'];
      final audioAyahs = data['data'][1]['ayahs'];

      final ayahs = List.generate(arabicAyahs.length, (index) {
        return {
          'text': arabicAyahs[index]['text'],
          'audio': audioAyahs[index]['audio'],
          'numberInSurah': arabicAyahs[index]['numberInSurah'],
        };
      });

      return ayahs;
    } else {
      throw Exception('Failed to fetch Ayahs');
    }
  }
}
