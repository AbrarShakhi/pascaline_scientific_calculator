import 'package:flutter/material.dart';

import 'data/theme_notifier.dart';
import 'views/widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadThemePreference();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: themeMode,
    builder: (context, themeMode, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        brightness: themeMode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light,
      ),
      home: WidgetTree(),
    ),
  );
}
