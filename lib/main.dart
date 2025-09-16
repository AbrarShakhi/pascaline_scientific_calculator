import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

import 'pages/calculator.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pascaline Scientific Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorPage(title: 'Calculator'),
    );
  }
}
