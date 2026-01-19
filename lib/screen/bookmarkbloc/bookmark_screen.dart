import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/database_helper.dart';

import 'bookmark_cubit.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();

    return BlocProvider(
      create: (_) => BookmarkCubit(dbHelper: dbHelper),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
          backgroundColor: Colors.green.shade700,
        ),
        body: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            if (state.bookmarks.isEmpty) {
              return const Center(child: Text('No bookmarks saved.'));
            }

            return ListView.builder(
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final ayah = state.bookmarks[index];
                final isPlaying = state.playingUrl == ayah['audioUrl'] && state.isPlaying;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Arabic Text
                        Text(
                          ayah['ayahText'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 22, height: 1.5),
                        ),
                        const SizedBox(height: 8),
                        // Urdu Translation
                        Text(
                          ayah['translation'] ?? '', // optional if translation exists
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.green,
                              ),
                              onPressed: () => context.read<BookmarkCubit>().playPauseAudio(ayah['audioUrl']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => context.read<BookmarkCubit>().deleteBookmark(
                                ayah['surahNumber'],
                                ayah['ayahNumber'],
                              ),
                            ),
                          ],
                        ),
                        if (state.playingUrl == ayah['audioUrl'])
                          Slider(
                            value: state.position.inSeconds.toDouble(),
                            max: state.duration.inSeconds.toDouble() > 0
                                ? state.duration.inSeconds.toDouble()
                                : 1,
                            onChanged: (value) => context
                                .read<BookmarkCubit>()
                                .seekAudio(Duration(seconds: value.toInt())),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
