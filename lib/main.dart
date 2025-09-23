import 'package:flutter/material.dart';

import '/widgets/output_display.dart';
import 'data/theme_notifier.dart';
import 'views/standard_calculator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // loadThemePreference();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeMode,
      builder: (context, themeMode, child) {
        final brightness = themeMode == ThemeMode.light
            ? Brightness.light
            : Brightness.dark;
        setState(() {});

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "JetBrainsMono",
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: brightness,
            ),
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text("Standard Calculator"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [OutputDisplay(), Spacer(), StandardCalculator()],
              ),
            ),
          ),
        );
      },
    );
  }
}
