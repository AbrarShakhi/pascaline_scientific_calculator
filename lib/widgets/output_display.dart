import 'package:flutter/material.dart';

import '../data/calculator_notifier.dart';
import '../services/expression_helpers.dart';

class OutputDisplay extends StatefulWidget {
  const OutputDisplay({super.key});

  @override
  State<OutputDisplay> createState() => _OutputDisplayState();
}

class _OutputDisplayState extends State<OutputDisplay> {
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
          child: Text(
            calculatorOutputValue,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        );
      },
    );
  }
}
