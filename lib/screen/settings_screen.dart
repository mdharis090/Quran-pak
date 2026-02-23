import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _nightMode = false;
  bool _audioEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nightMode = prefs.getBool('nightMode') ?? false;
      _audioEnabled = prefs.getBool('audioEnabled') ?? true;
    });
  }

  Future<void> _setNightMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('nightMode', value);
    setState(() {
      _nightMode = value;
    });
  }

  Future<void> _setAudioEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('audioEnabled', value);
    setState(() {
      _audioEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Night mode (reading screen)'),
            subtitle: const Text('Dark background for ayah reading'),
            value: _nightMode,
            onChanged: _setNightMode,
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('Enable audio'),
            subtitle: const Text('Turn off if you only want text'),
            value: _audioEnabled,
            onChanged: _setAudioEnabled,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About app'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
