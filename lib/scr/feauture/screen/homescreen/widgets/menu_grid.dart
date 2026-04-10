import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bookmarkbloc/bookmark_screen.dart';
import '../../juz_list_screen.dart';
import '../../settings_screen.dart';
import '../../surah_list_screen.dart';

class MenuGrid extends StatelessWidget {
  final ThemeData theme;

  const MenuGrid({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          onTap: () => context.push('/surah'),
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => const SurahListScreen()),
          // ),
        ),
        _menuCard(
          context,
          title: 'Juz Index',
          icon: Icons.format_list_numbered_rounded,
          color: const Color(0xFFFFF8E1),
          accent: Colors.orange.shade800,
          onTap: () => context.push('/juz'),
      
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => const JuzListScreen()),
          // ),
        ),
        _menuCard(
          context,
          title: 'Bookmarks',
          icon: Icons.bookmark_rounded,
          color: const Color(0xFFF3E5F5),
          accent: Colors.purple,
          onTap: () => context.push('/bookmark'),
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => const BookmarkScreen()),
          // ),
        ),
        _menuCard(
          context,
          title: 'Settings',
          icon: Icons.settings,
          color: const Color(0xFFE3F2FD),
          accent: Colors.blue.shade800,
          onTap: () => context.push('/setting'),
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => const SettingsScreen()),
          // ),
        ),
      ],
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Color accent,
    required VoidCallback onTap,
  }) {
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
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
