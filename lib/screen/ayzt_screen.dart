import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AyahScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const AyahScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<AyahScreen> createState() => _AyahScreenState();
}

class _AyahScreenState extends State<AyahScreen> {
  List ayahs = [];
  bool loading = true;

  final AudioPlayer player = AudioPlayer();

  Set<String> bookmarks = {};

  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.stop);
    fetchAyahs();
    loadBookmarks();
  }

  // 🔊 Quran Text + Audio
  Future<void> fetchAyahs() async {
    final res = await http.get(
      Uri.parse(
        'https://api.alquran.cloud/v1/surah/${widget.surahNumber}/editions/quran-uthmani,ar.alafasy',
      ),
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);

      final arabicAyahs = data['data'][0]['ayahs'];
      final audioAyahs = data['data'][1]['ayahs'];

      ayahs = List.generate(arabicAyahs.length, (index) {
        return {
          'text': arabicAyahs[index]['text'],
          'audio': audioAyahs[index]['audio'],
          'numberInSurah': arabicAyahs[index]['numberInSurah'],
        };
      });

      setState(() => loading = false);
    }
  }

  // ▶ PLAY AUDIO
  Future<void> playAudio(String url) async {
    try {
      if (url.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audio not available')),
        );
        return;
      }

      await player.stop();
      await player.play(UrlSource(url));
    } catch (e) {
      debugPrint('Audio error: $e');
    }
  }

  // ⭐ BOOKMARK
  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    bookmarks = prefs.getStringList('bookmarks')?.toSet() ?? {};
    setState(() {});
  }

  Future<void> toggleBookmark(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bookmarks.contains(key)
        ? bookmarks.remove(key)
        : bookmarks.add(key);
    await prefs.setStringList('bookmarks', bookmarks.toList());
    setState(() {});
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surahName)),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: ayahs.length,
        itemBuilder: (context, index) {
          final ayah = ayahs[index];
          final key =
              '${widget.surahNumber}:${ayah['numberInSurah']}';

          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ayah['text'],
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () =>
                            playAudio(ayah['audio']),
                      ),
                      IconButton(
                        icon: Icon(
                          bookmarks.contains(key)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.green,
                        ),
                        onPressed: () =>
                            toggleBookmark(key),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}