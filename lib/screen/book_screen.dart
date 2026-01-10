import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ayahbloc/ayah_screen.dart';
import 'ayzt_screen.dart';


class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  Set<String> bookmarks = {};

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    bookmarks = prefs.getStringList('bookmarks')?.toSet() ?? {};
    setState(() {});
  }

  Future<void> removeBookmark(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bookmarks.remove(key);
    await prefs.setStringList('bookmarks', bookmarks.toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (bookmarks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Bookmarks')),
        body: const Center(child: Text('No bookmarks added yet')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: ListView(
        children: bookmarks.map((key) {
          // key format: surahNumber:ayahNumber
          final parts = key.split(':');
          final surahNumber = int.tryParse(parts[0]) ?? 1;
          final ayahNumber = int.tryParse(parts[1]) ?? 1;

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Surah $surahNumber - Ayah $ayahNumber'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => removeBookmark(key),
              ),
              onTap: () {
                // Navigate to AyahScreen at that surah
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AyahScreen(
                      surahNumber: surahNumber,
                      surahName: 'Surah $surahNumber',
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
