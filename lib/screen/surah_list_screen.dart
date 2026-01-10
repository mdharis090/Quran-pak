// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'ayzt_screen.dart';
//
//
//
// class SurahListScreen extends StatefulWidget {
//   const SurahListScreen({super.key});
//
//   @override
//   State<SurahListScreen> createState() => _SurahListScreenState();
// }
//
// class _SurahListScreenState extends State<SurahListScreen> {
//   List surahs = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchSurahs();
//   }
//
//   Future<void> fetchSurahs() async {
//     final res =
//     await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));
//
//     if (res.statusCode == 200) {
//       final data = json.decode(res.body);
//       setState(() {
//         surahs = data['data'];
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quran Pak '),
//         centerTitle: true,
//         backgroundColor: Colors.green.shade700,
//         elevation: 4,
//         foregroundColor: Colors.white,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: surahs.length,
//         itemBuilder: (context, index) {
//           final surah = surahs[index];
//           return ListTile(
//             leading: CircleAvatar(
//               child: Text(surah['number'].toString()),
//             ),
//             title: Text(surah['englishName']),
//             subtitle: Text(surah['name']),
//             trailing: Text('${surah['numberOfAyahs']} Ayahs'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => AyahScreen(
//                     surahNumber: surah['number'],
//                     surahName: surah['englishName'],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ayzt_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  List surahs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    final res =
    await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      setState(() {
        surahs = data['data'];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah List'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        elevation: 4,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AyahScreen(
                      surahNumber: surah['number'],
                      surahName: surah['englishName'],
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade200
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.green.shade800,
                      child: Text(
                        surah['number'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surah['englishName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            surah['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${surah['numberOfAyahs']} Ayahs',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
