//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'ayahbloc/ayah_screen.dart';
// import 'ayzt_screen.dart';
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
//         title: const Text('Surah List'),
//         centerTitle: true,
//         backgroundColor: Colors.green.shade700,
//         elevation: 4,
//         foregroundColor: Colors.white,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView.builder(
//           itemCount: surahs.length,
//           itemBuilder: (context, index) {
//             final surah = surahs[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => AyahScreen(
//                       surahNumber: surah['number'],
//                       surahName: surah['englishName'],
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.green.shade400,
//                       Colors.green.shade200
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 6,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 24,
//                       backgroundColor: Colors.green.shade800,
//                       child: Text(
//                         surah['number'].toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             surah['englishName'],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             surah['name'],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white70,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '${surah['numberOfAyahs']} Ayahs',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ayahbloc/ayah_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  List surahs = [];
  List filteredSurahs = [];
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
        filteredSurahs = surahs;
        loading = false;
      });
    }
  }

  void searchSurah(String query) {
    final q = query.toLowerCase();

    setState(() {
      filteredSurahs = surahs.where((s) {
        return s['englishName'].toLowerCase().contains(q) ||
            s['name'].toLowerCase().contains(q) ||
            s['number'].toString().contains(q);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F6F4),
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Qur’an Surahs'),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // 🌙 Islamic Header
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.fromLTRB(16, 18, 16, 22),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: const [
                Text(
                  '﷽',
                  style:
                  TextStyle(fontSize: 36, color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  'Select a Surah to Continue Reading',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: searchSurah,
              decoration: InputDecoration(
                hintText: 'Search Surah name or number',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📜 SURAH LIST
          Expanded(
            child: filteredSurahs.isEmpty
                ? const Center(child: Text('No Surah Found'))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16),
              itemCount: filteredSurahs.length,
              itemBuilder: (context, index) {
                final surah = filteredSurahs[index];

                return Card(
                  elevation: 2,
                  margin:
                  const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AyahScreen(
                            surahNumber:
                            surah['number'],
                            surahName:
                            surah['englishName'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 23,
                            backgroundColor:
                            Colors.green.shade800,
                            child: Text(
                              surah['number']
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  surah[
                                  'englishName'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                    height: 4),
                                Text(
                                  surah['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .grey.shade700,
                                  ),
                                ),
                                const SizedBox(
                                    height: 4),
                                Text(
                                  '${surah['numberOfAyahs']} Ayahs',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors
                                        .grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons
                                .chevron_right_rounded,
                            color:
                            Colors.green.shade700,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
