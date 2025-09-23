import 'package:flutter/material.dart';

import '../services/expression_manager.dart';
import '../data/calculator_notifier.dart';
import 'button.dart';

class OperatorPad extends StatelessWidget {
  final ExpressionManager _expressionManager;
  OperatorPad({super.key}) : _expressionManager = ExpressionManager();

  String _updatedString(String old, String new_) {
    if (new_ != '=') {
      return old + new_;
    }
    _expressionManager.clear();
    try {
      _expressionManager.parseInfix(calculatorDisplayString.value);
      return _expressionManager.calculate().toString();
    } catch (e) {
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
              label: "(",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  '(',
                );
              },
            ),
            Button(
              label: ")",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  ')',
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
              label: "*",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  '*',
                );
              },
            ),
            Button(
              label: "/",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  '/',
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
              label: "+",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  '+',
                );
              },
            ),
            Button(
              label: "-",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  '-',
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              label: "=",
              event: () {
                calculatorDisplayString.value = _updatedString(
                  calculatorDisplayString.value,
                  '=',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
