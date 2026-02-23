import 'package:flutter/material.dart';

import '../screen/ayahbloc/ayah_screen.dart';

class ManzilDetailScreen extends StatelessWidget {
  const ManzilDetailScreen({super.key});

  final List<Map<String, dynamic>> manzils = const [
    {
      'number': '1',
      'name': 'Al-Fatiha to Al-Baqarah 2:141',
      'surahs': [
        {'surahNumber': 1, 'surahName': 'Al-Fatiha'},
        {'surahNumber': 2, 'surahName': 'Al-Baqarah'},
      ],
    },
    {
      'number': '2',
      'name': 'Al-Baqarah 2:142 to Al-Baqarah 2:252',
      'surahs': [
        {'surahNumber': 2, 'surahName': 'Al-Baqarah'},
      ],
    },
    {
      'number': '3',
      'name': 'Al-Baqarah 2:253 to An-Nisa 4:23',
      'surahs': [
        {'surahNumber': 2, 'surahName': 'Al-Baqarah'},
        {'surahNumber': 3, 'surahName': 'Al-Imran'},
        {'surahNumber': 4, 'surahName': 'An-Nisa'},
      ],
    },
    {
      'number': '4',
      'name': 'An-Nisa 4:24 to Al-Ma\'idah 5:81',
      'surahs': [
        {'surahNumber': 4, 'surahName': 'An-Nisa'},
        {'surahNumber': 5, 'surahName': 'Al-Ma\'idah'},
      ],
    },
    {
      'number': '5',
      'name': 'Al-Ma\'idah 5:82 to Al-A\'raf 7:87',
      'surahs': [
        {'surahNumber': 5, 'surahName': 'Al-Ma\'idah'},
        {'surahNumber': 6, 'surahName': 'Al-An\'am'},
        {'surahNumber': 7, 'surahName': 'Al-A\'raf'},
      ],
    },
    {
      'number': '6',
      'name': 'Al-A\'raf 7:88 to At-Tawbah 9:92',
      'surahs': [
        {'surahNumber': 7, 'surahName': 'Al-A\'raf'},
        {'surahNumber': 8, 'surahName': 'Al-Anfal'},
        {'surahNumber': 9, 'surahName': 'At-Tawbah'},
      ],
    },
    {
      'number': '7',
      'name': 'At-Tawbah 9:93 to An-Nas 114:6',
      'surahs': [
        {'surahNumber': 9, 'surahName': 'At-Tawbah'},
        {'surahNumber': 10, 'surahName': 'Yunus'},
        {'surahNumber': 114, 'surahName': 'An-Nas'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('All Manzils'), elevation: 0),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: manzils.length,
        itemBuilder: (context, index) {
          final manzil = manzils[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Manzil ${manzil['number']}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              ...(manzil['surahs'] as List).map(
                (surah) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(
                      'Surah ${surah['surahNumber']} - ${surah['surahName']}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AyahScreen(
                            surahNumber: surah['surahNumber'],
                            surahName: surah['surahName'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
