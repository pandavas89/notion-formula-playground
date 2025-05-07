import 'package:flutter/material.dart';

final List<Color> braceColors = [
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.red,
];

TextSpan buildBraceColoredSpan(String input) {
  final spans = <TextSpan>[];
  final stack = <int>[];

  for (int i = 0; i < input.length; i++) {
    final char = input[i];

    if ('({['.contains(char)) {
      int depth = stack.length;
      stack.add(depth);
      spans.add(TextSpan(
        text: char,
        style: TextStyle(
          color: braceColors[depth % braceColors.length],
          fontWeight: FontWeight.bold,
        ),
      ));
    } else if (')}]'.contains(char)) {
      int depth = stack.isNotEmpty ? stack.removeLast() : 0;
      spans.add(TextSpan(
        text: char,
        style: TextStyle(
          color: braceColors[depth % braceColors.length],
          fontWeight: FontWeight.bold,
        ),
      ));
    } else {
      spans.add(TextSpan(text: char));
    }
  }

  return TextSpan(children: spans);
}
