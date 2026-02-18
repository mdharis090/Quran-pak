import 'package:flutter/material.dart';
import 'package:quranpak/screen/homescreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran Pak',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F3), // Soft off-white
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004B40), // Deep Green
          primary: const Color(0xFF004B40),
          secondary: const Color(0xFFFFD700), // Gold
          surface: const Color(0xFFF5F5F3),
          background: const Color(0xFFF5F5F3),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF004B40),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          shadowColor: Colors.black12,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004B40),
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004B40),
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
