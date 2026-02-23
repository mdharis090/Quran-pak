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
import 'package:shared_preferences/shared_preferences.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _saveScrollPosition() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('surah_list_scroll_position', _scrollController.offset);
  }

  Future<void> _restoreScrollPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final double? savedOffset = prefs.getDouble('surah_list_scroll_position');
    if (savedOffset != null && _scrollController.hasClients) {
      _scrollController.jumpTo(savedOffset);
    }
  }

  Future<void> fetchSurahs() async {
    final res = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      if (mounted) {
        setState(() {
          surahs = data['data'];
          filteredSurahs = surahs;
          loading = false;
        });
        // Restore scroll position after list is built
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _restoreScrollPosition(),
        );
      }
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Surah Index'),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar Container
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: TextField(
              onChanged: searchSurah,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search Surah...',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.colorScheme.primary,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // � List
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : filteredSurahs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Surah found',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
                : NotificationListener<ScrollEndNotification>(
                    onNotification: (notification) {
                      _saveScrollPosition();
                      return true;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      itemCount: filteredSurahs.length,
                      itemBuilder: (context, index) {
                        final surah = filteredSurahs[index];
                        return _buildSurahTile(context, surah);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahTile(BuildContext context, Map surah) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 🔢 Number Badge
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${surah['number']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // 📝 Names
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah['englishName'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${surah['englishNameTranslation']} • ${surah['numberOfAyahs']} Verses',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // 🕌 Arabic Name
                Text(
                  surah['name'],
                  style: const TextStyle(
                    fontFamily: 'Amiri',
                    // Ensure you have a font or use default
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004B40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
