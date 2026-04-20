import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quranpak/core/presentation/provider/manzil_provider.dart';

class ManzilDetailScreen extends ConsumerWidget {
  const ManzilDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final manzils = ref.watch(manzilProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Manzils')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: manzils.length,
        itemBuilder: (context, index) {
          final manzil = manzils[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manzil ${manzil.number}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 8),

              ...manzil.surahs.map(
                (surah) => Card(
                  child: ListTile(
                    title: Text(
                      'Surah ${surah.number} - ${surah.name}',
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, size: 16),

                    /// ✅ GoRouter use karo
                    onTap: () {
                      context.push(
                        '/ayah?name=${surah.name}',
                        extra: surah.number,
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