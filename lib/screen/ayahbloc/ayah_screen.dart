
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/ayah_repository.dart';
import '../../database/database_helper.dart';
import 'ayah_cubit.dart';
import 'ayah_state.dart';


class AyahScreen extends StatelessWidget {
  final int surahNumber;
  final String surahName;

  const AyahScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();
    final repository = AyahRepository();
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => AyahCubit(
        surahNumber: surahNumber,
        surahName: surahName,
        dbHelper: dbHelper,
        repository: repository,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF9F6), // Warm paper-like background
        appBar: AppBar(
          title: Text(surahName),
          backgroundColor: theme.colorScheme.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _showSettingsModal(context, context.read<AyahCubit>(), context.read<AyahCubit>().state);
              },
            ),
          ],
        ),
        body: BlocBuilder<AyahCubit, AyahState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(
                child: CircularProgressIndicator(color: theme.colorScheme.primary),
              );
            }
            if (state.error.isNotEmpty) {
              return Center(child: Text(state.error));
            }

            return Column(
              children: [
                // 📜 Verses List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    itemCount: state.ayahs.length,
                    itemBuilder: (context, index) {
                      final ayah = state.ayahs[index];
                      final key = '${surahNumber}:${ayah['numberInSurah']}';
                      final isBookmarked = state.bookmarks.contains(key);
                      final isPlaying = state.playingUrl == ayah['audio'] && state.isPlaying;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isPlaying
                              ? theme.colorScheme.secondary.withOpacity(0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: isPlaying
                              ? Border.all(color: theme.colorScheme.secondary, width: 1.5)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 🛠 Actions Row (Play, Bookmark, Number)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${ayah['numberInSurah']}',
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                        color: isBookmarked
                                            ? theme.colorScheme.secondary
                                            : Colors.grey.shade400,
                                      ),
                                      onPressed: () => context
                                          .read<AyahCubit>()
                                          .toggleBookmark(ayah),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                        color: theme.colorScheme.primary,
                                        size: 32,
                                      ),
                                      onPressed: () => context
                                          .read<AyahCubit>()
                                          .playPauseAudio(ayah['audio']),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // 🕌 Arabic Text
                            Text(
                              ayah['text'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'PDMS_IslamicFont', // Use a font references here if available
                                fontSize: state.arabicFontSize,
                                height: 1.6,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 📝 Translation
                            Text(
                              ayah['translation'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: state.translationFontSize,
                                height: 1.5,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 🎵 Bottom Player (Visible when playing)
                if (state.isPlaying || state.playingUrl != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Playing Verse...',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Close player logic if needed
                              },
                              icon: const Icon(Icons.minimize, color: Colors.white),
                            )
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: theme.colorScheme.secondary,
                            inactiveTrackColor: Colors.white24,
                            thumbColor: Colors.white,
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: state.position.inSeconds.toDouble(),
                            max: state.duration.inSeconds.toDouble() > 0
                                ? state.duration.inSeconds.toDouble()
                                : 1,
                            onChanged: (value) => context
                                .read<AyahCubit>()
                                .seekAudio(Duration(seconds: value.toInt())),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showSettingsModal(BuildContext context, AyahCubit cubit, AyahState state) {
    print("Opening Settings Modal"); // Debug print
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            // We use the cubit from the parent context
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Arabic Font Size',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Slider(
                    value: state.arabicFontSize,
                    min: 18,
                    max: 40,
                    divisions: 11,
                    onChanged: (val) {
                      cubit.updateArabicFontSize(val);
                      setState(() {}); // Rebuild local state if needed for slider
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Translation Font Size',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Slider(
                    value: state.translationFontSize,
                    min: 12,
                    max: 24,
                    divisions: 6,
                    onChanged: (val) {
                      cubit.updateTranslationFontSize(val);
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
