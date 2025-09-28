import 'package:flutter/material.dart';

import '/widgets/output_display.dart';
import '/widgets/input_buttons.dart';

class Pascaline extends StatelessWidget {
  const Pascaline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pascaline"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutputDisplay(controller: TextEditingController()),
            Spacer(),
            InputButtons(),
          ],
        ),
      ),
    );
  }
}
