import 'package:flutter/material.dart';

import '../common/text/bigtext.dart';

class Buttons extends StatefulWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline,
              color: Color.fromRGBO(186, 0, 0, 1)),
          onPressed: _decrementCounter,
        ),
        const SizedBox(width: 0.5),
        BigText(text: '$_counter'),
        const SizedBox(width: 0.5),
        IconButton(
          icon:
              const Icon(Icons.add_circle, color: Color.fromRGBO(186, 0, 0, 1)),
          onPressed: _incrementCounter,
        ),
      ],
    );
  }
}
