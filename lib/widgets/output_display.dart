import 'package:flutter/material.dart';

import '../data/calculator_notifier.dart';
import '../services/expression_helpers.dart';

class OutputDisplay extends StatelessWidget {
  final TextEditingController controller;

  const OutputDisplay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: calculatorOutput,
      builder: (context, calculatorOutputValue, child) {
        if (calculatorOutputValue != '0' &&
            ExpressionHelpers.isZero(calculatorOutputValue)) {
          calculatorOutput.value = '0';
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          height: double.infinity,
          child: TextField(
            controller: controller,
            // calculatorOutputValue
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
            textAlign: TextAlign.right,
            autofocus: true,
            showCursor: false,
            readOnly: true,
            autocorrect: false,
          ),
        );
      },
    );
  }
}
