import 'package:flutter/material.dart';
import 'package:pascaline_scientific_calculator/services/expression_helpers.dart';

import '../data/calculator_notifier.dart';

class InputDisplay extends StatefulWidget {
  const InputDisplay({super.key});

  @override
  State<InputDisplay> createState() => _InputDisplayState();
}

class _InputDisplayState extends State<InputDisplay> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: calculatorDisplayString,
      builder: (context, calculatorDisplayStringValue, child) {
        if (calculatorDisplayStringValue != '0' &&
            ExpressionHelpers.isZero(calculatorDisplayStringValue)) {
          calculatorDisplayString.value = '0';
        }
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            calculatorDisplayStringValue,
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
