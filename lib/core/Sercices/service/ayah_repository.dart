// import 'package:dio/dio.dart';

// class AyahRepository {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://api.alquran.cloud/v1/',
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );

//   String _normalizeAudioUrl(String url) {
//     return url.replaceFirst('cdn.islmaic.network', 'cdn.islamic.network');
//   }

//   Future<List<Map<String, dynamic>>> fetchAyahs(int surahNumber) async {
//     try {
//       final response = await _dio.get(
//         'surah/$surahNumber/editions/quran-uthmani,ar.alafasy,ur.jalandhry',
//       );

//       final data = response.data;

//       final arabicAyahs = data['data'][0]['ayahs'];
//       final audioAyahs = data['data'][1]['ayahs'];
//       final urduAyahs = data['data'][2]['ayahs'];

//       final ayahs = List.generate(arabicAyahs.length, (index) {
//         final audioUrl = (audioAyahs[index]['audio'] ?? '').toString();

//         return {
//           'text': arabicAyahs[index]['text'],
//           'audio': _normalizeAudioUrl(audioUrl),
//           'translation': urduAyahs[index]['text'],
//           'numberInSurah': arabicAyahs[index]['numberInSurah'],
//         };
//       });

//       return ayahs;
//     } on DioException catch (e) {
//       throw Exception('Dio Error: ${e.message}');
//     } catch (e) {
//       throw Exception('Unexpected Error: $e');
//     }
//   }
// }