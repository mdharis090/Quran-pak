// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:audioplayers/audioplayers.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AyahScreen extends StatefulWidget {
//   final int surahNumber;
//   final String surahName;
//
//   const AyahScreen({
//     super.key,
//     required this.surahNumber,
//     required this.surahName,
//   });
//
//   @override
//   State<AyahScreen> createState() => _AyahScreenState();
// }
//
// class _AyahScreenState extends State<AyahScreen> {
//   List ayahs = [];
//   bool loading = true;
//
//   final AudioPlayer player = AudioPlayer();
//
//   Set<String> bookmarks = {};
//
//   @override
//   void initState() {
//     super.initState();
//     player.setReleaseMode(ReleaseMode.stop);
//     fetchAyahs();
//     loadBookmarks();
//   }
//
//   // 🔊 Quran Text + Audio
//   Future<void> fetchAyahs() async {
//     final res = await http.get(
//       Uri.parse(
//         'https://api.alquran.cloud/v1/surah/${widget.surahNumber}/editions/quran-uthmani,ar.alafasy',
//       ),
//     );
//
//     if (res.statusCode == 200) {
//       final data = json.decode(res.body);
//
//       final arabicAyahs = data['data'][0]['ayahs'];
//       final audioAyahs = data['data'][1]['ayahs'];
//
//       ayahs = List.generate(arabicAyahs.length, (index) {
//         return {
//           'text': arabicAyahs[index]['text'],
//           'audio': audioAyahs[index]['audio'],
//           'numberInSurah': arabicAyahs[index]['numberInSurah'],
//         };
//       });
//
//       setState(() => loading = false);
//     }
//   }
//
//   // ▶ PLAY AUDIO
//   Future<void> playAudio(String url) async {
//     try {
//       if (url.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Audio not available')),
//         );
//         return;
//       }
//
//       await player.stop();
//       await player.play(UrlSource(url));
//     } catch (e) {
//       debugPrint('Audio error: $e');
//     }
//   }
//
//   // ⭐ BOOKMARK
//   Future<void> loadBookmarks() async {
//     final prefs = await SharedPreferences.getInstance();
//     bookmarks = prefs.getStringList('bookmarks')?.toSet() ?? {};
//     setState(() {});
//   }
//
//   Future<void> toggleBookmark(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     bookmarks.contains(key)
//         ? bookmarks.remove(key)
//         : bookmarks.add(key);
//     await prefs.setStringList('bookmarks', bookmarks.toList());
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.surahName)),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: ayahs.length,
//         itemBuilder: (context, index) {
//           final ayah = ayahs[index];
//           final key =
//               '${widget.surahNumber}:${ayah['numberInSurah']}';
//
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     ayah['text'],
//                     textAlign: TextAlign.right,
//                     style: const TextStyle(fontSize: 22),
//                   ),
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.play_arrow),
//                         onPressed: () =>
//                             playAudio(ayah['audio']),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           bookmarks.contains(key)
//                               ? Icons.bookmark
//                               : Icons.bookmark_border,
//                           color: Colors.green,
//                         ),
//                         onPressed: () =>
//                             toggleBookmark(key),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'surah_list_screen.dart';
// import 'juz_list_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quran Pak'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//
//             // 🌙 HEADER
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade100,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Column(
//                 children: [
//                   Text(
//                     '﷽',
//                     style: TextStyle(fontSize: 28),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Read Quran Daily',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // 🔘 MENU ROW
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _menuCard(
//                   icon: Icons.play_circle_fill,
//                   title: 'Resume',
//                   onTap: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Resume feature coming soon'),
//                       ),
//                     );
//                   },
//                 ),
//                 _menuCard(
//                   icon: Icons.menu_book,
//                   title: 'Juz Index',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const JuzListScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 _menuCard(
//                   icon: Icons.library_books,
//                   title: 'Surah Index',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const SurahListScreen(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _menuCard({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 6),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Icon(icon, size: 36, color: Colors.green),
//               const SizedBox(height: 10),
//               Text(
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'surah_list_screen.dart';
import 'juz_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Quran Pak'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🌙 HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    '﷽',
                    style: TextStyle(fontSize: 36),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Read Quran Daily',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Keep your heart connected with the Quran every day',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 🔘 MENU GRID (Column-wise)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 columns
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _menuCard(
                    icon: Icons.play_circle_fill,
                    title: 'Resume',
                    color: Colors.orange.shade400,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Resume feature coming soon'),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    icon: Icons.menu_book,
                    title: 'Juz Index',
                    color: Colors.green.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const JuzListScreen(),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    icon: Icons.library_books,
                    title: 'Surah Index',
                    color: Colors.blue.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SurahListScreen(),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    icon: Icons.bookmark,
                    title: 'Bookmarks',
                    color: Colors.purple.shade400,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bookmarks feature coming soon'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
