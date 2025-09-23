import 'package:flutter/material.dart';
import 'package:pascaline_scientific_calculator/services/expression_helpers.dart';

import '../data/calculator_notifier.dart';
import 'button.dart';

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
    List<Button> children = [];

    for (var i = 0; i < labels.length; i++) {
      children.add(
        Button(
          label: labels[i],
          event: () {
            calculatorDisplayString.value = _updatedString(
              calculatorDisplayString.value,
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
