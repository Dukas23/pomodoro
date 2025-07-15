import 'package:flutter/material.dart';

class CircularProgressWithContex extends StatelessWidget {
  final double value;
  final Text text;
  final double strokeWidth;
  final double size;

  const CircularProgressWithContex({
    super.key,
    required this.value,
    required this.text,
    required this.strokeWidth,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(value: value, strokeWidth: strokeWidth),
          Center(child: text),
        ],
      ),
    );
  }
}
