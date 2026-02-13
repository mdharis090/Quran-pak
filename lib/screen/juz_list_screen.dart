//
// import 'package:flutter/material.dart';
// import 'juz_detail_screen.dart';
//
// class JuzListScreen extends StatelessWidget {
//   const JuzListScreen({super.key});
//
//   // List of Juz names / first Surah info
//   final List<String> juzNames = const [
//     'Al-Fatiha – Al-Baqarah 1:1',
//     'Al-Baqarah 142',
//     'Al-Baqarah 253',
//     'Al-Imran 93',
//     'An-Nisa 24',
//     'Al-Ma\'idah 82',
//     'Al-An\'am 111',
//     'Al-A\'raf 88',
//     'Al-Anfal 41',
//     'At-Tawbah 93',
//     'Hud 6',
//     'Yusuf 53',
//     'Al-Hijr 1',
//     'Al-Isra 1',
//     'Al-Kahf 75',
//     'Al-Anbiya 1',
//     'Al-Furqan 21',
//     'An-Naml 56',
//     'Al-Ankabut 46',
//     'Al-Azhab 31',
//     'Ya-Sin 28',
//     'Sad 1',
//     'Az-Zumar 32',
//     'Fussilat 47',
//     'Al-Ahqaf 1',
//     'Az-Zariyat 31',
//     'Al-Mujadila 1',
//     'Al-Mulk 1',
//     'An-Naba 1',
//     'An-Nas 1',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Juz Index'),
//         centerTitle: true,
//         backgroundColor: Colors.green.shade700,
//         foregroundColor: Colors.white,
//         elevation: 4,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView.builder(
//           itemCount: 30,
//           itemBuilder: (context, index) {
//             final juz = index + 1;
//             final name = juzNames[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => JuzDetailScreen(juzNumber: juz),
//                   ),
//                 );
//               },
//               child: Container(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.green.shade400, Colors.green.shade200],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 24,
//                       backgroundColor: Colors.green.shade800,
//                       child: Text(
//                         juz.toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Juz $juz',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               fontSize: 14,
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
// // }
// import 'package:flutter/material.dart';
// import 'juz_detail_screen.dart';
//
// class JuzListScreen extends StatelessWidget {
//   const JuzListScreen({super.key});
//
//   final List<String> juzNames = const [
//     'Al-Fatiha – Al-Baqarah 1:1',
//     'Al-Baqarah 142',
//     'Al-Baqarah 253',
//     'Al-Imran 93',
//     'An-Nisa 24',
//     'Al-Ma\'idah 82',
//     'Al-An\'am 111',
//     'Al-A\'raf 88',
//     'Al-Anfal 41',
//     'At-Tawbah 93',
//     'Hud 6',
//     'Yusuf 53',
//     'Al-Hijr 1',
//     'Al-Isra 1',
//     'Al-Kahf 75',
//     'Al-Anbiya 1',
//     'Al-Furqan 21',
//     'An-Naml 56',
//     'Al-Ankabut 46',
//     'Al-Ahzab 31',
//     'Ya-Sin 28',
//     'Sad 1',
//     'Az-Zumar 32',
//     'Fussilat 47',
//     'Al-Ahqaf 1',
//     'Az-Zariyat 31',
//     'Al-Mujadila 1',
//     'Al-Mulk 1',
//     'An-Naba 1',
//     'An-Nas 1',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7F6),
//       appBar: AppBar(
//         title: const Text('Juz Index'),
//         centerTitle: true,
//         backgroundColor: Colors.green.shade800,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           final juz = index + 1;
//
//           return Card(
//             elevation: 3,
//             margin: const EdgeInsets.only(bottom: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => JuzDetailScreen(juzNumber: juz),
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(14),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 48,
//                       width: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade700,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           juz.toString(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Juz $juz',
//                             style: const TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             juzNames[index],
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey.shade700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                       color: Colors.green.shade700,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'juz_detail_screen.dart';
//
// class JuzListScreen extends StatelessWidget {
//   const JuzListScreen({super.key});
//
//   final List<String> juzNames = const [
//     'Al-Fatiha – Al-Baqarah 1:1',
//     'Al-Baqarah 142',
//     'Al-Baqarah 253',
//     'Al-Imran 93',
//     'An-Nisa 24',
//     'Al-Ma\'idah 82',
//     'Al-An\'am 111',
//     'Al-A\'raf 88',
//     'Al-Anfal 41',
//     'At-Tawbah 93',
//     'Hud 6',
//     'Yusuf 53',
//     'Al-Hijr 1',
//     'Al-Isra 1',
//     'Al-Kahf 75',
//     'Al-Anbiya 1',
//     'Al-Furqan 21',
//     'An-Naml 56',
//     'Al-Ankabut 46',
//     'Al-Ahzab 31',
//     'Ya-Sin 28',
//     'Sad 1',
//     'Az-Zumar 32',
//     'Fussilat 47',
//     'Al-Ahqaf 1',
//     'Az-Zariyat 31',
//     'Al-Mujadila 1',
//     'Al-Mulk 1',
//     'An-Naba 1',
//     'An-Nas 1',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF3F6F4),
//       appBar: AppBar(
//         backgroundColor: Colors.green.shade900,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         title: const Text('Qur’an Juz'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // 🌙 Islamic Header
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
//             decoration: BoxDecoration(
//               color: Colors.green.shade900,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(28),
//                 bottomRight: Radius.circular(28),
//               ),
//             ),
//             child: Column(
//               children: const [
//                 Text(
//                   '﷽',
//                   style: TextStyle(
//                     fontSize: 36,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   'Select a Juz to Continue Reading',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // 🔍 Search Bar (UI ready)
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Juz...',
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//
//           // 📜 Juz List
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: 30,
//               itemBuilder: (context, index) {
//                 final juz = index + 1;
//
//                 return Card(
//                   elevation: 2,
//                   margin: const EdgeInsets.only(bottom: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(18),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               JuzDetailScreen(juzNumber: juz),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(14),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 46,
//                             width: 46,
//                             decoration: BoxDecoration(
//                               color: Colors.green.shade800,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 juz.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 17,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Juz $juz',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   juzNames[index],
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Icon(
//                             Icons.chevron_right_rounded,
//                             size: 26,
//                             color: Colors.green.shade700,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'juz_detail_screen.dart';

class JuzListScreen extends StatefulWidget {
  const JuzListScreen({super.key});

  @override
  State<JuzListScreen> createState() => _JuzListScreenState();
}

class _JuzListScreenState extends State<JuzListScreen> {
  final List<String> juzNames = const [
    'Al-Fatiha – Al-Baqarah 1:1',
    'Al-Baqarah 142',
    'Al-Baqarah 253',
    'Al-Imran 93',
    'An-Nisa 24',
    'Al-Ma\'idah 82',
    'Al-An\'am 111',
    'Al-A\'raf 88',
    'Al-Anfal 41',
    'At-Tawbah 93',
    'Hud 6',
    'Yusuf 53',
    'Al-Hijr 1',
    'Al-Isra 1',
    'Al-Kahf 75',
    'Al-Anbiya 1',
    'Al-Furqan 21',
    'An-Naml 56',
    'Al-Ankabut 46',
    'Al-Ahzab 31',
    'Ya-Sin 28',
    'Sad 1',
    'Az-Zumar 32',
    'Fussilat 47',
    'Al-Ahqaf 1',
    'Az-Zariyat 31',
    'Al-Mujadila 1',
    'Al-Mulk 1',
    'An-Naba 1',
    'An-Nas 1',
  ];

  late List<int> filteredIndexes;

  @override
  void initState() {
    super.initState();
    filteredIndexes =
        List.generate(juzNames.length, (index) => index);
  }

  void searchJuz(String query) {
    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredIndexes = List.generate(juzNames.length, (index) => index)
          .where((index) =>
      juzNames[index].toLowerCase().contains(lowerQuery) ||
          'juz ${index + 1}'.contains(lowerQuery))
          .toList();
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
        title: const Text('Qur’an Juz'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🌙 Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
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
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  'Select a Juz to Continue Reading',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // 🔍 SEARCH BAR (WORKING)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: searchJuz,
              decoration: InputDecoration(
                hintText: 'Search Juz or Surah name',
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

          // 📜 LIST
          Expanded(
            child: filteredIndexes.isEmpty
                ? const Center(
              child: Text(
                'No Juz Found',
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredIndexes.length,
              itemBuilder: (context, i) {
                final index = filteredIndexes[i];
                final juz = index + 1;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              JuzDetailScreen(juzNumber: juz),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 23,
                            backgroundColor:
                            Colors.green.shade800,
                            child: Text(
                              juz.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Juz $juz',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  juzNames[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                    Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.green.shade700,
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
