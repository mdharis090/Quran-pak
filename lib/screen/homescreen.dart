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
// }
import 'package:flutter/material.dart';
import 'package:quranpak/database/database_helper.dart';
import 'package:quranpak/screen/ayahbloc/ayah_screen.dart';
import 'bookmarkbloc/bookmark_screen.dart';
import 'surah_list_screen.dart';
import 'juz_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 🌿 Background Gradient Decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🕌 Header Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu, color: theme.colorScheme.primary, size: 28),
                          Text(
                            'Quran Pak',
                            style: theme.textTheme.titleLarge,
                          ),
                          Icon(Icons.notifications_none,
                              color: theme.colorScheme.primary, size: 28),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              const Color(0xFF006B5C),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Last Read',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.book, color: Colors.white, size: 20),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Continue Reading',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                final db = DatabaseHelper();
                                final lastRead = await db.getLastRead();

                                if (context.mounted) {
                                  if (lastRead != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AyahScreen(
                                          surahNumber: lastRead['surahNumber'],
                                          surahName: lastRead['surahName'],
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('No recent reading found.')),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.secondary,
                                foregroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              child: const Text(
                                'Resume ➔',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 📂 Menu Grid
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                      children: [
                        _menuCard(
                          context,
                          title: 'Surah Index',
                          icon: Icons.menu_book_rounded,
                          color: const Color(0xFFE8F5E9),
                          accent: theme.colorScheme.primary,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SurahListScreen()),
                          ),
                        ),
                        _menuCard(
                          context,
                          title: 'Juz Index',
                          icon: Icons.format_list_numbered_rounded,
                          color: const Color(0xFFFFF8E1),
                          accent: Colors.orange.shade800,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const JuzListScreen()),
                          ),
                        ),
                        _menuCard(
                          context,
                          title: 'Bookmarks',
                          icon: Icons.bookmark_rounded,
                          color: const Color(0xFFF3E5F5),
                          accent: Colors.purple,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const BookmarkScreen()),
                          ),
                        ),
                        _menuCard(
                          context,
                          title: 'Settings',
                          icon: Icons.settings,
                          color: const Color(0xFFE3F2FD),
                          accent: Colors.blue.shade800,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SettingsScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required Color accent,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.black.withOpacity(0.03)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: accent),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
