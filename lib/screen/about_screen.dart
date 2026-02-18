import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mosque, 
                  size: 64, 
                  color: theme.colorScheme.primary
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Quran Pak',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Version 1.0.0',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Designed to help you read and understand the Holy Quran with ease and comfort.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
