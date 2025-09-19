import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

Future<void> loadThemePreference() async {
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('themeMode') ?? 'system';

  if (savedTheme == 'dark') {
    themeMode.value = ThemeMode.dark;
  } else if (savedTheme == 'light') {
    themeMode.value = ThemeMode.light;
  } else {
    themeMode.value = ThemeMode.system;
  }
}

Future<void> saveThemePreference(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();

  if (mode == ThemeMode.dark) {
    prefs.setString('themeMode', 'dark');
  } else if (mode == ThemeMode.light) {
    prefs.setString('themeMode', 'light');
  } else {
    prefs.setString('themeMode', 'system');
  }
}
