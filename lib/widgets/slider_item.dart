import 'package:flutter/material.dart';

class Card_Slider extends StatelessWidget {
  const Card_Slider({
    Key? key,
    required this.UrlImage,
  }) : super(key: key);

  final String UrlImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        color: const Color.fromRGBO(186, 0, 0, 1),
        child: Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(UrlImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
