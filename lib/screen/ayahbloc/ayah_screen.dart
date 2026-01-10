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

    return BlocProvider(
      create: (_) => AyahCubit(
        surahNumber: surahNumber,
        dbHelper: dbHelper,
        repository: repository,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(surahName),
          backgroundColor: Colors.green.shade700,
        ),
        body: BlocBuilder<AyahCubit, AyahState>(
          builder: (context, state) {
            if (state.loading) return const Center(child: CircularProgressIndicator());
            if (state.error.isNotEmpty) return Center(child: Text(state.error));

            return ListView.builder(
              itemCount: state.ayahs.length,
              itemBuilder: (context, index) {
                final ayah = state.ayahs[index];
                final key = '${surahNumber}:${ayah['numberInSurah']}';
                final isBookmarked = state.bookmarks.contains(key);

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
                        Text(
                          ayah['text'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 22, height: 1.5),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.play_arrow, color: Colors.green),
                              onPressed: () => context.read<AyahCubit>().playAudio(ayah['audio']),
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                color: Colors.green.shade700,
                              ),
                              onPressed: () => context.read<AyahCubit>().toggleBookmark(ayah),
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
