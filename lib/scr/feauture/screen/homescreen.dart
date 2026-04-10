//
// import 'package:flutter/material.dart';
//
// import 'bookmarkbloc/bookmark_screen.dart';
// import 'surah_list_screen.dart';
// import 'juz_list_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         title: const Text('Quran Pak'),
//         centerTitle: true,
//         backgroundColor: Colors.green.shade700,
//         foregroundColor: Colors.white,
//         elevation: 6,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.green.shade400, Colors.green.shade200],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 8,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: const Column(
//                 children: [
//                   Text(
//                     '﷽',
//                     style: TextStyle(fontSize: 36),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'Read Quran Daily',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     'Keep your heart connected with the Quran every day',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 40),
//
//             // 🔘 MENU GRID (Column-wise)
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2, // 2 columns
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 children: [
//                   _menuCard(
//                     image: 'Surah.png',
//                     icon: Icons.play_circle_fill,
//                     title: 'Resume',
//                     color: Colors.orange.shade400,
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (_)=> BookmarkScreen())
//                       );
//                     },
//                   ),
//                   _menuCard(
//                     image: 'Surah.png',
//                     icon: Icons.menu_book,
//                     title: 'Juz Index',
//                     color: Colors.green.shade400,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const JuzListScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   _menuCard(
//                     image: 'Surah.png',
//                     icon: Icons.library_books,
//                     title: 'Surah Index',
//                     color: Colors.blue.shade400,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const SurahListScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   _menuCard(
//                     image: 'Surah.png',
//                     icon: Icons.bookmark,
//                     title: 'Bookmarks',
//                     color: Colors.purple.shade400,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const BookmarkScreen()),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _menuCard({
//     required IconData icon,
//     required String image,
//     required String title,
//     required VoidCallback onTap,
//     required Color color,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 6,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.white),
//             const SizedBox(height: 12),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:quranpak/database/database_helper.dart';
// import 'package:quranpak/screen/ayahbloc/ayah_screen.dart';
// import 'bookmarkbloc/bookmark_screen.dart';
// import 'surah_list_screen.dart';
// import 'juz_list_screen.dart';
// import 'settings_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> last10Surahs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLast10Surahs();
//   }
//
//   Future<void> _loadLast10Surahs() async {
//     final db = DatabaseHelper();
//     final surahs = await db.getLast10Surahs();
//     if (mounted) {
//       setState(() {
//         last10Surahs = surahs;
//       });
//     }
//   }
//
//   // Manzil data (7 manzils)
//   final List<Map<String, String>> manzils = const [
//     {'number': '1', 'name': 'Al-Fatiha to Al-Baqarah 2:141'},
//     {'number': '2', 'name': 'Al-Baqarah 2:142 to Al-Baqarah 2:252'},
//     {'number': '3', 'name': 'Al-Baqarah 2:253 to An-Nisa 4:23'},
//     {'number': '4', 'name': 'An-Nisa 4:24 to Al-Ma\'idah 5:81'},
//     {'number': '5', 'name': 'Al-Ma\'idah 5:82 to Al-A\'raf 7:87'},
//     {'number': '6', 'name': 'Al-A\'raf 7:88 to At-Tawbah 9:92'},
//     {'number': '7', 'name': 'At-Tawbah 9:93 to An-Nas 114:6'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: Stack(
//         children: [
//           // 🌿 Background Gradient Decoration
//           Positioned(
//             top: -100,
//             right: -100,
//             child: Container(
//               width: 300,
//               height: 300,
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.primary.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 100,
//             left: -50,
//             child: Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.secondary.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//
//           SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 🕌 Header Section
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.menu, color: theme.colorScheme.primary, size: 28),
//                           Text(
//                             'Quran Pak',
//                             style: theme.textTheme.titleLarge,
//                           ),
//                           Icon(Icons.notifications_none,
//                               color: theme.colorScheme.primary, size: 28),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               theme.colorScheme.primary,
//                               const Color(0xFF006B5C),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(24),
//                           boxShadow: [
//                             BoxShadow(
//                               color: theme.colorScheme.primary.withOpacity(0.4),
//                               blurRadius: 12,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Last Read',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Icon(Icons.book, color: Colors.white, size: 20),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             const Text(
//                               'Continue Reading',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 final db = DatabaseHelper();
//                                 final lastRead = await db.getLastRead();
//
//                                 if (context.mounted) {
//                                   if (lastRead != null) {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => AyahScreen(
//                                           surahNumber: lastRead['surahNumber'],
//                                           surahName: lastRead['surahName'],
//                                         ),
//                                       ),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text('No recent reading found.')),
//                                     );
//                                   }
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: theme.colorScheme.secondary,
//                                 foregroundColor: theme.colorScheme.primary,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 24, vertical: 12),
//                               ),
//                               child: const Text(
//                                 'Resume ➔',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // 📂 Scrollable Content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                         // Manzil Container
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           margin: const EdgeInsets.only(bottom: 16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.04),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(Icons.layers,
//                                       color: theme.colorScheme.primary),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Manzil',
//                                     style: theme.textTheme.titleLarge?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               SizedBox(
//                                 height: 120,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: manzils.length,
//                                   itemBuilder: (context, index) {
//                                     final manzil = manzils[index];
//                                     return Container(
//                                       width: 140,
//                                       margin: const EdgeInsets.only(right: 12),
//                                       padding: const EdgeInsets.all(12),
//                                       decoration: BoxDecoration(
//                                         color: theme.colorScheme.primary
//                                             .withOpacity(0.1),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             'Manzil ${manzil['number']}',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: theme.colorScheme.primary,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             manzil['name']!,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: Colors.grey.shade700,
//                                             ),
//                                             maxLines: 3,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // Last 10 Surahs Container
//                         if (last10Surahs.isNotEmpty)
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             margin: const EdgeInsets.only(bottom: 16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.04),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(Icons.history,
//                                         color: theme.colorScheme.primary),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       'Last 10 Surahs',
//                                       style: theme.textTheme.titleLarge
//                                           ?.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 SizedBox(
//                                   height: 100,
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: last10Surahs.length,
//                                     itemBuilder: (context, index) {
//                                       final surah = last10Surahs[index];
//                                       return GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (_) => AyahScreen(
//                                                 surahNumber:
//                                                     surah['surahNumber'],
//                                                 surahName: surah['surahName'],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: Container(
//                                           width: 100,
//                                           margin:
//                                               const EdgeInsets.only(right: 12),
//                                           padding: const EdgeInsets.all(12),
//                                           decoration: BoxDecoration(
//                                             color: theme.colorScheme.secondary
//                                                 .withOpacity(0.1),
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 'Surah ${surah['surahNumber']}',
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: theme
//                                                       .colorScheme.secondary,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 4),
//                                               Text(
//                                                 surah['surahName'],
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: Colors.grey.shade700,
//                                                 ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                         // Menu Grid
//                         GridView.count(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 16,
//                           mainAxisSpacing: 16,
//                           childAspectRatio: 0.9,
//                           children: [
//                             _menuCard(
//                               context,
//                               title: 'Surah Index',
//                               icon: Icons.menu_book_rounded,
//                               color: const Color(0xFFE8F5E9),
//                               accent: theme.colorScheme.primary,
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => const SurahListScreen()),
//                               ),
//                             ),
//                             _menuCard(
//                               context,
//                               title: 'Juz Index',
//                               icon: Icons.format_list_numbered_rounded,
//                               color: const Color(0xFFFFF8E1),
//                               accent: Colors.orange.shade800,
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => const JuzListScreen()),
//                               ),
//                             ),
//                             _menuCard(
//                               context,
//                               title: 'Bookmarks',
//                               icon: Icons.bookmark_rounded,
//                               color: const Color(0xFFF3E5F5),
//                               accent: Colors.purple,
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => const BookmarkScreen()),
//                               ),
//                             ),
//                             _menuCard(
//                               context,
//                               title: 'Settings',
//                               icon: Icons.settings,
//                               color: const Color(0xFFE3F2FD),
//                               accent: Colors.blue.shade800,
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => const SettingsScreen()),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 ),],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _menuCard(BuildContext context,
//       {required String title,
//       required IconData icon,
//       required Color color,
//       required Color accent,
//       required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//           border: Border.all(color: Colors.black.withOpacity(0.03)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, size: 32, color: accent),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:quranpak/database/database_helper.dart';
// import 'package:quranpak/screen/ayahbloc/ayah_screen.dart';
// import '../muzail/ManzilDetailScreen.dart';
// import 'bookmarkbloc/bookmark_screen.dart';
// import 'surah_list_screen.dart';
// import 'juz_list_screen.dart';
// import 'settings_screen.dart';
// // Make sure to create this screen
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> last10Surahs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLast10Surahs();
//   }
//
//   Future<void> _loadLast10Surahs() async {
//     final db = DatabaseHelper();
//     final surahs = await db.getLast10Surahs();
//     if (mounted) {
//       setState(() {
//         last10Surahs = surahs;
//       });
//     }
//   }
//
//   // Last 10 Surahs of the Quran (Al-Fil to An-Nas)
//   final List<Map<String, dynamic>> last10QuranSurahs = const [
//     {'number': 105, 'name': 'Al-Fil'},
//     {'number': 106, 'name': 'Quraish'},
//     {'number': 107, 'name': 'Al-Ma\'un'},
//     {'number': 108, 'name': 'Al-Kauthar'},
//     {'number': 109, 'name': 'Al-Kafirun'},
//     {'number': 110, 'name': 'An-Nasr'},
//     {'number': 111, 'name': 'Al-Masad'},
//     {'number': 112, 'name': 'Al-Ikhlas'},
//     {'number': 113, 'name': 'Al-Falaq'},
//     {'number': 114, 'name': 'An-Nas'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header + Last Read Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(Icons.menu, color: theme.colorScheme.primary, size: 28),
//                       Text('Quran Pak', style: theme.textTheme.titleLarge),
//                       Icon(Icons.notifications_none, color: theme.colorScheme.primary, size: 28),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [theme.colorScheme.primary, const Color(0xFF006B5C)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: theme.colorScheme.primary.withOpacity(0.4),
//                           blurRadius: 12,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Last Read', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
//                             Icon(Icons.book, color: Colors.white, size: 20),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         const Text('Continue Reading', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () async {
//                             final db = DatabaseHelper();
//                             final lastRead = await db.getLastRead();
//                             if (context.mounted) {
//                               if (lastRead != null) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => AyahScreen(
//                                       surahNumber: lastRead['surahNumber'],
//                                       surahName: lastRead['surahName'],
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('No recent reading found.')),
//                                 );
//                               }
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: theme.colorScheme.secondary,
//                             foregroundColor: theme.colorScheme.primary,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                           ),
//                           child: const Text('Resume ➔', style: TextStyle(fontWeight: FontWeight.bold)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // Scrollable content
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Unified Manzil Section (One Page)
//                       _buildManzilSection(theme),
//
//                       const SizedBox(height: 16),
//
//                       // Last 10 Quran Surahs Section
//                       _buildLast10QuranSurahsSection(theme),
//
//                       const SizedBox(height: 16),
//
//                       // Reading History (Last 10 Surahs Read)
//                       if (last10Surahs.isNotEmpty) _buildLast10SurahsSection(theme),
//
//                       const SizedBox(height: 16),
//
//                       // Menu Grid
//                       _buildMenuGrid(theme),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildManzilSection(ThemeData theme) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const ManzilDetailScreen()),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [theme.colorScheme.primary.withOpacity(0.8), theme.colorScheme.primary],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: theme.colorScheme.primary.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.auto_stories, color: Colors.white, size: 32),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Unified Manzil',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Read all 7 Manzils on one page',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.8),
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLast10QuranSurahsSection(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(Icons.stars, color: theme.colorScheme.secondary),
//             const SizedBox(width: 8),
//             Text('Last 10 Quran Surahs', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 110,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: last10QuranSurahs.length,
//             itemBuilder: (context, index) {
//               final surah = last10QuranSurahs[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => AyahScreen(surahNumber: surah['number'], surahName: surah['name']),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 120,
//                   margin: const EdgeInsets.only(right: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: theme.colorScheme.secondary.withOpacity(0.1)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.04),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 12,
//                         backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
//                         child: Text(
//                           '${surah['number']}',
//                           style: TextStyle(fontSize: 10, color: theme.colorScheme.secondary, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         surah['name'],
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLast10SurahsSection(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(Icons.history, color: theme.colorScheme.primary),
//             const SizedBox(width: 8),
//             Text('Last 10 Surahs', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
//           ],
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: last10Surahs.length,
//             itemBuilder: (context, index) {
//               final surah = last10Surahs[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => AyahScreen(surahNumber: surah['surahNumber'], surahName: surah['surahName']),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 100,
//                   margin: const EdgeInsets.only(right: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.secondary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Surah ${surah['surahNumber']}', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.secondary, fontSize: 14)),
//                       const SizedBox(height: 4),
//                       Text(surah['surahName'], textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey.shade700), maxLines: 2, overflow: TextOverflow.ellipsis),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMenuGrid(ThemeData theme) {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       childAspectRatio: 0.9,
//       children: [
//         _menuCard(context, title: 'Surah Index', icon: Icons.menu_book_rounded, color: const Color(0xFFE8F5E9), accent: theme.colorScheme.primary, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SurahListScreen()))),
//         _menuCard(context, title: 'Juz Index', icon: Icons.format_list_numbered_rounded, color: const Color(0xFFFFF8E1), accent: Colors.orange.shade800, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JuzListScreen()))),
//         _menuCard(context, title: 'Bookmarks', icon: Icons.bookmark_rounded, color: const Color(0xFFF3E5F5), accent: Colors.purple, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookmarkScreen()))),
//         _menuCard(context, title: 'Settings', icon: Icons.settings, color: const Color(0xFFE3F2FD), accent: Colors.blue.shade800, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
//       ],
//     );
//   }
//
//   Widget _menuCard(BuildContext context, {required String title, required IconData icon, required Color color, required Color accent, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
//           border: Border.all(color: Colors.black.withOpacity(0.03)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//               child: Icon(icon, size: 32, color: accent),
//             ),
//             const SizedBox(height: 16),
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
//           ],
//         ),
//       ),
//     );
//   }
// }