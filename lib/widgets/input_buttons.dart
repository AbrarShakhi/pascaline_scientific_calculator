import 'package:flutter/material.dart';

class InputButtons extends StatefulWidget {
  const InputButtons({super.key});

  @override
  State<InputButtons> createState() => _InputButtonsState();
}

class _InputButtonsState extends State<InputButtons> {
  Widget _buildNumberPad() => Column(
    children: [
      Row(
        children: [
          // 7
          // 8
          // 9
        ],
      ),
      Row(
        children: [
          // 4
          // 5
          // 6
        ],
      ),
      Row(
        children: [
          // 1
          // 2
          // 3
        ],
      ),
      Row(
        children: [
          // 0
          // .
          // <-
        ],
      ),
    ],
  );

  Widget _buildOperatorPad() => Column(
    children: [
      Row(), // ( )
      Row(), // * /
      Row(), // + -
      // Only 1 big buttion =
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildNumberPad(), _buildOperatorPad()]);
  }
}

/*
  7  8  9  (  )
  4  5  6  *  /
  1  2  3  +  -
  0  .  <   ==
*/
