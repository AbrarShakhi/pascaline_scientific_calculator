import 'package:flutter/material.dart';

import 'button.dart';

class OperatorPad extends StatelessWidget {
  const OperatorPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "("),
            Button(label: ")"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "*"),
            Button(label: "/"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "+"),
            Button(label: "-"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Button(label: "=")],
        ),
      ],
    );
  }
}
