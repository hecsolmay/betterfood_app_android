import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tu Orden',
        ),
      ),
      body: const Center(
        child: Text('Aqui van todas las ordenes'),
      ),
    );
  }
}
