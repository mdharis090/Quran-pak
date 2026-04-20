import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quranpak/core/route/app_route.dart';
import 'package:quranpak/core/utliy/constant/colors.dart';

import 'package:quranpak/scr/feauture/screen/homescreen/homescreen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Quran Pak',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F3), // Soft off-white
        colorScheme: ColorScheme.fromSeed(
          
          seedColor: AppColors.Green,
          primary: AppColors.Green,
          secondary: AppColors.secondaryGold,
          surface: AppColors.backgroundOffWhite,
          background: AppColors.backgroundOffWhite,

        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.Green,
          foregroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
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
            color: AppColors.Green,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color:AppColors.Green,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: AppColors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: AppColors.black54),
        ),
      ),
         routerConfig: router,
      //home: const HomeScreen(),
    );
  }
}
