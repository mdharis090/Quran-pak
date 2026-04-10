import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quranpak/scr/feauture/database/database_helper.dart';
import 'package:quranpak/scr/feauture/screen/homescreen/widgets/last10_quran_surahs.dart';
import 'package:quranpak/scr/feauture/screen/homescreen/widgets/last10_surahs.dart';
import 'package:quranpak/scr/feauture/screen/homescreen/widgets/manzil_section.dart';
import 'package:quranpak/scr/feauture/screen/homescreen/widgets/menu_grid.dart';

import '../../ayahbloc/ayah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> last10Surahs = [];

  @override
  void initState() {
    super.initState();
    _loadLast10Surahs();
  }

  Future<void> _loadLast10Surahs() async {
    final db = DatabaseHelper();
    final surahs = await db.getLast10Surahs();
    if (mounted) {
      setState(() {
        last10Surahs = surahs;
      });
    }
  }

  final List<Map<String, dynamic>> last10QuranSurahs = const [
    {'number': 105, 'name': 'Al-Fil'},
    {'number': 106, 'name': 'Quraish'},
    {'number': 107, 'name': 'Al-Ma\'un'},
    {'number': 108, 'name': 'Al-Kauthar'},
    {'number': 109, 'name': 'Al-Kafirun'},
    {'number': 110, 'name': 'An-Nasr'},
    {'number': 111, 'name': 'Al-Masad'},
    {'number': 112, 'name': 'Al-Ikhlas'},
    {'number': 113, 'name': 'Al-Falaq'},
    {'number': 114, 'name': 'An-Nas'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header + Last Read Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
                      Text('Quran Pak', style: theme.textTheme.titleLarge),
                      Icon(
                        Icons.notifications_none,
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _lastReadCard(theme),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManzilSection(theme: theme),
                      const SizedBox(height: 16),
                      Last10QuranSurahsSection(
                        theme: theme,
                        surahs: last10QuranSurahs,
                      ),
                      const SizedBox(height: 16),
                      if (last10Surahs.isNotEmpty)
                        Last10SurahsSection(theme: theme, surahs: last10Surahs),
                      const SizedBox(height: 16),
                      MenuGrid(theme: theme),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lastReadCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, const Color(0xFF006B5C)],
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
                  context.push(
          '/ayah?name=${lastRead['surahName']}',
          extra: lastRead['surahNumber'],
        );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => AyahScreen(
                  //       surahNumber: lastRead['surahNumber'],
                  //       surahName: lastRead['surahName'],
                  //     ),
                  //   ),
                  // );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No recent reading found.')),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Resume ➔',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
