import 'package:flutter/material.dart';

import '../widgets/input_buttons.dart';
import '../widgets/input_display.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Standard"), centerTitle: true),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [InputDisplay(), SizedBox(height: 20), InputButtons()],
      ),
    ),
  );
}
