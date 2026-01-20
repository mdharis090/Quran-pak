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

import 'bookmarkbloc/bookmark_screen.dart';
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

            /// 🔰 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade200],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Text('﷽', style: TextStyle(fontSize: 36)),
                  SizedBox(height: 12),
                  Text(
                    'Read Quran Daily',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),


            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _menuCard(
                    imagePath: 'assets/resum.png',
                    title: 'Resume',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookmarkScreen(),
                        ),
                      );
                    },
                  ),
                  _menuCard(
                    imagePath: 'assets/juz.png',
                    title: 'Juz Index',
                    color: Colors.green,
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
                    imagePath: 'assets/Surah.png',
                    title: 'Surah Index',
                    color: Colors.blue,
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
                    imagePath: 'assets/book.png',
                    title: 'Bookmarks',
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookmarkScreen(),
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
    required String imagePath,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
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
            Container(
              height: 85,
              width: 85,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),

            //   Image.asset(
          //     imagePath,
          //     height: 48,
          //     width: 48,
          //     color: Colors.white,
          //   ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
