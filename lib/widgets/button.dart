import 'package:flutter/material.dart';

enum ButtonKind { number, operator_, modifier }

class Button extends StatelessWidget {
  final String _label;
  final VoidCallback _event;

  const Button({super.key, required String label, required VoidCallback event})
    : _label = label,
      _event = event;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: _event,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          _label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
