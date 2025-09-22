import 'package:flutter/material.dart';

import 'button.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "7"),
            Button(label: "8"),
            Button(label: "9"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "4"),
            Button(label: "5"),
            Button(label: "6"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "1"),
            Button(label: "2"),
            Button(label: "3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(label: "0"),
            Button(label: "."),
            Button(label: "<-"),
          ],
        ),
      ],
    );
  }
}
