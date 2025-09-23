import 'package:flutter/material.dart';
import '../data/calculator_notifier.dart';
import '../services/expression_helpers.dart';
import '../widgets/number_pad.dart';
import '../widgets/operator_pad.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Standard Calculator"), centerTitle: true),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<String>(
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
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: NumberPad()),
                  Expanded(child: OperatorPad()),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
