import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double? size;
  TextOverflow? overflow;

  BigText({
    super.key,
    required this.text,
    this.size = 16,
    this.color = Colors.black,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: size, color: color),
    );
  }
}
