import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/database_helper.dart';

import 'bookmark_cubit.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => BookmarkCubit(dbHelper: dbHelper),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Bookmarks'),
          backgroundColor: theme.colorScheme.primary,
          elevation: 0,
        ),
        body: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            if (state.bookmarks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border_rounded,
                        size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'No bookmarks yet',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Any Ayah you bookmark will appear here.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final ayah = state.bookmarks[index];
                final isPlaying =
                    state.playingUrl == ayah['audioUrl'] && state.isPlaying;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 🏷 Header (Metadata)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Surah ${ayah['surahNumber']} : Verse ${ayah['ayahNumber']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => context
                                  .read<BookmarkCubit>()
                                  .deleteBookmark(
                                      ayah['surahNumber'], ayah['ayahNumber']),
                              icon: const Icon(Icons.bookmark_remove,
                                  color: Colors.redAccent),
                              tooltip: 'Remove Bookmark',
                            )
                          ],
                        ),
                        const SizedBox(height: 12),

                        // 🕌 Arabic Text
                        Text(
                          ayah['ayahText'],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                            color: Colors.black87,
                            fontFamily: 'PDMS_IslamicFont',
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 📝 Translation (if available)
                        if (ayah['translation'] != null &&
                            ayah['translation'].toString().isNotEmpty)
                          Text(
                            ayah['translation'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),

                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 8),

                        // 🎵 Audio Player
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: isPlaying
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.primary.withOpacity(0.1),
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: isPlaying
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.primary,
                                ),
                                onPressed: () => context
                                    .read<BookmarkCubit>()
                                    .playPauseAudio(ayah['audioUrl']),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (state.playingUrl == ayah['audioUrl'])
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: theme.colorScheme.primary,
                                    inactiveTrackColor: Colors.grey.shade200,
                                    thumbColor: theme.colorScheme.secondary,
                                    trackHeight: 4,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6),
                                  ),
                                  child: Slider(
                                    value: state.position.inSeconds.toDouble(),
                                    max: state.duration.inSeconds.toDouble() > 0
                                        ? state.duration.inSeconds.toDouble()
                                        : 1,
                                    onChanged: (value) => context
                                        .read<BookmarkCubit>()
                                        .seekAudio(Duration(seconds: value.toInt())),
                                  ),
                                ),
                              )
                            else
                              Text(
                                'Tap to play recitation',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
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
