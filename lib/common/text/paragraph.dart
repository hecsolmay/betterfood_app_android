import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Paragraph extends StatelessWidget {
  final String text;
  double size;
  TextOverflow overflow;
  int maxLines;
  Paragraph(
      {super.key,
      required this.text,
      this.size = 14,
      this.maxLines = 4,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(fontSize: size),
    );
  }
}
