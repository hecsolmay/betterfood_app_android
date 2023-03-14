import 'package:flutter/material.dart';

Future<dynamic> alertNotFound(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(mainAxisSize: MainAxisSize.min, children: const [
        SizedBox(
          height: 20,
        ),
        Icon(
          Icons.cancel,
          size: 64,
          color: Colors.red,
        ),
        SizedBox(
          height: 20,
        )
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
    ),
  );
}
