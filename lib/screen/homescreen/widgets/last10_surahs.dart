import 'package:flutter/material.dart';
import '../../ayahbloc/ayah_screen.dart';

class Last10SurahsSection extends StatelessWidget {
  final ThemeData theme;
  final List<Map<String, dynamic>> surahs;
  const Last10SurahsSection({super.key, required this.theme, required this.surahs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text('Last 10 Surahs', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AyahScreen(surahNumber: surah['surahNumber'], surahName: surah['surahName'])));
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: theme.colorScheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Surah ${surah['surahNumber']}', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.secondary, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(surah['surahName'], textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey.shade700), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}