import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final String text;
  double? size;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  Color? color;
  PriceText(
      {super.key,
      required this.text,
      this.size = 16,
      this.textAlign = TextAlign.right,
      this.color = Colors.amber,
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }
}
