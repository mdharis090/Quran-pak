import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:quranpak/scr/feauture/ayahbloc/ayah_screen.dart';
import 'package:quranpak/scr/feauture/screen/bookmarkbloc/bookmark_screen.dart';
import 'package:quranpak/scr/feauture/screen/homescreen/homescreen.dart';
import 'package:quranpak/scr/feauture/screen/homescreen/widgets/menu_grid.dart';
import 'package:quranpak/scr/feauture/screen/juz_list_screen.dart';
import 'package:quranpak/scr/feauture/screen/settings_screen.dart';
import 'package:quranpak/scr/feauture/screen/surah_list_screen.dart';

final router = GoRouter(
  initialLocation: "/mainscreeen",
  debugLogDiagnostics: true,

  routes: [
    GoRoute(path: '/mainscreeen', builder: (context, state) => HomeScreen(),),
    GoRoute(
      path: '/ayah',
      builder: (context, state) {
        final surahNumber = state.extra as int;
        final surahName = state.uri.queryParameters['name'] ?? "";

        return AyahScreen(
          surahNumber: surahNumber,
          surahName: surahName,
        );
      }
    ),
    GoRoute(path: '/menugrid',builder: (context,state)=>MenuGrid(theme: ThemeData())),
    GoRoute(path: '/setting', builder: (context,state)=>SettingsScreen()),
    GoRoute(path: '/bookmark', builder: (context,state)=>BookmarkScreen()),
    GoRoute(path: '/juz', builder: (context,state)=>JuzListScreen()),
    GoRoute(path: '/surah', builder: (context,state)=>SurahListScreen()),
    //GoRoute(path: "/home", builder: (context, state) => HomeScreen()),

  ],
);