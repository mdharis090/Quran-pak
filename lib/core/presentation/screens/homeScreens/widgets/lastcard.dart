import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quranpak/core/presentation/provider/home_screen_provider.dart';

Widget lastReadCard(BuildContext context, WidgetRef ref, ThemeData theme) {
  final lastReadAsync = ref.watch(lastReadProvider);

  return Container(
       width: double.infinity,
       height: 170,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme.colorScheme.primary, const Color(0xFF006B5C),
      
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.4),
            blurRadius: 12,
           ),]
    ),
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last Read',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.book, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Continue Reading',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        lastReadAsync.when(
          data: (lastRead) => ElevatedButton(
            onPressed: lastRead == null
                ? null
                : () {
                    context.push(
                      '/ayah?name=${lastRead.name}',
                      extra: lastRead.number,
                    );
                  },
            child: const Text('Resume '),
          ),

          loading: () => const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text("Error: $e"),
        ),
      ],
    ),
  );
}
