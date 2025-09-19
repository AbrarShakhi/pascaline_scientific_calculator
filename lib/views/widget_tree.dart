import 'package:flutter/material.dart';
import 'package:pascaline_scientific_calculator/views/pages/calculator.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(body: Calculator());
}
