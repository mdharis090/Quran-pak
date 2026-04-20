import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quranpak/core/presentation/provider/home_screen_provider.dart';
import 'package:quranpak/core/presentation/screens/homeScreens/widgets/lastcard.dart';
import 'package:quranpak/core/presentation/screens/homeScreens/widgets/last10_quran_surahs.dart';
import 'package:quranpak/core/presentation/screens/homeScreens/widgets/last10_surahs.dart';
import 'package:quranpak/core/presentation/screens/homeScreens/widgets/manzil_section.dart';
import 'package:quranpak/core/presentation/screens/homeScreens/widgets/menu_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final last10SurahsAsync = ref.watch(last10SurahsProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: theme.colorScheme.primary),
                      Text('Quran Pak', style: theme.textTheme.titleLarge),
                      Icon(Icons.notifications_none,
                          color: theme.colorScheme.primary),
                    ],
                  ),
                  const SizedBox(height: 24),
                  lastReadCard(context, ref, theme),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      ManzilSection(theme: theme),
                      const SizedBox(height: 16),

                      Last10QuranSurahsSection(
                        theme: theme,
                        surahs: last10QuranSurahs,
                      ),

                      const SizedBox(height: 16),

                      ///  Riverpod data handling
                      last10SurahsAsync.when(
                        data: (surahs) => Last10SurahsSection(
                           theme: theme,
                          surahs: surahs.map((e) => {
                             'surahNumber': e.number,
                          'surahName': e.name,
                              }).toList(),),

                        // data: (surahs) => surahs.isNotEmpty
                        //     ? Last10SurahsSection(
                        //         theme: theme,
                        //         surahs: surahs,
                        //       )
                        //  : const SizedBox(),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, _) => Text("Error: $e"),
                      ),
                      

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
}