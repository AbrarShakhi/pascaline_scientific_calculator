import 'package:flutter/material.dart';

import 'number_pad.dart';
import 'operator_pad.dart';

class InputButtons extends StatelessWidget {
  const InputButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
