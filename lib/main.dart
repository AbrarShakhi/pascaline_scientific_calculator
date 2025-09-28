import 'package:flutter/material.dart';

import 'data/theme_notifier.dart';
import 'views/pascaline.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeMode,
      builder: (context, themeMode, child) {
        final brightness = themeMode == ThemeMode.light
            ? Brightness.light
            : Brightness.dark;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "JetBrainsMono",
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: brightness,
            ),
          ),
          home: Pascaline(),
        );
      },
    );
  }
}
