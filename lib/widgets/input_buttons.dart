import 'package:flutter/material.dart';

import '../services/expression_helpers.dart';
import '../services/expression_manager.dart';
import '../widgets/buttons/digit_button.dart';
import '../data/calculator_notifier.dart';

class InputButtons extends StatelessWidget {
  const InputButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
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
    );
  }
}

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  String _updatedString(String old, String new_) {
    if (new_.isEmpty) {
      throw Exception(
        "_updatedString function got an empty string : new_ = ''",
      );
    }
    if (new_ != '<-') {
      if (ExpressionHelpers.isZero(old)) {
        if (old == '.') {
          return "0.";
        }
        return new_;
      } else {
        return old + new_;
      }
    }
    if (old.isEmpty) {
      return '0';
    }
    List<int> modificableCarCodes = [];
    for (final rune in old.runes) {
      modificableCarCodes.add(rune);
    }
    modificableCarCodes.removeLast();
    if (modificableCarCodes.isEmpty) {
      modificableCarCodes.add('0'.codeUnits[0]);
    }
    return String.fromCharCodes(modificableCarCodes);
  }

  Widget _buildButtons(List<String> labels) {
    List<DigitButton> children = [];

    for (var i = 0; i < labels.length; i++) {
      children.add(
        DigitButton(
          label: labels[i],
          event: () {
            calculatorOutput.value = _updatedString(
              calculatorOutput.value,
              labels[i],
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r1 = _buildButtons(['7', '8', '9']);
    final r2 = _buildButtons(['4', '5', '6']);
    final r3 = _buildButtons(['1', '2', '3']);
    final r4 = _buildButtons(['0', '.', '<-']);
    return Column(children: [r1, r2, r3, r4]);
  }
}

class OperatorPad extends StatelessWidget {
  final ExpressionManager _expressionManager;
  OperatorPad({super.key}) : _expressionManager = ExpressionManager();

  String _updatedString(String old, String new_) {
    if (new_ != '=') {
      return old + new_;
    }
    _expressionManager.clear();
    try {
      _expressionManager.parseInfix(calculatorOutput.value);
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
            DigitButton(
              label: "(",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
                  '(',
                );
              },
            ),
            DigitButton(
              label: ")",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
                  ')',
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DigitButton(
              label: "*",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
                  '*',
                );
              },
            ),
            DigitButton(
              label: "/",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
                  '/',
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DigitButton(
              label: "+",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
                  '+',
                );
              },
            ),
            DigitButton(
              label: "-",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
                  '-',
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DigitButton(
              label: "=",
              event: () {
                calculatorOutput.value = _updatedString(
                  calculatorOutput.value,
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
