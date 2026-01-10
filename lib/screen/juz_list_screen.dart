
import 'package:flutter/material.dart';
import 'juz_detail_screen.dart';

class JuzListScreen extends StatelessWidget {
  const JuzListScreen({super.key});

  // List of Juz names / first Surah info
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
    'Al-Azhab 31',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juz Index'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            final juz = index + 1;
            final name = juzNames[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JuzDetailScreen(juzNumber: juz),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.green.shade800,
                      child: Text(
                        juz.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Juz $juz',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
